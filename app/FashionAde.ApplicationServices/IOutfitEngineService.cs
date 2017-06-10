using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core;
using FashionAde.Core.Clothing;

namespace FashionAde.ApplicationServices
{
    public interface IOutfitEngineService
    {
        void CreatePreCombinations(IList<FashionFlavor> flavors, IList<PreGarment> garments);
        void RunOutfitGenerator(Closet closet);
    }
}
