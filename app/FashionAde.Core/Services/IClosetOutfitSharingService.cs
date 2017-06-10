using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FashionAde.Core.Services
{
    public interface IClosetOutfitSharingService
    {
        ClosetOutfit OutfitToShare { get; set; }
        IList<ISharingService> SharingServices { get; set;}
        void ShareOutfit();
    }
}
