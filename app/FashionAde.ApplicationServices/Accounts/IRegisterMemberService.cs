using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Accounts;
using FashionAde.Core.Clothing;
using FashionAde.Core;

namespace FashionAde.ApplicationServices
{
    public interface IRegisterMemberService
    {
        bool RegisterMember(string email, string userName, string firstName, string lastName, string password,
           UserSize userSize, int membershipUserId, string zipCode,
           IList<UserFlavor> userFlavors, IList<EventType> eventTypes,
           IList<Garment> mygarments, IList<Garment> mywishlist,
           string validateUri, string channel, string invitationCode);
        void SendValidationCode(RegisteredUser user, string validateUri);
    }
}
