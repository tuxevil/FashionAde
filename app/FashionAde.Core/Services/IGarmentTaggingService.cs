using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;

namespace FashionAde.Core.Services
{
    public interface IGarmentTaggingService
    {
        UserGarment g { get; set;}
        IList<Tag> TagsToApply { get; set; }
        GarmentVisibility Visibility { get; set; }

        void TagGarment();
    }
}
