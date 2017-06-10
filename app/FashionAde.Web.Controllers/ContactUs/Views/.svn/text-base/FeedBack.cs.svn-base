using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using FashionAde.Core.ContentManagement;
using FashionAde.Utils.Validators;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public class FeedBack
    {
        [Required(ErrorMessage = "Email required")]
        [Email(ErrorMessage = "Email is invalid")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Name required")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Message required")]
        public string Message { get; set; }

        public IList<ContentPublishedSection> Content { get; set; }
    }
}
