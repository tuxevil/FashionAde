using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.OutfitCombination;
using FashionAde.Core.OutfitEngine;
using SharpArch.Core.DomainModel;

namespace FashionAde.Core.MVCInteraction
{
    public class ClosetOutfitView : Entity
    {
        private ClosetOutfit closetOutfit;
        private decimal averageFriendRating;
        private decimal averageUserRating;
        private decimal averageWearRating;
        private decimal editorRating;
        private DateTime wornDate;
        private string location;
        private List<ClosetOutfitGarmentView> _outfitGarments = new List<ClosetOutfitGarmentView>();
        private int seasons;
        private int userId;
        private int myRating;
        private PreCombination preCombination;
        private bool disabled;


        public virtual decimal AverageFriendRating
        {
            get { return averageFriendRating; }
            set { averageFriendRating = value; }
        }

        public virtual decimal AverageUserRating
        {
            get { return averageUserRating; }
            set { averageUserRating = value; }
        }

        public virtual decimal AverageWearRating
        {
            get { return averageWearRating; }
            set { averageWearRating = value; }
        }

        public virtual decimal EditorRating
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

        public virtual int Seasons
        {
            get { return seasons; }
            set { seasons = value; }
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

        public virtual int UserId
        {
            get { return userId; }
            set { userId = value; }
        }

        public virtual int MyRating
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
    }
}
