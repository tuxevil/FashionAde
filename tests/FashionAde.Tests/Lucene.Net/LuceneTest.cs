using System;
using System.Collections.Generic;
using System.Linq;
using System.Text; 
using NUnit.Framework;
using FashionAde.ApplicationServices.SearchEngine;
using Lucene.Net.Analysis.Snowball;
using Lucene.Net.Store;
using System.IO;

using Directory = Lucene.Net.Store.Directory;
using Lucene.Net.Analysis.Standard;
using Lucene.Net.Analysis;
using System.Threading;

namespace Tests.Lucene.Net
{
    public class LuceneTest
    {
        private int maxClosets = 1;
        private static int maxRecordsPerCloset = 100;

        #region Random Helper
        static Random rnd = new Random();
        private static string GetRandom(string[] values)
        {
            return GetRandom(values, null);
        }

        private static string GetRandom(string[] values, int? amount)
        {
            int max;
            if (amount.HasValue)
                max = amount.Value;
            else
                max = rnd.Next(values.Length) + 1;

            string[] items = new string[max];

            for (int i = 0; i < max; i++)
            {
                while (string.IsNullOrEmpty(items[i]))
                {
                    string val = values[rnd.Next(values.Length)];
                    if (!items.Contains(val))
                        items[i] = val;
                }
            }

            return string.Join(" ", items, 0, items.Length);
        }

