using System.Web.Mvc;
using System;
using System.Collections;
using System.Collections.Generic;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.ThirdParties;
using FashionAde.Data.Repository;
using SharpArch.Web.NHibernate;

namespace FashionAde.WebAdmin.Controllers
{
    [HandleError]
    public class OutfitUpdaterController : BaseController
    {
        private readonly IOutfitUpdaterRepository _outfitUpdaterRepository;

        public OutfitUpdaterController(IOutfitUpdaterRepository outfitUpdaterRepository)
        {
            _outfitUpdaterRepository = outfitUpdaterRepository;
        }

        public ActionResult Verification()
        {
            var updaters =_outfitUpdaterRepository.GetFiltered(OutfitUpdaterStatus.Processed);
            return View(updaters);
        }

        [Transaction]
        public ActionResult ConfirmAll()
        {
            _outfitUpdaterRepository.ChangeOutfitUpdatersStatus(OutfitUpdaterStatus.Processed,
                                                                               OutfitUpdaterStatus.Approved);
            return RedirectToAction("Verification");
        }

        [Transaction]
        public ActionResult Reject(int outfitUpdaterId)
        {
            OutfitUpdater ou = _outfitUpdaterRepository.Get(outfitUpdaterId);
            ou.Status = OutfitUpdaterStatus.Rejected;
            _outfitUpdaterRepository.SaveOrUpdate(ou);
            return Json(true);
        }

    }
}
