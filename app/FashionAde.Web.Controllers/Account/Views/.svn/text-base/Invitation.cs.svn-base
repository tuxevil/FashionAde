using System.ComponentModel.DataAnnotations;
using FashionAde.Utils.Validators;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public class Invitation
    {
        [Required(ErrorMessage = "Email required")]
        [Email(ErrorMessage = "Email is invalid")]
        public string EmailAdress { get; set; }
    }
}
