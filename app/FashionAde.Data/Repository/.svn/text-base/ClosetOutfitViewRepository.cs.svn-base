using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core;
using FashionAde.Core.Accounts;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.MVCInteraction;
using NHibernate;
using NHibernate.Criterion;
using NHibernate.SqlCommand;
using NHibernate.Type;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class ClosetOutfitViewRepository : Repository<ClosetOutfitView>, IClosetOutfitViewRepository
    {
        private IClosetOutfitRepository closetOutfitRepository;
        private IRegisteredUserRepository registeredUserRepository;

        public IList<ClosetOutfitView> Search(out int totalCount, int pageSize, int pageNumber, int season, int userId, string search, string sortBy, Closet closet)
        {
            ICriteria crit = GetCrit(userId, season, search);
            crit.SetProjection(Projections.ProjectionList().Add(Projections.Count("Id")));
            totalCount = crit.UniqueResult<int>();
            if (totalCount == 0)
                return new List<ClosetOutfitView>();

            crit = GetCrit(userId, season, search);
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
                    crit.AddOrder(new Order("EditorRating", false));
                    break;
                case "2":
                    crit.AddOrder(new Order("MyRating", false));
                    break;
                case "3":
                    crit.AddOrder(new Order("AverageFriendRating", false));
                    break;
                case "4":
                    crit.AddOrder(new Order("WornDate", false));
                    break;
            }

            return GetComponents(crit.List<ClosetOutfitView>(), closet);
        }

        private IList<ClosetOutfitView> GetComponents(IList<ClosetOutfitView> result, Closet closet)
        {
            closetOutfitRepository = new ClosetOutfitRepository();
            List<ClosetOutfitGarmentView> components = closetOutfitRepository.GetComponentList(result, closet) as List<ClosetOutfitGarmentView>;
            foreach (ClosetOutfitView outfitView in result)
            {
                outfitView.OutfitGarments.AddRange(components.FindAll(delegate(ClosetOutfitGarmentView record)
                {
                    if (record.ClosetOutfitId == outfitView.ClosetOutfitId)
                    {
                        return true;
                    }
                    return false;
                }));
            }
            return result;
        }

        private ICriteria GetCrit(int userId, int season, string search)
        {
            ICriteria crit = Session.CreateCriteria(typeof(ClosetOutfitView));
            crit.Add(Expression.Eq("UserId", userId));
            if (season > 0 && season < 5)
                crit.Add(Restrictions.Gt(Projections.SqlProjection("(this_.Seasons & " + season + ") as bitWiseResult", new[] { "bitWiseResult" }, new IType[] { NHibernateUtil.Int32 }), 0));
            if (!string.IsNullOrEmpty(search))
            {
                ICriteria precombination = crit.CreateCriteria("ClosetOutfit");
                ICriteria Garment1 = precombination.CreateCriteria("Garment1", "garment1", JoinType.LeftOuterJoin);
                ICriteria Garment2 = precombination.CreateCriteria("Garment2", "garment2", JoinType.LeftOuterJoin);
                ICriteria Garment3 = precombination.CreateCriteria("Garment3", "garment3", JoinType.LeftOuterJoin);
                ICriteria Garment4 = precombination.CreateCriteria("Garment4", "garment4", JoinType.LeftOuterJoin);
                ICriteria Garment5 = precombination.CreateCriteria("Garment5", "garment5", JoinType.LeftOuterJoin);
                ICriteria Garment6 = precombination.CreateCriteria("Garment6", "garment6", JoinType.LeftOuterJoin);
                ICriteria Garment7 = precombination.CreateCriteria("Garment7", "garment7", JoinType.LeftOuterJoin);
                ICriteria Garment8 = precombination.CreateCriteria("Garment8", "garment8", JoinType.LeftOuterJoin);
                ICriteria Garment9 = precombination.CreateCriteria("Garment9", "garment9", JoinType.LeftOuterJoin);
                ICriteria Garment510 = precombination.CreateCriteria("Garment10", "garment10", JoinType.LeftOuterJoin);
                Disjunction d = new Disjunction();
                d.Add(Expression.InsensitiveLike("garment1.Title", search, MatchMode.Anywhere));
                d.Add(Expression.InsensitiveLike("garment2.Title", search, MatchMode.Anywhere));
                d.Add(Expression.InsensitiveLike("garment3.Title", search, MatchMode.Anywhere));
                d.Add(Expression.InsensitiveLike("garment4.Title", search, MatchMode.Anywhere));
                d.Add(Expression.InsensitiveLike("garment5.Title", search, MatchMode.Anywhere));
                d.Add(Expression.InsensitiveLike("garment6.Title", search, MatchMode.Anywhere));
                d.Add(Expression.InsensitiveLike("garment7.Title", search, MatchMode.Anywhere));
                d.Add(Expression.InsensitiveLike("garment8.Title", search, MatchMode.Anywhere));
                d.Add(Expression.InsensitiveLike("garment9.Title", search, MatchMode.Anywhere));
                d.Add(Expression.InsensitiveLike("garment10.Title", search, MatchMode.Anywhere));
                crit.Add(d);
            }
            return crit;
        }

        public ClosetOutfitView GetByClosetOutfitId(int closetOutfitId)
        {
            ICriteria crit = Session.CreateCriteria(typeof(ClosetOutfitView));
            ICriteria closetOutfit = crit.CreateCriteria("ClosetOutfit");
            closetOutfit.Add(Expression.Eq("Id", closetOutfitId));

            ClosetOutfitView tempOV = crit.UniqueResult<ClosetOutfitView>();
            List<ClosetOutfitView> result = new List<ClosetOutfitView>();
            result.Add(tempOV);

            return GetComponents(result, null)[0];
        }

        public IList<ClosetOutfitView> GetTopRatedOutfits(int userId)
        {
            closetOutfitRepository = new ClosetOutfitRepository();
            registeredUserRepository = new RegisteredUserRepository();
            RegisteredUser user = registeredUserRepository.Get(userId);
            ICriteria crit = Session.CreateCriteria(typeof(ClosetOutfitView));

            crit.Add(Expression.Eq("UserId", userId));
            crit.AddOrder(new Order("AverageFriendRating", false));
            crit.AddOrder(new Order("AverageUserRating", false));
            crit.AddOrder(new Order("EditorRating", false));
            crit.SetMaxResults(2);

            IList<ClosetOutfitView> result = crit.List<ClosetOutfitView>();
            foreach (ClosetOutfitView closetOutfitView in result)
                closetOutfitView.Disabled = true;
            return GetComponents(result, user.Closet);
        }
    }
}
