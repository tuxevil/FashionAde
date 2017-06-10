﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;
using SharpArch.Core.PersistenceSupport;
using FashionAde.Core.OutfitCombination;
using FashionAde.Core.Views;

namespace FashionAde.Core.DataInterfaces
{
    public interface IGarmentRepository : IRepository<Garment>
    {
        IList<Garment> GetForProcess(int closetId);
        IList<MasterGarment> GetBySelection(Silouhette silouhette, Fabric fabric, Pattern pattern, IList<EventType> selectedET, IList<ClosetGarment> closetGarments, IList<WishGarment> wishGarments);
        IList<LayerResponse> GetLayers(Array garmentIds);
        IList<Garment> GetByIds(IList<int> garmentsIds);
    }
}
