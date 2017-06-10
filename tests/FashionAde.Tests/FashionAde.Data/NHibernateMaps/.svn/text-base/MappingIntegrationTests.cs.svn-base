 using System.Collections.Generic;
 using FashionAde.Core.DataInterfaces;
 using FashionAde.Data.Repository;
 using FluentNHibernate.Cfg;
 using FluentNHibernate.Cfg.Db;
 using NHibernate;
 using NHibernate.Criterion;
 using NHibernate.Metadata;
using NUnit.Framework;
using FashionAde.Data.NHibernateMaps;
using SharpArch.Data.NHibernate;
using SharpArch.Testing.NHibernate;
using NHibernate.Cfg;
using NHibernate.Tool.hbm2ddl;
using FashionAde.Core;
using FashionAde.Core.Accounts;
using System;

namespace Tests.FashionAde.Data.NHibernateMaps
{
    /// <summary>
    /// Provides a means to verify that the target database is in compliance with all mappings.
    /// Taken from http://ayende.com/Blog/archive/2006/08/09/NHibernateMappingCreatingSanityChecks.aspx.
    /// 
    /// If this is failing, the error will likely inform you that there is a missing table or column
    /// which needs to be added to your database.
    /// </summary>
    [TestFixture]
    [Category("DB Tests")]
    public class MappingIntegrationTests
    {
        [Test]
        public void CanConfirmDatabaseMatchesMappings()
        {
            using (ISession ses = TestSessionCreator.CreateSessionWithMemoryDatabase())
            {
                var allClassMetadata = ses.SessionFactory.GetAllClassMetadata();

                foreach (var entry in allClassMetadata)
                {
                    ses.CreateCriteria(entry.Value.GetMappedClass(EntityMode.Poco))
                         .SetMaxResults(0).List();
                }
            }
        }
    }
}
