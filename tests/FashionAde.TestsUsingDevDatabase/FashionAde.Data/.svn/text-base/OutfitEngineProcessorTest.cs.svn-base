using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.ApplicationServices.Outfit;
using FashionAde.ApplicationServices.SearchEngine;
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

namespace Tests.FashionAde.Services
{
    [TestFixture]
    [Category("DB Tests")]
    public class OutfitEngineProcessorTest
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

        public static IOutfitEngineService CreateOutfitEngineService()
        {
            IStyleRuleRepository srr = new StyleRuleRepository();
            IClosetRepository cr = new ClosetRepository();
            IIndexCreationService ois = new IndexCreationService(new ClosetRepository(), new ClosetOutfitRepository());
            IOutfitUpdaterService ous = new OutfitUpdaterService(new OutfitUpdaterRepository(),
                new PreCombinationRepository(), srr);

            IOutfitEngineProcessor processor = new OutfitEngineProcessor(srr, cr, ous, ois);


            IGarmentRepository gr = new GarmentRepository();
            IFashionFlavorRepository fr = new FashionFlavorRepository();
            return new OutfitEngineService(gr, cr, processor, fr);
        }

        [Test]
        [TestCase(1)]
        public void CanRetrieveSmallClosetCombination(int flavorId)
        {
            IList<int> lst = new List<int>();

            IOutfitEngineService service = CreateOutfitEngineService();
            string values = "195391,2079106,1325626,2652391";
            foreach (string val in values.Split(','))
                lst.Add(Convert.ToInt32(val));

            IList<int> lstFlavors = new List<int>();
            lstFlavors.Add(flavorId);

            Assert.IsTrue(service.HasValidCombinations(lst, lstFlavors));
        }

        [Test]
        public void CanRetrieveModerateClosetCombination()
        {
            IOutfitEngineService service = CreateOutfitEngineService();
            
            IList<int> lst = new List<int>();
            string values = "195391,180181,181741,182521,186421,187591,457546,459106,460666,464956,469246,688756,693436,692266,687586,689536,694996,698896,698116,1162996,1164166,1168456,1169236,1172746,1170016,1165336,1169626,1171186,1407526,1408696,1409866,1418446,1418056,1407917,1409087,1413377,1418447,1414937,966827,970727,972677,976187,966052,970342,972292,969952,2177386,2178556,2183626,2188696,2150086,2155156,2153986,2150476,2067406,2064286,2069746,2073646,2070526,2072476,2228866,2226916,20281,21841,25351,170041,169261,2979991,2981161,2570491,2571661,2572441,2636011,2636791,2637571";
            foreach (string val in values.Split(','))
                lst.Add(Convert.ToInt32(val));

            IList<int> lstFlavors = new List<int>();
            lstFlavors.Add(1);
            lstFlavors.Add(6);

            Assert.IsTrue(service.HasValidCombinations(lst, lstFlavors));
        }

        [Test]
        public void CanRetrieveClassicWithTrendy()
        {
            IOutfitEngineService service = CreateOutfitEngineService();
            
            IList<int> lst = new List<int>();
            string values = "244531,1325626,2062726,2619631";
            foreach (string val in values.Split(','))
                lst.Add(Convert.ToInt32(val));

            IList<int> lstFlavors = new List<int>();
            lstFlavors.Add(1);
            lstFlavors.Add(8);

            Assert.IsTrue(service.HasValidCombinations(lst, lstFlavors));
        }

        [Test]
        public void CanCreateWithOtherAccessories()
        {
            IClosetRepository cr = new ClosetRepository();
            
            IList<int> lst = new List<int>();
            string values = "89701,94771,95161,99451,100231,162241,162631,163021,179011,181351,184471,184861,189541,244921,246091,249991,251161,256621,277291,278461,283921,287431,588511,594361,599431,703171,707851,709021,713701,998401,1003471,1007761,1008151,1342381,1343551,1347451,1351351,1353691,2177371,2181661,2182051,2182831,2186731,2210521,2215201,2216371,2717911,2727661,2729611,2731171,2979991,2981551,2985061,2986621,3029131,3029521,3033811,3039661";
            foreach (string val in values.Split(','))
                lst.Add(Convert.ToInt32(val));

            cr.DbContext.BeginTransaction();
            Closet c = cr.Get(2);
            foreach (int i in lst)
                c.AddGarment(new MasterGarment(i));
            cr.SaveOrUpdate(c);
            cr.DbContext.CommitTransaction();

            IList<int> lstFlavors = new List<int>();
            lstFlavors.Add(1);
            lstFlavors.Add(5);

            IOutfitEngineService service = CreateOutfitEngineService();
            service.AddOutfits(2, lst);

            //IList<int> lstFlavors = new List<int>();
            //lstFlavors.Add(1);

            //Assert.IsTrue(service.HasValidCombinations(lst, lstFlavors));
        }

