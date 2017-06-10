using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core;
using FashionAde.Core.Accounts;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.Views;
using FashionAde.Core.OutfitCombination;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core.ThirdParties;
using NHibernate;
using NHibernate.Criterion;
using NHibernate.SqlCommand;
using NHibernate.Type;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class ClosetOutfitRepository : Repository<ClosetOutfit>, IClosetOutfitRepository
    {
        #region Can Copy

        public bool CanCopyOutfit(int closetOutfitId, int closetId)
        {
            ICriteria crit = Session.CreateCriteria(typeof(ClosetOutfit));
            crit.Add(Expression.Eq("Closet", new Closet(closetId)));
            crit.Add(Expression.Eq("Id", closetOutfitId));
            return crit.List<ClosetOutfit>().Count == 0;
        }

        #endregion

        #region Read Complete Outfit

        public ClosetOutfitView GetByClosetOutfitId(int closetOutfitId)
        {
            ClosetOutfit closetOutfit = Get(closetOutfitId);
            if (closetOutfit == null)
                return null;
            ICriteria closet;
            ICriteria crit = GetCrit(out closet);

            crit.Add(Expression.Eq("co.Id", closetOutfitId));
            crit.SetResultTransformer(new NHibernate.Transform.AliasToBeanConstructorResultTransformer(typeof(ClosetOutfitView).GetConstructors()[0]));

            ClosetOutfitView tempOV = crit.UniqueResult<ClosetOutfitView>();
            if (tempOV == null)
                return null;

            List<ClosetOutfitView> result = new List<ClosetOutfitView>();
            result.Add(tempOV);

            ClosetOutfitView view = GetComponents(result, null)[0];
            view.ClosetOutfit = closetOutfit;
            return view;
        }

        private IList<ClosetOutfitGarmentView> GetComponentList(IList<ClosetOutfitView> outfits, Closet closet)
        {
            if (outfits.Count == 0)
                return new List<ClosetOutfitGarmentView>();

            string where = " where ";

            string outfitIds = "";
            if (closet != null)
            {
                where += "co.closetid= " + closet.Id;
                outfitIds = " and ";
            }
            outfitIds += "ClosetOutfitId in (";
            foreach (ClosetOutfitView closetOutfitView in outfits)
                outfitIds += closetOutfitView.ClosetOutfitId + ",";

            outfitIds = outfitIds.Substring(0, outfitIds.Length - 1) + ")";

            where += outfitIds;
            where += " and g.GarmentId != 0";
            int i = 1;
            string query = "";
            for (; i <= 13; i++)
            {
                query += "select `co`.`closetoutfitid` AS `ClosetOutfitId`,`g`.`Title` AS `Title`,`g`.`ImageUri` AS `ImageUri`,`g`.`GarmentId` AS `GarmentId` from (`closetoutfits` `co` join `garments` `g` on((`co`.`Garment" + i + "Id` = `g`.`GarmentId`))) " + where + " union ";
            }
            query = query.Substring(0, query.Length - 7);

            IQuery q = NHibernateSession.Current.CreateSQLQuery(query);
            q.SetResultTransformer(new NHibernate.Transform.AliasToBeanConstructorResultTransformer(typeof(ClosetOutfitGarmentView).GetConstructors()[1]));
            return q.List<ClosetOutfitGarmentView>();
        }

        #endregion

        #region Find Top Rated By User

        public IList<ClosetOutfitView> GetTopRatedOutfits(int userId)
        {
            IRegisteredUserRepository registeredUserRepository = new RegisteredUserRepository();
            RegisteredUser user = registeredUserRepository.Get(userId);
            ICriteria crit = GetCrit(user, 0, "");

            crit.AddOrder(new Order("co.Rating.FriendRatingAverage", false));
            crit.AddOrder(new Order("co.Rating.MyRating", false));
            crit.AddOrder(new Order("co.Rating.EditorRating", false));

            crit.SetMaxResults(2);

            crit.SetResultTransformer(new NHibernate.Transform.AliasToBeanConstructorResultTransformer(typeof(ClosetOutfitView).GetConstructors()[0]));

            IList<ClosetOutfitView> result = crit.List<ClosetOutfitView>();
            foreach (ClosetOutfitView closetOutfitView in result)
            {
                closetOutfitView.Disabled = true;
                closetOutfitView.SendToFriends = false;
            }
            return GetComponents(result, user.Closet);
        }

        public bool HaveBeenRated(int closetId)
        {
            ICriteria crit = Session.CreateCriteria(typeof(ClosetOutfit));
            crit.Add(Expression.Eq("Closet.Id", closetId));
            crit.Add(Expression.Gt("Rating.FriendRatingAverage", Convert.ToSingle(0)));

            return crit.List<ClosetOutfit>().Count > 0;
        }

        #endregion

        #region Search My Outfits

        public IList<ClosetOutfitView> Search(out int totalCount, int pageSize, int pageNumber, int season, string search, string sortBy, RegisteredUser user)
        {
            ICriteria crit = GetCrit(user, season, search);
            crit.SetProjection(Projections.ProjectionList().Add(Projections.Count("Id")));
            totalCount = crit.UniqueResult<int>();
            if (totalCount == 0)
                return new List<ClosetOutfitView>();

            crit = GetCrit(user, season, search);
            crit.SetMaxResults(pageSize);

            if (pageNumber == -1)
                if (totalCount % 10 > 0)
                    pageNumber = (totalCount / pageSize) + 1;
                else
                    pageNumber = (totalCount / pageSize);

            crit.SetFirstResult((pageNumber * pageSize) - (pageSize));

            switch (sortBy)
            {
                case "1":
                    crit.AddOrder(new Order("co.Rating.EditorRating", false));
                    break;
                case "2":
                    crit.AddOrder(new Order("co.Rating.MyRating", false));
                    break;
                case "3":
                    crit.AddOrder(new Order("pc.AverageFriendRating", false));
                    break;
                case "4":
                    crit.AddOrder(new Order("d.WornDate", false));
                    break;
            }
            crit.AddOrder(new Order("co.Id", true));

            crit.SetResultTransformer(new NHibernate.Transform.AliasToBeanConstructorResultTransformer(typeof(ClosetOutfitView).GetConstructors()[0]));

            return GetComponents(crit.List<ClosetOutfitView>(), user.Closet);
        }

        public IList<ClosetOutfitView> Search(List<int> lstIds, int closetId)
        {
            ICriteria closet;
            ICriteria crit = GetCrit(out closet);

            closet.Add(Expression.Eq("Id", closetId));
            crit.Add(Expression.In("Id", lstIds));

            crit.SetResultTransformer(new NHibernate.Transform.AliasToBeanConstructorResultTransformer(typeof(ClosetOutfitView).GetConstructors()[0]));

            List<ClosetOutfitView> result = new List<ClosetOutfitView>(crit.List<ClosetOutfitView>());
            IList<ClosetOutfitView> orderedResults = new List<ClosetOutfitView>();

            foreach (int id in lstIds)
                orderedResults.Add(result.Find(x => x.Id == id));

            return GetComponents(orderedResults, new Closet(closetId));
        }

        private IList<ClosetOutfitView> GetComponents(IList<ClosetOutfitView> result, Closet closet)
        {
            List<ClosetOutfitGarmentView> components = GetComponentList(result, closet) as List<ClosetOutfitGarmentView>;

            foreach (ClosetOutfitView outfitView in result)
            {
                outfitView.OutfitGarments.AddRange(components.FindAll(delegate(ClosetOutfitGarmentView record)
                {
                    if (record.ClosetOutfitId == outfitView.ClosetOutfitId && record.GarmentId != 0)
                    {
                        return true;
                    }
                    return false;
                }));
                
                outfitView.OutfitUpdater = new OutfitUpdaterRepository().GetRandomOutfitUpdaterFor(outfitView.PreCombination);
                outfitView.ShortEventTypes = GetShortNames(new EventTypeRepository().GetByCode(ResolveBinaryCode(outfitView.EventTypes)));
            }
            return result;
        }
        
        private ICriteria GetCrit(RegisteredUser user, int season, string search)
        {
            string[] searchlist = search.Split(' ');
            ICriteria closet;
            ICriteria crit = GetCrit(out closet);

            closet.Add(Expression.Eq("Id", user.Closet.Id));
            crit.Add(Expression.Eq("Status", ClosetOutfitStatus.Ready));

            Disjunction dj = new Disjunction();
            foreach (UserFlavor uf in user.UserFlavors)
                dj.Add(Expression.Eq("co.FashionFlavor", uf.Flavor));
            crit.Add(dj);

            int sum = 0;
            foreach (EventType et in user.EventTypes)
                sum += et.BinaryNumber;

            crit.Add(Restrictions.Gt(Projections.SqlProjection("(this_.EventTypes & " + sum + ") as bitWiseResult2", new[] { "bitWiseResult" }, new IType[] { NHibernateUtil.Int32 }), 0));

            if (season > 0 & season < (int)Season.All)
                crit.Add(Restrictions.Gt(Projections.SqlProjection("(this_.Seasons & " + season + ") as bitWiseResult", new[] { "bitWiseResult" }, new IType[] { NHibernateUtil.Int32 }), 0));

            if (search.Length > 0 && !string.IsNullOrEmpty(search))
            {
                ICriteria Garment1 = crit.CreateCriteria("Garment1", "garment1", JoinType.LeftOuterJoin);
                ICriteria Garment2 = crit.CreateCriteria("Garment2", "garment2", JoinType.LeftOuterJoin);
                ICriteria Garment3 = crit.CreateCriteria("Garment3", "garment3", JoinType.LeftOuterJoin);
                ICriteria Garment4 = crit.CreateCriteria("Garment4", "garment4", JoinType.LeftOuterJoin);
                ICriteria Garment5 = crit.CreateCriteria("Garment5", "garment5", JoinType.LeftOuterJoin);
                ICriteria Garment6 = crit.CreateCriteria("Garment6", "garment6", JoinType.LeftOuterJoin);
                ICriteria Garment7 = crit.CreateCriteria("Garment7", "garment7", JoinType.LeftOuterJoin);
                ICriteria Garment8 = crit.CreateCriteria("Garment8", "garment8", JoinType.LeftOuterJoin);
                ICriteria Garment9 = crit.CreateCriteria("Garment9", "garment9", JoinType.LeftOuterJoin);
                ICriteria Garment10 = crit.CreateCriteria("Garment10", "garment10", JoinType.LeftOuterJoin);
                ICriteria Garment11 = crit.CreateCriteria("Garment11", "garment11", JoinType.LeftOuterJoin);
                ICriteria Garment12 = crit.CreateCriteria("Garment12", "garment12", JoinType.LeftOuterJoin);
                ICriteria Garment13 = crit.CreateCriteria("Garment13", "garment13", JoinType.LeftOuterJoin);

                Disjunction d = new Disjunction();
                d.Add(FilterGarment(searchlist, 1));
                d.Add(FilterGarment(searchlist, 2));
                d.Add(FilterGarment(searchlist, 3));
                d.Add(FilterGarment(searchlist, 4));
                d.Add(FilterGarment(searchlist, 5));
                d.Add(FilterGarment(searchlist, 6));
                d.Add(FilterGarment(searchlist, 7));
                d.Add(FilterGarment(searchlist, 8));
                d.Add(FilterGarment(searchlist, 9));
                d.Add(FilterGarment(searchlist, 10));
                d.Add(FilterGarment(searchlist, 11));
                d.Add(FilterGarment(searchlist, 12));
                d.Add(FilterGarment(searchlist, 13));
                crit.Add(d);
            }

            return crit;
        }

        private ICriteria GetCrit(out ICriteria closet)
        {
            ICriteria crit = Session.CreateCriteria(typeof(ClosetOutfit), "co");
            ICriteria precomb = crit.CreateCriteria("PreCombination", "pc");
            closet = crit.CreateCriteria("Closet", "cl");
            ICriteria maxdetail = crit.CreateCriteria("Detail", "d", JoinType.LeftOuterJoin);

            crit.SetProjection(Projections.ProjectionList().Add(Projections.Property("co.Id"))
                                   .Add(Projections.Property("co.Rating.FriendRatingAverage"))
                                   .Add(Projections.Property("pc.AverageUserRating"))
                                   .Add(Projections.Property("pc.AverageWearRating"))
                                   .Add(Projections.Property("co.Rating.EditorRating"))
                                   .Add(Projections.Property("d.WornDate"))
                                   .Add(Projections.Property("d.Location"))
                                   .Add(Projections.Property("co.Rating.MyRating"))
                                   .Add(Projections.Property("pc.Id"))
                                   .Add(Projections.Property("co.EventTypes"))
                );
            return crit;
        }

        private Conjunction FilterGarment(string[] searchlist, int number)
        {
            Conjunction c = new Conjunction();
            
            foreach (string s in searchlist)
                c.Add(Expression.Or(Expression.InsensitiveLike(string.Format("garment{0}.Title",number), s, MatchMode.Anywhere),Expression.InsensitiveLike(string.Format("garment{0}.Keywords",number), s, MatchMode.Anywhere)));

            c.Add(Expression.Not(Expression.Eq(string.Format("garment{0}.Id", number), 0)));

            return c;
        }

        private List<int> ResolveBinaryCode(int binaryCode)
        {
            List<int> result = new List<int>();
            for (int start = 16; start > 0; start = start / 2)
                if (binaryCode - start >= 0)
                {
                    binaryCode = binaryCode - start;
                    result.Add(start);
                }
            result.Reverse();
            return result;
        }

        private string GetShortNames(IList<EventType> eventTypes)
        {
            string name = string.Empty;
            List<string> alreadyNames = new List<string>();
            foreach (EventType eventType in eventTypes)
            {
                if (alreadyNames.Exists(e => e.Equals(eventType.ShortName)))
                    continue;
                name += eventType.ShortName + "/";
                alreadyNames.Add(eventType.ShortName);
            }
            return name.TrimEnd('/') + " ";
        }

        #endregion

        public void ChangeStatus(int closetId, ClosetOutfitStatus fromStatus, ClosetOutfitStatus toStatus)
        {
            string query = string.Format("call uspUpdateOutfitStatus({0},{1},{2});", closetId, (int)fromStatus, (int)toStatus);
            IQuery q = NHibernateSession.Current.CreateSQLQuery(query);
            q.ExecuteUpdate();
        }

        public int GetCountByCloset(int closetId)
        {
            ICriteria crit = Session.CreateCriteria<ClosetOutfit>();
            crit.Add(Expression.Eq("Closet.Id", closetId));
            crit.SetProjection(Projections.Count("Id"));
            return crit.UniqueResult<int>();
        }

        public IList<ClosetOutfit> GetByClosetPaged(int closetId, int start, int quantity)
        {
            ICriteria crit = Session.CreateCriteria<ClosetOutfit>();
            crit.Add(Expression.Eq("Closet.Id", closetId));

            for (int i = 1; i <= 13; i++ )
            {
                string fetchEntity = string.Format("Garment{0}", i);
                crit.SetFetchMode(fetchEntity, FetchMode.Join);
                crit.SetFetchMode(fetchEntity + ".Tags.Silouhette", FetchMode.Join);
                crit.SetFetchMode(fetchEntity + ".Tags.Category", FetchMode.Join);
                crit.SetFetchMode(fetchEntity + ".Tags.DefaultColor", FetchMode.Join);
                crit.SetFetchMode(fetchEntity + ".Tags.Pattern", FetchMode.Join);
            }

            crit.SetMaxResults(quantity);
            crit.SetFirstResult(start);
            return crit.List<ClosetOutfit>();
        }
    }
}
