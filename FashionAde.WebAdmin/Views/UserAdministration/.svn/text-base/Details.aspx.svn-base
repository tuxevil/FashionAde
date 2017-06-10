<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DetailsViewModel>" %>
<%@ Import Namespace="FashionAde.WebAdmin.Controllers.UserAdministration"%>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="MvcContrib.UI.Grid" %>

<asp:Content ID="contentOverlay" ContentPlaceHolderID="OverlayPlaceHolder" runat="server">
    <div class="modal" id="divChangeApproval" style="opacity:1;"> 
        <img src='/img/close.png' class='close close_Image' />
        <center>
            <p>Are you sure you want to change approval status of this account?</p> 
            <div id="btnConfirmApproval" class="divButton roleConfirmation">Yes</div><div class="divButton close" >No</div>
        </center>
    </div>
</asp:Content> 

<asp:Content ID="contentMain" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">    	

    <h1>User Details: <% =Html.Encode(Model.DisplayName) %></h1>
    
    <fieldset class="detailsFieldset">
        <legend>Account</legend>        
        <dl>
			<dt>User Name:</dt>
				<dd><% =Html.Encode(Model.User.UserName) %></dd>
			<% if(Model.User.LastActivityDate == Model.User.CreationDate){ %>
			<dt>Last Active:</dt>
				<dd><em>Never</em></dd>
			<dt>Last Login:</dt>
				<dd><em>Never</em></dd>
			<% }else{ %>
			<dt>Last Active:</dt>
				<dd><% =Model.User.LastActivityDate.ToString("MMMM dd, yyyy h:mm:ss tt", CultureInfo.InvariantCulture) %></dd>
			<dt>Last Login:</dt>
				<dd><% =Model.User.LastLoginDate.ToString("MMMM dd, yyyy h:mm:ss tt", CultureInfo.InvariantCulture) %></dd>
			<% } %>
			<dt>Created:</dt>
				<dd><% =Model.User.CreationDate.ToString("MMMM dd, yyyy h:mm:ss tt", CultureInfo.InvariantCulture) %></dd>
		</dl>
		
		<% using (Html.BeginForm("ChangeApproval", "UserAdministration", new { id = Model.User.ProviderUserKey }, FormMethod.Post, new { id = "formChangeApproval" })) { %>
		    <% =Html.Hidden("isApproved", !Model.User.IsApproved) %>		    
			<% if (Model.User.IsApproved) { %>
			    <a id="lnkChangeApproval" class="actionLink">Unapprove Account</a>
		    <% } else { %>
		        <a id="lnkChangeApproval" class="actionLink">Approve Account</a>
		    <% }
        }%>
		
		<br /><br>
		
    </fieldset>
    
    <fieldset class="detailsFieldset">
        <legend>Email Address & Comments</legend>
        <div class="detailsSeparator"></div> 	
	<div class="mvcMembership-emailAndComments">
		<% using(Html.BeginForm("Details", "UserAdministration", new{ id = Model.User.ProviderUserKey }, FormMethod.Post, new { id = "formDetails" })){ %>
		<fieldset>
		<br />
			<table>
			    <tr>
			        <td><label for="User_Email">Email Address:</label></td> 
				    <td><% =Html.TextBox("User.Email") %></td>
			    </tr>
			    <tr>
			        <td><label for="User_Comment">Comments:</label></td> 
				    <td><% =Html.TextArea("User.Comment") %></td> 
			    </tr>
		    </table>
		    <a id="lnkEmailAndComments" class="actionLink">Save Email Address and Comment</a>			
		</fieldset>
		<% } %>		
	</div>    
    </fieldset>
	
	<fieldset class="detailsFieldset">
	    <legend>Password</legend>
	    <div class="mvcMembership-password" style="margin-top:10px">
		<% if(Model.User.IsLockedOut){ %>
			<p>Locked out since <% =Model.User.LastLockoutDate.ToString("MMMM dd, yyyy h:mm:ss tt", CultureInfo.InvariantCulture) %></p>
			<% using(Html.BeginForm("Unlock", "UserAdministration", new{ id = Model.User.ProviderUserKey }, FormMethod.Post, new { id = "formUnlock" })){ %>
			    <a id="lnkUnlock" class="actionLink>Unlock</a>
			<% } %>
		<% }else{ %>
			<% if(Model.User.LastPasswordChangedDate == Model.User.CreationDate){ %>
			<dl>
				<dt>Last Changed:</dt>
				<dd><em>Never</em></dd>
			</dl>
			<% }else{ %>
			<dl>
				<dt>Last Changed:</dt>
				<dd><% =Model.User.LastPasswordChangedDate.ToString("MMMM dd, yyyy h:mm:ss tt", CultureInfo.InvariantCulture) %></dd>
			</dl>
			<% } %>

			<% using(Html.BeginForm("ResetPassword", "UserAdministration", new{ id = Model.User.ProviderUserKey }, FormMethod.Post, new { id = "formResetPassword" } )){ %>
			<fieldset>
				<p>
					<dl>
						<dt>Password Question:</dt>
						<% if(string.IsNullOrEmpty(Model.User.PasswordQuestion) || string.IsNullOrEmpty(Model.User.PasswordQuestion.Trim())){ %>
						<dd><em>No password question defined.</em></dd>
						<% }else{ %>
						<dd><% =Html.Encode(Model.User.PasswordQuestion) %></dd>
						<% } %>
					</dl>
				</p>
				<p>
					<label for="answer">Password Answer:</label>
					<% =Html.TextBox("answer") %>
				</p>
				<a id="lnkResetPassword" class="actionLink">Reset Password</a>
			</fieldset>
			<% } %>

		<% } %>		
	</div>
	</fieldset>
	
	<fieldset class="detailsFieldset">
	<legend>Roles</legend>
	<div class="mvcMembership-userRoles">	    
	    <table>
	    
	        <% foreach(var role in Model.Roles){ %>
	        <tr>
			<td>
				<% =Html.ActionLink(role.Key, "Role", new{id = role.Key}, new { style ="color:#000;" } ) %>
			</td>
			<td>
				<% if(role.Value){ %>
				    <%= Html.ActionLink("Remove From", "RemoveFromRole", "UserAdministration", new { id = Model.User.ProviderUserKey, role = role.Key }, null)%>
				<% }else{ %>
				    <%= Html.ActionLink("Add To", "AddToRole", "UserAdministration", new { id = Model.User.ProviderUserKey, role = role.Key }, null  )%>
				<% } %>
			</td>
			</tr>
			<% } %>	    
	    
		</table> 
		
		</div>
	</fieldset>
