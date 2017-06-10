using FashionAde.Core.Accounts;
using FashionAde.Core.OutfitEngine;

namespace FashionAde.Core.OutfitCombination
{
    public class UserOutfit : ClosetOutfit
    {
        private RegisteredUser user;

        public virtual RegisteredUser User
        {
            get { return user; }
            set { user = value; }
        }
    }
}