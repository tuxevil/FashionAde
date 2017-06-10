using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Web.Security;
using MySql.Data.MySqlClient;
using NHibernate;
using PagedList;
using SharpArch.Data.NHibernate;
using System.Configuration;

namespace MvcMembership
{
	public class AspNetMembershipProviderWrapper : IUserService, IPasswordService
	{
		private readonly MembershipProvider _membershipProvider;

		public AspNetMembershipProviderWrapper(MembershipProvider membershipProvider)
		{
			_membershipProvider = membershipProvider;
		}

		#region IPasswordService Members

		public void Unlock(MembershipUser user)
		{
			user.UnlockUser();
		}

		public string ResetPassword(MembershipUser user, string passwordAnswer)
		{
            return user.ResetPassword(passwordAnswer);
		}

		#endregion

		#region IUserService Members

		public IPagedList<MembershipUser> FindAll(int pageIndex, int pageSize)
		{
			// get one page of users
			int totalUserCount;
            var usersCollection = _membershipProvider.GetAllUsers(pageIndex, pageSize, out totalUserCount);
            
			// convert from MembershipUserColletion to PagedList<MembershipUser> and return
			var converter = new EnumerableToEnumerableTConverter<MembershipUserCollection, MembershipUser>();
			var usersList = converter.ConvertTo<IEnumerable<MembershipUser>>(usersCollection);
			var usersPagedList = new StaticPagedList<MembershipUser>(usersList, pageIndex, pageSize, totalUserCount);
			return usersPagedList;
		}

        public IPagedList<MembershipUser> FindAllSorted(int pageIndex, int pageSize, int membershipAppId, string connString)
        {
            // get one page of users
            int totalUserCount;
            var usersCollection = ListAllUsersSorted(pageIndex, pageSize, membershipAppId, connString, out totalUserCount);

            // convert from MembershipUserColletion to PagedList<MembershipUser> and return
            var converter = new EnumerableToEnumerableTConverter<MembershipUserCollection, MembershipUser>();
            var usersList = converter.ConvertTo<IEnumerable<MembershipUser>>(usersCollection);
            var usersPagedList = new StaticPagedList<MembershipUser>(usersList, pageIndex, pageSize, totalUserCount);
            return usersPagedList;
        }

	    public IPagedList<MembershipUser> Find(int pageIndex, int pageSize, string searchText, bool isAppoved, bool isLockedOut, int membershipAppId)
        {
            // get one page of users
            var usersCollection = new MembershipUserCollection();
            string query = string.Format("call uspFindMembershipUsers({0},{1},{2},{3});", "'" + searchText + "'", Convert.ToInt16(isLockedOut),
                                         Convert.ToInt16(isAppoved), membershipAppId);
            IQuery q = NHibernateSession.Current.CreateSQLQuery(query);
            IList lst = q.List();

            foreach (int userId in lst)
                usersCollection.Add(Membership.GetUser(userId));

            // convert from MembershipUserColletion to PagedList<MembershipUser> and return
            var converter = new EnumerableToEnumerableTConverter<MembershipUserCollection, MembershipUser>();
            var usersList = converter.ConvertTo<IEnumerable<MembershipUser>>(usersCollection);
            var usersPagedList = new StaticPagedList<MembershipUser>(usersList, pageIndex, pageSize, lst.Count);
            return usersPagedList;
        }

		public IPagedList<MembershipUser> FindByEmail(string emailAddressToMatch, int pageIndex, int pageSize)
		{
			// get one page of users
			int totalUserCount;
			var usersCollection = _membershipProvider.FindUsersByEmail(emailAddressToMatch, pageIndex, pageSize, out totalUserCount);

			// convert from MembershipUserColletion to PagedList<MembershipUser> and return
			var converter = new EnumerableToEnumerableTConverter<MembershipUserCollection, MembershipUser>();
			var usersList = converter.ConvertTo<IEnumerable<MembershipUser>>(usersCollection);
			var usersPagedList = new StaticPagedList<MembershipUser>(usersList, pageIndex, pageSize, totalUserCount);
			return usersPagedList;
		}

		public IPagedList<MembershipUser> FindByUserName(string userNameToMatch, int pageIndex, int pageSize)
		{
			// get one page of users
			int totalUserCount;
			var usersCollection = _membershipProvider.FindUsersByName(userNameToMatch, pageIndex, pageSize, out totalUserCount);

			// convert from MembershipUserColletion to PagedList<MembershipUser> and return
			var converter = new EnumerableToEnumerableTConverter<MembershipUserCollection, MembershipUser>();
			var usersList = converter.ConvertTo<IEnumerable<MembershipUser>>(usersCollection);
			var usersPagedList = new StaticPagedList<MembershipUser>(usersList, pageIndex, pageSize, totalUserCount);
			return usersPagedList;
		}

		public MembershipUser Get(string userName)
		{
			return _membershipProvider.GetUser(userName, false);
		}

		public MembershipUser Get(object providerUserKey)
		{
			return _membershipProvider.GetUser(providerUserKey, false);
		}

		public void Update(MembershipUser user)
		{
			_membershipProvider.UpdateUser(user);
		}

		public void Delete(MembershipUser user)
		{
			_membershipProvider.DeleteUser(user.UserName, false);
		}

		public MembershipUser Touch(MembershipUser user)
		{
			return _membershipProvider.GetUser(user.UserName, true);
		}

		public MembershipUser Touch(string userName)
		{
			return _membershipProvider.GetUser(userName, true);
		}

		public MembershipUser Touch(object providerUserKey)
		{
			return _membershipProvider.GetUser(providerUserKey, true);
		}

