using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using NHibernate;
using NHibernate.Criterion;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class CategoryRepository : Repository<Category>, ICategoryRepository
    {
        public Category GetByDescription(string description)
        {
            ICriteria crit = Session.CreateCriteria(typeof (Category));
            crit.Add(Expression.Eq("Description", description));
            return crit.UniqueResult<Category>();
        }
    }
}