        static string[] categories = { "Pants", "Jeans", "Shorts", "Skirts", "Dresses", "Jackets", "Coats", "Cardigan", "Tops", "Jewelry", "Belts", "Shoes", "Bags" };
        static string[] colors = { "Black", "Gray", "Light Gray", "Beige", "White", "Brown", "Burgundy", "Red", "Pink", "Light Red Violet", "RedViolet", "Berry Red", "Deep Purple", "Purple", "Lavender", "Periwinkle", "Blue Purple", "Deep Blue Purple", "Navy", "Blue", "Baby Blue", "Aqua", "Blue Green", "Dark Blue Green", "Dark Green", "Green", "Mint", "Lime", "Yellow Green", "Olive", "Goldenrod ", "Yellow", "Lemon ", "Light Orange Yellow", "Orange Yellow", "Dark Orange Yellow", "Pumpkin", "Orange", "Sherbert ", "Light Coral", "Coral", "Dark Red Orange", "Silver", "Cooper", "Gold" };
        static string[] eventTypes = { "Date Night Play", "Formal Affair Evening", "The Casual Workplace Work", "The Formal Workplace Work", "At Play Play" };
        static string[] fabrics = { "Generic", "Satin", "Lace", "Sequin", "Brocade", "Denim", "Leather", "Suede", "Boucle", "Courduroy", "Velvet", "Velour", "Fleece", "Knit", "Fur", "Metallic", "Cotton", "Linen", "Wool", "Twill", "Jersey", "Silk", "Sweatshirt", "Patent", "Rubber", "Elastic" };
        static string[] seasons = { "Summer", "Winter", "Spring", "Fall" };
        static string[] silouhettes = { "Boot Cut Mid Rise Flat Waist", "Straight Mid Rise Flat Waist", "Straight High Rise Pleated Waist", "Wide Leg High Rise Flat Waist", "Wide Leg Mid Rise Flat Waist", "Skinny Leg Mid Rise Flat Waist", "Cropped Pant Mid Rise Flat Waist", "Cropped Cargo Mid Rise Flat Waist", "Cargo Pant", "Sailor Pant", "Palazzo Pant", "Wide Leg Drawstring", "Straight Leg Elastic Waist", "Legging", "Track Pant ", "Yoga Pant", "Riding Pant ", "Cigarette Pant", "Tuxedo Pant", "Harem Pant - dormant", "Mid Rise Pant", "Boot Cut Mid Rise Flat Waist", "Boot Cut Low Rise Flat Waist", "Straight High Rise Flat Waist", "Straight Mid Rise Flat Waist", "Wide Leg High Rise Flat Waist dormant", "Wide Leg Mid Rise Flat Waist", "Wide Leg Low Rise Flat Waist", "Cropped Mid Rise Flat Waist", "Skinny Mid Rise Flat Waist", "Boyfriend", "Cropped Rolled Mid Rise", "Short  High Rise", "Short Mid Rise", "Short  Low Rise", "Walking Mid Rise Mid Thigh", "Bermuda Mid Rise Full Thigh dormant", "Elastic Waist", "Cargo Mid Rise", "Boy Shorts", "A Line Knee Length", "A Line Floor Length", "Straight Knee Length", "Straight Calf Length", "Straight Floor Length", "Pencil Knee Length", "Mini Straight", "Prairie Calf Length", "Jean Skirt Knee Length", "Jean Skirt Mini", "Trumpet", "Pleated", "Skort dormant", "Wrap", "Tulip", "Mini Ruffled", "Bubble", "Sheath Dress", "Shift Dress", "Tent Dress", "Wrap Dress", "Polo Dress", "Short Sleeve Shirt Dress", "Long Sleeve Shirt Dress", "Strapless Dress", "Jumper Dress", "Sleeveless Full Dress", "Coat Dress", "Empire Waist Dress", "Dropped Waist Dress dormant", "Slip Dress", "Peasant Dress", "Tee Shirt Dress", "Tank Dress dormant", "One Shoulder Dress", "Halter Dress", "Bandage Dress", "Draped Dress ", "Sundress", "Fitted Cropped", "Fitted Waist Length", "Fitted Hip Length", "Blazer", "Swing", "Military", "Tuxedo ", "Boyfriend", "Safari", "Bomber", "Motorcycle", "Peplum", "Nehru - dormant", "Jean", "Track Jacket", "Hoodie", "Trench", "Top Coat", "Car Coat", "Peacoat", "Parka", "Swing", "Wrap", "Cape dormant", "Anorak", "Field Coat - dormant", "Button Down Hip Length", "Button Down Thigh Length", "Cropped/Bolero", "Zip Hip Length", "Zip Thigh Length", "Wrap Dormant", "Tuxedo/Suit/Halter Vest", "Boxy Vest", "Crop/Bolero Vest Dormant", "Hip Length/Tunic Vest", "Pullover Vest", "Button Down Plain", "Button Down Camp", "Button Down Tie Dormant", "Button Down Ruffle", "Sleeveless Ruffle", "Bustier", "Cap Sleeve", "Wrap Top", "Peasant Top", "Scoop Neck Short Sleeve", "Scoop Neck Long Sleeve", "Crew Neck Short Sleeve", "Crew Neck Long Sleeve dormant", "V Neck Short Sleeve", "V Neck Long Sleeve", "Boat Neck 3/4 Sleeve", "Long Sleeve Square Neck ", "Short Sleeve Square Neck - Dormant", "Tank Top", "Cami", "Cami - Empire Waist", "Polo Short Sleeve", "Polo Long Sleeve", "Henley Long Sleeve", "Cowl Neck Long Sleeve", "Drop Shoulder Long Sleeve Dormant", "Tunic", "Turtleneck Long Sleeve", "Turtleneck Short Sleeve", "Sweatshirt", "Tux Shirt", "Turtleneck Sleeveless", "Pullover Zip Neck", "Necklace -Chain Long", "Necklace -Chain Short", "Necklace -Pendant Long", "Necklace -Pendant Short", "Necklace - Bead Long", "Necklace - Bead Short", "Pearls Large Long", "Pearls Large Short", "Pearls Small Long", "Pearls Small Short", "Necklace Statement", "Necklace - Bead Spaced", "Bracelet - Cuff", "Bracelet Bangle", "Bracelet Link", "Bracelet bead", "Charm Bracelet", "Ring Bold Cocktail", "Ring Delicate", "Earring Chandelier", "Earring Hoop Large", "Earring Hoop Small", "Earring Stud", "Watch Bold Metal", "Watch Delicate Metal", "Watch Bold Leather", "Watch Delicate Leather", "Earring Drop", "Belt Waist Cincher", "Belt Wide", "Belt Moderate", "Belt Studded", "Belt Skinny", "Belt Chain", "Shoe Stiletto", "Shoe Platform Pump", "Shoe Pump", "Shoe D'Orsay", "Shoe Platform Sling Back", "Shoe Peep Toe", "Shoe Sandal with Heel", "Shoe Sandal Wedge", "Shoe Sandle Platform", "Shoe Espadrille", "Shoe Thong", "Shoe Gladiator Flat", "Shoe Flip Flop", "Shoe Ballet Flat", "Shoe Loafer", "Shoe Oxford/Brogan", "Boot Stiletto", "Boot Platform", "Boot Mid Heel with Square Toe", "Boot Bootie", "Boot Flat", "Boot Ugg", "Shoe Sneaker", "Shoe Clog", "Cowboy Boot Dormant", "Shoe Kitten Heel", "Satchel", "Shoulder", "Clutch", "Tote", "Hobo", "Evening", "Messenger", "Structured ", "Backpack" };
        static string[] tags = { "Tag1", "Tag2", "Tag3", "Tag4", "Tag5" };
        static string[] rating = { "1", "2", "3", "4", "5" };
        static string[] flavor = { "1", "2" };

