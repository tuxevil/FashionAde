
using System;
using System.Collections.Generic;
using FashionAde.Core;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.OutfitCombination;
using SharpArch.Data.NHibernate;

namespace FashionAde.ApplicationServices.SearchEngine
{
    public class IndexCreationService : IIndexCreationService
    {
        private IClosetRepository _closetRepository;
        private IClosetOutfitRepository _closetOutfitRepository;
        private const int Quantity = 10000;

        public IndexCreationService(IClosetRepository cr, IClosetOutfitRepository cor)
        {
            _closetRepository = cr;
            _closetOutfitRepository = cor;
        }

        public void IndexPendingOutfits(Closet closet)
        {
            IList<SearchEngineEntry> entries = new List<SearchEngineEntry>();

            var propertyValues = new Dictionary<string, object>();
            propertyValues.Add("Closet.Id", closet.Id);
            propertyValues.Add("Status", ClosetOutfitStatus.NotIndexed);

            IList<ClosetOutfit> lstNewOutfits = _closetOutfitRepository.FindAll(propertyValues);
            if (lstNewOutfits.Count > 0)
            {
                foreach (ClosetOutfit ou in lstNewOutfits)
                    entries.Add(ou.ToSearchEngineEntry());

                using (SearchEngineService ses = SearchEngineService.GetByCloset(closet.Id))
                    ses.AddEntries(entries);

                _closetOutfitRepository.ChangeStatus(closet.Id, ClosetOutfitStatus.NotIndexed, ClosetOutfitStatus.Ready);
            }
        }

        public void CreateIndividualIndex(int closetId)
        {
            CreateIndex(_closetRepository.Get(closetId));
        }

        public void CreateIndexes()
        {
            IList<Closet> closets = _closetRepository.GetAll();
            foreach (Closet closet in closets)
                CreateIndex(closet);
        }

        private void CreateIndex(Closet closet)
        {

#if !DEBUG
            //if (closet.Id == 144 || closet.Id == 30 || closet.Id == 11 || closet.Id == 2)
            //    return;

            //if (closet.Id != 144 && closet.Id != 30 && closet.Id != 11 && closet.Id != 2)
            //    return;
#endif
            using (SearchEngineService ses = SearchEngineService.GetByCloset(closet.Id))
            {
                int start = 0;
                int count = _closetOutfitRepository.GetCountByCloset(closet.Id);

                while (start < count)
                {
                    IList<SearchEngineEntry> lst = new List<SearchEngineEntry>();

                    IList<ClosetOutfit> lstOutfits = _closetOutfitRepository.GetByClosetPaged(closet.Id, start, Quantity);
                    if (lstOutfits == null)
                        break;

                    foreach (ClosetOutfit closetOutfit in lstOutfits)
                    {
                        SearchEngineEntry see = closetOutfit.ToSearchEngineEntry();
                        lst.Add(see);
                    }

                    ses.AddEntries(lst);

                    start += Quantity;
                    GC.Collect();
                }
            }

            NHibernateSession.Current.Clear();
            GC.Collect();
        }
    }
}
