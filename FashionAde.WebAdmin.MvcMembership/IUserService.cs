﻿using System.Web.Security;
using PagedList;

namespace MvcMembership
{
	public interface IUserService
	{
		//todo: add create user method
		int TotalUsers { get; }
		int UsersOnline{ get; }
        IPagedList<MembershipUser> Find(int pageIndex, int pageSize, string searchText, bool isAppoved, bool isLockedOut, int membershipAppId);
		IPagedList<MembershipUser> FindAll(int pageIndex, int pageSize);
        IPagedList<MembershipUser> FindAllSorted(int pageIndex, int pageSize, int membershipAppId, string connString);
		IPagedList<MembershipUser> FindByEmail(string emailAddressToMatch, int pageIndex, int pageSize);
		IPagedList<MembershipUser> FindByUserName(string userNameToMatch, int pageIndex, int pageSize);
		MembershipUser Get(string userName);
		MembershipUser Get(object providerUserKey);
		void Update(MembershipUser user);
		void Delete(MembershipUser user);
		MembershipUser Touch(MembershipUser user);
		MembershipUser Touch(string userName);
		MembershipUser Touch(object providerUserKey);
	}
}