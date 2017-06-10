using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.Trends;
using NHibernate;
using NHibernate.Criterion;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class TrendRepository : Repository<Trend>, ITrendRepository
    {
        public IList<Trend> GetCurrentTrends()
        {
            ICriteria crit = Session.CreateCriteria<Trend>()
                .Add(Expression.Eq("IsEnabled", true))
                .Add(Expression.Eq("Season", SeasonHelper.CurrentSeason));

            return crit.List<Trend>();
        }

        public Trend GetByName(string name)
        {
            ICriteria crit = Session.CreateCriteria(typeof(Trend));
            crit.Add(Expression.Eq("Name", name));
            return crit.UniqueResult<Trend>();
        }
    }
}
