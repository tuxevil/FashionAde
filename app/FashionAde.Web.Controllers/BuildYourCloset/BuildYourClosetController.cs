using System;
using System.Configuration;
using System.Web.Mvc;
using FashionAde.Web.Common;
using FashionAde.ApplicationServices;

namespace FashionAde.Web.Controllers
{
    public class BuildYourClosetController : BaseController
    {
        private BuildYourClosetState _state;
        protected BuildYourClosetState ClosetState
        {
            get
            {
                if (_state == null)
                    _state = new BuildYourClosetState();

                return _state;
            }
        }

        //public void ValidateInvitationCode()
        //{
        //    if (Convert.ToBoolean(ConfigurationManager.AppSettings["IsInBeta"]))
        //        if (string.IsNullOrEmpty(ClosetState.InvitationCode))
        //            Response.Redirect(Url.RouteUrl(new {controller = "Home", action = "Index"}));
        //}

        [ObjectFilter(Param = "validationError", RootType = typeof(string))]
        public JsonResult TrackValidationError(string validationError)
        {
            return Json(validationError);
        }
    }
}
