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
using NHibernate.SqlCommand;
using SharpArch.Core.PersistenceSupport;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class SilouhetteRepository : Repository<Silouhette>, ISilouhetteRepository
    {
        public IList<Silouhette> ListEnabled()
        {
            ICriteria crit = Session.CreateCriteria(typeof(Silouhette));
            crit.Add(Expression.Eq("IsEnabled", true));
            crit.CreateCriteria("Category").AddOrder(new Order("Order", true));
            crit.SetCacheable(true);
            crit.SetCacheRegion("Static");
            return crit.List<Silouhette>();
        }

        public IList<Silouhette> GetByFlavors(IList<FashionFlavor> flavors, IList<EventType> types)
        {
            string flavorids = "";
            string eventtypeids = "";
            foreach (FashionFlavor fashionFlavor in flavors)
                flavorids += fashionFlavor.Id + ",";
            flavorids = flavorids.TrimEnd(',');

            foreach (EventType eventType in types)
                eventtypeids += eventType.Id + ",";
            eventtypeids = eventtypeids.TrimEnd(',');

            string query = "select distinct S from Silouhette S join S.FashionFlavors FF join S.EventTypes ET join S.Category C where FF.Id in(" + flavorids + ") and ET.Id in (" + eventtypeids + ") order by C.Order";
            IQuery q = NHibernateSession.Current.CreateQuery(query);
            q.SetCacheable(true);
            q.SetCacheRegion("Static");

            return q.List<Silouhette>();
        }

        public IList<SilouhetteKeywordsByPartner> GetKeywordsByPartner(Partner partner)
        {
            ICriteria crit = Session.CreateCriteria(typeof(SilouhetteKeywordsByPartner));
            crit.Add(Expression.Eq("Partner", partner));
            return crit.List<SilouhetteKeywordsByPartner>();
        }
    }
}
