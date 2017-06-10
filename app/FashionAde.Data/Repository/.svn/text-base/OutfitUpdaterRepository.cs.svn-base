using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core.ThirdParties;
using FashionAde.Core.Views;
using NHibernate;
using NHibernate.Criterion;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class OutfitUpdaterRepository : Repository<OutfitUpdater>, IOutfitUpdaterRepository
    {
        #region Find an updater
        public OutfitUpdater Get(string externalId)
        {
            ICriteria crit = Session.CreateCriteria(typeof(OutfitUpdater));
            crit.Add(Expression.Eq("ExternalId", externalId));
            return crit.UniqueResult<OutfitUpdater>();
        }
        #endregion

        #region List Methods

        public IList<OutfitUpdater> GetFor(Partner partner)
        {
            ICriteria crit = Session.CreateCriteria(typeof(OutfitUpdater));
            crit.Add(Expression.Eq("Partner.Id", partner.Id));
            return crit.List<OutfitUpdater>();
        }

        public IList<OutfitUpdater> GetFor(Silouhette silouhette, ColorFamily colorFamily, int pageNumber, int pageSize, out int totalCount)
        {
            ICriteria crit = Session.CreateCriteria(typeof (OutfitUpdater));
            crit.Add(Expression.Eq("Season", SeasonHelper.CurrentSeason));
            crit.CreateCriteria("Silouhette").Add(Expression.Eq("Id", silouhette.Id));
            crit.Add(Expression.Not(Expression.Ge("Status", OutfitUpdaterStatus.Valid)));
            totalCount =
                crit.SetProjection(Projections.ProjectionList().Add(Projections.Count("Id"))).UniqueResult<int>();

            string sizeandpage = pageSize.ToString();
            if (pageNumber > 1)
                sizeandpage += ", " + pageSize;
            string query = string.Format("SELECT ou.outfitupdaterid, ou.description, ou.name, ou.price, ou.buyurl, ou.imageurl, p.Code, p.Name, ou.silouhetteid FROM outfitupdaters ou inner join partners p ON ou.PartnerId = p.PartnerId inner join silouhettes s ON ou.SilouhetteId = s.SilouhetteId WHERE ou.Status >= {0} and ou.Season = {3} and s.CategoryId = {1} ORDER BY RAND() LIMIT {2};", Convert.ToInt32(OutfitUpdaterStatus.Valid), silouhette.Category.Id, sizeandpage, (int)SeasonHelper.CurrentSeason);
            IQuery q = Session.CreateSQLQuery(query);
            q.SetResultTransformer(new NHibernate.Transform.AliasToBeanConstructorResultTransformer(typeof(OutfitUpdater).GetConstructors()[3]));
            return q.List<OutfitUpdater>();
        }

        #endregion

        #region Outfit Updater Process

        public IList<OutfitUpdater> GetOnly(params OutfitUpdaterStatus[] status)
        {
            ICriteria crit = Session.CreateCriteria(typeof(OutfitUpdater));

            crit.Add(Expression.Eq("Season", SeasonHelper.CurrentSeason));

            Disjunction d = new Disjunction();
            foreach (OutfitUpdaterStatus ous in status)
                d.Add(Expression.Eq("Status", ous));

            crit.Add(d);

            // Fetch everything we can to avoid select on the loops.
            crit.SetFetchMode("Silouhette", FetchMode.Join);
            crit.SetFetchMode("Silouhette.Structure", FetchMode.Join);
            crit.SetFetchMode("Silouhette.Shape", FetchMode.Join);
            crit.SetFetchMode("ColorFamily", FetchMode.Join);
            crit.SetFetchMode("ColorFamily.AnalogousFamily", FetchMode.Join);
            crit.SetFetchMode("ColorFamily.AnalogousFamily2", FetchMode.Join);
            crit.SetFetchMode("ColorFamily.ComplimentaryFamily", FetchMode.Join);
            crit.SetFetchMode("Pattern", FetchMode.Join);

            return crit.List<OutfitUpdater>();
        }

        public IList<OutfitUpdaterView> GetFiltered(params OutfitUpdaterStatus[] status)
        {
            ICriteria crit = Session.CreateCriteria(typeof(OutfitUpdater));

            crit.Add(Expression.Eq("Season", SeasonHelper.CurrentSeason));

            Disjunction d = new Disjunction();
            foreach (OutfitUpdaterStatus ous in status)
                d.Add(Expression.Eq("Status", ous));

            crit.Add(d);

            crit.SetProjection(Projections.Property("Id"),
                   Projections.Property("BuyUrl"),
                   Projections.Property("Name"),
                   Projections.Property("ImageUrl"));

            crit.SetResultTransformer(new NHibernate.Transform.AliasToBeanConstructorResultTransformer(typeof(OutfitUpdaterView).GetConstructors()[1]));

            return crit.List<OutfitUpdaterView>();
        }

        public void ProcessOutfitUpdatersByPreCombinationsFile(string fileName)
        {
            string query = "LOAD DATA INFILE '{0}' IGNORE INTO TABLE outfitupdaterbyprecombinations ";
            query += "FIELDS TERMINATED BY ','";
            query += "LINES TERMINATED BY '\r\n' STARTING BY '' ";
            query += "(OutfitUpdaterId, PreCombinationId);";

            query = string.Format(query, fileName.Replace(@"\", @"\\"));

            IQuery q = NHibernateSession.Current.CreateSQLQuery(query);
            q.ExecuteUpdate();
        }

        public void ChangeOutfitUpdatersStatus(OutfitUpdaterStatus from, OutfitUpdaterStatus to)
        {
            string query = string.Format("call uspUpdateOutfitUpdaterStatus({0},{1});", (int)from, (int)to);
            IQuery q = NHibernateSession.Current.CreateSQLQuery(query);
            q.ExecuteUpdate();
        }

        public void ChangeOutfitUpdatersStatus(OutfitUpdaterStatus from, OutfitUpdaterStatus to, Season currentSeason)
        {
            string query = string.Format("call uspUpdateOutfitUpdaterStatusPerSeason({0},{1},{2});", (int)from, (int)to, (int)currentSeason);
            IQuery q = NHibernateSession.Current.CreateSQLQuery(query);
            q.ExecuteUpdate();
        }

        public void ChangeOutfitUpdatersStatus()
        {
            ChangeOutfitUpdatersStatus(OutfitUpdaterStatus.Valid, OutfitUpdaterStatus.Processed);
        }

        #endregion

        #region Find Random Updater per Precombination

        public OutfitUpdater GetRandomOutfitUpdaterFor(PreCombination preCombination)
        {
            string query = "SELECT oubpc.outfitupdaterid, ou.description, ou.name, ou.price, ou.buyurl, ou.imageurl, p.Code, p.Name, ou.silouhetteid FROM outfitupdaterbyprecombinations oubpc ";
            query += "inner join outfitupdaters ou ON oubpc.OutfitUpdaterId = ou.OutfitUpdaterId ";
            query += "inner join outfitupdatersbytrend oubt ON oubt.OutfitUpdaterId = ou.OutfitUpdaterId ";
            query += "inner join partners p on ou.PartnerId = p.PartnerId ";
            query += "inner join trends t ON oubt.TrendId = t.TrendId ";
            query += string.Format("where t.IsEnabled = 1 and t.Season = {1} and ou.Status >= {2} and oubpc.precombinationid = {0} ORDER BY RAND() LIMIT 1;", 
                preCombination.Id,
                (int)SeasonHelper.CurrentSeason,
                (int)OutfitUpdaterStatus.Processed);

            IQuery q = Session.CreateSQLQuery(query);

            q.SetResultTransformer(new NHibernate.Transform.AliasToBeanConstructorResultTransformer(typeof(OutfitUpdater).GetConstructors()[3]));
            return q.UniqueResult<OutfitUpdater>();
        }

        #endregion

        #region Verify Updaters

        public bool HasUpdaters(OutfitUpdaterStatus atLeastFrom, Season currentSeason)
        {
            ICriteria crit = Session.CreateCriteria(typeof(OutfitUpdater));
            crit.Add(Expression.Ge("Status", atLeastFrom));
            crit.Add(Expression.Eq("Season", currentSeason));
            crit.SetProjection(Projections.Count("Id"));
            int count = crit.UniqueResult<int>();

            return (count != 0);
        }

        #endregion
    }
}
