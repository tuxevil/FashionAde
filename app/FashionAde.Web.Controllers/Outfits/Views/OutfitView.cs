using System.Collections.Generic;
using FashionAde.Core;
using FashionAde.Core.ContentManagement;
using FashionAde.Core.Views;
using FashionAde.Web.Common;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    /// <summary>
    /// Vista utilizada para mostrar distinta información de los outfits.
    /// </summary>
    public class OutfitView
    {
        public Closet Closet {get; set; }
        public string Season { get; set; }
        public int TotalOutfits { get; set; }        
        public string PrivacyLevel { get; set; }
        public IList<ClosetOutfitView> Outfits { get; set; }
        public IList<ContentPublishedSection> StyleAlerts { get; set; }
        public string UserName { get; set; }
        public string FilterText { get; set; }
        public string FavoriteOutfit  { get; set; }
        public int FavoriteOutfitId { get; set; }
        public string CurrentPage { get; set; }
        public bool ShowAsPublicCloset { get; set; }
        public OutfitSearch Search { get; set; }
        public Pager Pager { get; set; }
    }

    public class OutfitViewLight
    {
        public int TotalOutfits { get; set; }
        public IList<ClosetOutfitViewLight> Outfits { get; set; }
        public Pager Pager { get; set; }
        //TODO: This part
        //public IList<ContentPublishedSection> StyleAlerts { get; set; }

        public OutfitViewLight(OutfitView outfitView)
        {
            this.TotalOutfits = outfitView.TotalOutfits;
            this.Outfits = new List<ClosetOutfitViewLight>();
            foreach (ClosetOutfitView closetOutfitView in outfitView.Outfits)
                this.Outfits.Add(new ClosetOutfitViewLight(closetOutfitView));
            this.Pager = outfitView.Pager;

        }
    }
}