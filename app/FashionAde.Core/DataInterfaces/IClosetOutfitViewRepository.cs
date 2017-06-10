using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.MVCInteraction;
using SharpArch.Core.PersistenceSupport;

namespace FashionAde.Core.DataInterfaces
{
    public interface IClosetOutfitViewRepository : IRepository<ClosetOutfitView>
    {
        IList<ClosetOutfitView> Search(out int totalcount, int pageSize, int pageNumber, int season, int userId, string search, string sortBy, Closet closet);
        ClosetOutfitView GetByClosetOutfitId(int closetOutfitId);
        IList<ClosetOutfitView> GetTopRatedOutfits(int userId);
    }
}