        #endregion

        [Test]
        public void GetIndex()
        {
            using (SearchEngineService ses = SearchEngineService.GetByCloset(98))
            {
                SearchParameters sp = new SearchParameters();
                sp.Seasons = new[] { "winter", "summer", "spring", "fall" };
                SearchEngineResponse ser = ses.Search(sp, 0, 9, "EditorRating", false);
                Console.WriteLine(ser.TotalCount);
                foreach(SearchEngineResult res in ser.Results)
                    Console.WriteLine(res.EntryId);
            }
        }

        /// <summary>
        /// Create indexes per closet simulation
        /// </summary>
        [Test]
        public void CreateIndexes()
        {
            for (int closet = 1; closet <= maxClosets; closet++)
            {
                CreateIndex(closet);
            }
        }

        [Test]
        public void CanSearchByBooleanField()
        {
            CreateIndex(1);

            using (SearchEngineService ses = SearchEngineService.GetByCloset(1))
            {
                SearchParameters sp = new SearchParameters();
                sp.CreatedByMe = true;

                SearchEngineResponse ser = ses.Search(sp, 0, 10, "EditorRating", false);
                Assert.IsTrue(ser.TotalCount == 0, ser.TotalCount.ToString());
            }
        }

        [Test]
        public void CanSearchFriendRateRange()
        {
            CreateIndex(1);

            using (SearchEngineService ses = SearchEngineService.GetByCloset(1))
            {
                SearchParameters sp = new SearchParameters();
                sp.IsRatedByFriends = true;
                SearchEngineResponse ser = ses.Search(sp, 0, 10, "EditorRating", false);
                Assert.IsTrue(ser.TotalCount == 11, ser.TotalCount.ToString());
                Assert.IsTrue(ser.Results.Count() > 0);
            }
        }

        [Test]
        public void CanSearchAllSeasons()
        {
            CreateIndex(1);

            using (SearchEngineService ses = SearchEngineService.GetByCloset(1))
            {
                SearchParameters sp = new SearchParameters();
                sp.Seasons = new [] { "winter", "summer", "spring", "fall" }; 
                SearchEngineResponse ser = ses.Search(sp, 0, 10, "EditorRating", false);
                Assert.IsTrue(ser.TotalCount == 100, ser.TotalCount.ToString());
            }
        }

        [Test]
        public void CanSearchEventTypes()
        {
            CreateIndex(1);

            using (SearchEngineService ses = SearchEngineService.GetByCloset(1))
            {
                SearchParameters sp = new SearchParameters();
                sp.EventTypes = new[] { "Formal Affair Evening" };
                SearchEngineResponse ser = ses.Search(sp, 0, 10, "EditorRating", false);
                Assert.IsTrue(ser.TotalCount > 0);
            }
        }


        [Test]
        public void CanSearchByIntegerField()
        {
            CreateIndex(1);

            using (SearchEngineService ses = SearchEngineService.GetByCloset(1))
            {
                SearchParameters sp = new SearchParameters();
                sp.MyRating = 4;

                SearchEngineResponse ser = ses.Search(sp, 0, 10, "EditorRating", false);
                Assert.IsTrue(ser.TotalCount == 0, ser.TotalCount.ToString());

                sp.MyRating = 5;
                ser = ses.Search(sp, 0, 10, "EditorRating", false);
                Assert.IsTrue(ser.TotalCount == 1, ser.TotalCount.ToString());
            }
        }

        [Test]
        public void CanRemoveItemFromIndex()
        {
            CreateIndex(1);

            using (SearchEngineService ses = SearchEngineService.GetByCloset(1))
            {
                int totalEntry = ses.GetTotalIndexedEntryCount();
                ses.RemovePost(2);
                Assert.IsTrue(ses.GetTotalIndexedEntryCount() == totalEntry -1);
            }
        }

