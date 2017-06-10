using System.Web.Mvc;
using System.Web.Security;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.Accounts;
using System;
using System.Collections;
using System.Collections.Generic;
using FashionAde.Core.MVCInteraction;
using FashionAde.Core;

namespace FashionAde.Web.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        private IClosetOutfitViewRepository closetOutfitViewRepository;
        private IRegisteredUserRepository registeredUserRepository;
        private IUserGarmentRepository userGarmentRepository;

        public HomeController(IClosetOutfitViewRepository closetOutfitViewRepository, IRegisteredUserRepository registeredUserRepository, IUserGarmentRepository userGarmentRepository)
        {
            this.closetOutfitViewRepository = closetOutfitViewRepository;
            this.registeredUserRepository = registeredUserRepository;
            this.userGarmentRepository = userGarmentRepository;
        }

        public ActionResult Index()
        {
            MembershipUser user = Membership.GetUser();
            if (user != null)
            {
                ViewData["UserName"] = user.UserName;
                return RedirectToAction("RegisteredUser");
            }
            return View();
        }

        public ActionResult RegisteredUser()
        {
            RegisteredUser user = GetOutfitsInfo();
            if (user == null)
                return RedirectToAction("Index");

            ViewData["topRatedOutfits"] = closetOutfitViewRepository.GetTopRatedOutfits(user.Id);
            ViewData["recentlyUploadedGarments"] = userGarmentRepository.GetRecentlyUploaded(user);

            IList<FashionFlavor> flavors = new List<FashionFlavor>();
            foreach (UserFlavor flavor in user.UserFlavors)
                flavors.Add(flavor.Flavor);
            ViewData["fashionFlavors"] = flavors;

            return View(user.Closet);
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
            {
                ViewData["UserName"] = mu.UserName;
                return registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
            }
            return null;
        }

        public ActionResult Privacy()
        {
            return View();
        }

        public ActionResult TermsOfUse()
        {
            return View();
        }

        public ActionResult AboutUs()
        {
            return View();
        }

        public ActionResult SiteMap()
        {
            return View();
        }
    }
}
