using System;
using System.Collections.Generic;

namespace FashionAde.Core.Clothing
{
    public class SeasonHelper
    {
        public static Season CurrentSeason
        {
            get
            {
                return GetCurrentSeason(DateTime.Today);
            }
        }

        public static Season GetCurrentSeason(DateTime currDate)
        {
            DateTime march21 = new DateTime(currDate.Year, 3, 21);
            DateTime jun21 = new DateTime(currDate.Year, 6, 21);
            DateTime sep21 = new DateTime(currDate.Year, 9, 21);

            if (currDate < march21)
                return Season.Winter;

            if (currDate >= march21 && currDate < jun21)
                return Season.Spring;

            if (currDate >= jun21 && currDate < sep21)
                return Season.Summer;

            return Season.Fall;
        }

        public static string CurrentSeasonId
        {
            get { return ((int)CurrentSeason).ToString(); }
        }

        public static IList<Season> ListSeasons()
        {
            List<Season> lst = new List<Season>();

            switch (CurrentSeason)
            {
                case Season.Spring:
                    lst.AddRange(new List<Season> { Season.Spring, Season.Summer, Season.Fall, Season.Winter, Season.All });
                    break;
                case Season.Summer:
                    lst.AddRange(new List<Season> { Season.Summer, Season.Fall, Season.Winter, Season.Spring, Season.All });
                    break;
                case Season.Fall:
                    lst.AddRange(new List<Season> { Season.Fall, Season.Winter, Season.Spring, Season.Summer, Season.All });
                    break;
                case Season.Winter:
                    lst.AddRange(new List<Season> { Season.Winter, Season.Spring, Season.Summer, Season.Fall, Season.All });
                    break;
                case Season.All:
                    break;
            }

            return lst;
        }

        public static Season GetSeason(int season)
        {
            return (Season) season;
        }
    }
}