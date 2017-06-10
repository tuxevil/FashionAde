using System;
using System.Collections.Generic;
using FashionAde.Core;
using FashionAde.Core.Clothing;
using System.Linq;

namespace FashionAde.ApplicationServices.SearchEngine
{
    public static class SearchEngineExtensions
    {
        public static SearchEngineEntry ToSearchEngineEntry(this ClosetOutfit closetOutfit)
        {
            SearchEngineEntry see = new SearchEngineEntry();
            see.EntryId = closetOutfit.Id;

            var categories = new HashSet<string>();
            var colors = new HashSet<string>();
            var silouhettes = new HashSet<string>();
            var eventtypes = new HashSet<string>();
            var fabrics = new HashSet<string>();
            var seasons = new HashSet<string>();
            var keywords = new HashSet<string>();

            foreach (Garment g in closetOutfit.Components)
            {
                categories.Add(g.Tags.Category.Description);
                colors.Add(g.Tags.DefaultColor.Description);
                silouhettes.Add(g.Tags.Silouhette.Description);
                fabrics.Add(g.Tags.Fabric.Description);

                if (!string.IsNullOrEmpty(g.Tags.Silouhette.Keywords))
                    foreach (string keyword in g.Tags.Silouhette.Keywords.Split(','))
                        keywords.Add(keyword.Trim());

                foreach (EventType ev in g.Tags.EventTypes)
                    eventtypes.Add(ev.ShortName);

                foreach (Season s in g.Tags.Seasons)
                    seasons.Add(s.ToString());
            }

            see.CreatedByMe = closetOutfit.User != null;
            see.EditorRating = Convert.ToInt32(closetOutfit.Rating.EditorRating);
            see.FriendRating = Convert.ToInt32(Math.Round(closetOutfit.Rating.FriendRatingAverage));
            see.MyRating = Convert.ToInt32(closetOutfit.Rating.MyRating);
            see.FlavorId = closetOutfit.FashionFlavor.Id;

            if (closetOutfit.Detail != null)
            {
                // Mark as up to date, save last worndate and add all locations to the keywords.
                see.IsUpToDate = true;
                see.LastWornDate = closetOutfit.Detail.WornDate;
                foreach (OutfitDetails od in closetOutfit.Details)
                    keywords.Add(od.Location);
            }

            see.Categories = string.Join(" ", categories.ToArray());
            see.Silouhettes = string.Join(" ", silouhettes.ToArray());
            see.Colors = string.Join(" ", colors.ToArray());
            see.EventTypes = string.Join(" ", eventtypes.ToArray());
            see.Fabrics = string.Join(" ", fabrics.ToArray());
            see.Seasons = string.Join(" ", seasons.ToArray());
            see.Tags = string.Join(" ", keywords.ToArray());

            return see;
        }
    }
}