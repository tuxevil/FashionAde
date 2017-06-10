using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Web.Security;
using FashionAde.Core;
using FashionAde.Core.Accounts;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.MVCInteraction;
using FashionAde.Core.OutfitCombination;
using FashionAde.Core.UserCloset;
using FashionAde.Web.Controllers.MVCInteraction;
using System.Web;
using System.IO;
using System.Collections;
using ProjectBase.Utils.Email;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Collections.Specialized;

namespace FashionAde.Web.Controllers
{
    [HandleError]
    [Authorize]
    public class MyGarmentsController : Controller
    {
        private ICategoryRepository categoryRepository;
        private IRegisteredUserRepository registeredUserRepository;
        private IClosetRepository closetRepository;
        private ISilouhetteRepository silouhetteRepository;
        private IEventTypeRepository eventTypeRepository;
        private IClosetOutfitViewRepository closetOutfitViewRepository;
        private IClosetOutfitRepository closetOutfitRepository;
        private IColorRepository colorRepository;
        private IPatternRepository patternRepository;
        private IFabricRepository fabricRepository;
        private IUserGarmentRepository userGarmentRepository;
        private IUserOutfitRepository userOutfitRepository;
        private IGarmentRepository garmentRepository;
        private IFriendRatingInvitationRepository friendRatingInvitationRepository;
        
        public MyGarmentsController(ICategoryRepository categoryRepository, IRegisteredUserRepository registeredUserRepository, IClosetRepository closetRepository, ISilouhetteRepository silouhetteRepository, IEventTypeRepository eventTypeRepository, IClosetOutfitViewRepository closetOutfitViewRepository, IClosetOutfitRepository closetOutfitRepository, IColorRepository colorRepository, IPatternRepository patternRepository, IFabricRepository fabricRepository, IUserGarmentRepository userGarmentRepository, IUserOutfitRepository userOutfitRepository, IGarmentRepository garmentRepository, IFriendRatingInvitationRepository friendRatingInvitationRepository)
        {
            this.categoryRepository = categoryRepository;
            this.registeredUserRepository = registeredUserRepository;
            this.closetRepository = closetRepository;
            this.silouhetteRepository = silouhetteRepository;
            this.eventTypeRepository = eventTypeRepository;
            this.closetOutfitViewRepository = closetOutfitViewRepository;
            this.closetOutfitRepository = closetOutfitRepository;
            this.colorRepository = colorRepository;
            this.patternRepository = patternRepository;
            this.fabricRepository = fabricRepository;
            this.userGarmentRepository = userGarmentRepository;
            this.userOutfitRepository = userOutfitRepository;
            this.garmentRepository = garmentRepository;
            this.friendRatingInvitationRepository = friendRatingInvitationRepository;
        }

        public ActionResult Recomendations()
        {
            return View();
        }

        #region MyGarments Page
        public ActionResult Index()
        {
            MembershipUser mu = Membership.GetUser();
            if (mu != null)
                ViewData["UserName"] = mu.UserName;
            
            RegisteredUser user = registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
            
            LoadSeasons(); 

            IList<Category> categories = categoryRepository.GetAll();
            foreach (Category category in categories)
            {
                ViewData["Category" + category.Description] = category.Id;
            }

            IList<FashionFlavor> flavors = new List<FashionFlavor>();
            foreach (UserFlavor flavor in user.UserFlavors)
            {
                flavors.Add(flavor.Flavor);
            }
            ViewData["FashionFlavors"] = flavors;

            List<WebClosetGarment> webClosetGarments =  closetRepository.GetWebClosetGarments(user);            

            ViewData["pants_jeans"] = webClosetGarments.FindAll(delegate(WebClosetGarment record)
            {
                if (record.CatId == (int)ViewData["CategoryPants"] || record.CatId == (int)ViewData["CategoryJeans"])
                {
                    return true;
                }
                return false;
            });

            ViewData["skirts_shorts"] = webClosetGarments.FindAll(delegate(WebClosetGarment record)
            {
                if (record.CatId == (int)ViewData["CategoryShorts"] || record.CatId == (int)ViewData["CategorySkirts"])
                {
                    return true;
                }
                return false;
            });

            ViewData["dresses"] = webClosetGarments.FindAll(delegate(WebClosetGarment record)
            {
                if (record.CatId == (int)ViewData["CategoryDresses"])
                {
                    return true;
                }
                return false;
            });

            ViewData["jackets"] = webClosetGarments.FindAll(delegate(WebClosetGarment record)
            {
                if (record.CatId == (int)ViewData["CategoryJackets"])
                {
                    return true;
                }
                return false;
            });

            ViewData["tops"] = webClosetGarments.FindAll(delegate(WebClosetGarment record)
            {
                if (record.CatId == (int)ViewData["CategoryCoats"] || record.CatId == (int)ViewData["CategoryCardigan"] || record.CatId == (int)ViewData["CategoryShirts"])
                {
                    return true;
                }
                return false;
            });

            ViewData["accesories"] = webClosetGarments.FindAll(delegate(WebClosetGarment record)
            {
                if (record.CatId == (int)ViewData["CategoryJewelry"] || record.CatId == (int)ViewData["CategoryBelts"] || record.CatId == (int)ViewData["CategoryShoes"] || record.CatId == (int)ViewData["CategoryBags"])
                {
                    return true;
                }
                return false;
            });

            return View();
        }

