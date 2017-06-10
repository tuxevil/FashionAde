using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Utils.Validators;
using System.ComponentModel.DataAnnotations;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    [PropertiesMatchAttribute("NewPassword", "ConfirmPassword", ErrorMessage = "Password does not match.")]
    public class UserPassword
    {
        [Required(ErrorMessage = "Old Password Required")]
        public string OldPassword { get; set; }

        [Required(ErrorMessage = "New Password Required")]
        public string NewPassword { get; set; }

        [Required(ErrorMessage = "Password Confirmation Required")]
        public string ConfirmPassword { get; set; }

        public UserPassword() { }
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
