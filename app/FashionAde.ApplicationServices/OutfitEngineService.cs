using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Accounts;
using FashionAde.Core.DataInterfaces;
using SharpArch.Core;
using FashionAde.Core.Clothing;
using FashionAde.Core;
using System.Collections;
using FashionAde.Core.OutfitCombination;
using FashionAde.Core.OutfitEngine;
using System.Threading;

namespace FashionAde.ApplicationServices
{
    public class OutfitEngineService : IOutfitEngineService
    {
        private readonly ICombinationRepository combinationRepository;
        private readonly IOutfitEngineProcessor outfitEngineProcessor;
        private readonly IPreCombinationRepository preCombinationRepository;

        public OutfitEngineService(ICombinationRepository combinationRepository, IPreCombinationRepository preCombinationRepository, IOutfitEngineProcessor outfitProcessor)
        {
            Check.Require(combinationRepository != null, "combinationRepository may not be null");
            Check.Require(preCombinationRepository != null, "preCombinationRepository may not be null");
            Check.Require(outfitProcessor != null, "outfitEngineProcessor may not be null");

            this.combinationRepository = combinationRepository;
            this.preCombinationRepository = preCombinationRepository;
            this.outfitEngineProcessor = outfitProcessor;
        }

        #region Create PreCombinations

        public void CreatePreCombinations(IList<FashionFlavor> flavors, IList<PreGarment> garments)
        {
            //outfitEngineProcessor.EventTypes.Add(et);
            outfitEngineProcessor.FashionFlavors = flavors;
            outfitEngineProcessor.Garments = garments;
            outfitEngineProcessor.CreateCombinations();

            int i = 0;
            StringBuilder sb = new StringBuilder();
            foreach (PreOutfit po in outfitEngineProcessor.Outfits)
            {
                int used = 2;
                PreCombination pc = po.Combination;

                // Add Garments
                sb.Append(pc.FashionFlavor.Id);
                sb.Append(",");
                sb.Append(pc.GarmentA.Id);
                sb.Append(",");
                sb.Append(pc.GarmentB.Id);

                if (pc.GarmentC != null)
                {
                    sb.Append(",");
                    sb.Append(pc.GarmentC.Id);
                    used++;
                }

                if (pc.GarmentD != null)
                {
                    sb.Append(",");
                    sb.Append(pc.GarmentD.Id);
                    used++;
                }

                if (pc.GarmentE != null)
                {
                    sb.Append(",");
                    sb.Append(pc.GarmentE.Id);
                    used++;
                }

                if (po.Accesory1 != null)
                {
                    sb.Append(",");
                    sb.Append(po.Accesory1.Id);
                    used++;
                }

                if (po.Accesory2 != null)
                {
                    sb.Append(",");
                    sb.Append(po.Accesory2.Id);
                    used++;
                }

                if (po.Accesory3 != null)
                {
                    sb.Append(",");
                    sb.Append(po.Accesory3.Id);
                    used++;
                }

                if (po.Accesory4 != null)
                {
                    sb.Append(",");
                    sb.Append(po.Accesory4.Id);
                    used++;
                }

                if (po.Accesory5 != null)
                {
                    sb.Append(",");
                    sb.Append(po.Accesory5.Id);
                    used++;
                }

                for (int j = used; j < 10; j++)
                {
                    sb.Append(",");
                    sb.Append(@"\N");
                }

                sb.AppendLine("");

                i++;
                if (i == 50000)
                {
                    System.IO.File.AppendAllText(@"c:\leo.txt", sb.ToString());
                    sb = new StringBuilder();
                    i = 0;
                }
            }

        }

        //private Garment CreateGarment(PreGarment pregarment)
        //{
        //    Garment g = new Garment();
        //    SharpArch.Testing.EntityIdSetter.SetIdOf<int>(g, pregarment.Id);

        //    g.Tags.PreSilouhette = pregarment.Silouhette;
        //    g.Tags.Pattern = new Pattern { Type = pregarment.PatternType };
        //    g.Tags.Colors.Add(new Color { Family = pregarment.ColorFamily });

        //    foreach (Season season in Enum.GetValues(typeof(Season)))
        //        g.Tags.Seasons.Add(season);

        //    foreach (EventType eventType in eventTypeRepository.GetAll())
        //        g.Tags.EventTypes.Add(eventType);

        //    return g;
        //}

        #endregion

        /// <summary>
        /// Creates the necessary combinations for a current closet
        /// </summary>
        /// <param name="c">Current closet</param>
        public void RunOutfitGenerator(Closet c)
        {
            outfitEngineProcessor.EventTypes = c.User.EventTypes;

            foreach (UserFlavor uf in c.User.UserFlavors)
                outfitEngineProcessor.FashionFlavors.Add(uf.Flavor);

            //foreach (ClosetGarment g in c.Garments)
            //    outfitEngineProcessor.Garments.Add(g.Garment);

            outfitEngineProcessor.CreateCombinations();

            // TODO: Could be better to only get combinations for the event types to be processed right?
            // TODO: Outfits should be unique with the accesories, or not? OF COURSE!

            // TODO: The amount of combinations will keep growing and growing.... this will take too much time.
            //IList<Combination> dupPreCombs = combinationRepository.GetAll();
            //IList<Outfit> dupOufits = outfitRepository.GetAll();
            // IList<Combination> dupPreCombs = new List<Combination>();

            //int i = 0;
            //foreach (PreOutfit po in outfitEngineProcessor.Outfits)
            //{
            //    if (i == 0)
            //        combinationRepository.DbContext.BeginTransaction();

            //    PreCombination pc = po.Combination;

            //    Combination comb = new Combination();
            //    comb.AddComponent(pc.GarmentA);
            //    comb.AddComponent(pc.GarmentB);
            //    comb.AddComponent(pc.GarmentC);
            //    comb.AddComponent(pc.GarmentD);
            //    comb.AddComponent(pc.GarmentE);

            //    //int pos = dupPreCombs.IndexOf(comb);
            //    //if (pos >= 0)
            //    //    comb = dupPreCombs[pos];

            //    foreach (EventType et in pc.EventTypes)
            //        comb.AddEventType(et);

            //    foreach (FashionFlavor fv in pc.Flavors)
            //        comb.AddFashionFlavor(fv);

            //    foreach (Season se in pc.Seasons)
            //        comb.AddSeason(se);

            //    Outfit of = new Outfit { Combination = comb };
            //    of.AddAccesory(po.Accesory1);
            //    of.AddAccesory(po.Accesory2);
            //    of.AddAccesory(po.Accesory3);
            //    of.AddAccesory(po.Accesory4);
            //    of.AddAccesory(po.Accesory5);

            //    //pos = dupOufits.IndexOf(of);
            //    //if (pos >= 0) // This outfit already exist, just save the combination updated for now.
            //    //    combinationRepository.SaveOrUpdate(comb);
            //    //else

            //    combinationRepository.SaveOrUpdate(comb);
            //    outfitRepository.SaveOrUpdate(of);

            //    c.AddOutfit(of);
            //    i++;

            //    if (i == 500)
            //    {
            //        combinationRepository.DbContext.CommitTransaction();
            //        i = 0;
            //    }
            //}

            //if (i != 0)
            //    combinationRepository.DbContext.CommitTransaction();
        }
    }
}