        public ActionResult ReadMore()
        {
            return View();
        }

        [ObjectFilter(Param = "userOutfitSelection", RootType = typeof(UserOutfitSelection))]
        public ActionResult SaveUserOutfit(UserOutfitSelection userOutfitselection)
        {
            UserOutfit uo = new UserOutfit();            
            uo.AddSeason(userOutfitselection.Season);
            
            MembershipUser mu = Membership.GetUser();
            RegisteredUser user = registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
            uo.User = user;

            for (int i = 0; i < userOutfitselection.ClosetOutfits.Length; i++)
                uo.AddComponent(closetRepository.GetClosetGarment(Convert.ToInt32(userOutfitselection.ClosetOutfits.GetValue(i))).Garment);
            
            uo.Visibility = userOutfitselection.PrivacyStatus;
            userOutfitRepository.SaveOrUpdate(uo);

            uo.Closet = user.Closet;            
            closetOutfitRepository.SaveOrUpdate(uo);
            
            return Json(new { Success = true });
        }

        [ObjectFilter(Param = "garmentSelected", RootType = typeof(int))]
        public ActionResult GetClosetGarmentDetails(int garmentSelected)
        {
            ClosetGarment garment = closetRepository.GetClosetGarment(garmentSelected);
            if(garment.Details == null)
            {
                return Json(new
                {
                    PurchasedAt = string.Empty,
                    PurchasedOn = string.Empty,
                    MadeBy = string.Empty,
                    MadeOf = string.Empty,
                    IsTailored = string.Empty,
                    CareConditions = string.Empty,
                    StoreConditions = string.Empty
                });
            }

            return Json(new
            {
                PurchasedAt = garment.Details.PurchasedAt,
                PurchasedOn = garment.Details.PurchasedOn.ToShortDateString(),
                MadeBy = garment.Details.MadeBy,
                MadeOf = garment.Details.MadeOf,
                IsTailored = garment.Details.IsTailored.ToString(),
                CareConditions = garment.Details.CareConditions,
                StoreConditions = garment.Details.StoreConditions
            });
        }

        [ObjectFilter(Param = "detail", RootType = typeof(WebGarmentDetails))]
        public ActionResult SaveDetails(WebGarmentDetails detail)
        {
            ClosetGarment garment = closetRepository.GetClosetGarment(detail.ClosetGarmentId);
            if(garment.Details == null)
                garment.Details = new GarmentDetails();
            garment.Details.CareConditions = detail.CareConditions;
            garment.Details.IsTailored = false;
            if(detail.IsTailored == "True")
                garment.Details.IsTailored = true;
            garment.Details.MadeBy = detail.MadeBy;
            garment.Details.MadeOf = detail.MadeOf;
            garment.Details.PurchasedAt = detail.PurchasedAt;
            garment.Details.PurchasedOn = Convert.ToDateTime(detail.PurchasedOn);
            garment.Details.StoreConditions = detail.StoreConditions;
            closetRepository.SaveOrUpdateGeneric(garment);

            return Json(new { Success = true });
        }

