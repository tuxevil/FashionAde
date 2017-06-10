using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public class UserAnswer
    {
        public int? SecurityQuestion { get; set; }
        [Required(ErrorMessage = "Security Answer Required")]
        public string SecurityAnswer { get; set; }
        [Required(ErrorMessage = "Password Required")]
        public string Password { get; set; }

        public UserAnswer() { }
        public UserAnswer(UserFull userFull)
        {
            this.SecurityQuestion = userFull.SecurityQuestion;
            this.Password = userFull.Password;
            this.SecurityAnswer = userFull.SecurityAnswer;
        }
    }
}
