using System.Collections.Specialized;
using FashionAde.Core.ThirdParties;
using SharpArch.Core.DomainModel;

namespace FashionAde.Core.Clothing
{
    public class ThirdPartyGarment : Entity, IGarmentExtender
    {
        private Garment garment;
        private Partner thirdParty;
        private string imageUri;
        private string linkUri;
        private string thirdPartyCode;

        public virtual Garment Garment
        {
            get { return garment; }
            set { garment = value; }
        }

        public virtual Partner ThirdParty
        {
            get { return thirdParty; }
            set { thirdParty = value; }
        }

        public virtual string ImageUri
        {
            get { return imageUri; }
            set { imageUri = value; }
        }

        public virtual string LinkUri
        {
            get { return linkUri; }
            set { linkUri = value; }
        }

        public virtual string ThirdPartyCode
        {
            get { return thirdPartyCode; }
            set { thirdPartyCode = value; }
        }
    }
}