        [ObjectFilter(Param = "garmentSelected", RootType = typeof(int))]
        public ActionResult RemoveGarmentFromCloset(int garmentSelected)
        {
            MembershipUser mu = Membership.GetUser();
            RegisteredUser user = registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
            Closet closet = user.Closet;
            ClosetGarment garment = closetRepository.GetClosetGarment(garmentSelected);
            closet.RemoveGarment(garment);
            closetRepository.SaveOrUpdate(closet);
            closetRepository.RemoveGarmentFromCloset(garment.Id, closet.Id);

            return Json(new {Success= true});
        }
        #endregion
        
        private ArrayList GetFormatedValues(FormCollection values) 
        {
            ArrayList lst = new ArrayList();
            UserGarment ug = new UserGarment();
            int controlId = int.Parse(((NameValueCollection)(values)).AllKeys[0].Substring(
                                        ((NameValueCollection)(values)).AllKeys[0].Length - 1, 1));
            
            foreach (string tag in values)
            {
                if (tag == "x" || tag == "y")
                    continue;

                if (int.Parse(tag.Substring(tag.Length - 1)) != controlId)
                {
                    lst.Add(ug);
                    ug = new UserGarment();
                     controlId++;
                }

                string propName = tag.Substring(0, tag.Length - 1);
                string propValue = values[tag.ToString()];

                if (propValue == "")
                    continue;

                switch (propName)
                {
                    case "Title":  
                        Silouhette s = silouhetteRepository.Get(int.Parse(propValue));
                        ug.Title = s.Category.Description + " " + s.Description;
                        ug.Tags.Silouhette = s;
                        break;

                    case "Fabric":
                        ug.Tags.Fabric = fabricRepository.Get(int.Parse(propValue));
                        break;

                    case "PrimaryColor":
                        ug.Tags.Colors.Add(colorRepository.Get(int.Parse(propValue)));
                        break;

                    case "Pattern":
                        ug.Tags.Pattern = patternRepository.Get(int.Parse(propValue));
                        break;

                    case "Season":
                        ug.Tags.Seasons.Add((Season)int.Parse(propValue));
                        break;

                    case "EventType":
                        ug.Tags.EventTypes.Add(eventTypeRepository.Get(int.Parse(propValue)));
                        break;

                    case "PrivacyStatus":
                        ug.Visibility = (Convert.ToBoolean(propValue)) ? GarmentVisibility.Private : GarmentVisibility.Public;
                        break;
                }
            }

            lst.Add(ug);
            return lst;        
        }

        public ActionResult UploadFile(FormCollection values) 
        {
            MembershipUser mu = Membership.GetUser();
            if (mu != null)
                ViewData["UserName"] = mu.UserName;

            ArrayList lst = GetFormatedValues(values);                        
            RegisteredUser user = registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
            IList<UserGarment> lstFiles = new List<UserGarment>();            

            for (int i = 0; i < Request.Files.Count - 1; i++)
            {                
                HttpPostedFileBase uploadedFile = Request.Files[i];
                if (uploadedFile.ContentLength != 0) 
                {
                    UserGarment ug = (UserGarment)lst[i];
                    ug.User = user;
                    ug.ImageUri = "";
                    ug.LinkUri = "";
                    userGarmentRepository.SaveOrUpdate(ug);

                    FileInfo fi = new FileInfo(uploadedFile.FileName);
                    string fileName = ug.Id.ToString() + fi.Extension;
                    string filePath = Path.Combine(Server.MapPath("/res/Garments/"), fileName);
                    uploadedFile.SaveAs( filePath );

                    Closet closet = user.Closet;
                    closet.AddGarment(ug);
                    closetRepository.SaveOrUpdate(closet); 

                    ug.ImageUri = fileName;
                    userGarmentRepository.SaveOrUpdate(ug);
                    lstFiles.Add(ug);                    
                }
            }
            
            ViewData["uploadedFiles"] = lstFiles;            
            return View();
        }

