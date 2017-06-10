<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<RoleViewModel>" %>
<%@ Import Namespace="FashionAde.WebAdmin.Controllers.UserAdministration"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <h1>Role: <% =Html.Encode(Model.Role) %></h1>
    <div class="mvcMembership-roleUsers">
		<% if(Model.Users.Count() > 0){ %>
			<table>
				<% foreach(var user in Model.Users){ %>
				<tr>				
					<td><% =Html.ActionLink(user.UserName, "Details", new{id=user.ProviderUserKey}, new { style = "color:#000;" }) %></td>
					<td><%= Html.ActionLink("Remove From", "RemoveFromRole", "UserAdministration", new { id = user.ProviderUserKey, role = Model.Role }, new { @class ="actionLink" } )%></td>
				</tr>
				<% } %>			
			</table>
		<% }else{ %>
		<p>No users are in this role.</p>
		<% } %>
	</div>

</asp:Content>

<asp:Content ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" language="javascript">
    $(document).ready(function() {
        $("#lnkUsersAdmin").css("background-color", "#F08331");
    });
</script> 
</asp:Content>