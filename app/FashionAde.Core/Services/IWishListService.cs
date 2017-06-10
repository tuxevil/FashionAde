using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Accounts;
using FashionAde.Core.Clothing;

namespace FashionAde.Core.Services
{
    public interface IWishListService
    {
        Garment Garment { get; set;}
        Closet Closet { get; set; }

        ClosetGarment MoveGarmentToUserCloset();
    }
}