        public ActionResult UploadGarment()
        {
            MembershipUser mu = Membership.GetUser();
            if (mu != null)
                ViewData["UserName"] = mu.UserName;

            RegisteredUser user = registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));

            IList<FashionFlavor> flavors = new List<FashionFlavor>();
            foreach (UserFlavor flavor in user.UserFlavors)
            {
                flavors.Add(flavor.Flavor);
            }
            ViewData["FashionFlavors"] = flavors;

            IList<FashionAde.Core.Clothing.Color> colors = colorRepository.GetAll(); 
            List<SelectListItem> lstcolors = new List<SelectListItem>();
            
            foreach (FashionAde.Core.Clothing.Color color in colors)
            {
                SelectListItem sl = new SelectListItem();
                sl.Text = color.Description;                
                sl.Value = color.Id.ToString();
                lstcolors.Add(sl);    
            }
            ViewData["Colors"] = lstcolors;           

            IList<Pattern> patterns = patternRepository.GetAll();
            List<SelectListItem> lstPatterns = new List<SelectListItem>();

            foreach (Pattern pattern in patterns)
            {
                SelectListItem sl = new SelectListItem();
                sl.Text = pattern.Description;
                sl.Value = pattern.Id.ToString();
                lstPatterns.Add(sl);
            }
            ViewData["Patterns"] = lstPatterns;

            IList<Fabric> fabrics = fabricRepository.GetAll();
            List<SelectListItem> lstFabrics = new List<SelectListItem>();

            foreach (Fabric fabric in fabrics)
            {
                SelectListItem sl = new SelectListItem();
                sl.Text = fabric.Description;
                sl.Value = fabric.Id.ToString();
                lstFabrics.Add(sl);
            }
            ViewData["Fabrics"] = lstFabrics;

            IList<Silouhette> silouhettes = silouhetteRepository.GetAll();
            List<SelectListItem> lstsilouhettes = new List<SelectListItem>();

            foreach (Silouhette silouhette in silouhettes)
            {
                SelectListItem sl = new SelectListItem();

                sl.Text = silouhette.Category.Description + " " + silouhette.Description;
                sl.Value = silouhette.Id.ToString();
                lstsilouhettes.Add(sl);
            }
            ViewData["Titles"] = lstsilouhettes;

            IList<EventType> eventTypes = eventTypeRepository.GetAll();
            List<SelectListItem> lsteventTypes = new List<SelectListItem>();
            
            foreach (EventType type in eventTypes)
            {
                SelectListItem sl = new SelectListItem();
                sl.Text = type.Description;
                sl.Value = type.Id.ToString();
                lsteventTypes.Add(sl);
            }
            ViewData["EventTypes"] = lsteventTypes;

            LoadSeasons();

