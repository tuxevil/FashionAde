using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using FashionAde.Core.Clothing;
using FashionAde.Core.Views;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public class OutfitSearch
    {
        private bool showAsPublicCloset;
        private string sortBy;
        private string search;
        private string page;
        private string season;
        private string pageSize;
        private List<Pattern> patterns;
        private List<Color> colors;
        private List<SelectListItem> categories;
        private List<SelectListItem> trends;
        private List<SelectListItem> eventTypes;
        private List<SelectListItem> flavors;
        private string username;
        private bool _public;
        private string garment;
        private string trend;
        private string color;
        private string pattern;
        private string seasonName;
        private bool createdByMe;
        private bool isRatedByMe;
        private bool isRatedByFriends;
        private bool myFavorites;
        private bool isUpToDate;
        private string selectedEvents;
        private string selectedFlavors;
        private string name;
        private List<SavedFilter> savedFilters;
        
        public string SortBy
        {
            get { return sortBy; }
            set { sortBy = value; }
        }

        public string Search
        {
            get { return search; }
            set { search = value; }
        }

        public string Page
        {
            get { return page; }
            set { page = value; }
        }

        public string Season
        {
            get { return season; }
            set { season = value; }
        }

        public bool ShowAsPublicCloset
        {
            get { return showAsPublicCloset; }
            set { showAsPublicCloset = value; }
        }

        public List<Pattern> Patterns
        {
            get { return patterns; }
            set { patterns = value; }
        }

        public List<SelectListItem> Categories
        {
            get { return categories; }
            set { categories = value; }
        }

        public List<SelectListItem> Trends
        {
            get { return trends; }
            set { trends = value; }
        }

        public List<Color> Colors
        {
            get { return colors; }
            set { colors = value; }
        }

        public string Username
        {
            get { return username; }
            set { username = value; }
        }

        public bool Public
        {
            get { return _public; }
            set { _public = value; }
        }

        public string PageSize
        {
            get { return pageSize; }
            set { pageSize = value; }
        }

        public string Garment
        {
            get { return garment; }
            set { garment = value; }
        }

        public string Trend
        {
            get { return trend; }
            set { trend = value; }
        }

        public string Color
        {
            get { return color; }
            set { color = value; }
        }

        public string Pattern
        {
            get { return pattern; }
            set { pattern = value; }
        }

        public string SeasonName
        {
            get { return seasonName; }
            set { seasonName = value; }
        }

        public List<SelectListItem> EventTypes
        {
            get { return eventTypes; }
            set { eventTypes = value; }
        }

        public List<SelectListItem> Flavors
        {
            get { return flavors; }
            set { flavors = value; }
        }

        public bool CreatedByMe
        {
            get { return createdByMe; }
            set { createdByMe = value; }
        }

        public bool IsRatedByMe
        {
            get { return isRatedByMe; }
            set { isRatedByMe = value; }
        }

        public bool IsRatedByFriends
        {
            get { return isRatedByFriends; }
            set { isRatedByFriends = value; }
        }

        public string SelectedEvents
        {
            get { return selectedEvents; }
            set { selectedEvents = value; }
        }

        public string SelectedFlavors
        {
            get { return selectedFlavors; }
            set { selectedFlavors = value; }
        }

        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        public List<SavedFilter> SavedFilters
        {
            get { return savedFilters; }
            set { savedFilters = value; }
        }

        public bool MyFavorites
        {
            get { return myFavorites; }
            set { myFavorites = value; }
        }

        public bool IsUpToDate
        {
            get { return isUpToDate; }
            set { isUpToDate = value; }
        }
    }
}
