using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core.Clothing;
using FashionAde.Core;
using FashionAde.Core.DataInterfaces;
using SharpArch.Core;

namespace FashionAde.ApplicationServices
{
    public class OutfitEngineProcessor : IOutfitEngineProcessor
    {
        #region Private Properties

        private HashSet<PreOutfit> outfits = new HashSet<PreOutfit>();
        private HashSet<PreCombination> flavorCombinations = new HashSet<PreCombination>();
        private HashSet<PreCombination> combinations = new HashSet<PreCombination>();

        private HashSet<Garment> newGarments = null;
        private HashSet<Garment> newAccesories = null;

        private IList<StyleRule> lstStyleRules = null;
        private IList<FashionFlavor> currentFlavors = null;
        private IList<EventType> currentEventTypes = null;
        private IList<PreGarment> currentGarments = null;

        private Season currentSeason;
        private EventType currentEventType;
        private log4net.ILog logger;
        private readonly IStyleRuleRepository styleRuleRepository;

        #endregion

        public OutfitEngineProcessor(IStyleRuleRepository styleRuleRepository)
        {
            Check.Require(styleRuleRepository != null, "styleRuleRepository may not be null");
            this.styleRuleRepository = styleRuleRepository;

            lstStyleRules = styleRuleRepository.GetAll();
            logger = log4net.LogManager.GetLogger(this.GetType().Namespace);
        }

        private bool ExecuteOutfitGenerator(IList<Garment> addedGarments, IList<Garment> addedAccesories)
        {
            if (addedGarments != null)
                foreach (Garment g in addedGarments)
                    newGarments.Add(g);

            if (addedAccesories != null)
                foreach (Garment g in addedAccesories)
                    newAccesories.Add(g);

            //foreach (Season season in Enum.GetValues(typeof(Season)))
            //{
            //    foreach (EventType et in currentEventTypes)
            //    {
            //        currentSeason = season;
            //        currentEventType = et;

                    IList<PreGarment> lstGarments = (from cg in currentGarments
                                                  where
                                                  !cg.PreSilouhette.Layer.Equals(LayerCode.ACC1)
                                                  && !cg.PreSilouhette.Layer.Equals(LayerCode.ACC2)
                                                  && !cg.PreSilouhette.Layer.Equals(LayerCode.ACC3)
                                                  && !cg.PreSilouhette.Layer.Equals(LayerCode.ACC4)
                                                  && !cg.PreSilouhette.Layer.Equals(LayerCode.ACC5)
                                                  && !cg.PreSilouhette.Layer.Equals(LayerCode.ACC6)
                                                  && !cg.PreSilouhette.Layer.Equals(LayerCode.ACC7)
                                                  && !cg.PreSilouhette.Layer.Equals(LayerCode.ACC8)
                                                     select cg).ToList<PreGarment>();

                    IList<PreGarment> lstAccesories = (from cg in currentGarments
                                                    where 
                                                    (cg.PreSilouhette.Layer.Equals(LayerCode.ACC1)
                                                    || cg.PreSilouhette.Layer.Equals(LayerCode.ACC2)
                                                    || cg.PreSilouhette.Layer.Equals(LayerCode.ACC3)
                                                    || cg.PreSilouhette.Layer.Equals(LayerCode.ACC4)
                                                    || cg.PreSilouhette.Layer.Equals(LayerCode.ACC5)
                                                    || cg.PreSilouhette.Layer.Equals(LayerCode.ACC6)
                                                    || cg.PreSilouhette.Layer.Equals(LayerCode.ACC7)
                                                    || cg.PreSilouhette.Layer.Equals(LayerCode.ACC8))
                                                       select cg).ToList<PreGarment>();

                    ExecuteSet(lstGarments, lstAccesories);
            //    }
            //}

            logger.DebugFormat("Found {0} Combinations With Accesories.", this.outfits.Count);

            return (this.outfits.Count > 0);
        }

        #region Execute Sets

        public void ExecuteSet(IList<PreGarment> lstGarments, IList<PreGarment> accesories)
        {
            ExecuteSet(lstGarments, accesories, false);
        }

