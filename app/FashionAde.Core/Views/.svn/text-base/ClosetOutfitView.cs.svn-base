using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.OutfitCombination;
using FashionAde.Core.OutfitEngine;
using FashionAde.Core.ThirdParties;
using SharpArch.Core.DomainModel;

namespace FashionAde.Core.Views
{
    public class ClosetOutfitView
    {
        private ClosetOutfit closetOutfit;
        private float averageFriendRating;
        private float averageUserRating;
        private float averageWearRating;
        private float editorRating;
        private DateTime wornDate;
        private string location;
        private float myRating;
        private PreCombination preCombination;
        private bool disabled;        
        private bool showAddToMyCloset;
        private List<ClosetOutfitGarmentView> _outfitGarments = new List<ClosetOutfitGarmentView>();
        private OutfitUpdater outfitUpdater;
        private int eventTypes;
        private string shortEventTypes;
        private bool sendToFriends = true;

        public virtual int Id { get; set; }

        public virtual float AverageFriendRating
        {
            get { return averageFriendRating; }
            set { averageFriendRating = value; }
        }

        public virtual float AverageUserRating
        {
            get { return averageUserRating; }
            set { averageUserRating = value; }
        }

        public virtual float AverageWearRating
        {
            get { return averageWearRating; }
            set { averageWearRating = value; }
        }

        public virtual float EditorRating
        {
            get { return editorRating; }
            set { editorRating = value; }
        }

        public virtual DateTime WornDate
        {
            get { return wornDate; }
            set { wornDate = value; }
        }

        public virtual string Location
        {
            get { return location; }
            set { location = value; }
        }

        public virtual List<ClosetOutfitGarmentView> OutfitGarments
        {
            get { return _outfitGarments; }
            set { _outfitGarments = value; }
        }

        public virtual int ClosetOutfitId
        {
            get { return closetOutfit.Id; }
        }

        public virtual ClosetOutfit ClosetOutfit
        {
            get { return closetOutfit; }
            set { closetOutfit = value; }
        }

        public virtual float MyRating
        {
            get { return myRating; }
            set { myRating = value; }
        }

        public virtual PreCombination PreCombination
        {
            get { return preCombination; }
            set { preCombination = value; }
        }

        public virtual bool Disabled
        {
            get { return disabled; }
            set { disabled = value; }
        }

        public virtual bool ShowAddToMyCloset
        {
            get { return showAddToMyCloset; }
            set { showAddToMyCloset = value; }
        }

        public virtual OutfitUpdater OutfitUpdater
        {
            get { return outfitUpdater; }
            set { outfitUpdater = value; }
        }

        public virtual string ShortEventTypes
        {
            get { return shortEventTypes; }
            set { shortEventTypes = value; }
        }

        public virtual int EventTypes
        {
            get { return eventTypes; }
            set { eventTypes = value; }
        }

        public virtual bool SendToFriends
        {
            get { return sendToFriends; }
            set { sendToFriends = value; }
        }

        public ClosetOutfitView(int closetOutfit, float averageFriendRating, float averageUserRating, float averageWearRating, float editorRating, DateTime wornDate, string location, float myRating, int preCombination, int eventTypes)
        {
            this.Id = closetOutfit;
            this.closetOutfit = new ClosetOutfit(closetOutfit);
            this.averageFriendRating = averageFriendRating;
            this.averageWearRating = averageWearRating;
            this.averageUserRating = averageUserRating;
            this.editorRating = editorRating;
            this.wornDate = wornDate;
            this.location = location;
            this.myRating = myRating;
            this.preCombination = new PreCombination(preCombination);
            this.eventTypes = eventTypes;
        }
    }

    [Serializable]
    public class ClosetOutfitViewLight
    {
        private int closetOutfitId;
        private int averageFriendRating;
        private int editorRating;
        private string wornDate;
        private string location;
        private int myRating;
        private List<ClosetOutfitGarmentView> _outfitGarments = new List<ClosetOutfitGarmentView>();
        private OutfitUpdaterLight outfitUpdater;
        private string shortEventTypes;

        public virtual int Id { get; set; }

        public virtual float AverageFriendRating
        {
            get { return averageFriendRating; }
        }

        public virtual float EditorRating
        {
            get { return editorRating; }
        }

        public virtual string WornDate
        {
            get { return wornDate; }
        }

        public virtual string Location
        {
            get { return location; }
        }

        public virtual List<ClosetOutfitGarmentView> OutfitGarments
        {
            get { return _outfitGarments; }
        }

        public virtual int ClosetOutfitId
        {
            get { return closetOutfitId; }
        }

        public virtual float MyRating
        {
            get { return myRating; }
        }

        public virtual OutfitUpdaterLight OutfitUpdater
        {
            get { return outfitUpdater; }
        }

        public virtual string ShortEventTypes
        {
            get { return shortEventTypes; }
        }

        public ClosetOutfitViewLight(ClosetOutfitView closetOutfitView)
        {
            this.Id = closetOutfitView.Id;
            this.closetOutfitId = closetOutfitView.ClosetOutfitId;
            this.averageFriendRating = Convert.ToInt32(Math.Round(closetOutfitView.AverageFriendRating, 0));
            this.editorRating = Convert.ToInt32(Math.Round(closetOutfitView.EditorRating, 0));
            this.wornDate = "?";
            this.location = "?";
            if (closetOutfitView.WornDate > DateTime.MinValue)
                this.wornDate = closetOutfitView.WornDate.ToString("MM/dd/yyyy");
            if (!string.IsNullOrEmpty(closetOutfitView.Location))
                this.location = closetOutfitView.Location;
            this.myRating = Convert.ToInt32(Math.Round(closetOutfitView.MyRating, 0));
            this.outfitUpdater = new OutfitUpdaterLight(closetOutfitView.OutfitUpdater);
            this._outfitGarments = closetOutfitView.OutfitGarments;
            this.shortEventTypes = closetOutfitView.ShortEventTypes;
        }
    }
}
