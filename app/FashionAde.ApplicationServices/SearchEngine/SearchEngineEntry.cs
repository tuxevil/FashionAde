using System;
using System.Collections.Generic;

namespace FashionAde.ApplicationServices.SearchEngine
{
    public class SearchEngineEntry
    {
        public int EntryId { get; set; }
        public string Categories { get; set; }
        public string Silouhettes { get; set; }
        public string Colors { get; set; }
        public string Fabrics { get; set; }
        public string Seasons { get; set; }
        public string EventTypes { get; set; }
        public string Tags { get; set; }
        public int FlavorId { get; set; }
        public bool CreatedByMe { get; set; }
        public int MyRating { get; set; }
        public int FriendRating { get; set; }
        public int EditorRating { get; set; }
        public DateTime? LastWornDate { get; set;}
        public bool IsUpToDate { get; set; }
    }
}