using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Security;
using Castle.Components.Validator;
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
        
        public UserFull() {}
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

    public class UserRegistration
    {
        [ValidateNonEmpty("Email required")]
        [ValidateEmail("Please enter a valid email address")]
        public string Email { get; set; }

        [ValidateNonEmpty("User Name required")]
        public string UserName { get; set; }

        [ValidateNonEmpty("Password required")]
        public string Password { get; set; }

        [ValidateNonEmpty("Password Confirmation required")]
        [ValidateSameAs("Password", "Dont match")]
        public string ConfirmPassword { get; set; }

        [ValidateNonEmpty("Security Question required")]
        [ValidateInteger]
        public int? SecurityQuestion { get; set; }

        [ValidateNonEmpty("Security Answer required")]
        public string SecurityAnswer { get; set; }

        [ValidateNonEmpty("Zip Code required")]
        public string ZipCode { get; set; }

        [ValidateNonEmpty("User Size required")]
        [ValidateInteger]
        public int? UserSize { get; set; }

        public bool RememberMe { get; set; }
        public bool TermOfUse { get; set; }

        public ErrorSummary Validate()
        {
            ValidatorRunner vr = new ValidatorRunner(true, new CachedValidationRegistry());
            if (!vr.IsValid(this))
                return vr.GetErrorSummary(this);
            else
                return null;
        }

        public UserRegistration() {}
        public UserRegistration(UserFull userFull)
        {
            this.ConfirmPassword = userFull.ConfirmPassword;
            this.Email = userFull.Email;
            this.Password = userFull.Password;
            this.SecurityAnswer = userFull.SecurityAnswer;
            this.SecurityQuestion = userFull.SecurityQuestion;
            this.UserName = userFull.UserName;
            this.UserSize = userFull.UserSize;
            this.ZipCode = this.ZipCode;
        }
        public UserRegistration(string userName)
        {
            this.UserName = userName;
        }
    }

    public class UserUpdate
    {
        public string FirstName { get; set; }
        [ValidateNonEmpty("Last Name Required")]
        public string LastName { get; set; }
        public string PhoneNumber { get; set; }
        public string PrivacyStatus { get; set; }
        [ValidateNonEmpty("Zip Code required")]
        //[ValidateRegExp(@"/(^\d{5}$)|(^\d{5}-\d{4}$)/", "Enter a valid Zip Code")]
        public string ZipCode { get; set; }
        public string Email { get; set; }

        public ErrorSummary Validate()
        {
            ValidatorRunner vr = new ValidatorRunner(true, new CachedValidationRegistry());
            if (!vr.IsValid(this))
                return vr.GetErrorSummary(this);
            else
                return null;
        }

        public UserUpdate(){}
        public UserUpdate(UserFull userFull)
        {
            this.FirstName = userFull.FirstName;
            this.LastName = userFull.LastName;
            this.PhoneNumber = userFull.PhoneNumber;
            this.PrivacyStatus = userFull.PrivacyStatus;
            this.ZipCode = userFull.ZipCode;
            this.Email = userFull.Email;
        }
    }

    public class UserAnswer
    {
        [ValidateNonEmpty("Security Question Required")]
        [ValidateInteger]
        public int? SecurityQuestion { get; set; }
        [ValidateNonEmpty("Security Answer Required")]
        public string SecurityAnswer { get; set; }
        [ValidateNonEmpty("Password Required")]
        public string Password { get; set; }
        
        public ErrorSummary Validate()
        {
            ValidatorRunner vr = new ValidatorRunner(true, new CachedValidationRegistry());
            if (!vr.IsValid(this))
                return vr.GetErrorSummary(this);
            else
                return null;
        }

        public UserAnswer() { }
        public UserAnswer(UserFull userFull)
        {
            this.SecurityQuestion = userFull.SecurityQuestion;
            this.Password = userFull.Password;
            this.SecurityAnswer = userFull.SecurityAnswer;
        }
    }

    public class UserEmail
    {
        [ValidateEmail("Please enter a valid email address")]
        public string Email { get; set; }

        public ErrorSummary Validate()
        {
            ValidatorRunner vr = new ValidatorRunner(true, new CachedValidationRegistry());
            if (!vr.IsValid(this))
                return vr.GetErrorSummary(this);
            else
                return null;
        }

        public UserEmail() {}
        public UserEmail(UserFull userFull)
        {
            this.Email = userFull.Email;
        }
        public UserEmail(UserRegistration userRegistration)
        {
            this.Email = userRegistration.Email;
        }
    }

    public class UserPassword
    {
        [ValidateNonEmpty("Old Password required")]
        public string OldPassword { get; set; }

        //[ValidateNotSameAs("OldPassword", "Same Password")]
        [ValidateNonEmpty("New Password required")]
        public string NewPassword { get; set; }

        [ValidateSameAs("NewPassword", "Dont match")]
        [ValidateNonEmpty("Password Confirmation required")]
        public string ConfirmPassword { get; set; }

        public ErrorSummary Validate()
        {
            ValidatorRunner vr = new ValidatorRunner(true, new CachedValidationRegistry());
            if (!vr.IsValid(this))
                return vr.GetErrorSummary(this);
            else
                return null;
        }

        public UserPassword() {}
        public UserPassword(UserFull userFull)
        {
            this.NewPassword = "";
            this.ConfirmPassword = "";
        }
        public UserPassword(UserRegistration userRegistration)
        {
            this.NewPassword = userRegistration.Password;
            this.ConfirmPassword = userRegistration.ConfirmPassword;
        }
        public UserPassword(string OldPassword, string NewPassword, string ConfirmPassword)
        {
            this.ConfirmPassword = ConfirmPassword;
            this.NewPassword = NewPassword;
            this.OldPassword = OldPassword;
        }
    }
 
}
