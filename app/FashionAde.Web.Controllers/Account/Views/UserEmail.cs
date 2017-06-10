using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;
using FashionAde.Utils.Validators;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public class UserEmail
    {
        [Required(ErrorMessage = "Email Required")]
        [Email(ErrorMessage = "Email is invalid")]
        public string Email { get; set; }

        public UserEmail() { }
        public UserEmail(UserFull userFull)
        {
            this.Email = userFull.Email;
        }
        public UserEmail(UserRegistration userRegistration)
        {
            this.Email = userRegistration.Email;
        }
    }
}
