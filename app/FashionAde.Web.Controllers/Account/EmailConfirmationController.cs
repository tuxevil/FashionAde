using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Web.Security;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.Accounts;
using FashionAde.ApplicationServices;
using SharpArch.Web.NHibernate;
using FashionAde.Core.Clothing;
using FashionAde.Web.Controllers.MVCInteraction;

namespace FashionAde.Web.Controllers
{
    [RetainHttps]
    public class EmailConfirmationController : BaseController
    {
        IRegisteredUserRepository registeredUserRepository;
        IMessageSenderService messageSenderService;

        public EmailConfirmationController(IRegisteredUserRepository registeredUserRepository, 
            IMessageSenderService messageSenderService) 
        {
            this.registeredUserRepository = registeredUserRepository;
            this.messageSenderService = messageSenderService;
        }

        [Transaction]
        public ActionResult Validate(string userid, string code)
        {
            if (!string.IsNullOrEmpty(code) && !string.IsNullOrEmpty(userid))
            {
                int userId = Convert.ToInt32(userid);

                MembershipUser mu = Membership.GetUser(userId);
                if (mu != null)
                {
                    RegisteredUser ru = registeredUserRepository.GetByMembershipId(userId);

                    if (!mu.IsApproved)
                    {
                        // Make sure is using the valid code
                        if (ru != null && ru.RegistrationCode.Trim().ToLower() == code.Trim().ToLower())
                        {
                            // Approve on Membership
                            mu.IsApproved = true;
                            Membership.UpdateUser(mu);

                            // Approve on System
                            ru.Confirm();
                            ru.Closet.PrivacyLevel = PrivacyLevel.FullCloset;
                            registeredUserRepository.SaveOrUpdate(ru);
                            // Send approval mail
                            messageSenderService.SendWithTemplate("approvedmail", ru, ru.UserName, ru.EmailAddress);
                            return RedirectToAction("Index", "Login", new { validatedUser = true });
                        }
                    }
                    else
                    {
                        if (ru != null && ru.RegistrationCode.Trim().ToLower() == code.Trim().ToLower())
                        {
                            ru.EmailAddress = ru.NewMail;
                            mu.Email = ru.EmailAddress;
                            ru.NewMail = string.Empty;
                            registeredUserRepository.SaveOrUpdate(ru);
                            Membership.UpdateUser(mu);
                            // Send approval mail
                            messageSenderService.SendWithTemplate("approvedmail", ru, ru.UserName, ru.EmailAddress);
                            return RedirectToAction("Index", "Home", new { validatedUser = true });
                        }
                    }
                }
            }
            
            return RedirectToAction("Index", new { invalidCode = true, userid = userid });
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ViewResult Index(string invalidCode)
        {
            Session.Abandon();
            ViewData["invalidCode"] = !string.IsNullOrEmpty(invalidCode) && Convert.ToBoolean(invalidCode);
            return View();
        }
    }
}
