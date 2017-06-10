using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.ThirdParties;
using NHibernate;
using NHibernate.Criterion;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class PartnerRepository : Repository<Partner>, IPartnerRepository
    {
        public Partner GetByCode(string code)
        {
            ICriteria crit = Session.CreateCriteria(typeof (Partner));
            crit.Add(Expression.Eq("Code", code));
            crit.SetCacheable(true);
            crit.SetCacheRegion("Static");
            return crit.UniqueResult<Partner>();
        }
    }
}
