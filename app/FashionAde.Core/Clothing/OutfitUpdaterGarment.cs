using System.Collections.Specialized;
using FashionAde.Core.ThirdParties;

namespace FashionAde.Core.Clothing
{
    public class OutfitUpdaterGarment : Garment
    {
        private decimal price;
        private string buyLink;
        //private NameValueCollection properties;
        private string productLink;
        private Partner thirdParty;
        private string suffix;

        public virtual decimal Price
        {
            get { return price; }
            set { price = value; }
        }

        public virtual string BuyLink
        {
            get { return buyLink; }
            set { buyLink = value; }
        }

        //public NameValueCollection Properties
        //{
        //    get { return properties; }
        //    set { properties = value; }
        //}

        public virtual string ProductLink
        {
            get { return productLink; }
            set { productLink = value; }
        }

        public virtual Partner ThirdParty
        {
            get { return thirdParty; }
            set { thirdParty = value; }
        }

        public virtual string Suffix
        {
            get { return suffix; }
            set { suffix = value; }
        }
    }
}