        public void ExecuteSet(IList<PreGarment> lstGarments, IList<PreGarment> accesories, bool maintainCombinations)
        {
            if (lstGarments.Count == 0)
                return;

            combinations.Clear();
            flavorCombinations.Clear();
            outfits.Clear();

            IList<PreGarment> garmentsA = (from g in lstGarments
                                        where g.PreSilouhette.Layer.Equals(LayerCode.A)
                                           select g).ToList<PreGarment>();
            IList<PreGarment> garmentsC = (from g in lstGarments
                                        where g.PreSilouhette.Layer.Equals(LayerCode.C)
                                           select g).ToList<PreGarment>();
            IList<PreGarment> garmentsD = (from g in lstGarments
                                        where g.PreSilouhette.Layer.Equals(LayerCode.D)
                                           select g).ToList<PreGarment>();

            IList<PreGarment> garmentsAii = (from g in lstGarments
                                          where g.PreSilouhette.Layer.Equals(LayerCode.Aii)
                                             select g).ToList<PreGarment>();

            IList<PreGarment> garmentsAi = (from g in lstGarments
                                         where g.PreSilouhette.Layer.Equals(LayerCode.Ai)
                                            select g).ToList<PreGarment>();

            IList<PreGarment> garmentsB = (from g in lstGarments where g.PreSilouhette.Layer.Equals(LayerCode.B) select g).ToList<PreGarment>();
            IList<PreGarment> garmentsCD = (from g in lstGarments
                                         where g.PreSilouhette.Layer.Equals(LayerCode.C) ||
                                             g.PreSilouhette.Layer.Equals(LayerCode.D)
                                         select g).ToList<PreGarment>();
            IList<PreGarment> garmentsBCD = (from g in lstGarments
                                          where g.PreSilouhette.Layer.Equals(LayerCode.C) ||
                                              g.PreSilouhette.Layer.Equals(LayerCode.D) ||
                                              g.PreSilouhette.Layer.Equals(LayerCode.B)
                                          select g).ToList<PreGarment>();

            //  A + B, A+C, A+D 
            IEnumerable<PreCombination> comb = Combine(garmentsA, garmentsBCD, null, null, null);

            // A+B+C, A+B+D, A+C+D
            IEnumerable<PreCombination> combABC_D = Combine(garmentsA, garmentsB, garmentsCD, null, null);

            // A+C+D
            IEnumerable<PreCombination> combACD = Combine(garmentsA, garmentsC, garmentsD, null, null);

            // Ai + Aii + B, Ai + Aii + C, Ai + Aii + D
            IEnumerable<PreCombination> combAii = Combine(garmentsAi, garmentsAii, garmentsBCD, null, null);

            //// A+B+C+D
            IEnumerable<PreCombination> combABCD = Combine(garmentsA, garmentsB, garmentsC, garmentsD, null);

            //// Ai + Aii + B + C, Ai + Aii + C + D
            IEnumerable<PreCombination> combAiAiiBC = Combine(garmentsAi, garmentsAii, garmentsB, garmentsC, null);
            IEnumerable<PreCombination> combAiAiiCD = Combine(garmentsAi, garmentsAii, garmentsC, garmentsD, null);

            //// Ai + Aii + B + C + D
            IEnumerable<PreCombination> combAiAiiBCD = Combine(garmentsAi, garmentsAii, garmentsB, garmentsC, garmentsD);

            // TODO: Find accesories
            var linqAccesories1 = (from g in accesories
                                   where g.PreSilouhette.Layer.Equals(LayerCode.ACC1)
                                   select g).ToList<PreGarment>();

            var linqAccesories2 = (from g in accesories
                                   where g.PreSilouhette.Layer.Equals(LayerCode.ACC2)
                                   select g).ToList<PreGarment>();

            var linqAccesories3 = (from g in accesories
                                   where g.PreSilouhette.Layer.Equals(LayerCode.ACC3)
                                   select g).ToList<PreGarment>();

            var linqAccesories4 = (from g in accesories
                                   where g.PreSilouhette.Layer.Equals(LayerCode.ACC4)
                                   select g).ToList<PreGarment>();

            var linqAccesories5 = (from g in accesories
                                   where g.PreSilouhette.Layer.Equals(LayerCode.ACC5)
                                   select g).ToList<PreGarment>();

            IEnumerable<PreCombination> accesories1 = Combine(linqAccesories1, null, null, null, null);
            IEnumerable<PreCombination> accesories2 = Combine(linqAccesories1, linqAccesories2, null, null, null);
            IEnumerable<PreCombination> accesories3 = Combine(linqAccesories1, linqAccesories2, linqAccesories3, null, null);
            IEnumerable<PreCombination> accesories4 = Combine(linqAccesories1, linqAccesories2, linqAccesories3, linqAccesories4, null);
            IEnumerable<PreCombination> accesories5 = Combine(linqAccesories1, linqAccesories2, linqAccesories3, linqAccesories4, linqAccesories5);

            foreach (FashionFlavor fv in currentFlavors)
            {
                Console.WriteLine("{0} Started Flavor {1} on Season {2}", DateTime.Now, fv.Name, currentSeason.ToString());

                var styleRule = from s in lstStyleRules
                                where s.FashionFlavor == fv
                                select s;

                StyleRule sr = styleRule.First<StyleRule>();

                for (int i = sr.MinimumLayers; i <= sr.MaximumLayers; i++)
                {
                    Console.WriteLine("{0} Started Layers {1}", DateTime.Now, i);
                    switch (i)
                    {
                        case 2:

                            ExcludeCombinations(sr, comb);

                            break;
                        case 3:

                            ExcludeCombinations(sr, combABC_D);


                            ExcludeCombinations(sr, combACD);


                            ExcludeCombinations(sr, combAii);

                            break;
                        //case 4:
                        //    ExcludeCombinations(sr, combABCD);

                        //    ExcludeCombinations(sr, combAiAiiBC);

                        //    ExcludeCombinations(sr, combAiAiiCD);

                        //    break;
                        //case 5:

                        //    ExcludeCombinations(sr, combAiAiiBCD);

                        //    break;

                    }

                    Console.WriteLine("{0} Ended Layers {1} : {2}", DateTime.Now, i, this.flavorCombinations.Count);
                }

                if (flavorCombinations.Count == 0)
                    continue;

                if (accesories.Count != 0)
                {
                    foreach (int i in sr.AccessoriesAmount)
                    {
                        switch (i)
                        {
                            case 1:
                                // Only ACC1.
                                this.IncludeAccesories(flavorCombinations, accesories1, 1);
                                break;
                            case 2:
                                // Only ACC1, ACC2.
                                this.IncludeAccesories(flavorCombinations, accesories2, 2);
                                break;
                            case 3:
                                // Only ACC1, ACC2, ACC3.
                                this.IncludeAccesories(flavorCombinations, accesories3, 3);
                                break;
                            case 4:
                                // Only ACC1, ACC2, ACC3, ACC4.
                                this.IncludeAccesories(flavorCombinations, accesories4, 4);
                                break;
                            case 5:
                                // Only ACC1, ACC2, ACC3, ACC4, ACC5.
                                this.IncludeAccesories(flavorCombinations, accesories5, 5);

                                //TODO: Add the rest of possible accesories

                                // Only ACC1, ACC2, ACC3, ACC4, ACC5, ACC6.
                                // Only ACC1, ACC2, ACC3, ACC4, ACC5, ACC6, ACC7.
                                // Only ACC1, ACC2, ACC3, ACC4, ACC5, ACC6, ACC7, ACC8.
                                break;
                        }
                    }

                    Console.WriteLine("{0} Ended {1} / {2}", DateTime.Now, this.flavorCombinations.Count, this.outfits.Count);
                }

                combinations.UnionWith(flavorCombinations);
                if (!maintainCombinations)
                    flavorCombinations.Clear();
            }
        }

