using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using FashionAde.Core.Clothing;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.ThirdParties;
using FashionAde.Core.Trends;
using FileHelpers;
using FileHelpers.RunTime;
using SharpArch.Web.NHibernate;
using SharpArch.Data.NHibernate;
using SharpArch.Core.PersistenceSupport;

namespace FashionAde.OutfitUpdaterImportation
{
    public static class StringExtension
    {
        public static bool HasKeywords(this string source, string keywords)
        {
            if (!string.IsNullOrEmpty(keywords) && !string.IsNullOrEmpty(source))
            {
                bool found = true;
                string safeSource = source.ToLower();

                string[] arrKeys = keywords.ToLower().Split(' ');
                foreach(string key in arrKeys)
                    if (!safeSource.Contains(key.Trim()))
                        found = false;

                return found;
            }

            return false;
        }
    }

    public class ImportExecutor
    {
        #region Logger

        private static log4net.ILog _logger = log4net.LogManager.GetLogger(typeof(ImportExecutor).Namespace);

        #endregion

        #region Constructors

        private IFeedImporter feedImporter;
        private IOutfitUpdaterRepository outfitUpdaterRepository;
        private ITrendRepository trendRepository;
        private ISilouhetteRepository silouhetteRepository;
        private IPatternRepository patternRepository;
        private IColorFamilyRepository colorFamilyRepository;
        private IPartnerRepository partnerRepository;

        public ImportExecutor(IFeedImporter feedImporter, 
            IOutfitUpdaterRepository outfitUpdaterRepository, 
            ITrendRepository trendRepository, 
            ISilouhetteRepository silouhetteRepository, 
            IPatternRepository patternRepository, 
            IColorFamilyRepository colorFamilyRepository,
            IPartnerRepository partnerRepository)
        {
            this.feedImporter = feedImporter;
            this.outfitUpdaterRepository = outfitUpdaterRepository;
            this.trendRepository = trendRepository;
            this.silouhetteRepository = silouhetteRepository;
            this.patternRepository = patternRepository;
            this.colorFamilyRepository = colorFamilyRepository;
            this.partnerRepository = partnerRepository;
        }

        #endregion

        #region Properties

        private int totalAdded = 0;
        private List<ImportLine> lines;

        private HashSet<string> itemIds = new HashSet<string>();

        private Partner partner;

        private List<OutfitUpdater> outfitUpdaters = new List<OutfitUpdater>();

        private List<Trend> trends = new List<Trend>();
        private List<Silouhette> silouhettes = new List<Silouhette>();
        private List<Pattern> patterns = new List<Pattern>();
        private List<ColorFamily> colorFamilies = new List<ColorFamily>();


        private IList<ColorFamilyKeywordsByPartner> colorFamilyKeywords;
        private IList<PatternKeywordsByPartner> patternKeywords;
        private IList<SilouhetteKeywordsByPartner> silouhetteKeywords;

        private List<string> wordsForDiscard = new List<string>();


        #endregion

