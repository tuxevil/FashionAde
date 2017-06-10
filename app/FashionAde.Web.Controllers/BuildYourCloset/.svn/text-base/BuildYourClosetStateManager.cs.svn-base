using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Accounts;
using FashionAde.Core;
using System.Web;
using System.Web.Mvc;
using FashionAde.Web.Common;
using FashionAde.Web.Controllers.MVCInteraction;

namespace FashionAde.Web.Controllers
{
    /// <summary>
    /// Maintains the state on the Build Your Closet wizard
    /// </summary>
    public class BuildYourClosetState
    {
        /// <summary>
        /// Create the object from the datastore (cookies or session)
        /// </summary>
        public BuildYourClosetState() 
        {
            this.InvitationCode = GetData<string>("InvitationCode");

            if (GetData<int[]>("Flavors") != null)
                this.Flavors = (from f in GetData<int[]>("Flavors") select new FashionFlavor(f)).ToList<FashionFlavor>();
            
            if (GetData<UserFlavorView[]>("UserFlavors") != null)
                this.UserFlavors = (from cuf in GetData<UserFlavorView[]>("UserFlavors") select new UserFlavor { Flavor = new FashionFlavor(cuf.Id), Weight = cuf.Weight }).ToList<UserFlavor>();

            if (GetData<int[]>("EventTypes") != null)
                this.EventTypes = (from e in GetData<int[]>("EventTypes") select new EventType(e) ).ToList<EventType>();

            this.Channel = GetData<string>("Channel");
            this.AddGarments = GetData<List<int>>("AddGarments");
            this.WishGarments = GetData<List<int>>("WishGarments");
            this.UserRegistration = GetData<UserRegistrationSerializable>("UserRegistration");
        }

        #region Properties

        public string InvitationCode { get; protected set; }
        public IList<FashionFlavor> Flavors { get; protected set; }
        public IList<UserFlavor> UserFlavors { get; protected set; }
        public IList<EventType> EventTypes { get; protected set; }
        public IList<int> AddGarments { get; protected set; }
        public IList<int> WishGarments { get; protected set; }
        public string Channel { get; protected set; }
        public UserRegistrationSerializable UserRegistration { get; protected set; }

        #endregion

        #region Load or Save the Data

        private T GetData<T>(string key)
        {
            if (CookieManager.Has(key))
                return (T)CookieManager.Get(key);

            return default(T);
        }

        private void SaveData(string key, object value)
        {
            if (CookieManager.IsEnabled())
                CookieManager.Set(key, value);
        }

        #endregion

        #region Set methods

        /// <summary>
        /// Clear all data from Session or Cookies.
        /// </summary>
        public void Clear()
        {
            DeleteData("InvitationCode");
            DeleteData("Flavors");
            DeleteData("UserFlavors");
            DeleteData("EventTypes");
            DeleteData("AddGarments");
            DeleteData("WishGarments");
            DeleteData("Channel");
        }

        public void ClearGarments()
        {
            DeleteData("AddGarments");
            DeleteData("WishGarments");
        }

        private void DeleteData(string key)
        {
            CookieManager.Delete(key);
            HttpContext.Current.Session.Remove(key);
        }

        /// <summary>
        /// Saves a valid Invitation Code
        /// </summary>
        /// <param name="invitationCode"></param>
        public void SetInvitationCode(string invitationCode)
        {
            SaveData("InvitationCode", invitationCode.Trim());
        }

        /// <summary>
        /// Assign new flavors
        /// </summary>
        public void SetFlavors(IList<FashionFlavor> flavors)
        {
            SaveData("Flavors", (from f in flavors select f.Id).ToArray());
            this.Flavors = flavors;
        }

        /// <summary>
        /// Assign new User Flavors
        /// </summary>
        public void SetUserFlavors(IList<UserFlavor> userFlavors)
        {
            SaveData("UserFlavors", (from f in userFlavors select new UserFlavorView { Id = f.Flavor.Id, Weight = f.Weight }).ToArray<UserFlavorView>());
            this.UserFlavors = userFlavors;
        }

        /// <summary>
        /// Assign new Event Types
        /// </summary>
        public void SetEventTypes(IList<EventType> eventTypes)
        {
            SaveData("EventTypes", (from e in eventTypes select e.Id).ToArray());
            this.EventTypes = eventTypes;
        }

        /// <summary>
        /// Assign garments selected
        /// </summary>
        public void SetAddGarments(IList<int> garments)
        {
            SaveData("AddGarments", garments);
            this.AddGarments = garments;
        }

        /// <summary>
        /// Assign the wished garments
        /// </summary>
        /// <param name="wishGarments"></param>
        public void SetWishGarments(IList<int> wishGarments)
        {
            SaveData("WishGarments", wishGarments);
            this.WishGarments = wishGarments;
        }

        /// <summary>
        /// Assign the channel for wich the user enter the website
        /// </summary>
        /// <param name="channel"></param>
        public void SetChannel(string channel)
        {
            SaveData("Channel", channel);
            this.Channel = channel;
        }

        public void SetUserRegistration(UserRegistrationSerializable userRegistration)
        {
            SaveData("UserRegistration", userRegistration);
            this.UserRegistration = userRegistration;
        }

        #endregion
    }

    #region Helper Classes

    /// <summary>
    /// Helper class to save less data on cookie or session
    /// </summary>
    [Serializable]
    public class UserFlavorView 
    {
        public int Id {get;set;}
        public decimal Weight {get;set;}
    }

    #endregion
}


