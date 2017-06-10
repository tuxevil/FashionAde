using System.Web.Mvc;
using FashionAde.ApplicationServices;
using FashionAde.Core.Accounts;
using SharpArch.Web.NHibernate;

namespace FashionAde.Web.Controllers
{
    public class InvitationController : BuildYourClosetController
    {
        private readonly IMessageSenderService _messageSenderService;
        private readonly IInvitationValidatorService _invitationValidatorService;
        private readonly IInvitationCodeGeneratorService _invitationCodeGeneratorService;

        public InvitationController(IMessageSenderService messageSenderService, IInvitationCodeGeneratorService invitationCodeGeneratorService, IInvitationValidatorService invitationValidatorService)
        {
            _messageSenderService = messageSenderService;
            _invitationValidatorService = invitationValidatorService;
            _invitationCodeGeneratorService = invitationCodeGeneratorService;
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ViewResult Index()
        {
            return View();
        }

        [Transaction]
        public RedirectToRouteResult Validate(string validationCode)
        {
            if (_invitationValidatorService.IsValidCode(validationCode))
            {
                ClosetState.SetInvitationCode(validationCode);
                return RedirectToAction("Index", "FlavorSelect");
            }

            TempData["error"] = "Your invitation code is not valid.";
            return RedirectToAction("Index", "Home");
        }

        [Transaction]
        [ValidateAntiForgeryToken]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Index(string emailAdress)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    InvitationCode invitationCode = _invitationCodeGeneratorService.Generate(emailAdress);
                    _messageSenderService.SendWithTemplate("InvitationRequest", null, invitationCode.Code, invitationCode.EmailAddress);
                    TempData["message"] = "We have just send you an invitation code to your email address. You can enter it here to start creating your closet!";
                    return RedirectToAction("Index", "Home");
                }
                catch (MailAlreadyExistsException)
                {
                    ModelState.AddModelError("emailAdress", "Email address already used.");
                }
            }

            return View();
        }
    }
}