        [Test]
        public void CanUpdateIndex()
        {
            CreateIndex(1);

            using (SearchEngineService ses = SearchEngineService.GetByCloset(1))
            {
                //int totalEntry = ses.GetTotalIndexedEntryCount();
                //ses.RemovePost(2);
                //Assert.IsTrue(ses.GetTotalIndexedEntryCount() == totalEntry - 1);

                SearchEngineEntry see = new SearchEngineEntry();
                see.EntryId = 2;
                int amountOfClothes = rnd.Next(10) + 1;

                see.Categories = GetRandom(categories, amountOfClothes / 2);
                see.Colors = GetRandom(colors, amountOfClothes);
                see.Silouhettes = GetRandom(silouhettes, amountOfClothes);
                see.EventTypes = GetRandom(eventTypes);
                see.Fabrics = GetRandom(fabrics);
                see.Seasons = GetRandom(seasons);
                see.Tags = GetRandom(tags);
                see.CreatedByMe = true;
                see.EditorRating = Convert.ToInt32(GetRandom(rating, 1));
                see.FriendRating = Convert.ToInt32(GetRandom(rating, 1));
                see.MyRating = 6;
                see.FlavorId = Convert.ToInt32(GetRandom(flavor, 1));

                ses.AddEntry(see);
                //Assert.IsTrue(ses.GetTotalIndexedEntryCount() == totalEntry);

                SearchParameters sp = new SearchParameters();
                //sp.CreatedByMe = true;
                sp.MyRating = 6;

                SearchEngineResponse ser = ses.Search(sp, 0, 10, "EditorRating", false);
                Assert.IsTrue(ser.TotalCount == 1);
            }

        }

        public static void CreateIndex(object closet)
        {
            using (SearchEngineService ses = SearchEngineService.GetByCloset(Convert.ToInt32(closet)))
            {
                IList<SearchEngineEntry> lst = new List<SearchEngineEntry>();
                for (int i = ((Convert.ToInt32(closet) - 1) * maxRecordsPerCloset); i < maxRecordsPerCloset * Convert.ToInt32(closet); i++)
                {
                    SearchEngineEntry see = new SearchEngineEntry();
                    see.EntryId = i;

                    int amountOfClothes = rnd.Next(10) + 1;

                    see.Categories = GetRandom(categories, amountOfClothes / 2);
                    see.Colors = GetRandom(colors, amountOfClothes);
                    see.Silouhettes = GetRandom(silouhettes, amountOfClothes);
                    see.EventTypes = GetRandom(eventTypes);
                    see.Fabrics = GetRandom(fabrics);
                    see.Seasons = GetRandom(seasons);
                    see.Tags = GetRandom(tags);
                    see.EditorRating = Convert.ToInt32(GetRandom(rating, 1));
                    see.FriendRating = 0;
                    see.FlavorId = Convert.ToInt32(GetRandom(flavor, 1));

                    see.CreatedByMe = false;
                    see.MyRating = 0;

                    if (i == 1)
                        see.MyRating = 5;

                    if (i <= 10)
                        see.FriendRating = 3;

                    lst.Add(see);
                }

                ses.AddEntries(lst);
            }
        }

        public static void RunSearch(object closet)
        {
            using (SearchEngineService ses = SearchEngineService.GetByCloset(Convert.ToInt32(closet)))
            {
                SearchParameters sp = new SearchParameters();
                sp.FreeText = "";
                sp.IsRatedByMe = false;
                sp.FlavorId = 2;
                sp.IsRatedByFriends = true;

                SearchEngineResponse response = ses.Search(sp, 0, 10, "MyRating", true);
                Assert.IsTrue(response.TotalCount > 0);
                Console.WriteLine(response.TotalCount);
            };
        }

        //[Test]
        //public void CanSearchIndexes()
        //{
        //    RunSearch(1);
        //}

        ///// <summary>
        ///// Search the indexes per closet
        ///// </summary>
        //[Test]
        //public void CanSearchIndexesWhileUpdatingIndex()
        //{
        //    for (int k = 1; k <= 5; k++)
        //    {
        //        IList<Thread> threads = new List<Thread>();

        //        for (int closet = 1; closet <= maxClosets; closet++)
        //        {
        //            Thread t = new Thread(new ParameterizedThreadStart(CreateIndex));
        //            t.Start(closet);
        //            threads.Add(t);
        //            Console.WriteLine("Thread for update started.");

        //            Thread.Sleep(10000);

        //            for (int j = 1; j <= 100; j++)
        //            {
        //                t = new Thread(new ParameterizedThreadStart(RunSearch));
        //                t.Start(closet);
        //                threads.Add(t);
        //                Console.WriteLine("Thread {0} started.", j);
        //            }
        //        }

        //        foreach (Thread t in threads)
        //            t.Join();
        //    }

        //}
    }
}
