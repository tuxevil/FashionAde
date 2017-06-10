using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using FashionAde.ApplicationServices.Outfit;
using FashionAde.Core;
using FashionAde.Core.Clothing;
using FashionAde.Data.NHibernateMaps;
using FashionAde.Data.Repository;
using NUnit.Framework;
using FashionAde.ApplicationServices.SearchEngine;
using Lucene.Net.Analysis.Snowball;
using Lucene.Net.Store;
using System.IO;
using SharpArch.Data.NHibernate;
using SharpArch.Testing.NHibernate;
using Directory = Lucene.Net.Store.Directory;
using Lucene.Net.Analysis.Standard;
using Lucene.Net.Analysis;
using System.Threading;

namespace Tests.Lucene.Net
{
    public class LuceneTest
    {
        #region Setup
        private NHibernate.Cfg.Configuration configuration;

        [SetUp]
        public virtual void SetUp()
        {
            log4net.Config.XmlConfigurator.Configure();

            string[] mappingAssemblies = RepositoryTestsHelper.GetMappingAssemblies();
            configuration = NHibernateSession.Init(new SimpleSessionStorage(), mappingAssemblies,
                       new AutoPersistenceModelGenerator().Generate(),
                       "../../../../tests/FashionAde.TestsUsingDevDatabase/Hibernate.Test.cfg.xml");
        }

        [TearDown]
        public virtual void TearDown()
        {
            NHibernateSession.CloseAllSessions();
            NHibernateSession.Reset();
        }

        #endregion

        /// <summary>
        /// Create indexes per closet simulation
        /// </summary>
        [Test]
        public void CreateIndividualIndex()
        {
            IndexCreationService ics = new IndexCreationService(new ClosetRepository(), new ClosetOutfitRepository());
            ics.CreateIndividualIndex(30);
        }

        [Test]
        public void CreateIndexes()
        {
            IndexCreationService ics = new IndexCreationService(new ClosetRepository(), new ClosetOutfitRepository());
            ics.CreateIndexes();
        }

        [Test]
        public void CheckCodes()
        {
            SilouhetteRepository sr = new SilouhetteRepository();

            IList garments = new GarmentRepository().GetCodes();
            string path = ConfigurationManager.AppSettings["TestResource_Path"];

            StringBuilder sb = new StringBuilder();

            Console.WriteLine("Total items: {0}", garments.Count);

            int notFound = 0;
            foreach (object[] g in garments)
            {
                string code = g[0].ToString();
                FileInfo fi = new FileInfo(path + code);
                if (!fi.Exists)
                {
                    notFound++;
                    sb.AppendLine(code);
                }
            }

            Console.WriteLine("Not Found: {0}", notFound);

            Console.WriteLine(sb.ToString());
        }

        [Test]
        public void IndexPendingOutfits()
        {
            IIndexCreationService ois = new IndexCreationService(new ClosetRepository(), new ClosetOutfitRepository());
            ois.IndexPendingOutfits(new ClosetRepository().Get(96));
        }
    }
}