        [Test]
        public void CanRetrieveWithPatterns()
        {
            IOutfitEngineService service = CreateOutfitEngineService();
            
            IList<int> lst = new List<int>();
            string values = "44531,244532,246092,261302,260911,262861,267151,1326796,1330306,1326019,1327969,1325629,1476949,1474219,1342006,1343176,1347856,2062726,2064286,2068576,2063118,2065458,2068188,2072868,2063898,2065068,2619631,2620801,2625481,2622361,2979991,2981161,2986231,2990521,2586871,2588821,2592331,2593501,2594671";
            foreach (string val in values.Split(','))
                lst.Add(Convert.ToInt32(val));

            IList<int> lstFlavors = new List<int>();
            lstFlavors.Add(1);
            lstFlavors.Add(8);

            Assert.IsTrue(service.HasValidCombinations(lst, lstFlavors));
        }

        [Test]
        public void CanRetrieveClassicWithAccessories() 
        {
            IOutfitEngineService service = CreateOutfitEngineService();
            
            IList<int> lst = new List<int>();
            string values = "179011,179401,179791,180181,180961,181741,182911,187981,184081,187591,1359166,1358776,1358386,1361116,1365016,1369306,1365406,1366966,1367746,2144626,2145016,2145406,2146186,2146966,2146576,2145796,2151646,2570491,2571271,2570881,2572441,2573611,2574391,2575561,2573221,2578681,2579461,2578291,2572831,2575171,2576341,2577121,2577901,2574001,2576731,2579071,2581021,2583751,2574781";
            foreach (string val in values.Split(','))
                lst.Add(Convert.ToInt32(val));

            IList<int> lstFlavors = new List<int>();
            lstFlavors.Add(1);

            Assert.IsTrue(service.HasValidCombinations(lst, lstFlavors));
        }

        [Test]
        public void CanCreateSummerCombinationWithCoats()
        {
            IClosetRepository cr = new ClosetRepository();
            IOutfitEngineService service = CreateOutfitEngineService();

            IList<int> lst = new List<int>();
            string values = "244531,245311,246091,1587706,1588876,1589656,2210146,2211316,2226526,2227696,2979991,2981161";
            foreach (string val in values.Split(','))
                lst.Add(Convert.ToInt32(val));

            cr.DbContext.BeginTransaction();
            Closet c = cr.Get(2);
            foreach (int i in lst)
                c.AddGarment(new MasterGarment(i));
            cr.SaveOrUpdate(c);
            cr.DbContext.CommitTransaction();

            IList<int> lstFlavors = new List<int>();
            lstFlavors.Add(1);
            lstFlavors.Add(6);

            service.AddOutfits(2, lst);
        }
        
        [Test]
        public void CanCreateLargeClosetWithAccessoriesCombination()
        {
            IClosetRepository cr = new ClosetRepository();
            IOutfitEngineService service = CreateOutfitEngineService();

            IList<int> lst = new List<int>();
            string values = "781,14431,54601,55771,56551,62791,107251,109201,123631,179011,180571,391951,670411,671588,861908,948871,962911,1000748,1325611,1326001,1337191,1391131,1571311,1735111,1749931,1915305,1916851,1918411,2064271,2070901,2586871,2637961,2752621,2848951,2996371,2998321,3040051,3066181";
            foreach (string val in values.Split(','))
                lst.Add(Convert.ToInt32(val));

            cr.DbContext.BeginTransaction();
            Closet c = cr.Get(2);
            foreach (int i in lst)
                c.AddGarment(new MasterGarment(i));
            cr.SaveOrUpdate(c);
            cr.DbContext.CommitTransaction();

            IList<int> lstFlavors = new List<int>();
            lstFlavors.Add(1);
            lstFlavors.Add(8);

            service.AddOutfits(2, lst);
        }

