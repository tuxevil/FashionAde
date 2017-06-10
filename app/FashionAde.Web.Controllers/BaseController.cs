using System;
using System.Collections.Generic;
using System.Web.Mvc;
using FashionAde.Core.Accounts;
using FashionAde.Core;
using SharpArch.Web.NHibernate;

namespace FashionAde.Web.Controllers
{
    [RegisterTracking]
    [ExitHttpsIfNotRequiredAttribute]
    [HandleError]
    [Transaction]
    public class BaseController : Controller
    {
        protected int UserId
        {
            get {
                if (UserDataHelper.Data == null)
                    return 0;
                return UserDataHelper.Data.UserId; 
            }
        }

        protected int ClosetId
        {
            get {
                if (UserDataHelper.Data == null)
                    return 0;

                return UserDataHelper.Data.ClosetId; 
            }
        }

        private RegisteredUser _proxyLoggedUser;
        protected RegisteredUser ProxyLoggedUser  
        {
            get {
                if (User.Identity.IsAuthenticated && _proxyLoggedUser == null)
                {
                    _proxyLoggedUser = new RegisteredUser(UserId);
                    _proxyLoggedUser.Closet = ProxyCloset;
                }
                return _proxyLoggedUser;
            }
        }

        private Closet _proxyCloset;
        protected Closet ProxyCloset
        {
            get
            {
                if (User.Identity.IsAuthenticated && _proxyCloset == null)
                    _proxyCloset = new Closet(ClosetId);
                return _proxyCloset;
            }
        }

        private IList<FashionFlavor> _proxyFlavors = new List<FashionFlavor>();
        public IList<FashionFlavor> ProxyFlavors
        {
            get 
            {
                if (User.Identity.IsAuthenticated && _proxyFlavors.Count == 0 && !string.IsNullOrEmpty(UserDataHelper.Data.Flavors))
                {
                    string[] arrFlavors = UserDataHelper.Data.Flavors.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    string[] arrFlavorNames = UserDataHelper.Data.FlavorNames.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                    for (int i = 0; i < arrFlavors.Length; i++)
                        _proxyFlavors.Add(new FashionFlavor(Convert.ToInt32(arrFlavors[i]), arrFlavorNames[i]));
                }

                return _proxyFlavors;
            }
        }
        
        public string Channel
        {
            get
            {
                if (UserDataHelper.Data == null)
                    return null;

                return UserDataHelper.Data.Channel;
            }
            
        }

        protected override void OnAuthorization(AuthorizationContext filterContext)
        {
            if (User.Identity.IsAuthenticated)
            {
                // Write to ViewData, used on every view in the system when authorized.
                ViewData["UserName"] = User.Identity.Name;

                if (ProxyFlavors.Count > 0)
                    ViewData["FashionFlavors"] = ProxyFlavors;
            }

            base.OnAuthorization(filterContext);
        }
    }
}
