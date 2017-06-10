using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using FashionAde.Core.Accounts;
using FashionAde.Core.DataInterfaces;
using FashionAde.Web.Common;

namespace FashionAde.Web.Controllers
{
    [RetainHttps]
    public class AccountValidationController : BaseController
    {
        private IRegisteredUserRepository registeredUserRepository;
        private IBasicUserRepository basicUserRepository;
        private IZipCodeRepository zipCodeRepository;

        public AccountValidationController(IRegisteredUserRepository registeredUserRepository, IZipCodeRepository zipCodeRepository, IBasicUserRepository basicUserRepository)
        {
            this.registeredUserRepository = registeredUserRepository;
            this.zipCodeRepository = zipCodeRepository;
            this.basicUserRepository = basicUserRepository;
        }

        [ObjectFilter(Param = "email", RootType = typeof(string))]
        public ActionResult CheckNewEmail(string email)
        {
            return EmailCheck(registeredUserRepository.GetByMail(email), email);
        }

        [ObjectFilter(Param = "email", RootType = typeof(string))]
        public ActionResult CheckEmail(string email)
        {
            return EmailCheck(basicUserRepository.GetByMail(email), email);
        }

        private ActionResult EmailCheck(BasicUser user, string email)
        {
            Regex regex = new Regex(@"^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$");
            if (regex.IsMatch(email))
            {
                if (user == null)
                    return Json(new
                                    {
                                        Exist = false,
                                        RegExError = false,
                                        Email = HttpUtility.HtmlEncode(email)
                                    });
                return Json(new
                                {
                                    Exist = true,
                                    RegExError = false,
                                    Email = HttpUtility.HtmlEncode(email)
                                });
            }
            return Json(new
                            {
                                Exist = true,
                                RegExError = true,
                                Email = HttpUtility.HtmlEncode(email)
                            });
        }

        [ObjectFilter(Param = "username", RootType = typeof(string))]
        public ActionResult CheckUsername(string username)
        {
            if (IsReserved(username))
                return Json(new
                {
                    Exist = false,
                    Reserved = true,
                    Username = HttpUtility.HtmlEncode(username)
                });
            string user = CheckUser(username);
            if (user == username)
                return Json(new
                {
                    Exist = false,
                    Reserved = false,
                    Username = HttpUtility.HtmlEncode(username)
                });


            return Json(new
            {
                Exist = true,
                Username = HttpUtility.HtmlEncode(username),
                Recommended = user
            });
        }

        [ObjectFilter(Param = "code", RootType = typeof(string))]
        public ActionResult CheckZipCode(string code)
        {
            ZipCode zipcode = zipCodeRepository.GetByCode(code);

            if (zipcode != null)
                return Json(new
                {
                    Exist = true
                });
            return Json(new
            {
                Exist = false,
                ZipCode = HttpUtility.HtmlEncode(code)
            });
        }

        private string CheckUser(string username)
        {
            if (Membership.GetUser(username) != null)
            {
                Random r = new Random();
                return CheckUser(username + r.Next(99));
            }
            return username;
        }

        private bool IsReserved(string username)
        {
            foreach (string reservedUsername in ReservedUsernames)
                if (reservedUsername.ToLower() == username.ToLower())
                    return true;
            return false;
        }

        private string[] ReservedUsernames
        {
            get { return "Administrator,Administrador,Administra,Administro,Admin,Adm".Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries); }
        }
    }
}
