using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using FashionAde.Core.Accounts;
using FashionAde.Data.Repository;

namespace FashionAde.Web.Controllers
{
    public class UserDataHelper
    {
        private const string USERDATA = "UserData";
        public static UserData Data
        {
            get
            {
                if (!HttpContext.Current.User.Identity.IsAuthenticated)
                    return null;

                if (HttpContext.Current.Session[USERDATA] == null)
                    LoadFromDatabase();

                return (UserData)HttpContext.Current.Session[USERDATA];
            }
        }

        public static void LoadFromDatabase(string userName)
        {
            int providerUserKey = 0;
            MembershipUser mu;

            // Given we are saving on Session if the Session expires we need to retrieve again from DB.
            if (userName != null)
                mu = Membership.GetUser(userName);
            else
                mu = Membership.GetUser();

            if (mu != null)
                providerUserKey = Convert.ToInt32(mu.ProviderUserKey);
            else
                HttpContext.Current.Response.Redirect("/");

            // Create the Registered User repository
            RegisteredUserRepository rup = new RegisteredUserRepository();
            RegisteredUser ru = rup.GetByMembershipId(providerUserKey);
            if (ru != null)
            {
                UserData ud = new UserData();
                ud.UserId = ru.Id;
                ud.ClosetId = ru.Closet.Id;
                ud.Channel = ru.Channel;

                string[] flavors = new string[ru.UserFlavors.Count];
                for (int i = 0; i < ru.UserFlavors.Count; i++)
                    flavors[i] = ru.UserFlavors[i].Flavor.Id.ToString();
                ud.Flavors = string.Join(",", flavors);

                string[] flavornames = new string[ru.UserFlavors.Count];
                for (int i = 0; i < ru.UserFlavors.Count; i++)
                    flavornames[i] = ru.UserFlavors[i].Flavor.Name;
                ud.FlavorNames = string.Join(",", flavornames);

                HttpContext.Current.Session[USERDATA] = ud;
            }
        }

        public static void LoadFromDatabase()
        {
            LoadFromDatabase(null);
        }
    }

}
