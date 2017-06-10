using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;

namespace FashionAde.Web.Controllers.Account.Views
{
    public class UserLogin
    {
        [Required(ErrorMessage = "UserName Required")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Password Required")]
        public string Password { get; set; }

        public bool? RememberMe { get; set; }

        public string ReturnUrl { get; set; }
    }
}
