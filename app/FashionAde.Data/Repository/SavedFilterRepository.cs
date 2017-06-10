using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.Views;
using NHibernate;
using NHibernate.Criterion;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class SavedFilterRepository : Repository<SavedFilter>, ISavedFilterRepository 
    {
        public IList<SavedFilter> GetAllFor(int userId)
        {
            ICriteria crit = Session.CreateCriteria(typeof (SavedFilter));
            crit.Add(Expression.Eq("UserId", userId));
            return crit.List<SavedFilter>();
        }

        public SavedFilter GetByName(string name, int userId)
        {
            ICriteria crit = Session.CreateCriteria(typeof(SavedFilter));
            crit.Add(Expression.Eq("Name", name));
            crit.Add(Expression.Eq("UserId", userId));
            return crit.UniqueResult<SavedFilter>();
        }
    }
}