        #region Exclude Combinations

        private void IncludeAccesories(IEnumerable<PreCombination> currentCombinations, IEnumerable<PreCombination> accesories, int amount)
        {
            foreach (PreCombination comb in currentCombinations)
            {
                // Make sure there will be only 10 garments per outfit.
                int combinationAmount = 2;
                if (comb.GarmentC != null)
                    combinationAmount++;
                if (comb.GarmentD != null)
                    combinationAmount++;
                if (comb.GarmentE != null)
                    combinationAmount++;

                if (combinationAmount + amount > 10)
                    continue;

                foreach (PreCombination acc in accesories)
                {
                    PreOutfit outfit = new PreOutfit();
                    outfit.Combination = comb;
                    outfit.Accesory1 = acc.GarmentA;
                    outfit.Accesory2 = acc.GarmentB;
                    outfit.Accesory3 = acc.GarmentC;
                    outfit.Accesory4 = acc.GarmentD;
                    outfit.Accesory5 = acc.GarmentE;
                    outfits.Add(outfit);
                }
            }
        }
        public void ExcludeCombinations(StyleRule sr, IEnumerable<PreCombination> lst)
        {
            IList<PreCombination> lstFound = new List<PreCombination>();

            // Exclude By Rules
            foreach (PreCombination cb in lst)
            {
                bool colorMatched = true;

                // Exclude combination if does not contains an added garment.
                //if (newGarments != null)
                //    if (!newGarments.Contains(cb.GarmentA) && !newGarments.Contains(cb.GarmentB) && !newGarments.Contains(cb.GarmentC) && !newGarments.Contains(cb.GarmentD) && !newGarments.Contains(cb.GarmentE))
                //        continue;

                HashSet<ColorFamily> colorFamiliesHash = new HashSet<ColorFamily>();
                if (cb.GarmentA != null) colorFamiliesHash.Add(cb.GarmentA.ColorFamily);
                if (cb.GarmentB != null) colorFamiliesHash.Add(cb.GarmentB.ColorFamily);
                if (cb.GarmentC != null) colorFamiliesHash.Add(cb.GarmentC.ColorFamily);
                if (cb.GarmentD != null) colorFamiliesHash.Add(cb.GarmentD.ColorFamily);
                if (cb.GarmentE != null) colorFamiliesHash.Add(cb.GarmentE.ColorFamily);

                IList<ColorFamily> colorFamilies = colorFamiliesHash.ToList<ColorFamily>();

                if (sr.ColorBlending.MonotoneColor)
                    colorMatched = (colorFamilies.Count == 1);

                if (!colorMatched && sr.ColorBlending.AnalogousColor)
                {
                    if (colorFamilies.Count == 2)
                        colorMatched = (colorFamilies[0].AnalogousFamily == colorFamilies[1] || colorFamilies[0].AnalogousFamily2 == colorFamilies[1]);
                }

                if (!colorMatched && sr.ColorBlending.ComplimentaryColor)
                    if (colorFamilies.Count == 2)
                        colorMatched = (colorFamilies[0].ComplimentaryFamily == colorFamilies[1]);

                if (!colorMatched && sr.ColorBlending.NeutralColor)
                {
                    colorMatched = true;
                    foreach (ColorFamily cf in colorFamilies)
                        if (!cf.IsNeutral)
                            colorMatched = false;
                }

                if (!colorMatched && sr.ColorBlending.NeutralPrimaryColor)
                {
                    colorMatched = true;
                    foreach (ColorFamily cf in colorFamilies)
                        if (!cf.IsNeutral && !cf.IsPrimary)
                            colorMatched = false;
                }

                if (!colorMatched && sr.ColorBlending.NeutralSecondaryColor)
                {
                    colorMatched = true;
                    foreach (ColorFamily cf in colorFamilies)
                        if (!cf.IsNeutral && !cf.IsSecondary)
                            colorMatched = false;
                }

                if (!colorMatched)
                    continue;

                HashSet<PatternType> pt = new HashSet<PatternType>();
                if (cb.GarmentA != null) pt.Add(cb.GarmentA.PatternType);
                if (cb.GarmentB != null) pt.Add(cb.GarmentB.PatternType);
                if (cb.GarmentC != null) pt.Add(cb.GarmentC.PatternType);
                if (cb.GarmentD != null) pt.Add(cb.GarmentD.PatternType);
                if (cb.GarmentE != null) pt.Add(cb.GarmentE.PatternType);

                bool matched = false;
                foreach (PatternRule pr in sr.Patterns)
                {
                    if (pt.Count == 1 && pr.FromItem == pr.ToItem && pt.Contains(pr.FromItem))
                        matched = true;
                    else if (pt.Count == 2 && pr.FromItem != pr.ToItem && pt.Contains(pr.FromItem) && pt.Contains(pr.ToItem))
                        matched = true;
                }

                if (!matched)
                    continue;

                HashSet<StructureType> st = new HashSet<StructureType>();
                if (cb.GarmentA != null) st.Add(cb.GarmentA.PreSilouhette.StructureType);
                if (cb.GarmentB != null) st.Add(cb.GarmentB.PreSilouhette.StructureType);
                if (cb.GarmentC != null) st.Add(cb.GarmentC.PreSilouhette.StructureType);
                if (cb.GarmentD != null) st.Add(cb.GarmentD.PreSilouhette.StructureType);
                if (cb.GarmentE != null) st.Add(cb.GarmentE.PreSilouhette.StructureType);

                matched = false;
                foreach (StructureRule pr in sr.Structures)
                {
                    if (st.Count == 1 && pr.FromItem == pr.ToItem && st.Contains(pr.FromItem))
                        matched = true;
                    else if (st.Count == 2 && pr.FromItem != pr.ToItem && st.Contains(pr.FromItem) && st.Contains(pr.ToItem))
                        matched = true;
                }

                if (!matched)
                    continue;

                if (cb.GarmentA.PreSilouhette.Layer == LayerCode.Ai)
                {
                    HashSet<ShapeType> sh = new HashSet<ShapeType>();
                    if (cb.GarmentA != null) sh.Add(cb.GarmentA.PreSilouhette.ShapeType);
                    if (cb.GarmentB != null) sh.Add(cb.GarmentB.PreSilouhette.ShapeType);
                    if (cb.GarmentC != null) sh.Add(cb.GarmentC.PreSilouhette.ShapeType);
                    if (cb.GarmentD != null) sh.Add(cb.GarmentD.PreSilouhette.ShapeType);
                    if (cb.GarmentE != null) sh.Add(cb.GarmentE.PreSilouhette.ShapeType);

                    matched = false;
                    foreach (ShapeRule pr in sr.Shapes)
                    {
                        if (pt.Count == 1 && pr.FromItem == pr.ToItem && sh.Contains(pr.FromItem))
                            matched = true;
                        else if (pt.Count == 2 && pr.FromItem != pr.ToItem && sh.Contains(pr.FromItem) && sh.Contains(pr.ToItem))
                            matched = true;
                    }

                    if (!matched)
                        continue;
                }

                cb.FashionFlavor = sr.FashionFlavor;
                lstFound.Add(cb);
            }

            flavorCombinations.UnionWith(lstFound);

            //// Add current flavor
            //var list = flavorCombinations.Intersect<PreCombination>(lstFound);
            //foreach (PreCombination pc in list)
            //{
            //    pc.Flavors.Add(sr.FashionFlavor);
            //    pc.Seasons.Add(currentSeason);
            //    pc.EventTypes.Add(currentEventType);
            //}
        }

