using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using FashionAde.Core.Views;
using FashionAde.Core.ThirdParties;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public class FriendRatingView
    {
        public int InvitationId { get; set; }
        public int ClosetOutfitId { get; set; }
        public string UserName { get; set; }

        public OutfitUpdater Updater { get; set; }
        public ClosetOutfitView ClosetOutfit { get; set; }

        [Required]
        [Range(1,5)]
        public int FriendRating {get; set;} 

        [Required]
        [StringLength(100)]
        public string Comment { get; set; }
    }
}
