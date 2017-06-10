using System;
using System.Web.Mvc;
using System.Web.Security;
using FashionAde.WebAdmin.Controllers;

namespace FashionAde.Web.Controllers
{
    [HandleError]
    public class LoginController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        [Authorize]
        public ActionResult PasswordChanged()
        {
            return View();
        }

        [Authorize]
        public ActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        [Authorize]
        public ActionResult ChangePassword(string currentPassword, string newPassword, string confirmPassword)
        {
            if (ModelState.IsValid)
            {
                if (!string.IsNullOrEmpty(currentPassword) && !string.IsNullOrEmpty(newPassword) && !string.IsNullOrEmpty(confirmPassword))
                {
                    if (confirmPassword != newPassword)
                        ModelState.AddModelError("confirmPassword", "Confirm Password does not match.");
                    else
                    {
                        if (Membership.GetUser().ChangePassword(currentPassword, newPassword))
                            return RedirectToAction("PasswordChanged");

                        ModelState.AddModelError("currentPassword", "Verify your current password is valid.");
                    }
                }
                else
                    ModelState.AddModelError("currentPassword", "Verify all fields are completed.");
            }

            return View();
        }

        public ActionResult Validate(string userName, string userPassword, bool? chkMaintain)
        {
            if (Membership.ValidateUser(userName, userPassword) && !Roles.IsUserInRole(userName, "User"))
            {
                bool tmp = false;
                if (chkMaintain != null)
                    tmp = (bool) chkMaintain;

                FormsAuthentication.SetAuthCookie(userName, tmp);
                return RedirectToAction("Index", "Grid");
            }
            
            TempData["LoginMessage"] = "The username and password supplied are not valid.";
            return RedirectToAction("Index", "Login");
        }

        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            return RedirectToAction("Index", "Login");
        }
    }
}