        #endregion

        #region Combine Cartesian Method

        public IEnumerable<PreCombination> Combine(IEnumerable<PreGarment> garmentListForA, IEnumerable<PreGarment> garmentListForB, IEnumerable<PreGarment> garmentListForC, IEnumerable<PreGarment> garmentListForD, IEnumerable<PreGarment> garmentListForE)
        {
            foreach (PreGarment ga in garmentListForA)
            {
                if (garmentListForB == null)
                {
                    yield return new PreCombination { GarmentA = ga };
                    continue;
                }

                foreach (PreGarment gb in garmentListForB)
                {
                    if (garmentListForC == null)
                    {
                        yield return new PreCombination { GarmentA = ga, GarmentB = gb };
                        continue;
                    }

                    foreach (PreGarment gc in garmentListForC)
                    {
                        if (garmentListForD == null)
                        {
                            yield return new PreCombination { GarmentA = ga, GarmentB = gb, GarmentC = gc };
                            continue;
                        }

                        foreach (PreGarment gd in garmentListForD)
                        {
                            if (garmentListForE == null)
                            {
                                yield return new PreCombination { GarmentA = ga, GarmentB = gb, GarmentC = gc, GarmentD = gd };
                                continue;
                            }

                            foreach (PreGarment ge in garmentListForE)
                            {
                                yield return new PreCombination { GarmentA = ga, GarmentB = gb, GarmentC = gc, GarmentD = gd, GarmentE = ge };
                            }
                        }
                    }
                }
            }
        }

