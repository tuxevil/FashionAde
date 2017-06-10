using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.ThirdParties;
using NHibernate;
using NHibernate.Criterion;
using SharpArch.Core.PersistenceSupport;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class PatternRepository : Repository<Pattern>, IPatternRepository
    {
        public Pattern GetSolid()
        {
            ICriteria crit = Session.CreateCriteria(typeof(Pattern));
            crit.Add(Expression.Eq("Description", "Solid"));
            crit.SetCacheable(true);
            crit.SetCacheRegion("Static");
            return crit.UniqueResult<Pattern>();
        }

        public override IList<Pattern>  GetAll()
        {
            ICriteria crit = Session.CreateCriteria(typeof(Pattern));
            crit.AddOrder(new Order("Description", true));
            crit.SetCacheable(true);
            crit.SetCacheRegion("Static");
            return crit.List<Pattern>();
        }

        public IList<PatternKeywordsByPartner> GetKeywordsByPartner(Partner partner)
        {
            ICriteria crit = Session.CreateCriteria(typeof(PatternKeywordsByPartner));
            crit.Add(Expression.Eq("Partner", partner));
            return crit.List<PatternKeywordsByPartner>();
        }

        public Pattern GetByDescription(string description)
        {
            ICriteria crit = Session.CreateCriteria(typeof(Pattern));
            crit.Add(Expression.Eq("Description", description));
            return crit.UniqueResult<Pattern>();
        }
    }
}
