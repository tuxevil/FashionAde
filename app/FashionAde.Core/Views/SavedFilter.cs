using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SharpArch.Core.DomainModel;

namespace FashionAde.Core.Views
{
    [Serializable]
    public class SavedFilter : Entity
    {
        private string search;
        private string garment;
        private string trend;
        private string color;
        private string pattern;
        private string seasonName;
        private bool createdByMe;
        private bool isRatedByMe;
        private bool isRatedByFriends;
        private string selectedEvents;
        private string selectedFlavors;
        private string name;
        private int userId;
        private bool myFavorites;
        private bool isUpToDate;

        public virtual string Search
        {
            get { return search; }
            set { search = value; }
        }

        public virtual string Garment
        {
            get { return garment; }
            set { garment = value; }
        }

        public virtual string Trend
        {
            get { return trend; }
            set { trend = value; }
        }

        public virtual string Color
        {
            get { return color; }
            set { color = value; }
        }

        public virtual string Pattern
        {
            get { return pattern; }
            set { pattern = value; }
        }

        public virtual string SeasonName
        {
            get { return seasonName; }
            set { seasonName = value; }
        }

        public virtual bool CreatedByMe
        {
            get { return createdByMe; }
            set { createdByMe = value; }
        }

        public virtual bool IsRatedByMe
        {
            get { return isRatedByMe; }
            set { isRatedByMe = value; }
        }

        public virtual bool IsRatedByFriends
        {
            get { return isRatedByFriends; }
            set { isRatedByFriends = value; }
        }

        public virtual string SelectedEvents
        {
            get { return selectedEvents; }
            set { selectedEvents = value; }
        }

        public virtual string SelectedFlavors
        {
            get { return selectedFlavors; }
            set { selectedFlavors = value; }
        }

        public virtual string Name
        {
            get { return name; }
            set { name = value; }
        }

        public virtual int UserId
        {
            get { return userId; }
            set { userId = value; }
        }

        public virtual bool MyFavorites
        {
            get { return myFavorites; }
            set { myFavorites = value; }
        }

        public virtual bool IsUpToDate
        {
            get { return isUpToDate; }
            set { isUpToDate = value; }
        }
    }

    [Serializable]
    public class MVCSavedFilter
    {
        public SavedFilter SavedFilter { get; set; }
        public bool Selected { get; set; }

        public MVCSavedFilter(SavedFilter savedFilter)
        {
            this.SavedFilter = savedFilter;
            this.Selected = false;
        }
        public MVCSavedFilter(SavedFilter savedFilter, bool selected)
        {
            this.SavedFilter = savedFilter;
            this.Selected = selected;
        }
    }
}
