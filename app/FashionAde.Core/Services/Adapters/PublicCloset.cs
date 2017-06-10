namespace FashionAde.Core.Services
{
    public class PublicCloset
    {
        private string userName;
        private FashionFlavor flavor;
        private string zipCode;
        private ClosetOutfit favouriteOutfit;
        private ClosetStatus status;

        public string UserName
        {
            get { return userName; }
            set { userName = value; }
        }

        public FashionFlavor Flavor
        {
            get { return flavor; }
            set { flavor = value; }
        }

        public string ZipCode
        {
            get { return zipCode; }
            set { zipCode = value; }
        }

        public ClosetOutfit FavouriteOutfit
        {
            get { return favouriteOutfit; }
            set { favouriteOutfit = value; }
        }

        public ClosetStatus Status
        {
            get { return status; }
            set { status = value; }
        }
    }
}