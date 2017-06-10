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
using Tests.FashionAde.ApplicationServices;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core;
using FashionAde.Core.Clothing;

namespace Tests.FashionAde.Data
{
    [TestFixture]
    [Category("DB Tests")]
    public class ApplicationServicesTest
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
                       "../../../../tests/FashionAde.Tests/Hibernate.Test.cfg.xml");
        }

        [TearDown]
        public virtual void TearDown()
        {
            NHibernateSession.CloseAllSessions();
            NHibernateSession.Reset();
        }
        #endregion

        [Test]
        public void CreateStyleRules()
        {
            IFashionFlavorRepository repFlavors = new FashionFlavorRepository();
            IStyleRuleRepository repStyleRule = new StyleRuleRepository();

            foreach (FashionFlavor fv in repFlavors.GetAll())
                repStyleRule.SaveOrUpdate(CreateStyleRule(fv));
        }

        [Test]
        public void CanReadStyleRuleAccessories()
        {
            IStyleRuleRepository repStyleRule = new StyleRuleRepository();
            Assert.IsTrue(repStyleRule.Get(1).AccessoriesAmount.Count > 0);
        }

        [Test]
        public void CanCreatePreCombinations()
        {
            ICombinationRepository repCombination = new CombinationRepository();
            IPreCombinationRepository repPreCombination = new PreCombinationRepository();
            IStyleRuleRepository repStyleRule = new StyleRuleRepository();
            IOutfitEngineProcessor processor = new OutfitEngineProcessor(repStyleRule);

            OutfitEngineService oes = new OutfitEngineService(
                repCombination,
                repPreCombination,
                processor);

            IList<PreGarment> pregarments = new PreGarmentRepository().GetFetched();

            foreach (FashionFlavor fv in new FashionFlavorRepository().GetAll())
            {
                //if (fv.Name.Contains("Preppy") || fv.Name.Contains("Trendy"))
                //    continue;

                IList<FashionFlavor> flavors = new List<FashionFlavor>();
                flavors.Add(fv);

                IList<PreGarment> reducedPregarments = (from cg in pregarments
                                                        where
                                                        cg.PreSilouhette.Flavors.Contains(fv)
                                                        select cg).ToList<PreGarment>();

                Console.WriteLine("Amount of pregarments: {0}", reducedPregarments.Count);

                oes.CreatePreCombinations(
                    flavors,
                    reducedPregarments);
            }
        }

        #region Create Style Rules

        private StyleRule CreateStyleRule(FashionFlavor fv)
        {
            StyleRule sr = new StyleRule();
            sr.MaximumGarments = 10;
            sr.MinimumGarments = 2;
            sr.FashionFlavor = fv;

            int maximumLayers = 5;
            int minimumLayers = 2;

            switch (fv.Name)
            {
                case "Classic":
                    maximumLayers = 5;
                    minimumLayers = 3;

                    sr.ColorBlending.MonotoneColor = true;
                    sr.ColorBlending.AnalogousColor = true;
                    sr.ColorBlending.NeutralPrimaryColor = true;
                    sr.ColorBlending.NeutralColor = true;

                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Solid, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Minimal, StyleRule = sr });

                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.Structured, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.FlowingFluid, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.Relaxed, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.BodyConscious, StyleRule = sr });

                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Slim, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Slim, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Fitted, StyleRule = sr });

                    sr.AccessoriesAmount.Add(3);
                    break;
                case "Romantic":
                    maximumLayers = 5;
                    minimumLayers = 1;

                    sr.ColorBlending.AnalogousColor = true;
                    sr.ColorBlending.ComplimentaryColor = true;
                    sr.ColorBlending.NeutralSecondaryColor = true;
                    sr.ColorBlending.NeutralColor = true;

                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Solid, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Minimal, StyleRule = sr });

                    sr.AccessoriesAmount.Add(4);

                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.FlowingFluid, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.FlowingFluid, ToItem = StructureType.FlowingFluid, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.FlowingFluid, ToItem = StructureType.Relaxed, StyleRule = sr });

                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Loose, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Loose, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Loose, ToItem = ShapeType.Slim, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Loose, ToItem = ShapeType.Fitted, StyleRule = sr });

                    break;
                case "Comfortable":
                    maximumLayers = 3;
                    minimumLayers = 1;

                    sr.ColorBlending.ComplimentaryColor = true;
                    sr.ColorBlending.NeutralPrimaryColor = true;
                    sr.ColorBlending.NeutralSecondaryColor = true;
                    sr.ColorBlending.NeutralColor = true;

                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Solid, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Minimal, StyleRule = sr });

                    sr.AccessoriesAmount.Add(1);
                    sr.AccessoriesAmount.Add(3);

                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.Relaxed, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.FlowingFluid, ToItem = StructureType.Relaxed, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Relaxed, ToItem = StructureType.BodyConscious, StyleRule = sr });

                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Loose, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Loose, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Loose, ToItem = ShapeType.Loose, StyleRule = sr });

                    break;
                case "Sporty":
                    maximumLayers = 3;
                    minimumLayers = 1;

                    sr.ColorBlending.ComplimentaryColor = true;
                    sr.ColorBlending.NeutralPrimaryColor = true;
                    sr.ColorBlending.NeutralSecondaryColor = true;
                    sr.ColorBlending.NeutralColor = true;

                    sr.AccessoriesAmount.Add(1);
                    sr.AccessoriesAmount.Add(3);
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Solid, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Minimal, StyleRule = sr });

                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.BodyConscious, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Relaxed, ToItem = StructureType.Relaxed, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Relaxed, ToItem = StructureType.BodyConscious, StyleRule = sr });

                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Slim, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Slim, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Fitted, StyleRule = sr });

                    break;
                case "Preppy":
                    maximumLayers = 5;
                    minimumLayers = 2;

                    sr.ColorBlending.ComplimentaryColor = true;
                    sr.ColorBlending.NeutralPrimaryColor = true;
                    sr.ColorBlending.NeutralSecondaryColor = true;

                    sr.AccessoriesAmount.Add(1);
                    sr.AccessoriesAmount.Add(3);
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Solid, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Minimal, StyleRule = sr });

                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.Structured, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.Relaxed, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Relaxed, ToItem = StructureType.Relaxed, StyleRule = sr });

                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Loose, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Loose, ToItem = ShapeType.Fitted, StyleRule = sr });

                    break;
                case "Glam":
                    maximumLayers = 3;
                    minimumLayers = 1;

                    sr.ColorBlending.MonotoneColor = true;
                    sr.ColorBlending.ComplimentaryColor = true;
                    sr.ColorBlending.NeutralPrimaryColor = true;
                    sr.ColorBlending.NeutralSecondaryColor = true;

                    sr.AccessoriesAmount.Add(5);
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Solid, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Minimal, StyleRule = sr });

                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.Structured, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.BodyConscious, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Relaxed, ToItem = StructureType.BodyConscious, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.BodyConscious, ToItem = StructureType.BodyConscious, StyleRule = sr });

                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Slim, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Slim, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Fitted, StyleRule = sr });

                    break;
                case "Bohemian":
                    maximumLayers = 5;
                    minimumLayers = 3;

                    sr.ColorBlending.AnalogousColor = true;
                    sr.ColorBlending.ComplimentaryColor = true;
                    sr.ColorBlending.NeutralPrimaryColor = true;
                    sr.ColorBlending.NeutralSecondaryColor = true;

                    sr.AccessoriesAmount.Add(4);
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Bold, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Minimal, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Minimal, ToItem = PatternType.Minimal, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Minimal, ToItem = PatternType.Bold, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Bold, ToItem = PatternType.Bold, StyleRule = sr });

                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.FlowingFluid, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.FlowingFluid, ToItem = StructureType.FlowingFluid, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.FlowingFluid, ToItem = StructureType.Relaxed, StyleRule = sr });

                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Loose, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Loose, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Loose, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Loose, ToItem = ShapeType.Loose, StyleRule = sr });

                    break;
                case "Trendy":
                    maximumLayers = 5;
                    minimumLayers = 1;

                    sr.ColorBlending.MonotoneColor = true;
                    sr.ColorBlending.AnalogousColor = true;
                    sr.ColorBlending.ComplimentaryColor = true;
                    sr.ColorBlending.NeutralPrimaryColor = true;
                    sr.ColorBlending.NeutralSecondaryColor = true;
                    sr.ColorBlending.NeutralColor = true;

                    sr.AccessoriesAmount.Add(4);
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Solid, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Minimal, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Solid, ToItem = PatternType.Bold, StyleRule = sr });
                    sr.Patterns.Add(new PatternRule { FromItem = PatternType.Minimal, ToItem = PatternType.Bold, StyleRule = sr });

                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.Structured, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.FlowingFluid, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.Relaxed, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Structured, ToItem = StructureType.BodyConscious, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.FlowingFluid, ToItem = StructureType.FlowingFluid, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.FlowingFluid, ToItem = StructureType.Relaxed, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.FlowingFluid, ToItem = StructureType.BodyConscious, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Relaxed, ToItem = StructureType.Relaxed, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.Relaxed, ToItem = StructureType.BodyConscious, StyleRule = sr });
                    sr.Structures.Add(new StructureRule { FromItem = StructureType.BodyConscious, ToItem = StructureType.BodyConscious, StyleRule = sr });

                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Slim, ToItem = ShapeType.Loose, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Slim, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Fitted, ToItem = ShapeType.Fitted, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Loose, ToItem = ShapeType.Slim, StyleRule = sr });
                    sr.Shapes.Add(new ShapeRule { FromItem = ShapeType.Loose, ToItem = ShapeType.Fitted, StyleRule = sr });

                    break;
            }

            sr.MaximumLayers = maximumLayers;
            sr.MinimumLayers = minimumLayers;
            return sr;
        }

        #endregion

    }
}
