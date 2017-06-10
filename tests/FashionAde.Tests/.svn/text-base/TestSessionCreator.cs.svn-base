using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Data.NHibernateMaps;
using FluentNHibernate.Cfg;
using FluentNHibernate.Cfg.Db;
using NHibernate;
using NHibernate.Cfg;
using NHibernate.Tool.hbm2ddl;

namespace Tests
{
    public class TestSessionCreator
    {
        public static ISession CreateSessionWithMemoryDatabase()
        {
            Configuration configuration = null;

            ISessionFactory factory =
                Fluently
                    .Configure()
                    .Database(SQLiteConfiguration.Standard.InMemory().ShowSql())
                    .Mappings(m => m.AutoMappings.Add(new AutoPersistenceModelGenerator().Generate()))
                    .ExposeConfiguration((c) => configuration = c)
                    .BuildSessionFactory();

            ISession ses = factory.OpenSession();

            var export = new SchemaExport(configuration);
            export.Execute(false, true, false, ses.Connection, null);
            return ses;
        }  
    }
}
