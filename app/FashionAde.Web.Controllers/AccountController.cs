using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Castle.Components.Validator;
using FashionAde.Core;
using FashionAde.Core.Accounts;
using FashionAde.Core.DataInterfaces;
using FashionAde.Web.Controllers.MVCInteraction;
using Google.Contacts;
using Google.GData.Client;
using Google.GData.Contacts;
using Google.GData.Extensions;
using ProjectBase.Utils.Email;

namespace FashionAde.Web.Controllers
{
    [HandleError]
    [Authorize]
    public class AccountController : Controller
    {
        private ISecurityQuestionRepository securityQuestionRepository;
        private IRegisteredUserRepository registeredUserRepository;
        private IUserSizeRepository userSizeRepository;

        public AccountController(ISecurityQuestionRepository securityQuestionRepository, IRegisteredUserRepository registeredUserRepository, IUserSizeRepository userSizeRepository)
        {
            this.securityQuestionRepository = securityQuestionRepository;
            this.registeredUserRepository = registeredUserRepository;
            this.userSizeRepository = userSizeRepository;
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ViewResult Index()
        {
            if (Request.QueryString["token"] != null)
                return View("FriendSelection", GetGmailContacts(1));

            UserFull userModification = new UserFull();
            userModification = GetAccountData(userModification);
            return View(userModification);
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ViewResult FriendSelection(int page)
        {
            if (Session["GMailToken"] != null)
                return View("FriendSelection", GetGmailContacts(page));
            return null;
        }

        public ViewResult AddFriends(FormCollection values)
        {
            List<int> selectedIndexs = new List<int>();
            List<Friend> selectedFriends = new List<Friend>();
            MembershipUser mu = Membership.GetUser();
            RegisteredUser user = registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
            foreach (var value in values)
            {
                object o = values[value.ToString()];
                if (o.ToString().Contains("true"))
                    selectedIndexs.Add(Convert.ToInt32(value.ToString().Split('_')[1]));
            }

            if (Session["GMailToken"] != null)
                selectedFriends = GetGmailContacts(selectedIndexs);

            user.AddFriends(selectedFriends);
            registeredUserRepository.SaveOrUpdate(user);

            return View("FriendSelection", selectedFriends);
        }
        #region Index Zone
        private UserFull GetAccountData(UserFull userModification)
        {
            MembershipUser mu = Membership.GetUser();
            List<SelectListItem> securityQuestionList = new List<SelectListItem>();
            List<SelectListItem> userSizeList = new List<SelectListItem>();
            List<SelectListItem> privacyList = new List<SelectListItem>();
            if (mu != null)
            {
                RegisteredUser ru = registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
                SecurityQuestion securityQuestion = securityQuestionRepository.GetByDescription(mu.PasswordQuestion);
                userModification = new UserFull(ru, securityQuestion.Id, userModification.Alert, userModification.Tab);

                IList<SecurityQuestion> questions = securityQuestionRepository.GetAll();
                foreach (SecurityQuestion question in questions)
                {
                    SelectListItem sl = new SelectListItem();
                    sl.Text = question.Description;
                    sl.Value = question.Id.ToString();
                    if (question.Description == securityQuestion.Description)
                        sl.Selected = true;
                    securityQuestionList.Add(sl);
                }

                IList<UserSize> userSizes = userSizeRepository.GetAll();
                foreach (UserSize userSize in userSizes)
                {
                    SelectListItem sli = new SelectListItem();
                    sli.Text = userSize.Description;
                    sli.Value = userSize.Id.ToString();
                    if (userSize.Id == ru.Size.Id)
                        sli.Selected = true;
                    userSizeList.Add(sli);
                }

                SelectListItem pvy = new SelectListItem();
                pvy.Text = "My Closet can be viewed by me only";
                pvy.Value = PrivacyLevel.Private.ToString();
                if (ru.Closet.PrivacyLevel == PrivacyLevel.Private)
                    pvy.Selected = true;
                privacyList.Add(pvy);
                pvy = new SelectListItem();
                pvy.Text = "My Closet can be viewed by me and my friends";
                pvy.Value = PrivacyLevel.Friends.ToString();
                if (ru.Closet.PrivacyLevel == PrivacyLevel.Friends)
                    pvy.Selected = true;
                privacyList.Add(pvy);
                pvy = new SelectListItem();
                pvy.Text = "Only my Signature Outfit can be viewed by anyone";
                pvy.Value = PrivacyLevel.FavoriteOutfit.ToString();
                if (ru.Closet.PrivacyLevel == PrivacyLevel.FavoriteOutfit)
                    pvy.Selected = true;
                privacyList.Add(pvy);
                pvy = new SelectListItem();
                pvy.Text = "My Entire Closet can be viewed by anyone";
                pvy.Value = PrivacyLevel.FullCloset.ToString();
                if (ru.Closet.PrivacyLevel == PrivacyLevel.FullCloset)
                    pvy.Selected = true;
                privacyList.Add(pvy);
            }

            ViewData["Errors"] = Session["Errors"];
            Session["Errors"] = null;
            ViewData["SecurityQuestions"] = securityQuestionList;
            ViewData["UserSizes"] = userSizeList;
            ViewData["PrivacyStatus"] = privacyList;
            if (mu != null)
                ViewData["UserName"] = mu.UserName;

            WindowsLive.WindowsLiveLogin temp = new WindowsLive.WindowsLiveLogin(true);
            ViewData["LiveID"] = temp.GetConsentUrl("Contacts.Invite", string.Empty, temp.ReturnUrl);

            return userModification;
        }

        public ViewResult ChangeInfo(UserFull userModification)
        {
            UserUpdate userUpdate = new UserUpdate(userModification);

            var errors = userUpdate.Validate();
            if (errors == null)
            {
                MembershipUser mu = Membership.GetUser();
                PublicUser ru = (PublicUser) registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
                userModification.Email = ru.EmailAddress;
                ru.FirstName = userModification.FirstName;
                ru.LastName = userModification.LastName;
                //ru.PhoneNumber = userModification.PhoneNumber;
                ru.PhoneNumber = string.Empty;
                ru.ChangeZipCode(userModification.ZipCode);
                ru.Size = userSizeRepository.Get(userModification.UserSize);

                if (userModification.PrivacyStatus == PrivacyLevel.Private.ToString())
                    ru.Closet.PrivacyLevel = PrivacyLevel.Private;
                if (userModification.PrivacyStatus == PrivacyLevel.Friends.ToString())
                    ru.Closet.PrivacyLevel = PrivacyLevel.Friends;
                if (userModification.PrivacyStatus == PrivacyLevel.FavoriteOutfit.ToString())
                    ru.Closet.PrivacyLevel = PrivacyLevel.FavoriteOutfit;
                if (userModification.PrivacyStatus == PrivacyLevel.FullCloset.ToString())
                    ru.Closet.PrivacyLevel = PrivacyLevel.FullCloset;
                
                registeredUserRepository.SaveOrUpdate(ru);
                userModification.Alert = "User information updated successfully";
            }
            
            if(errors != null)
                Session["Errors"] = errors.ErrorMessages;

            GetAccountData(userModification);
            return View("Index", userModification);
        }

        public ViewResult ChangeEmail(UserFull userModification)
        {
            UserEmail userEmail = new UserEmail(userModification);
            var errors = userEmail.Validate();
            if (errors == null)
            {
                if (registeredUserRepository.GetByMail(userModification.Email) == null)
                {
                    MembershipUser mu = Membership.GetUser();
                    PublicUser ru = (PublicUser) registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
                    mu.Email = userModification.Email;
                    ru.EmailAddress = userModification.Email;
                    registeredUserRepository.SaveOrUpdate(ru);
                    userModification.Alert = "User email updated successfully";
                }
                else
                {
                    errors = new ErrorSummary();
                    errors.RegisterErrorMessage("Email", "That email already exist in our database");
                    
                }
            }
            
            if(errors != null)
                Session["Errors"] = errors.ErrorMessages;

            userModification.Tab = 1;
            userModification = GetAccountData(userModification);
            return View("Index", userModification);
        }

        public ViewResult ChangePassword(UserFull userModification, string OldPassword, string NewPassword, string ConfirmPassword)
        {
            UserPassword userPassword = new UserPassword(OldPassword, NewPassword, ConfirmPassword);

            var errors = userPassword.Validate();
            if (errors == null)
            {
                if (OldPassword != NewPassword)
                {
                    MembershipUser mu = Membership.GetUser();
                    if (!mu.ChangePassword(userPassword.OldPassword, userPassword.NewPassword))
                    {
                        errors = new ErrorSummary();
                        errors.RegisterErrorMessage("OldPassword", "The password that you enter is invalid");
                    }
                    else
                        userModification.Alert = "User password changed successfully";
                }
                else
                {
                    errors = new ErrorSummary();
                    errors.RegisterErrorMessage("NewPassword", "The New Password is same as the Old Password");
                }
            }
            
            if(errors != null)
                Session["Errors"] = errors.ErrorMessages;

            userModification.Tab = 2;
            userModification = GetAccountData(userModification);
            return View("Index", userModification);
        }

        public ViewResult ChangeAnswer(UserFull userModification)
        {
            UserAnswer userAnswer = new UserAnswer(userModification);
            var errors = userAnswer.Validate();
            if (errors == null)
            {
                MembershipUser mu = Membership.GetUser();
                if (!mu.ChangePasswordQuestionAndAnswer(userAnswer.Password, securityQuestionRepository.Get(userModification.SecurityQuestion).Description, userAnswer.SecurityAnswer))
                {
                    errors = new ErrorSummary();
                    errors.RegisterErrorMessage("SecurityQuestion", "There was an error while we was updating your security answer, please check your password and try again.");
                    
                }
                else
                    userModification.Alert = "User security question and answer changed successfully";
            }

            if (errors != null)
                Session["Errors"] = errors.ErrorMessages;

            userModification.Tab = 3;
            userModification = GetAccountData(userModification);
            return View("Index", userModification);
        }
        #endregion
        private List<Friend> GetGmailContacts(int page)
        {
            return GetGmailContacts(page, null);
        }
        private List<Friend> GetGmailContacts(List<int> selectedIndexs)
        {
            return GetGmailContacts(0, selectedIndexs);
        }
        private List<Friend> GetGmailContacts(int page, List<int> selectedIndexs)
        {
            int pageSize = 10;
            List<Friend> friends = new List<Friend>();
            MembershipUser mu = Membership.GetUser();
            RegisteredUser user = registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
            
            if(Session["GMailToken"] == null)
            {
                String token = Request.QueryString["token"];
                Session["GMailToken"] = AuthSubUtil.exchangeForSessionToken(token, null).ToString();
            }
            
            GAuthSubRequestFactory authFactory = new GAuthSubRequestFactory("cp","testingFADE");
            RequestSettings rs = new RequestSettings("testingFADE", (String)Session["GMailToken"]);
            rs.AutoPaging = true;
            ContactsRequest cr = new ContactsRequest(rs);

            Feed<Contact> contacts = cr.GetContacts();
            int i = 1;
            if (page > 0)
            {
                foreach (Contact e in contacts.Entries)
                {
                    if (i < (page*pageSize) - 9)
                    {
                        i++;
                        continue;
                    }
                    if (i > (page*pageSize))
                        break;
                    if (e.PrimaryEmail == null)
                        continue;
                    Friend friend = new Friend();
                    friend.FirstName = e.Title;
                    friend.EmailAddress = e.PrimaryEmail.Address;
                    friend.InvitedBy = user;
                    friends.Add(friend);
                    i++;
                }
                ViewData["Pages"] = Common.Paging(contacts.TotalResults, page, pageSize, 10);
            }
            else if(selectedIndexs != null)
            {
                foreach (Contact e in contacts.Entries)
                {
                    if (!selectedIndexs.Exists(delegate(int record) { if (record == i) { return true; } return false; }))
                    {
                        i++;
                        continue;
                    }
                    Friend friend = new Friend();
                    friend.FirstName = e.Title;
                    friend.EmailAddress = e.PrimaryEmail.Address;
                    friend.InvitedBy = user;
                    friends.Add(friend);
                    i++;
                }
            }

            return friends;
        }

        [ObjectFilter(Param = "inviteFriends", RootType = typeof(InviteFriends))]
        public ActionResult InviteFriends(InviteFriends inviteFriends)
        {
            string[] emails = inviteFriends.FriendsEmails.Split(',');
            RegisteredUser user = GetUser();
                
            SmtpMailing mail = new SmtpMailing();
            foreach (string email in emails)
            {
                SendMail(user.FullName, mail, email, inviteFriends.SiteURL);
            }
            if (inviteFriends.SendMe)
                SendMail(user.FullName, mail, user.EmailAddress, inviteFriends.SiteURL);

            return Json(new { Success = true });
        }

        private void SendMail(string fullName, SmtpMailing mail, string email, string siteURL)
        {
            string subject = fullName + " want to invite you to build your closet";
            string body = "";

            body += "<br /><br />Join NOW <a href='" + siteURL + "/' style='color: #F38333;' >here</a>!";

            mail.SendMail(email, "Crate your own virtual closet", subject, body, false);
        }

        private RegisteredUser GetUser()
        {
            MembershipUser mu = Membership.GetUser();
            if (mu != null)
                ViewData["UserName"] = mu.UserName;

            return registeredUserRepository.GetByMembershipId(Convert.ToInt32(mu.ProviderUserKey));
        }
    }
}