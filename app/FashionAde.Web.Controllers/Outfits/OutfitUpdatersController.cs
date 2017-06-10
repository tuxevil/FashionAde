using System.Collections.Generic;
using System.Web.Mvc;
using FashionAde.ApplicationServices;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.ThirdParties;
using FashionAde.Tracking;
using FashionAde.Web.Controllers.Outfits.Views;

namespace FashionAde.Web.Controllers
{
    public class OutfitUpdatersController : BaseController
    {
        private IOutfitUpdaterRepository outfitUpdaterRepository;
        private IContentService contentService;

        public OutfitUpdatersController(IOutfitUpdaterRepository outfitUpdaterRepository, IContentService contentService)
        {
            this.outfitUpdaterRepository = outfitUpdaterRepository;
            this.contentService = contentService;
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Index(int id, string closetOutfitId)
        {
            ViewData["closetOutfitId"] = closetOutfitId;
            OutfitUpdater outfitUpdater = outfitUpdaterRepository.Get(id);
            IList<OutfitUpdater> lst = GetList(outfitUpdater, 1);

            ////We need to be able to track the number of impressiones (views) of outfit updaters.
            foreach (OutfitUpdater ou in lst)
                TrackingHelper.SaveOutfitUpdaterInfo(ou.Id.ToString(), closetOutfitId);

            return View(lst);
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult TrackOutfitUpdater(string updaterId, string updaterOutfitId, string updaterBuyUrl)
        {
            OutfitUpdaterView ouv = new OutfitUpdaterView();
            ouv.OutifUpdaterId = updaterId;
            ouv.OutfitId = updaterOutfitId;
            ViewData.Model = ouv;
            return Redirect(updaterBuyUrl);
        }

        private IList<OutfitUpdater> GetList(OutfitUpdater outfitUpdater, int page)
        {
            ViewData["styleAlerts"] = contentService.GetRandomStyleAlerts();
            int totalCount;
            IList<OutfitUpdater> lst = outfitUpdaterRepository.GetFor(outfitUpdater.Silouhette, outfitUpdater.ColorFamily,  page, 24, out totalCount);
            ViewData["Pages"] = Common.PagingHelper.Paging(totalCount, page, 24, 6);
            ViewData["Id"] = outfitUpdater.Id;
            return lst;
        }

        [AcceptVerbs(HttpVerbs.Post)]        
        public ActionResult ChangePage(int Id, int Page)
        {
            OutfitUpdater outfitUpdater = outfitUpdaterRepository.Get(Id);
            return View("Index", GetList(outfitUpdater, Page));
        }
    }
}
