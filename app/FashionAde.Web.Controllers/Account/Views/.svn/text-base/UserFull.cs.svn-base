using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Accounts;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public class UserFull
    {
        public string Email { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public int SecurityQuestion { get; set; }
        public string SecurityAnswer { get; set; }
        public string ZipCode { get; set; }
        public int UserSize { get; set; }
        public bool RememberMe { get; set; }
        public bool TermOfUse { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNumber { get; set; }
        public string PrivacyStatus { get; set; }
        public string Alert { get; set; }
        public int Tab { get; set; }

        public UserFull() { }
        public UserFull(RegisteredUser registeredUser, int securityQuestion, string alert, int tab)
        {
            this.Email = registeredUser.EmailAddress;
            this.FirstName = registeredUser.FirstName;
            this.LastName = registeredUser.LastName;
            this.SecurityQuestion = securityQuestion;
            this.PhoneNumber = registeredUser.PhoneNumber;
            this.UserSize = registeredUser.Size.Id;
            this.ZipCode = registeredUser.ZipCode;
            this.Alert = alert;
            this.Tab = tab;
        }
    }

}
