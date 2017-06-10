using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Security;
using FashionAde.Core.Accounts;
using FashionAde.Utils.Validators;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    [Serializable]
    public class UserRegistrationSerializable
    {
        public string Email { get; set; }
        public string EmailConfirmation { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public int? SecurityQuestion { get; set; }
        public string SecurityAnswer { get; set; }
        public string ZipCode { get; set; }
        public string InvitationCode { get; set; }
        public bool TermOfUse { get; set; }
        public int? UserSize { get; set; }
        
        public UserRegistrationSerializable(UserRegistration userRegistration)
        {
            this.ConfirmPassword = userRegistration.ConfirmPassword;
            this.Email = userRegistration.Email;
            this.EmailConfirmation = userRegistration.EmailConfirmation;
            this.FirstName = userRegistration.FirstName;
            this.LastName = userRegistration.LastName;
            this.Password = userRegistration.Password;
            this.SecurityAnswer = userRegistration.SecurityAnswer;
            this.SecurityQuestion = userRegistration.SecurityQuestion;
            this.TermOfUse = userRegistration.TermOfUse;
            this.UserName = userRegistration.UserName;
            this.UserSize = userRegistration.UserSize;
            this.ZipCode = userRegistration.ZipCode;
        }
    }

    [PropertiesMatchAttribute("Password", "ConfirmPassword", ErrorMessage = "Password does not match.")]
    [EmailMatchAttribute("Email", "EmailConfirmation", ErrorMessage = "Email does not match.")]
    public class UserRegistration
    {
        [Required(ErrorMessage = "Email required")]
        [Email(ErrorMessage = "Email is invalid")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Email confirmation required")]
        [Email(ErrorMessage = "Email is invalid")]
        public string EmailConfirmation { get; set; }

        public string FirstName { get; set; }
        public string LastName { get; set; }

        [Required(ErrorMessage = "User Name required")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Password required")]
        public string Password { get; set; }

        [Required(ErrorMessage = "Password Confirmation required")]
        public string ConfirmPassword { get; set; }

        [Required(ErrorMessage = "Security Question required")]
        public int? SecurityQuestion { get; set; }

        [Required(ErrorMessage = "Security Answer required")]
        public string SecurityAnswer { get; set; }

        [Required(ErrorMessage = "Zip Code required")]
        public string ZipCode { get; set; }

        [Required(ErrorMessage = "Terms of Use are required")]
        public bool TermOfUse { get; set; }

        public int? UserSize { get; set; }

        public UserRegistration() { }
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

        public UserRegistration(UserRegistrationSerializable userRegistration)
        {
            this.ConfirmPassword = userRegistration.ConfirmPassword;
            this.Email = userRegistration.Email;
            this.EmailConfirmation = userRegistration.EmailConfirmation;
            this.FirstName = userRegistration.FirstName;
            this.LastName = userRegistration.LastName;
            this.Password = userRegistration.Password;
            this.SecurityAnswer = userRegistration.SecurityAnswer;
            this.SecurityQuestion = userRegistration.SecurityQuestion;
            this.TermOfUse = userRegistration.TermOfUse;
            this.UserName = userRegistration.UserName;
            this.UserSize = userRegistration.UserSize;
            this.ZipCode = userRegistration.ZipCode;
        }
    }









}
