using System.Web.Mvc;
using System;
using System.Collections;
using System.Collections.Generic;
using FashionAde.Data.Repository;

namespace FashionAde.WebAdmin.Controllers
{
    [HandleError]
    public class HomeController : AuthorizeController
    {
        public HomeController()
        {
        }

        public ActionResult Index()
        {
            return View();
        }
    }
}
