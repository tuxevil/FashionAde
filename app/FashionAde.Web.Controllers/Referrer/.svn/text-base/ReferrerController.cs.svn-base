using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace FashionAde.Web.Controllers.Referrer
{
    public class ReferrerController : Controller
    {
        [HttpGet]
        public void Index(string id)
        {
            Response.Redirect("/?utm_campaign=" + id.ToLower(), true);
//            return RedirectToAction("Index", "Home", new { utm_campaign = id.ToLower() });
        }
    }
}
