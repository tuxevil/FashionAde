using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.ApplicationServices;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core.ThirdParties;
using FashionAde.Data.NHibernateMaps;
using FashionAde.Data.Repository;
using FashionAde.Services;
using NUnit.Framework;
using SharpArch.Data.NHibernate;
using SharpArch.Testing.NHibernate;

namespace Tests.FashionAde.OutfitUpdaterImportation
{
    [TestFixture]
    [Category("DB Tests")]
    public class OUImportationTest
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

        [Test]
        public void ServiceTest()
        {
            //Acordarse de levantar el TestConsole
            new OutfitUpdaterService(new OutfitUpdaterRepository(), new PreCombinationRepository(), new StyleRuleRepository(), new SilouhetteRepository(), new PatternRepository(), new ColorFamilyRepository(), new TrendRepository(), new PartnerRepository()).UpdateFeeds();
        }
        
    }
}
