using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using NHibernate;
using NHibernate.Criterion;
using SharpArch.Data.NHibernate;

namespace FashionAde.Data.Repository
{
    public class FabricRepository : Repository<Fabric>, IFabricRepository 
    {
        public IList<Fabric> GetForSilouhette(Silouhette silouhette, IList<EventType> eventTypes)
        {
            string eventIds = "";
            foreach (EventType eventType in eventTypes)
                eventIds += eventType.Id + ",";
            eventIds = eventIds.TrimEnd(',');
            string query = "select distinct temp.fabricid, f.description from silouhettefabricsbyeventtypes temp inner join fabrics f on temp.fabricid = f.fabricid where temp.silouhetteid = " + silouhette.Id + " and temp.eventtypeid in (" + eventIds + ")";
            IQuery q = NHibernateSession.Current.CreateSQLQuery(query);
            q.SetResultTransformer(new NHibernate.Transform.AliasToBeanConstructorResultTransformer(typeof(Fabric).GetConstructors()[2]));
            return q.List<Fabric>();
        }
    }
}
