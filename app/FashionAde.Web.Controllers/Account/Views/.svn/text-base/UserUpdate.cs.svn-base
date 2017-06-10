using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public class UserUpdate
    {
        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string PhoneNumber { get; set; }

        public string PrivacyStatus { get; set; }

        [Required(ErrorMessage = "Zip Code Required")]
        public string ZipCode { get; set; }

        public string Email { get; set; }

        public UserUpdate() { }
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
}
