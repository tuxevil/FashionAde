using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Accounts;
using FashionAde.Core.Clothing;
using FashionAde.Core.Views;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core.ThirdParties;
using SharpArch.Core.PersistenceSupport;
using FashionAde.Core.OutfitCombination;

namespace FashionAde.Core.DataInterfaces
{
    public interface IClosetOutfitRepository : IRepository<ClosetOutfit>
    {
        IList<ClosetOutfitView> Search(out int totalCount, int pageSize, int pageNumber, int season, string search, string sortBy, RegisteredUser user);
        IList<ClosetOutfitView> Search(List<int> lstIds, int closetId);
        ClosetOutfitView GetByClosetOutfitId(int closetOutfitId);
        IList<ClosetOutfitView> GetTopRatedOutfits(int userId);
        bool HaveBeenRated(int closetId);
        bool CanCopyOutfit(int closetOutfitId, int closetId);

        int GetCountByCloset(int closetId);
        IList<ClosetOutfit> GetByClosetPaged(int closetId, int start, int quantity);

        void ChangeStatus(int closetId, ClosetOutfitStatus fromStatus, ClosetOutfitStatus toStatus);
    }
}