            return View();
        }

        /// <summary>
        /// Carga todas las temporadas en el ViewData Seasons.
        /// </summary>
        private void LoadSeasons()
        {
            List<SelectListItem> lstSeasons = new List<SelectListItem>();
            SelectListItem season = new SelectListItem();
            season.Text = Season.Fall.ToString();
            season.Value = ((int)Season.Fall).ToString();
            lstSeasons.Add(season);
            season = new SelectListItem();
            season.Text = Season.Spring.ToString();
            season.Value = ((int)Season.Spring).ToString();
            lstSeasons.Add(season);
            season = new SelectListItem();
            season.Text = Season.Summer.ToString();
            season.Value = ((int)Season.Summer).ToString();
            lstSeasons.Add(season);
            season = new SelectListItem();
            season.Text = Season.Winter.ToString();
            season.Value = ((int)Season.Winter).ToString();
            lstSeasons.Add(season);
            ViewData["Seasons"] = lstSeasons;
        }

        /// <summary>
        /// Guarda la imagen "recortada" por el usuario como una nueva imagen.        
        /// </summary>
        /// <param name="coords">Objeto armado del lado del cliente que contiene las coordenas seleccionadas
        /// por el usuario y el nombre del archivo.</param>
        /// <returns></returns>
        [ObjectFilter(Param = "coords", RootType = typeof(Coords))]
        public ActionResult CropImage(Coords coords) 
        {
             var X = coords.X;
             var Y = coords.Y;
             var Width = coords.Width;
             var Height = coords.Height;
     
             try
             {
                 using (Image OriginalImage = Image.FromFile(Server.MapPath(coords.ImageUri)))
                 {
                     using (Bitmap bmp = new Bitmap(Width, Height))
                     {
                         bmp.SetResolution(OriginalImage.HorizontalResolution, OriginalImage.VerticalResolution);
                         using (Graphics Graphic = Graphics.FromImage(bmp))
                         {
                             Graphic.SmoothingMode = SmoothingMode.AntiAlias;
                             Graphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
                             Graphic.PixelOffsetMode = PixelOffsetMode.HighQuality;
                             Graphic.DrawImage(OriginalImage, new Rectangle(0, 0, Width, Height), X, Y, Width, Height, GraphicsUnit.Pixel);
                             MemoryStream ms = new MemoryStream();
                             bmp.Save(ms, OriginalImage.RawFormat);
                             byte[] CropImage = ms.GetBuffer();                             

                             using (MemoryStream mstream = new MemoryStream(CropImage, 0, CropImage.Length))
                             {
                                 mstream.Write(CropImage, 0, CropImage.Length);
                                 using (Image CroppedImage = Image.FromStream(mstream, true))
                                 {
                                     string folderPath = Server.MapPath("/res/Garments/");
                                     string originalPath = Server.MapPath(coords.ImageUri);
                                     string smallPath = Path.Combine(folderPath, "small_" + Path.GetFileName(coords.ImageUri));
                                     string bigPath = Path.Combine(folderPath, "big_" + Path.GetFileName(coords.ImageUri));
                                     
                                     OriginalImage.Dispose(); 
                                     CroppedImage.Save(originalPath, CroppedImage.RawFormat);
                                     ResizeImage(originalPath, bigPath, 135, 100, true);  //Imagenes Grandes
                                     ResizeImage(originalPath, smallPath, 65, 65, true);  //Imagenes Grandes
                                 }
                             }
                         }
                     }
                 }
                 return Json(new { Success = true });
             }
             catch (Exception Ex)
             {
                 return Json(new { Success = false });
             }
            
            //return Json(new { Success = true });
        }
        
        public void ResizeImage(string OriginalFile, string NewFile, int NewWidth, int MaxHeight, bool OnlyResizeIfWider)
        {
            System.Drawing.Image FullsizeImage = System.Drawing.Image.FromFile(OriginalFile);

            // Prevent using images internal thumbnail
            FullsizeImage.RotateFlip(System.Drawing.RotateFlipType.Rotate180FlipNone);
            FullsizeImage.RotateFlip(System.Drawing.RotateFlipType.Rotate180FlipNone);

            if (OnlyResizeIfWider)
            {
                if (FullsizeImage.Width <= NewWidth)
                {
                    NewWidth = FullsizeImage.Width;
                }
            }

            int NewHeight = FullsizeImage.Height * NewWidth / FullsizeImage.Width;
            if (NewHeight > MaxHeight)
            {
                // Resize with height instead
                NewWidth = FullsizeImage.Width * MaxHeight / FullsizeImage.Height;
                NewHeight = MaxHeight;
            }

            System.Drawing.Image NewImage = FullsizeImage.GetThumbnailImage(NewWidth, NewHeight, null, IntPtr.Zero);
            
            // Clear handle to original file so that we can overwrite it if necessary
            FullsizeImage.Dispose();

            // Save resized picture
            NewImage.Save(NewFile);
        }
        
        [ObjectFilter(Param = "selection", RootType = typeof(jsonLayer))]
        public ActionResult GetLayers(jsonLayer selection)
        {
            IList <LayerResponse> lst = garmentRepository.GetLayers(selection.GarmentIds);
            return Json(new { Success = true, Layers = lst });
        }


        #region Outfit Page
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Outfits()
        {
            RegisteredUser user = GetOutfitsInfo();
            int totalCount;
            int season = 4;
            ViewData["Outfits"] = closetOutfitViewRepository.Search(out totalCount, 10, 1, 1, user.Id, string.Empty, "1", user.Closet);
            ViewData["TotalOutfits"] = totalCount;
            ViewData["Pages"] = Common.Paging(totalCount, 1, 10, 10);
            ViewData["PrivacyLevel"] = user.Closet.PrivacyLevel.ToString();

            if (DateTime.Today >= new DateTime(DateTime.Today.Year, 3, 21))
                season = 1;
            if (DateTime.Today >= new DateTime(DateTime.Today.Year, 6, 21))
                season = 2;
            if (DateTime.Today >= new DateTime(DateTime.Today.Year, 9, 21))
                season = 3;
            if (DateTime.Today >= new DateTime(DateTime.Today.Year, 12, 21))
                season = 4;

            ViewData["Season"] = season;
            return View(user.Closet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Outfits(string SortBy, string Search, string Page, string Season)
        {
            RegisteredUser user = GetOutfitsInfo();
            int totalCount;
            if (Search == "Type a color, name or function to filter the results")
                Search = string.Empty;
            ViewData["Outfits"] = this.Search(out totalCount, SortBy, Search, Page, Season, user.Id);
            ViewData["Season"] = Season;
            ViewData["TotalOutfits"] = totalCount;
            ViewData["Pages"] = Common.Paging(totalCount, Convert.ToInt32(Page), 10, 10);
            ViewData["PrivacyLevel"] = user.Closet.PrivacyLevel.ToString();
            return View(user.Closet);
        }

        [ObjectFilter(Param = "outfitSelected", RootType = typeof(int))]
        public ActionResult RemoveOutfitFromCloset(int outfitSelected)
        {
            ClosetOutfit outfit = closetOutfitRepository.Get(outfitSelected);
            closetOutfitRepository.DeleteClosetOutfit(outfit);
            
            return Json(new { Success = true });
        }

        [ObjectFilter(Param = "outfitNotate", RootType = typeof(OutfitNotate))]
        public ActionResult AddNotateToCloset(OutfitNotate outfitNotate)
        {
            ClosetOutfit outfit = closetOutfitRepository.Get(outfitNotate.OutfitSelected);
            outfit.Notate(outfitNotate.Location, Convert.ToDateTime(outfitNotate.WornDate));
            closetOutfitRepository.SaveOrUpdate(outfit);

            return Json(new { Success = true });
        }

        [ObjectFilter(Param = "inviteFriends", RootType = typeof(InviteFriends))]
        public ActionResult InviteFriends(InviteFriends inviteFriends)
        {
            string[] emails = inviteFriends.FriendsEmails.Split(',');
            RegisteredUser user = GetUser();
            ClosetOutfit co = closetOutfitRepository.Get(Convert.ToInt32(inviteFriends.OutfitId));
            SmtpMailing mail = new SmtpMailing();
            foreach (string email in emails)
            {
                string subject = user.FullName + " want that you rate her outfit";
                string body = "";
                foreach (Garment garment in co.Components)
                    body += "<img src='" + inviteFriends.SiteURL + "/" + Resources.GetGarmentPath(garment) + "' alt='" + garment.Title + "' /> ";

                string key = Guid.NewGuid().ToString();

                body += "<br /><br />Rate it NOW <a href='" + inviteFriends.SiteURL + "/rating/index/" + key + "/default.aspx' style='color: #F38333;' >here</a>!";

                FriendRatingInvitation invitation = new FriendRatingInvitation();
                invitation.FriendEmail = email;
                invitation.InvitationSentOn = DateTime.Now;
                invitation.FriendRateOn = invitation.InvitationSentOn;
                invitation.KeyCode = key;
                invitation.Message = inviteFriends.Message;
                invitation.User = user;
                invitation.ClosetOutfit = co;
                friendRatingInvitationRepository.SaveOrUpdate(invitation);
                
                mail.SendMail(email, "Rate my outfit", subject, body, false);    
            }

            if(inviteFriends.SendMe)
            {
                string subject = user.FullName + " want that you rate her outfit";
                string body = "";
                foreach (Garment garment in co.Components)
                    body += "<img src='" + inviteFriends.SiteURL + "/" + Resources.GetGarmentPath(garment) + "' alt='" + garment.Title + "' /> ";
                
                body += "<br /><br />Rate it NOW <span style='color: #F38333;' >here</span>! <span style='font-size=10px;'>(only your friends get the rating link)</span>";
                mail.SendMail(user.EmailAddress, "Rate my outfit", subject, body, false);    
            }

            return Json(new { Success = true });
        }
        
        private IList<ClosetOutfitView> Search(out int totalCount, string SortBy, string Search, string Page, string Season, int UserId)
        {
            RegisteredUser user = registeredUserRepository.Get(UserId);
            return closetOutfitViewRepository.Search(out totalCount, 10, Convert.ToInt32(Page), Convert.ToInt32(Season), UserId, Search, SortBy, user.Closet);
        }
        
        private RegisteredUser GetOutfitsInfo()
        {
            RegisteredUser user = GetUser();
            IList<FashionFlavor> flavors = new List<FashionFlavor>();
            foreach (UserFlavor flavor in user.UserFlavors)
            {
                flavors.Add(flavor.Flavor);
            }
            ViewData["FashionFlavors"] = flavors;

            List<SelectListItem> lst = new List<SelectListItem>();
            SelectListItem sl = new SelectListItem();
            sl.Text = "Editor Rating";
            sl.Value = 1.ToString();
            lst.Add(sl);
            sl = new SelectListItem();
            sl.Text = "My Rating";
            sl.Value = 2.ToString();
            lst.Add(sl);
            sl = new SelectListItem();
            sl.Text = "Friend Rating";
            sl.Value = 3.ToString();
            lst.Add(sl);
            sl = new SelectListItem();
            sl.Text = "Last Worn Date";
            sl.Value = 4.ToString();
            lst.Add(sl);
            ViewData["SortBy"] = lst;
            return user;
        }

        private RegisteredUser GetUser()
        {
            MembershipUser mu = Membership.GetUser();
            if (mu != null)
                ViewData["UserName"] = mu.UserName;

            return registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
        }

        [ObjectFilter(Param = "outfitRate", RootType = typeof(OutfitRate))]
        public ActionResult RateOutfit(OutfitRate outfitRate)
        {
            ClosetOutfit closetOutfit = closetOutfitRepository.Get(outfitRate.ClosetOutfitId);
            if (closetOutfit.Rating == null)
                closetOutfit.Rating = new Rating();
            closetOutfit.Rating.Rate(closetOutfit, outfitRate.Rate);
            if (outfitRate.Rate == 5)
            {
                if (closetOutfit.Closet.FavoriteOutfit != null)
                {
                    closetOutfitRepository.SaveOrUpdate(closetOutfit);
                    return Json(new { Success = true, WantFavorite = true });
                }

                return SetFavorite(outfitRate);
            }
            if (closetOutfit.Closet.FavoriteOutfit != null && closetOutfit.Closet.FavoriteOutfit.Id == closetOutfit.Id)
                closetOutfit.Closet.ClearFavoriteOutfit();
            closetOutfitRepository.SaveOrUpdate(closetOutfit);
            return Json(new { Success = true, WantFavorite = false });
        }

        [ObjectFilter(Param = "outfitRate", RootType = typeof(OutfitRate))]
        public ActionResult SetFavorite(OutfitRate outfitRate)
        {
            ClosetOutfit closetOutfit = closetOutfitRepository.Get(outfitRate.ClosetOutfitId);
            closetOutfit.IsFavouriteOutfit = true;
            closetOutfit.Closet.SetFavoriteOutfit(closetOutfit);
            closetOutfitRepository.SaveOrUpdate(closetOutfit);
            return Json(new { Success = true, WantFavorite = false });
        }
        #endregion


        public ActionResult OutfitResume(int outfitId)
        {
            RegisteredUser user = GetUser();
            ViewData["outfitView"] = closetOutfitViewRepository.GetByClosetOutfitId(outfitId);
            
            IList<FashionFlavor> flavors = new List<FashionFlavor>();
            foreach (UserFlavor flavor in user.UserFlavors)
                flavors.Add(flavor.Flavor);
            ViewData["fashionFlavors"] = flavors;

            return View();
        }
    }
}