</asp:Content>

<asp:Content ID="contentScripts" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server" >
    <script language="javascript" type="text/ecmascript">
        $(document).ready(function() {
            $("#lnkUsersAdmin").css("background-color", "#F08331");
            appendOverlay("#lnkChangeApproval", "#divChangeApproval", null, null);
            
            $("#lnkChangePassword").click(function(e) {                
                document.formResetPassword.submit();
            });
            
            $("#lnkChangeApproval").click(function(e){ 
                e.preventDefault();
            });
            
            $("#btnConfirmApproval").click(function(e){ 
                $("#formChangeApproval").submit();
            });
            
            $("#lnkDeleteAccount").click(function(e){
                $("#formDeleteUser").submit();
            });
            
            $("#lnkUnlock").click(function(e){
                $("#formUnlock").submit();
            });
            
            $("#lnkEmailAndComments").click(function(e){
                $("#formDetails").submit();
            });
                        
            $("#lnkResetPassword").click(function(e){
                if(trim($("#answer").val()) == ""){
	                showMessage("You must enter a password answer to continue.")
	                return false;
	            }	                        
                $("#formResetPassword").submit();
            });
            
            appendOverlay(".deleteRole", "#deleteRole", null, null);
            
            <% if (TempData["wrongPassword"] != null)
               { %>
                    showMessage('<%= TempData["wrongPassword"]  %>');
            <% } %>
        });    
    </script>
</asp:Content>