        public void Create()
        {
            lines = new List<ImportLine>();

            partner = partnerRepository.GetByCode(feedImporter.PartnerCode);

            trends = new List<Trend>(trendRepository.GetCurrentTrends());
            silouhettes = new List<Silouhette>(silouhetteRepository.GetAll());
            patterns = new List<Pattern>(patternRepository.GetAll());
            colorFamilies = new List<ColorFamily>(colorFamilyRepository.GetAll());
            outfitUpdaters = new List<OutfitUpdater>(outfitUpdaterRepository.GetFor(partner));

            // Retrieve Keywords
            colorFamilyKeywords = colorFamilyRepository.GetKeywordsByPartner(partner);
            patternKeywords = patternRepository.GetKeywordsByPartner(partner);
            silouhetteKeywords = silouhetteRepository.GetKeywordsByPartner(partner);

            // Set discard words
            wordsForDiscard.Add("men");
            wordsForDiscard.Add("mens");
            wordsForDiscard.Add("men's");
            wordsForDiscard.Add("men´s");
            wordsForDiscard.Add("kid");
            wordsForDiscard.Add("kids");
            wordsForDiscard.Add("kid's");
            wordsForDiscard.Add("infant");
            wordsForDiscard.Add("girl");
            wordsForDiscard.Add("boy");
            wordsForDiscard.Add("girls");
            wordsForDiscard.Add("boys");
            wordsForDiscard.Add("girl’s");
            wordsForDiscard.Add("boy’s");
            wordsForDiscard.Add("girl's");
            wordsForDiscard.Add("boy's");
            wordsForDiscard.Add("Toddler");
            wordsForDiscard.Add("4-6X");
            wordsForDiscard.Add("Newborn");
            wordsForDiscard.Add("Bedding Collection");
            wordsForDiscard.Add("Sleep Sense");
            wordsForDiscard.Add("7-16");
            wordsForDiscard.Add("Pajamas");
            wordsForDiscard.Add("Bra");
            wordsForDiscard.Add("Hipster");
            wordsForDiscard.Add("8-20");
            wordsForDiscard.Add("swimsuit");
            wordsForDiscard.Add("luggage");
            wordsForDiscard.Add("table linens");
            wordsForDiscard.Add("2T-10");
            wordsForDiscard.Add("China");
            wordsForDiscard.Add("stemwear");
            wordsForDiscard.Add("cuff links");
            wordsForDiscard.Add("Noritake");
            wordsForDiscard.Add("Jasmine & Ginger");

            _logger.InfoFormat("Looping through file");
            feedImporter.FeedLineRead += new FeedLineReadEventHandler(ouImportationClassBuilder_FeedLineRead);
            feedImporter.ProcessFeed();

            CheckToSaveLines();
        }

        void ouImportationClassBuilder_FeedLineRead(object sender, FeedLineReadEventArgs e)
        {
            ImportLine line = CheckLine(e.Data);
            if (line != null)
                lines.Add(line);

            CheckToSaveLines();
        }

        private void CheckToSaveLines()
        {
            if ((lines.Count + 1) % 500 == 0)
            {
                _logger.InfoFormat("Processing valid {0} records", lines.Count);
                ProcessList();
                totalAdded += lines.Count;
                lines.Clear();
                GC.Collect();
                _logger.InfoFormat("Processed so far: {0}", totalAdded);
            }
        }

        private ImportLine CheckLine(ImportLine line)
        {
            //Chekeo de datos obligatorios
            if (string.IsNullOrEmpty(line.Sku)
                || string.IsNullOrEmpty(line.Description)
                || line.Price == null || line.Price <= 0
                || string.IsNullOrEmpty(line.BuyUrl) || string.IsNullOrEmpty(line.ImageUrl))
            {
                return null;
            }

            string lineForKeywords = string.Format("{0} {1} {2} {3}", line.Name.ToLower(), line.Keywords.ToLower(), line.Description.ToLower(), line.Gender.ToLower());

            if (wordsForDiscard.Any(s => lineForKeywords.HasKeywords(s) && !lineForKeywords.HasKeywords("woman") && !lineForKeywords.HasKeywords("women")))
            {
                return null;
            }

            // REVIEW: LINQ queries are more efficient.
            foreach (Trend trend in trends)
                if (trend.Keywords.Any(keyword => lineForKeywords.HasKeywords(keyword)))
                {
                    line.Trends.Add(trend);
                }

            if (line.Trends.Count == 0)
                return null;

            // REVIEW: LINQ queries are more efficient.
            foreach (Silouhette silouhette in silouhettes)
                if (lineForKeywords.HasKeywords(silouhette.Description))
                {
                    line.Silouhette = silouhette;
                    break;
                }
                else
                {
                    foreach (SilouhetteKeywordsByPartner keyword in silouhetteKeywords)
                    {
                        if (keyword.Partner != partner || keyword.Silouhette != silouhette) continue;
                        
                        if (keyword.Keywords.Split(',').Any(key => lineForKeywords.HasKeywords(key)))
                        {
                            line.Silouhette = silouhette;
                            break;
                        }
                    }
                }

            // REVIEW: LINQ queries are more efficient.
            foreach (Pattern pattern in patterns)
                if (lineForKeywords.HasKeywords(pattern.Description))
                {
                    line.Pattern = pattern;
                    break;
                }
                else
                {
                    foreach (PatternKeywordsByPartner keyword in patternKeywords)
                        if (keyword.Partner == partner && keyword.Pattern == pattern)
                            if (keyword.Keywords.Split(',').Any(key => lineForKeywords.HasKeywords(key)))
                            {
                                line.Pattern = pattern;
                                break;
                            }
                }

            // REVIEW: LINQ queries are more efficient.
            foreach (ColorFamily colorFamily in colorFamilies)
                if (lineForKeywords.HasKeywords(colorFamily.Description))
                {
                    line.ColorFamily = colorFamily;
                    break;
                }
                else
                {
                    foreach (ColorFamilyKeywordsByPartner keyword in colorFamilyKeywords)
                        if (keyword.Partner == partner && keyword.ColorFamily == colorFamily)
                            if (keyword.Keywords.Split(',').Any(key => lineForKeywords.HasKeywords(key)))
                            {
                                line.ColorFamily = colorFamily;
                                break;
                            }
                }

            if (line.Silouhette != null && line.Pattern != null && line.ColorFamily != null)
                line.Status = OutfitUpdaterStatus.Valid;
            else
                return null;

            int tmpCount = itemIds.Count;
            itemIds.Add(line.Sku);
            if (itemIds.Count == tmpCount)
                return null;
            
            return line;
        }

