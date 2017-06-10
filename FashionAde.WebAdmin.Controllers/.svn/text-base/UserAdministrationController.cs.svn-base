using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Web.Mvc;
using System.Web.Security;
using FashionAde.Data.Repository;
using FashionAde.Web.Common;
using FashionAde.WebAdmin.Controllers;
using FashionAde.WebAdmin.Controllers.UserAdministration;
using MvcContrib.UI.Grid;
using MvcMembership;
using PagedList;

namespace FashionAde.WebAdmin.Controllers
{
    [Authorize(Roles = "Administrator")]
    public class UserAdministrationController : AuthorizeController
	{
		private const int PageSize = 50;
		private const string ResetPasswordBody = "Your new password is: ";
		private const string ResetPasswordFromAddress = "from@domain.com";
		private const string ResetPasswordSubject = "Your New Password";
		private readonly IRolesService _rolesService;
		private readonly ISmtpClient _smtpClient;
		private readonly IUserService _userService;
		private readonly IPasswordService _passwordService;

		public UserAdministrationController()
			: this(
				new AspNetMembershipProviderWrapper(Membership.Provider),
				new AspNetMembershipProviderWrapper(Membership.Provider),
				new AspNetRoleProviderWrapper(Roles.Provider),
				new SmtpClientProxy(new SmtpClient()))
		{
		}

		public UserAdministrationController(
			IUserService userService,
			IPasswordService passwordService,
			IRolesService rolesService,
			ISmtpClient smtpClient)
		{
			_userService = userService;
			_passwordService = passwordService;
			_rolesService = rolesService;
			_smtpClient = smtpClient;
		}

        public ViewResult Index(int? index, GridSortOptions sort)
        {
            ViewData["isApproved"] = true;
            ViewData["isLockedOut"] = false;

            int membershipAppId = int.Parse(ConfigurationManager.AppSettings["membershipAppId"]);
            string connString = ConfigurationManager.ConnectionStrings["LocalMySqlServer"].ConnectionString;

            return View(new IndexViewModel
            {
                //Changed to FindAllSorted. Originally it calls to standard method FindAll
                Users = _userService.FindAllSorted(index ?? 0, PageSize, membershipAppId, connString),
                Roles = _rolesService.FindAll()
            });            
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ViewResult Index(int? index, string searchText, bool isApproved, bool isLockedOut)
        {
            ViewData["isApproved"] = isApproved;
            ViewData["isLockedOut"] = isLockedOut;
            int membershipAppId = int.Parse(ConfigurationManager.AppSettings["membershipAppId"]);

            return View(new IndexViewModel
            {
                Users = _userService.Find(index ?? 0, PageSize, searchText, isApproved, isLockedOut, membershipAppId),
                Roles = _rolesService.FindAll()
            });
        }


        [AcceptVerbs(HttpVerbs.Post)]
		public RedirectToRouteResult CreateRole(string id)
		{
			_rolesService.Create(id);
            return RedirectToAction("Index");
		}


        [ObjectFilter(Param = "id", RootType = typeof(string))]
		public JsonResult DeleteRole(string id)
		{
			_rolesService.Delete(id);
		    return Json(new {Success = true});
		}

		public ViewResult Role(string id)
		{
			return View(new RoleViewModel
			            	{
			            		Role = id,
								Users = _rolesService.FindUserNamesByRole(id).Select(username => _userService.Get(username))
			            	});
		}

		public ViewResult Details(int id)
		{
			var user = _userService.Get(id);
			var userRoles = _rolesService.FindByUser(user);
			return View(new DetailsViewModel
			            	{
			            		DisplayName = user.UserName,
			            		User = user,
			            		Roles = _rolesService.FindAll().ToDictionary(role=> role, role=> userRoles.Contains(role)),
			            		Status = user.IsOnline
			            		         	? DetailsViewModel.StatusEnum.Online
			            		         	: !user.IsApproved
			            		         	  	? DetailsViewModel.StatusEnum.Unapproved
			            		         	  	: user.IsLockedOut
			            		         	  	  	? DetailsViewModel.StatusEnum.LockedOut
			            		         	  	  	: DetailsViewModel.StatusEnum.Offline
			            	});
		}

        [AcceptVerbs(HttpVerbs.Post)]
		public RedirectToRouteResult Details(int id,
		                            [Bind(Prefix = "User.Email")] string email,
		                            [Bind(Prefix = "User.Comment")] string comment)
		{
			var user = _userService.Get(id);
			user.Email = email;
			user.Comment = comment;
			_userService.Update(user);

            //Update email also in our Registered User Table
            RegisteredUserRepository rur = new RegisteredUserRepository();
            rur.UpdateEmail(rur.GetByMembershipId(id), email);
            
			return RedirectToAction("Details", new {id});
		}
		
        [AcceptVerbs(HttpVerbs.Post)]
		public RedirectToRouteResult DeleteUser(int id)
		{
			_userService.Delete(_userService.Get(id));
			return RedirectToAction("Index");
		}

        
        [AcceptVerbs(HttpVerbs.Post)]
		public RedirectToRouteResult ChangeApproval(int id, bool isApproved)
		{
			var user = _userService.Get(id);
			user.IsApproved = isApproved;
			_userService.Update(user);
			return RedirectToAction("Details", new {id});
		}

		[AcceptVerbs(HttpVerbs.Post)]
		public RedirectToRouteResult Unlock(int id)
		{
			_passwordService.Unlock(_userService.Get(id));
			return RedirectToAction("Details", new {id});
		}
		
		public RedirectToRouteResult ResetPassword(int id, string answer)
		{
		    try
		    {
                var user = _userService.Get(id);
                var newPassword = _passwordService.ResetPassword(user, answer);

                var body = ResetPasswordBody + newPassword;
                _smtpClient.Send(new MailMessage(ResetPasswordFromAddress, user.Email, ResetPasswordSubject, body));
		    }
		    catch (MembershipPasswordException)
		    {
		        TempData["wrongPassword"] = "Wrong password answer.";
		    }

            return RedirectToAction("Details", new { id });
		}

        public RedirectToRouteResult AddToRole(int id, string role)
		{
			_rolesService.AddToRole(_userService.Get(id), role);
			return RedirectToAction("Details", new { id });
		}
        
		public RedirectToRouteResult RemoveFromRole(int id, string role)
		{
			_rolesService.RemoveFromRole(_userService.Get(id), role);
			return RedirectToAction("Details", new { id });
		}

	}
}