		public int TotalUsers
		{
			get
			{
				int totalUsers;
				_membershipProvider.GetAllUsers(1, 1, out totalUsers);
				return totalUsers;
			}
		}

		public int UsersOnline
		{
			get
			{
				return _membershipProvider.GetNumberOfUsersOnline();
			}
		}

		#endregion

        #region CustomMethods

        /// <summary>
        /// We create our custom Total Users method because the implemented TotalUsers property
        /// gets all the users and return the users count output parameter. We need to improve
        /// this, so we create a stored procedure to make a count of the users.
        /// </summary>
        /// <param name="membershipAppId">Membership ApplicationId.</param>
        /// <param name="connString">Membership database connection string.</param>
        /// <remarks>This custom method requires uspMembershipUsersCount to work properly.</remarks>
        /// <returns>The total numebr of users for the current membershipAppId</returns>
        private static int GetTotalUsers(int membershipAppId, string connString)
        {
            object usersCount = 0;
            MySqlConnection conn = new MySqlConnection(connString);
            try
            {
                conn.Open();

                MySqlCommand command = new MySqlCommand { CommandType = CommandType.StoredProcedure, Connection = conn };
                command.Parameters.Add(new MySqlParameter("membershipAppId", membershipAppId));
                command.CommandText = "uspMembershipUsersCount";

                usersCount = command.ExecuteScalar();
            }
            catch (MySqlException)
            {
                // Handle exception.
            }
            finally
            {
                conn.Close();
            }
            return Convert.ToInt32(usersCount);
        }

        /// <summary>
        /// Get a MembershipUser from the reader.
        /// </summary>
        /// <param name="reader">Reader containing current user</param>
        /// <remarks>We adpated an official Microsoft Method to get the user. Plese see
        /// http://msdn.microsoft.com/en-us/library/system.web.security.membershipusercollection.membershipusercollection.aspx
        /// for more info.
        /// </remarks>
        /// <returns>A membershipUser object with the current reader dara</returns>
        private static MembershipUser GetUserFromReader(MySqlDataReader reader)
        {
            object providerUserKey = reader.GetValue(0);
            string username = reader.GetString(1);

            string email = "";
            if (reader.GetValue(2) != DBNull.Value)
                email = reader.GetString(2);

            string comment = "";
            if (reader.GetValue(3) != DBNull.Value)
                comment = reader.GetString(3);

            string passwordQuestion = "";
            if (reader.GetValue(4) != DBNull.Value)
                passwordQuestion = reader.GetString(4);

            bool isApproved = reader.GetBoolean(5);
            DateTime lastActivityDate = reader.GetDateTime(6);

            DateTime lastLoginDate = new DateTime();
            if (reader.GetValue(7) != DBNull.Value)
                lastLoginDate = reader.GetDateTime(7);

            DateTime lastPasswordChangedDate = reader.GetDateTime(8);
            DateTime creationDate = reader.GetDateTime(9);

            bool isLockedOut = reader.GetBoolean(10);
            DateTime lastLockedOutDate = new DateTime();

            if (reader.GetValue(11) != DBNull.Value)
                lastLockedOutDate = reader.GetDateTime(11);

            MembershipUser u = new MembershipUser(Membership.Provider.Name,
                                                  username,
                                                  providerUserKey,
                                                  email,
                                                  passwordQuestion,
                                                  comment,
                                                  isApproved,
                                                  isLockedOut,
                                                  creationDate,
                                                  lastLoginDate,
                                                  lastActivityDate,
                                                  lastPasswordChangedDate,
                                                  lastLockedOutDate);

            return u;
        }

        /// <summary>
        /// Get a MembershipUsersCollection of MembershipUsers sorted by creation date.
        /// </summary>
        /// <param name="pageIndex">Current Page Index.</param>
        /// <param name="pageSize">Current Page Size.</param>
        /// <param name="membershipAppId">Membership ApplicationId.</param>
        /// <param name="connString">Membership database connection string.</param>
        /// <param name="totalUserCount">Returns the total users.</param>
        /// <remarks>This custom method requires the uspFindAllMembershipUsersSorted stored procedure to work properly.</remarks>
        /// <returns>A membershipUsersCollection sorted by creation date desc.</returns>
        private static MembershipUserCollection ListAllUsersSorted(int pageIndex, int pageSize, int membershipAppId, string connString, out int totalUserCount)
        {
            MySqlConnection conn = new MySqlConnection(connString);
            MembershipUserCollection users = new MembershipUserCollection();
            MySqlDataReader reader = null;
            totalUserCount = 0;

            try
            {
                conn.Open();
                totalUserCount = GetTotalUsers(membershipAppId, connString);
                if (totalUserCount <= 0) { return users; }

                MySqlCommand command = new MySqlCommand { CommandType = CommandType.StoredProcedure, Connection = conn };
                command.Parameters.Add(new MySqlParameter("membershipAppId", membershipAppId));
                command.CommandText = "uspFindAllMembershipUsersSorted";

                reader = command.ExecuteReader();

                int counter = 0;
                int startIndex = pageSize * pageIndex;
                int endIndex = startIndex + pageSize - 1;

                while (reader.Read())
                {
                    if (counter >= startIndex)
                    {
                        MembershipUser u = GetUserFromReader(reader);
                        users.Add(u);
                    }

                    if (counter >= endIndex)
                    {
                        command.Cancel();
                        break;
                    }
                    counter++;
                }
            }
            catch (MySqlException)
            {
                // Handle exception.
            }
            finally
            {
                if (reader != null) { reader.Close(); }
                conn.Close();
            }

            return users;
        }


        #endregion
    }
}