        private void ProcessList()
        {
            if (lines.Count == 0)
                return;

            outfitUpdaterRepository.DbContext.BeginTransaction();
            foreach (ImportLine importationLine in lines)
            {
                OutfitUpdater outfitUpdater = outfitUpdaters.Find(e => e.ExternalId.Equals(importationLine.Sku) && e.Partner.Equals(partner));

                if(outfitUpdater == null)
                    outfitUpdater = new OutfitUpdater();

                int amountOfTrends = outfitUpdater.Trends.Count;

                ICollection<Trend> hsTrends = new HashSet<Trend>(outfitUpdater.Trends);
                outfitUpdater.Trends.Clear();
                foreach (Trend t in hsTrends.Union(importationLine.Trends))
                    outfitUpdater.Trends.Add(t);

                if (amountOfTrends == outfitUpdater.Trends.Count && (outfitUpdater.BuyUrl == importationLine.BuyUrl) && (outfitUpdater.Description == importationLine.Description)
                    && (outfitUpdater.ExternalId == importationLine.Sku) && (outfitUpdater.ImageUrl == importationLine.ImageUrl)
                    && (outfitUpdater.Keywords == importationLine.Keywords) && (outfitUpdater.Name == importationLine.Name)
                    && (outfitUpdater.Price == importationLine.Price)
                    && (outfitUpdater.Partner == partner) && (outfitUpdater.Silouhette == importationLine.Silouhette)
                    && (outfitUpdater.Pattern == importationLine.Pattern) && (outfitUpdater.ColorFamily == importationLine.ColorFamily))
                    continue;

                // If it was processed before and has more trends, let's mark it as updated.
                if (amountOfTrends < outfitUpdater.Trends.Count)
                    if (outfitUpdater.Status > OutfitUpdaterStatus.Valid)
                        outfitUpdater.Status = OutfitUpdaterStatus.Updated;

                outfitUpdater.BuyUrl = importationLine.BuyUrl;
                outfitUpdater.Description = importationLine.Description;
                outfitUpdater.ExternalId = importationLine.Sku;
                outfitUpdater.ImageUrl = importationLine.ImageUrl;
                outfitUpdater.Keywords = importationLine.Keywords;
                outfitUpdater.Name = importationLine.Name;
                outfitUpdater.Partner = partner;
                outfitUpdater.Price = importationLine.Price;
                outfitUpdater.Season = SeasonHelper.CurrentSeason;

                if (outfitUpdater.Status == OutfitUpdaterStatus.Incomplete)
                {
                    if (outfitUpdater.Silouhette == null)
                        outfitUpdater.Silouhette = importationLine.Silouhette;
                    if (outfitUpdater.Pattern == null)
                        outfitUpdater.Pattern = importationLine.Pattern;
                    if (outfitUpdater.ColorFamily == null)
                        outfitUpdater.ColorFamily = importationLine.ColorFamily;

                    if (outfitUpdater.Silouhette != null &&
                        outfitUpdater.Pattern != null &&
                        outfitUpdater.ColorFamily != null)
                        outfitUpdater.Status = OutfitUpdaterStatus.Valid;
                }

                outfitUpdaterRepository.SaveOrUpdate(outfitUpdater);
            }

            outfitUpdaterRepository.DbContext.CommitTransaction();
        }
    }
}
