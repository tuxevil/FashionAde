using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web.Security;
using FashionAde.Core.Accounts;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core;
using FashionAde.Core.Clothing;

namespace FashionAde.ApplicationServices
{
    public class RegisterMemberService : IRegisterMemberService
    {
        private IBasicUserRepository basicUserRepository;
        private IRegisteredUserRepository registeredUserRepository;
        private IWishListRepository wishListRepository;
        private IClosetRepository closetRepository;
        private IMessageSenderService messageSenderService;
        private IInvitationCodeRepository invitationCodeRepository;
        private IFriendRepository friendRepository;
        private IInvitationValidatorService invitationValidatorService;

        public RegisterMemberService(IBasicUserRepository basicUserRepository, IWishListRepository wishListRepository, IClosetRepository closetRepository, IUserSizeRepository userSizeRepository, ISecurityQuestionRepository securityQuestionRepository, IMessageSenderService messageSenderService, IInvitationCodeRepository invitationCodeRepository, 
            IFriendRepository friendRepository, IInvitationValidatorService invitationValidatorService, IRegisteredUserRepository registeredUserRepository)
        {
            this.basicUserRepository = basicUserRepository;
            this.wishListRepository = wishListRepository;
            this.closetRepository = closetRepository;
            this.messageSenderService = messageSenderService;
            this.invitationCodeRepository = invitationCodeRepository;
            this.friendRepository = friendRepository;
            this.invitationValidatorService = invitationValidatorService;
            this.registeredUserRepository = registeredUserRepository;
        }

        public bool RegisterMember(string email, string userName, string firstName, string lastName, string password, 
            UserSize userSize, int membershipUserId, string zipCode,
            IList<UserFlavor> userFlavors, IList<EventType> eventTypes,
            IList<Garment> mygarments, IList<Garment> mywishlist,
            string validateUri, string channel,
            string invitationCode)
        {
            bool mustConfirmMail = true;
            try
            {
                IDictionary<string, object> propertyValues;
                bool invited = false;

                email = email.ToLower().Trim();
                userName = userName.ToLower().Trim();

                basicUserRepository.DbContext.BeginTransaction();

                if (!string.IsNullOrEmpty(invitationCode))
                {
                    propertyValues = new Dictionary<string, object>();
                    propertyValues.Add("Code", invitationCode);
                    InvitationCode ic = invitationCodeRepository.FindOne(propertyValues);

                    if (!invitationValidatorService.IsValidCode(ic))
                        throw new InvalidInvitationCodeException();

                    mustConfirmMail = string.IsNullOrEmpty(ic.EmailAddress);
                    ic.MarkUsed();
                    invitationCodeRepository.SaveOrUpdate(ic);
                }

                RegisteredUser user = new RegisteredUser();
                user.UserName = userName;
                user.FirstName = firstName;
                user.LastName = lastName;
                user.EmailAddress = email.ToLower().Trim();
                user.Size = userSize;
                user.PhoneNumber = string.Empty;
                user.MembershipUserId = membershipUserId;
                user.RegistrationCode = Guid.NewGuid().ToString();  // Used for email verification purposes.
                user.ChangeZipCode(zipCode);
                user.SetFlavors(userFlavors);
                user.Channel = channel;

                if (eventTypes != null)
                    foreach (EventType eventType in eventTypes)
                        user.AddEventType(eventType);

                // Create Closet
                Closet closet = new Closet();
                closet.User = user;
                closet.PrivacyLevel = PrivacyLevel.Private;
                closet.MarkAsProcessed();

                if (mygarments != null)
                {
                    foreach (Garment garment in mygarments)
                        closet.AddGarment(garment);
                }
                user.Closet = closet;

                // Check if the user does not exist with that mail
                propertyValues = new Dictionary<string, object>();
                propertyValues.Add("EmailAddress", email);
                BasicUser bu = basicUserRepository.FindOne(propertyValues);

                // HACK: We need to change the mail of the invited user to be able to add the new registered user.
                if (bu != null && bu is InvitedUser)
                {
                    InvitedUser iu = bu as InvitedUser;
                    iu.EmailAddressReplaced = iu.EmailAddress;
                    iu.EmailAddress += new Random().Next().ToString();

                    basicUserRepository.SaveOrUpdate(iu);
                    basicUserRepository.DbContext.CommitTransaction();

                    basicUserRepository.DbContext.BeginTransaction();
                    closetRepository.SaveOrUpdate(closet);
                    basicUserRepository.SaveOrUpdate(user);

                    propertyValues = new Dictionary<string, object>();
                    propertyValues.Add("User", bu);
                    IList<Friend> lst = friendRepository.FindAll(propertyValues);
                    if (lst.Count > 0)
                    {
                        foreach (Friend f in lst)
                        {
                            Friend newFriend = new Friend();
                            newFriend.BasicUser = user;
                            newFriend.User = f.BasicUser;
                            newFriend.Status = FriendStatus.Pending;
                            friendRepository.SaveOrUpdate(newFriend);
                        }
                    }

                    invited = true;
                }
                else
                {
                    closetRepository.SaveOrUpdate(closet);
                    basicUserRepository.SaveOrUpdate(user);
                }

                // Create wishlist even if no items been selected for further use.
                WishList wl = new WishList();
                wl.User = user;

                // Save Wish List
                if (mywishlist != null && mywishlist.Count > 0)
                {
                    foreach (Garment wishlist in mywishlist)
                        wl.AddGarment(wishlist);
                }
                wishListRepository.SaveOrUpdate(wl);

                // Send Email Confirmation Mail
                if(mustConfirmMail)
                    SendValidationCode(user, validateUri);

                // Commit Transaction
                basicUserRepository.DbContext.CommitTransaction();

                new FashionAde.Utils.OutfitEngineService.OutfitEngineServiceClient().CreateOutfits(closet.Id);

                if (invited)
                    basicUserRepository.MigrateInvited(bu as InvitedUser, user);

            }
            catch
            {
                try { basicUserRepository.DbContext.RollbackTransaction(); }
                catch { }

                throw;
            }

            return mustConfirmMail;
        }

        public void SendValidationCode(RegisteredUser user, string validateUri)
        {
            string confirmUrl = string.Format("{0}?userid={1}&code={2}", validateUri, user.MembershipUserId, user.RegistrationCode);

            RegisterData rd = new RegisterData();
            rd.ConfimationCode = user.RegistrationCode;
            rd.ConfirmUrl = confirmUrl;
            rd.UserName = user.UserName;

            messageSenderService.SendWithTemplate("confirmemail", user, rd, user.EmailAddress);
            messageSenderService.SendWithTemplate("aweberemail", user, user, ConfigurationManager.AppSettings["Mailing_Admin"]);
        }
    }

    public class InvalidInvitationCodeException : Exception { }
}
