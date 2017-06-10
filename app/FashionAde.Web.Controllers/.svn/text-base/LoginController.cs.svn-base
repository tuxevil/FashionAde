using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.Security;
using FashionAde.Core;
using FashionAde.Core.DataInterfaces;
using FashionAde.Web.Controllers.MVCInteraction;
using ProjectBase.Utils.Email;

namespace FashionAde.Web.Controllers
{
    [HandleError]
    public class LoginController : Controller
    {
        [AcceptVerbs(HttpVerbs.Get)]
        public ViewResult Index()
        {
            ViewData["Errors"] = Session["Errors"];
            Session["Errors"] = null;
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ViewResult Index(string UserName)
        {
            return View();
        }

        public RedirectToRouteResult LogOut()
        {
            Session.Abandon();
            Session.Remove("username");
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ViewResult ForgotPassword()
        {
            ViewData["Errors"] = Session["Errors"];
            Session["Errors"] = null;
            return View();
        }

        [ObjectFilter(Param = "username", RootType = typeof(string))]
        public ActionResult GetQuestion(string username)
        {
            MembershipUser mu = Membership.GetUser(username);
            if(mu != null)
            {
                if(mu.IsLockedOut)
                    mu.UnlockUser();
                return Json(new
                                {
                                    Exist = true,
                                    PasswordQuestion = mu.PasswordQuestion
                                });
                
            }

            return Json(new
            {
                Exist = false
            });
            
        }

        public RedirectToRouteResult PasswordRecovery(string UserName, string Answer)
        {
            MembershipUser mu = Membership.GetUser(UserName);

            try
            {
                string newpassword = mu.ResetPassword(Answer);
                SmtpMailing mail = new SmtpMailing();
                string body = newpassword + "<br /><br /><h2 style='font-family:Century Gothic; color:#4D679B; font-weight:bold; font-size:14px; margin:0 0 0 30px; padding-bottom:2px;'>Please use it to login and change it in PROFILE page.</h2>";
                mail.SendMail(mu.Email, "Password Reset", "Your new password is", body, false);
                Session["Errors"] = "Your new password has been sent by email, please check your inbox.";
                return RedirectToAction("Index");
            }
            catch (Exception e)
            {
                Session["Errors"] = e.Message;
            }

            return RedirectToAction("ForgotPassword");
        }
    }
}
