using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Web.Security;
using ContactProvider;
using FashionAde.Core.Accounts;
using FashionAde.Core.DataInterfaces;
using FashionAde.Web.Common;
using FashionAde.Web.Controllers.MVCInteraction;
using SharpArch.Web.NHibernate;
using FashionAde.ApplicationServices;
using System.Configuration;

namespace FashionAde.Web.Controllers
{
    [Authorize]
    public class FriendController : BaseController
    {
        private IRegisteredUserRepository registeredUserRepository;
        private IFriendRepository friendRepository;
        private IInviteContactsService inviteContactsService;
        private IFriendCreatorService friendCreatorService;
        private FriendsData dataView = new FriendsData();

        public FriendController(IRegisteredUserRepository registeredUserRepository, 
            IFriendRepository friendRepository,
            IInviteContactsService inviteContactsService,
            IFriendCreatorService friendCreatorService)
        {
            this.registeredUserRepository = registeredUserRepository;
            this.friendRepository = friendRepository;
            this.inviteContactsService = inviteContactsService;
            this.friendCreatorService = friendCreatorService;
        }

        public ActionResult Index(int? status)
        {
            LoadFriendData(status);

            return View(dataView);
        }

        private void LoadFriendData(int? status)
        {
            if (status == null)
                status = 0;

            dataView.List = true;
            RegisteredUser ru = registeredUserRepository.Get(this.UserId);
            dataView.Friends = friendRepository.Search(this.ProxyLoggedUser, string.Empty, (FriendStatus)status, 0);
            dataView.NewFriendsRequest = ru.FriendsThatInvitedMe.Count;
            dataView.UserMail = Membership.GetUser().Email;
            dataView.NewFriend = new NewFriendView();

            ViewData["GMailAuthUrl"] = new GoogleProvider().GetAuthorizationURL();
            ViewData["LiveAuthUrl"] = new LiveProvider().GetAuthorizationURL();
            ViewData["YahooAuthUrl"] = "N/D";

            if(Session["NewFriendsAdded"] != null)
            {
                TempData["NewFriendsAdded"] = Session["NewFriendsAdded"];
                Session["NewFriendsAdded"] = null;
            }
        }

        public ActionResult FriendsRequest()
        {
            RegisteredUser ru = registeredUserRepository.Get(this.UserId);
            FriendsData fd = new FriendsData();
            fd.List = false;
            fd.Friends = ru.FriendsThatInvitedMe;

            ViewData["GMailAuthUrl"] = new GoogleProvider().GetAuthorizationURL();
            ViewData["LiveAuthUrl"] = new LiveProvider().GetAuthorizationURL();
            ViewData["YahooAuthUrl"] = "N/D";

            return View("Index", fd);
        }

        [Transaction]
        public ActionResult Accept(int friendId)
        {
            Friend f = friendRepository.Get(friendId);
            f.Status = FriendStatus.Confirmed;
            friendRepository.SaveOrUpdate(f);

            Friend inverseFriend = friendRepository.GetInverse(friendId);
            if (inverseFriend != null)
            {
                inverseFriend.Status = FriendStatus.Confirmed;
                friendRepository.SaveOrUpdate(inverseFriend);
            }

            return RedirectToAction("FriendsRequest");
        }

        [Transaction]
        public ActionResult Reject(int friendId)
        {
            Friend f = friendRepository.Get(friendId);
            f.Status = FriendStatus.Denied;
            friendRepository.SaveOrUpdate(f);

            Friend inverseFriend = friendRepository.GetInverse(friendId);
            if (inverseFriend != null)
            {
                inverseFriend.Status = FriendStatus.Denied;
                friendRepository.SaveOrUpdate(inverseFriend);
            }

            return RedirectToAction("FriendsRequest");
        }

        [Transaction]
        public ActionResult DeleteFriends(string selectedIndexs, string selectedAll)
        {
            string[] selected = selectedIndexs.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            bool all = selectedAll == "true";
            List<int> indexs = new List<int>();
            foreach (string index in selected)
                indexs.Add(Convert.ToInt32(index));

            RegisteredUser ru = registeredUserRepository.Get(UserId);
            if (!all)
                foreach (int i in indexs)
                {
                    Friend friend = friendRepository.Get(i);
                    ru.RemoveFriend(friend);
                }
            else
            {
                IList<Friend> tmp = friendRepository.Search(ru, string.Empty, FriendStatus.All, 0);
                foreach (Friend friend in tmp)
                    if (indexs.Exists(delegate(int record) { if (record == friend.Id) { return true; } return false; }))
                        ru.RemoveFriend(friend);
            }

            registeredUserRepository.SaveOrUpdate(ru);

            return RedirectToAction("Index");
        }

        [Transaction]
        public ActionResult DeleteFriend(int FriendId)
        {
            RegisteredUser ru = registeredUserRepository.Get(UserId);
            
            Friend friend = friendRepository.Get(FriendId);            
            ru.RemoveFriend(friend);
            registeredUserRepository.SaveOrUpdate(ru);

            return RedirectToAction("Index");
        }
        
        [Transaction]
        public ActionResult AddFriend(FriendsData friendData)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    inviteContactsService.InviteUser(this.ProxyLoggedUser, string.Empty, null, new UserContact() { EmailAddress = friendData.NewFriend.Email, FirstName = friendData.NewFriend.FirstName, LastName = friendData.NewFriend.LastName }, Convert.ToBoolean(ConfigurationManager.AppSettings["IsInBeta"]));
                    TempData["NewFriendsAdded"] = true;
                    return RedirectToAction("Index");
                }
                catch (LimitOfFriendsExceededException ex)
                {
                    ModelState.AddModelError("NewFriend.Email", ex.Message);
                }
            }

            LoadFriendData(null);
            dataView.NewFriend = friendData.NewFriend;
            return View("Index", dataView);
        }
    }
}