        [Test]
        public void CanCreateAccessoriesCombination()
        {
            IClosetRepository cr = new ClosetRepository();
            IOutfitEngineService service = CreateOutfitEngineService();

            IList<int> lst = new List<int>();
            string values = "244531,1309246,2062726,2979991,2981161,2980771,178231,178621,172771,169261,170041,2554111,2555281,3029131,3029911,3030691";
            foreach (string val in values.Split(','))
                lst.Add(Convert.ToInt32(val));

            cr.DbContext.BeginTransaction();
            Closet c = cr.Get(2);
            foreach (int i in lst)
                c.AddGarment(new MasterGarment(i));
            cr.SaveOrUpdate(c);
            cr.DbContext.CommitTransaction();

            IList<int> lstFlavors = new List<int>();
            lstFlavors.Add(1);

            service.AddOutfits(2, lst);
        }
        
//        [TestCase("179011,179791,180181,185641,186421,555751,556531,561601,1097071,1097851,1099021,1100191,1489801,1491361,2423071,2424241,2425021,2570491,2572051,2572441,2144611,2145781,425101,426271", 6, 7)]
//        [TestCase("179011,179791,1407511,1408291,2128231,2129401,2603251,2604421,2062711,2063491,2064271,2065051,195391,196171,196951", 1, 0)]
        [Test]
//        [TestCase("124411,917281,2221831,2488591,2636011,3040831", 2, 0)]
//        [TestCase("54601,392341,2343901,2750671,3061891,3211981", 8, 0)]
//        [TestCase("781,162631,1505011,2235098,2687101", 6, 0)]
//        [TestCase("175111,752311,1325611,1981981,2554111,2586871",1,0)]
//        [TestCase("6631,1365391,2260831,2799811,3012751,1908391", 5, 0)]
//        [TestCase("359971,1529191,2070511,2774461,3054873", 3, 0)]
//        [TestCase("115831,793651,1343953,2097428,2900041,2998321", 7, 0)]
//        [TestCase("14821,171601,1566241,2098591,2736241",4,0)]
        //[TestCase("2636011,2148902,861908", 2, 7)]
        [TestCase("2064271,824851, 2586871", 3, 4)]
        public void CanCreateBigClosetCombination(string values, int flavor1, int flavor2)
        {
            IClosetRepository cr = new ClosetRepository();
            IFashionFlavorRepository fr = new FashionFlavorRepository();
            IBasicUserRepository bur = new BasicUserRepository();

            IOutfitEngineService service = CreateOutfitEngineService();

            IList<int> lst = new List<int>();
            foreach (string val in values.Split(','))
                lst.Add(Convert.ToInt32(val));

            cr.DbContext.BeginTransaction();
            Closet c = cr.Get(2);
            foreach (int i in lst)
                c.AddGarment(new MasterGarment(i));
            cr.SaveOrUpdate(c);

            IList<UserFlavor> lstFlavors = new List<UserFlavor>();
            lstFlavors.Add(new UserFlavor(fr.Get(flavor1), 1));
            if (flavor2 != 0)
                lstFlavors.Add(new UserFlavor(fr.Get(flavor2), 1));

            c.User.SetFlavors(lstFlavors);

            bur.SaveOrUpdate(c.User);
            cr.DbContext.CommitTransaction();

            service.CreateOutfits(2);

            c = cr.Get(2);
            Assert.IsTrue(c.Outfits.Count > 0);
        }

        // Romantic: ,179011,179401,180181,359191,965251,967201,970711,1326001,1327561,1331071,2062711,2063881,2068171,2652391,2653561,244531,246091,251161,966421,975001,970321,966811

        [Test]
        public void CanMatchOutfits()
        {
            IOutfitUpdaterService ous = new OutfitUpdaterService(new OutfitUpdaterRepository(),
                new PreCombinationRepository(), new StyleRuleRepository());

            ous.MatchOutfitUpdatersForCloset(31);
        }

        [Test]
        public void CanCombine()
        {
            IOutfitEngineService service = CreateOutfitEngineService();
            service.CreateOutfits(1);
        }
    }
}