        #endregion

        #endregion

        #region IOutfitEngineProcessor Members

        public IEnumerable<PreCombination> Combinations
        {
            get { return combinations; }
        }

        public IEnumerable<PreOutfit> Outfits
        {
            get { return outfits; }
        }

        private IList<FashionFlavor> fashionFlavors = new List<FashionFlavor>();
        public IList<FashionFlavor> FashionFlavors
        {
            get { return fashionFlavors; }
            set { fashionFlavors = value; }
        }

        private IList<EventType> eventTypes = new List<EventType>();
        public IList<EventType> EventTypes
        {
            get { return eventTypes; }
            set { eventTypes = value; }
        }

        private IList<PreGarment> garments = new List<PreGarment>();
        public IList<PreGarment> Garments
        {
            get { return garments; }
            set { garments = value; }
        }

        public bool HasValidCombinations()
        {
            currentFlavors = FashionFlavors;
            currentEventTypes = EventTypes;
            currentGarments = Garments;

            return ExecuteOutfitGenerator(null, null);
        }

        public bool CreateCombinations()
        {
            return CreateCombinations(null, null);
        }

        public bool CreateCombinations(IList<Garment> addedGarments, IList<Garment> addedAccesories)
        {
            Check.Require(FashionFlavors.Count > 0, "Flavors must be included");
            //Check.Require(EventTypes.Count > 0, "EventTypes must be included");
            Check.Require(Garments.Count > 0, "Garments must be included");

            currentFlavors = FashionFlavors;
            currentEventTypes = EventTypes;
            currentGarments = Garments;

            return ExecuteOutfitGenerator(addedGarments, addedAccesories);
        }

        #endregion
    }
}
