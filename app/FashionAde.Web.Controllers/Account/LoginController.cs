using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.Security;
using FashionAde.Core;
using FashionAde.Core.DataInterfaces;
using FashionAde.Web.Controllers.Account.Views;
using FashionAde.Web.Controllers.MVCInteraction;
using FashionAde.Core.Accounts;
using System.Web;
using FashionAde.Web.Common;
using FashionAde.ApplicationServices;
using SharpArch.Web.NHibernate;

namespace FashionAde.Web.Controllers
{
//#if !DEBUG
//    [RequireHttps]
//#endif
    public class LoginController : BaseController
    {
        IRegisteredUserRepository registeredUserRepository;
        IMessageSenderService messageSender;

        public LoginController(IRegisteredUserRepository registeredUserRepository, IMessageSenderService messageSender)
        {
            this.registeredUserRepository = registeredUserRepository;
            this.messageSender = messageSender;
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ViewResult Index(string validatedUser)
        {
            ViewData["Errors"] = TempData["Errors"];
            TempData["Errors"] = null;
            ViewData["validatedUser"] = !string.IsNullOrEmpty(validatedUser) && Convert.ToBoolean(validatedUser);

            return View(new UserLogin());
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ViewResult Validate(UserLogin userLogin)
        {
            if (ModelState.IsValid)
            {
                if (Membership.ValidateUser(userLogin.UserName.Trim(), userLogin.Password))
                {
                    bool tmp = false;
                    if (userLogin.RememberMe != null)
                        tmp = (bool) userLogin.RememberMe;

                    FormsAuthentication.SetAuthCookie(userLogin.UserName, tmp);
                    UserDataHelper.LoadFromDatabase(userLogin.UserName);

                    new BuildYourClosetState().Clear();

                    if (!string.IsNullOrEmpty(userLogin.ReturnUrl))
                        Response.Redirect(userLogin.ReturnUrl);

                    Response.Redirect(Url.RouteUrl(new { controller = "Home", action = "Index" }));
                }

                ModelState.AddModelError("UserName", "The username or password is invalid.");
            }

            return View("Index", userLogin);
        }

        [HttpGet]
        public RedirectToRouteResult LogOut()
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            return RedirectToAction("Index", "Home");
        }

        [ObjectFilter(Param = "username", RootType = typeof(string))]
        public ActionResult GetQuestion(string username)
        {
            MembershipUser mu = Membership.GetUser(username);
            if(mu != null)
            {
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

        #region Forgot Password

        [HttpGet]
        [CustomOutputCache]
        public ActionResult ForgotPassword()
        {
            ViewData["Errors"] = TempData["Errors"];
            TempData["Errors"] = null;

            return View(new ForgotPasswordView());
        }

        [HttpPost]
        [Transaction]
        public ActionResult ForgotPassword(ForgotPasswordView view)
        {
            if (ModelState.IsValid)
            {
                MembershipUser mu = Membership.GetUser(view.UserName);

                if (mu != null)
                {
                    try
                    {
                        string newPassword = mu.ResetPassword(view.Answer);

                        PasswordEmailData ped = new PasswordEmailData();
                        ped.UserName = mu.UserName;
                        ped.NewPassword = newPassword;
                        messageSender.SendWithTemplate("forgotpassword", null, ped, mu.Email);

                        TempData["Errors"] = "Your new password has been sent by email, please check your inbox.";
                        return RedirectToAction("ForgotPassword");

                    }
                    catch (MembershipPasswordException)
                    {
                        ModelState.AddModelError("Answer", "Your answer does not match with our records.");
                    }
                }
                else
                    ModelState.AddModelError("UserName", "Your user name is not valid.");
            }
           
            return View(view);
        }

        #endregion
    }
}
