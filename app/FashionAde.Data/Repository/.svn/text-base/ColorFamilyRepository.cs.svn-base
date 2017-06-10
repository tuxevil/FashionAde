using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.ThirdParties;
using NHibernate;
using NHibernate.Criterion;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class ColorFamilyRepository : Repository<ColorFamily>, IColorFamilyRepository
    {
        public IList<ColorFamilyKeywordsByPartner> GetKeywordsByPartner(Partner partner)
        {
            ICriteria crit = Session.CreateCriteria(typeof(ColorFamilyKeywordsByPartner));
            crit.Add(Expression.Eq("Partner", partner));
            return crit.List<ColorFamilyKeywordsByPartner>();
        }
    }
}
