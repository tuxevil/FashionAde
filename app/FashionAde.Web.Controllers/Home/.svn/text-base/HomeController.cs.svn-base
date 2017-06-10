using System.Configuration;
using System.Web.Mvc;
using System.Web.Security;
using FashionAde.Core.DataInterfaces;
using System.Collections.Generic;
using FashionAde.Core;
using FashionAde.ApplicationServices;
using FashionAde.Core.Views;
using FashionAde.Web.Controllers.MVCInteraction;

namespace FashionAde.Web.Controllers
{
    public class HomeController : BaseController
    {
        private IContentService contentService;

        public HomeController(IContentService contentService)
        {
            this.contentService = contentService;
        }

        public ActionResult Index()
        {
            MembershipUser user = Membership.GetUser();
            if (user != null)
                return RedirectToAction("RegisteredUser");
            
            return RedirectToAction("Welcome");
        }

        public ActionResult Welcome()
        {
            return View("Index");
        }

        [Authorize]
        public ActionResult RegisteredUser()
        {
            HomeRegisteredUserInfo info = new HomeRegisteredUserInfo();
            info.UserName = ViewData["UserName"].ToString();
            info.FashionFlavors = (IList<FashionFlavor>) ViewData["fashionFlavors"];
            info.StyleAlerts = contentService.GetRandomStyleAlerts(info.FashionFlavors);
            info.HaveBeenRated = false;
            return View(info);
        }
    }
}
