using System.Collections.Generic;
using FashionAde.Core.Clothing;

namespace FashionAde.Core.Accounts
{
    public class TemporalUser : BasicUser
    {
        private IList<Garment> addedGarments = new List<Garment>();
        private IList<Garment> whishedGarments = new List<Garment>();
        private string referralTracking;

        public virtual IList<Garment> AddedGarments
        {
            get { return addedGarments; }
            set { addedGarments = value; }
        }

        public virtual IList<Garment> WhishedGarments
        {
            get { return whishedGarments; }
            set { whishedGarments = value; }
        }

        public virtual string ReferralTracking
        {
            get { return referralTracking; }
            set { referralTracking = value; }
        }
    }
}