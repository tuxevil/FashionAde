using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using FashionAde.ApplicationServices;
using FashionAde.Core.OutfitCombination;
using FashionAde.Core.DataInterfaces;
using FashionAde.Data.Repository;
using SharpArch.Testing.NHibernate;
using FashionAde.Data.NHibernateMaps;
using SharpArch.Data.NHibernate;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core;
using FashionAde.Core.Clothing;
using FashionAde.Core.Accounts;
using FashionAde.Services;
using FashionAde.Core.Services;

namespace FashionAde.TestsUsingDevDatabase.FashionAde.Data
{
    public class ColorValidationTest
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
        public void CanMatchColor()
        {
            Color c1 = new ColorRepository().Get(1); //Black
            Color c2 = new ColorRepository().Get(8); //Red
            Color c3 = new ColorRepository().Get(4); //Beige
            Color c4 = new ColorRepository().Get(24); //Dark Blue Green

            HashSet<Color> colors = new HashSet<Color>();
            colors.Add(c1);
            colors.Add(c2);
            colors.Add(c3);
            colors.Add(c4);

            HashSet<ColorFamily> colorFamiliesHash = new HashSet<ColorFamily>();
            colorFamiliesHash.Add(c1.Family);
            colorFamiliesHash.Add(c2.Family);
            colorFamiliesHash.Add(c3.Family);
            colorFamiliesHash.Add(c4.Family);

            HashSet<PatternType> pt = new HashSet<PatternType>();
            pt.Add(new PatternRepository().Get(1).Type);

            HashSet<StructureType> st = new HashSet<StructureType>();
            st.Add(StructureType.Structured);
            
            HashSet<ShapeType> sh = new HashSet<ShapeType>();
            sh.Add(ShapeType.Fitted100);
            sh.Add(ShapeType.Fitted600Plus);

            StyleRule sr = new StyleRuleRepository().Get(8);

            Assert.IsFalse(OutfitValidationService.IsValidCombination(
                        colorFamiliesHash,
                        colors,
                        pt,
                        null,
                        sr,
                        null,
                        false,
                        false));
        }
    }
}
