using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Views;
using SharpArch.Core.PersistenceSupport;

namespace FashionAde.Core.DataInterfaces
{
    public interface ISavedFilterRepository : IRepository<SavedFilter>
    {
        IList<SavedFilter> GetAllFor(int userId);
        SavedFilter GetByName(string name, int userId);
    }
}
