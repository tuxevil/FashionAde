﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using FashionAde.ApplicationServices.SearchEngine;
using FashionAde.Core.Clothing;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core.ThirdParties;
using FashionAde.Utils.OutfitUpdaters;
using FashionAde.Web.Controllers.MVCInteraction;
using SharpArch.Web.NHibernate;
using FashionAde.Core.OutfitCombination;
using System.Web.Security;
using FashionAde.Core.Accounts;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core;
using FashionAde.Web.Common;
using FashionAde.ApplicationServices.Outfit;

namespace FashionAde.Web.Controllers
{
    public class OutfitCreationController : BaseController
    {
        private IClosetRepository closetRepository;
        private IOutfitCreationService outfitCreationService;

        public OutfitCreationController(IClosetRepository closetRepository, IOutfitCreationService outfitCreationService)
        {
            this.closetRepository = closetRepository;
            this.outfitCreationService = outfitCreationService;
        }

        [ObjectFilter(Param = "userOutfitSelection", RootType = typeof(UserOutfitSelection))]
        [Transaction]
        [Authorize]     
        public ActionResult SaveUserOutfit(UserOutfitSelection userOutfitselection)
        {
            IList<Garment> garments = new List<Garment>();
            ClosetOutfit co;
            for (int i = 0; i < userOutfitselection.ClosetOutfits.Length; i++)
                garments.Add(
                    closetRepository.GetClosetGarment(Convert.ToInt32(userOutfitselection.ClosetOutfits.GetValue(i)))
                        .Garment);
            try
            {
                co = outfitCreationService.CreateUserOutfit(this.UserId, garments, userOutfitselection.Season, userOutfitselection.PrivacyStatus);
            }
            catch (NotValidCombinationException) 
            {
                return Json(new { Success = false, Message = "Oops, looks like you have more than one of something in this outfit – please use only one jacket, one pant, etc. to create an outfit." });
            }
            catch (CombinationAlreadyExistsException)
            {
                return Json(new { Success = false, Message = "This combination already exists. Try again!" });
            }

            new OutfitUpdaterServiceClient().MatchOutfitUpdatersForCloset(ClosetId);

            using (SearchEngineService ses = SearchEngineService.GetByCloset(ClosetId))
            {
                ses.AddEntry(co.ToSearchEngineEntry());
            }

            return Json(new { Success = true });
        }

        [ObjectFilter(Param = "closetOutfitId", RootType = typeof(int))]
        [Transaction]    
        public ActionResult CopyOutfit(int closetOutfitId)
        {
            bool registeredUser = (Membership.GetUser() != null);

            try
            {
                if (registeredUser)
                    if(outfitCreationService.CanCopyOutfit(closetOutfitId, this.ProxyCloset.Id))
                        outfitCreationService.CopyOutfitFromOtherUserCloset(closetOutfitId, this.UserId);

                return Json(new { Success = true, RegisteredUser = registeredUser });
            }
            catch
            {
            }

            return Json(new { Success = false });
        }        
    }
}
