using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core.ThirdParties;
using SharpArch.Core.PersistenceSupport;
using FashionAde.Core.Views;

namespace FashionAde.Core.DataInterfaces
{
    public interface IOutfitUpdaterRepository : IRepository<OutfitUpdater>
    {
        OutfitUpdater Get(string externalId);
        bool HasUpdaters(OutfitUpdaterStatus atLeastFrom, Season currentSeason);
        IList<OutfitUpdater> GetFor(Partner partner);
        IList<OutfitUpdater> GetFor(Silouhette silouhette, ColorFamily colorFamily, int pageNumber, int pageSize, out int totalCount);
        IList<OutfitUpdater> GetOnly(params OutfitUpdaterStatus[] status);
        IList<OutfitUpdaterView> GetFiltered(params OutfitUpdaterStatus[] status);
        void ProcessOutfitUpdatersByPreCombinationsFile(string fileName);
        void ChangeOutfitUpdatersStatus();
        void ChangeOutfitUpdatersStatus(OutfitUpdaterStatus from, OutfitUpdaterStatus to);
        void ChangeOutfitUpdatersStatus(OutfitUpdaterStatus from, OutfitUpdaterStatus to, Season currentSeason);
        OutfitUpdater GetRandomOutfitUpdaterFor(PreCombination preCombination);
    }
}
