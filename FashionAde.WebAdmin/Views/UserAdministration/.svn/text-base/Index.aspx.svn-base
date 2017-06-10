<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IndexViewModel>" %>
<%@ Import Namespace="FashionAde.WebAdmin.Controllers.UserAdministration"%>
<%@ Import Namespace="MvcContrib.UI.Grid" %>
<script runat="server">
    private static string GetLastLogin(MembershipUser user)
    {
        string result;
        var offlineSince = (DateTime.Now - user.LastActivityDate);
        if (offlineSince.TotalSeconds <= 60) result = "1 minute.";
        else if (offlineSince.TotalMinutes < 60) result = (Math.Floor(offlineSince.TotalMinutes) + " minutes.");
        else if (offlineSince.TotalMinutes < 120) result = "1 hour.";
        else if (offlineSince.TotalHours < 24) result = (Math.Floor(offlineSince.TotalHours) + " hours.");
        else if (offlineSince.TotalHours < 48) result = "1 day.";
        else result = (Math.Floor(offlineSince.TotalDays) + " days.");
        
        return result;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="OverlayPlaceHolder" runat="server">
    <div class="modal" id="deleteRole" style="opacity:1;"> 
        <img src='/img/close.png' class='close close_Image' />
        <center>
            <p>Do you want to delete this role?</p> 
            <div id="btnRoleConfirmation" class="divButton roleConfirmation">Yes</div><div class="divButton close" >No</div>
        </center>
    </div>
</asp:Content> 

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <h1 style="margin:0 0 5px 0;">User Administration</h1>    

        <% using (Html.BeginForm("Index", "UserAdministration", FormMethod.Post))
           {%>     
        <fieldset style="border:solid 1px #CCCCCC;">
        <legend style="margin-left:8px;">Filters</legend>
             <table>
                <tr>
                    <td>Email / UserName</td>
                    <td><%=Html.TextBox("searchText", ViewData["searchText"])%></td>
                    <td>Is Approved <%= Html.CheckBox("isApproved", ViewData["isApproved"])%></td>
                    <td>Is Locked Out <%= Html.CheckBox("isLockedOut", ViewData["isLockedOut"])%></td>
                    <td><input id="search" name="filter" type="submit" class="seeMannequin divButton" style="padding:2px 10px 2px 10px; margin:0 0 3px 5px;" value="Search" /></td>
                    <td><input id="clear"  name="filter" type="submit" class="seeMannequin divButton" style="padding:2px 10px 2px 10px; margin:0 0 3px 5px;" value="Clear" onclick="return false;"/></td>
                </tr>            
             </table>
         </fieldset>
          
        <% } %>
        
    <h2>Users</h2>	
	<%
	    Html.Grid(Model.Users).Columns(column =>
	                                       {
	                                           column.For(
	                                               user =>
	                                               Html.ActionLink("Edit", "Details", new {id = user.ProviderUserKey}, null))
	                                               .DoNotEncode().
	                                               Attributes(style => "text-align:center");
	                                           column.For(user => user.UserName);
	                                           column.For(user => user.Email);
                                               column.For(user => (user.IsLockedOut) ? "Yes" : "No").Named("Is Locked Out");
	                                           column.For(user => (user.IsApproved) ? "Yes" : "No").Named("Is Approved");
	                                           column.For(user => user.LastLockoutDate);
	                                           column.For(user => GetLastLogin(user)).Named("Last Login");
	                                       })
                                           .RowStart(row => (!row.Item.IsApproved || row.Item.IsLockedOut)
                                                                    ? (!row.Item.IsApproved) ? "<tr class='unapprovedAccount'>" : "<tr class='lockedAccount'>" 
                                                                    : "<tr>")
	        .Attributes(@class => "grid")
	        .Empty("No records found.")
	        .Render();
      %>
      
      <ul class="paging">
			<% if (Model.Users.IsFirstPage){ %>
			<li>First</li>
			<li>Previous</li>
			<% }else{ %>
			<li><% =Html.ActionLink("First", "Index", null, new { @class = "actionLink" }) %></li>
			<li><% =Html.ActionLink("Previous", "Index", new { index = Model.Users.PageIndex - 1 }, new { @class = "actionLink" } )%></li>
			<% } %>

			<li>Page <% =Model.Users.PageNumber%> of <% =Model.Users.PageCount%></li>

			<% if (Model.Users.IsLastPage){ %>
			<li>Next</li>
			<li>Last</li>
			<% }else{ %>
			<li><% =Html.ActionLink("Next", "Index", new { index = Model.Users.PageIndex + 1 }, new { @class = "actionLink"} )%></li>
			<li><% =Html.ActionLink("Last", "Index", new { index = Model.Users.PageCount - 1 }, new { @class = "actionLink" } )%></li>
			<% } %>
		</ul>
</asp:Content>

<asp:Content ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">

<script language="javascript" type="text/javascript">
    var apiRole;
    var roleSelected;

    $(document).ready(function() {
        apiRole = appendOverlay(".deleteRole", "#deleteRole", setRoleSelected, null);
        $(".roleConfirmation").click(removeRole);
        $("#lnkCreateRole").click(createRole);
        $("#clear").click(refreshPage);
        $("#lnkUsersAdmin").css("background-color", "#F08331");
    });

    function createRole(e) {
        var role = trim($("#id").val());
        if (role == "") {
            showMessage("You must enter a role to continue.")
            return false;
        }
        //document.formCreateRole.submit();
        $("#formCreateRole").submit();
    }

    function setRoleSelected(data, api) {
        roleSelected = $(data.getTrigger()).attr("role");
        apiRole = api;
    }

    function removeRole() {
        var encoded = $.toJSON(roleSelected);
        ajaxRequest("UserAdministration", "DeleteRole", encoded, removeRoleSuccess);
    }

    function removeRoleSuccess(data) {
        apiRole.close();
        refreshPage();
    }

    function refreshPage() {
        window.location = document.location.href;
    }
	    
	</script>

</asp:Content>