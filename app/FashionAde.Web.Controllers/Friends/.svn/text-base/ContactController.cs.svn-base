using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Web.Security;
using ContactProvider;
using ContactProvider.Classes;
using FashionAde.Core.Accounts;
using FashionAde.Core.DataInterfaces;
using SharpArch.Web.NHibernate;
using FashionAde.Web.Common;
using FashionAde.ApplicationServices;
using FashionAde.Web.Controllers.MVCInteraction;

namespace FashionAde.Web.Controllers
{
    [Authorize]
    public class ContactController : BaseController
    {
        private IInviteContactsService inviteContactsService;
        private IContactProvider contactProvider;
        private IFriendProviderRepository friendProviderRepository;
        private IFriendRepository friendRepository;
        private ContactView viewData = new ContactView();

        public ContactController(IFriendProviderRepository friendProviderRepository, 
            IInviteContactsService inviteContactsService,
            IFriendRepository friendRespository)
        {
            this.friendProviderRepository = friendProviderRepository;
            this.inviteContactsService = inviteContactsService;
            this.friendRepository = friendRespository;
        }

        public void LoadViewData(string providerCode)
        {
            contactProvider = ProviderFactory.GetProvider(providerCode);
            int totalCount = 0;

            // Find all friends
            IDictionary<string, object> propertyValues = new Dictionary<string, object>();
            propertyValues.Add("BasicUser", this.ProxyLoggedUser);
            IList<Friend> currentFriends = friendRepository.FindAll(propertyValues);

            IList<IContact> finalContacts = null;
            if (Session["Contacts_" + providerCode] == null)
            {
                IList<IContact> contacts = contactProvider.GetContacts(0, 0, out totalCount);

                // Make sure the user is not a friend already
                finalContacts = (from c in contacts
                                 where !(from f in currentFriends select f.User.EmailAddress).Contains(c.Email.ToLower())
                                 select c).ToList<IContact>();

                Session["Contacts_" + providerCode] = finalContacts;
            }
            else
            {
                finalContacts = (IList<IContact>)Session["Contacts_" + providerCode];
                totalCount = finalContacts.Count;
            }
            propertyValues = new Dictionary<string, object>();
            propertyValues.Add("BasicUser", this.ProxyLoggedUser);

            viewData.Contacts = finalContacts;
            viewData.Provider = providerCode;
            viewData.TotalCount = totalCount;

            FriendProvider friendProvider = friendProviderRepository.GetByName(contactProvider.Name);
            viewData.ProviderImg = friendProvider.ImageUri;
            viewData.ProviderName = friendProvider.Name;
        }

        [HttpGet]
        public ViewResult Index()
        {
            if (string.IsNullOrEmpty(Request.QueryString["api"]))
                RedirectToAction("Index", "Home");

            LoadViewData(Request.QueryString["api"]);

            return View(viewData);
        }

        [Transaction]
        [HttpPost]
        public ActionResult Index(ContactView contactData)
        {
            if (ModelState.IsValid)
            {
                this.viewData = contactData;
                contactProvider = ProviderFactory.GetProvider(contactData.Provider);

                bool all = contactData.SelectedAll;
                List<int> indexs = new List<int>();
                
                if (!string.IsNullOrEmpty(contactData.SelectedIndexes))
                {
                    string[] selected = contactData.SelectedIndexes.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                    foreach (string index in selected)
                        indexs.Add(Convert.ToInt32(index));
                }

                if (!all && indexs.Count == 0)
                    ModelState.AddModelError("Comments", "Please select at least one contact to invite.");
                else
                {
                    IList<IContact> selectedContacts = new List<IContact>();
                    if (Session["Contacts_" + contactData.Provider] != null)
                        selectedContacts = GetContacts((IList<IContact>)Session["Contacts_" + contactData.Provider], new ContactProvider.Selection(all, indexs));
                    else
                        selectedContacts = contactProvider.GetContacts(new ContactProvider.Selection(all, indexs));

                    FriendProvider fp = friendProviderRepository.GetByName(contactProvider.Name);

                    try
                    {
                        inviteContactsService.InviteUsers(this.ProxyLoggedUser, contactData.Comments, fp, TransformContacts(selectedContacts), Convert.ToBoolean(ConfigurationManager.AppSettings["IsInBeta"]));
                        Session.Remove("Contacts_" + contactData.Provider);
                        Session["NewFriendsAdded"] = true;
                        return RedirectToAction("Index", "Friend");
                    }
                    catch (LimitOfFriendsExceededException ex)
                    {
                        ModelState.AddModelError("Comments", ex.Message);
                    }
                }
            }

            LoadViewData(contactData.Provider);

            return View("Index", viewData);
        }

        private IList<IContact> GetContacts(IList<IContact> allContacts, ContactProvider.Selection selection)
        {
            IList<IContact> result = new List<IContact>();

            foreach (IContact e in allContacts)
            {
                if (!selection.SelectedAll && !selection.SelectedIndexs.Exists(delegate(int record) { if (record == e.Index) { return true; } return false; }))
                {
                    continue;
                }
                if (selection.SelectedAll && selection.SelectedIndexs.Exists(delegate(int record) { if (record == e.Index) { return true; } return false; }))
                {
                    continue;
                }
                
                result.Add(e);
            }
        
            return result;
        }

        private IList<IBasicUser> TransformContacts(IList<IContact> contacts)
        {
            List<IBasicUser> lst = new List<IBasicUser>(contacts.Count);
            foreach (IContact c in contacts)
                lst.Add(new UserContact() { FirstName = c.FirstName, LastName = c.LastName, EmailAddress = c.Email });
            return lst;
        }
    }
}
