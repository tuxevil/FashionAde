using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using FashionAde.ApplicationServices;
using FashionAde.Core;
using FashionAde.Web.Controllers.MVCInteraction;

namespace FashionAde.Web.Controllers
{
    public class ContactUsController : BaseController
    {
        private IMessageSenderService messageSenderService; 
        private IContentService contentService;

        public ContactUsController(IContentService contentService, IMessageSenderService messageSenderService)
        {
            this.contentService = contentService;
            this.messageSenderService = messageSenderService;
        }

        [AcceptVerbs(HttpVerbs.Get)]
        [CustomOutputCache]
        public ActionResult Index()
        {
            FeedBack feedBack = new FeedBack();
            feedBack.Content = contentService.GetRandomStyleAlerts();
            return View(feedBack);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Index(FeedBack feedBack)
        {
            feedBack.Content = contentService.GetRandomStyleAlerts();
            feedBack.Message = HttpUtility.HtmlEncode(feedBack.Message);
            feedBack.Name = HttpUtility.HtmlEncode(feedBack.Name);
            if(ModelState.IsValid)
            {
                foreach (string user in Roles.GetUsersInRole("Administrator"))
                    messageSenderService.SendWithTemplate("feedback", null, feedBack, Membership.GetUser(user).Email);    
                return View("Thanks", contentService.GetRandomStyleAlerts());    
            }
            return View(feedBack);
        }

        
    }
}
