using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.OutfitEngine;

namespace FashionAde.Core.OutfitCombination.Review
{
    public class OutfitReview
    {
        private PreCombination preCombinationToReview;
        private ReasonForRevision reason;

        public PreCombination PreCombinationToReview
        {
            get { return preCombinationToReview; }
            set { preCombinationToReview = value; }
        }
        public ReasonForRevision Reason
        {
            get { return reason; }
            set { reason = value; }
        }
    }

    public enum ReasonForRevision
    {
        EditorRating,
        LowFriendRating,
        LowUserRating,
        TwiceLowRating
    }
}
