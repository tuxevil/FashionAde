<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<UserFull>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Account</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<input type="hidden" id="Alert" name="Alert" value="<%= Model.Alert %>" />
<input type="hidden" id="Tab" name="Tab" value="<%= Model.Tab %>" />

<h1 style="display:block; float:left; margin:0 25px 0 0;">Modify Your Closet Profile</h1>
<div id="tabs" class="tabs">
    <ul class="accountTabs">    
        <li class="accountTab"><a id="lnkProfile" class="tablink" href="#tabProfile">Change Profile</a></li> 
	    <li class="accountTab"><a id="lnkMail" class="tablink" href="#tabMail">Change Email</a></li> 
	    <li class="accountTab"><a id="lnkPassword" class="tablink" href="#tabPassword">Change Password</a></li> 
	    <li class="accountTab"><a id="lnkAnswer" class="tablink" href="#tabAnswer">Change Question</a></li> 
    </ul>
    <% Html.EnableClientValidation(); %>
    <div class="accountTabPanes">     
        <div id="tabProfile" class="profile" >
             <% Html.RenderPartial("ChangeUserInfo", new UserUpdate(Model)); %>
        </div>   

        <div id="tabMail" class="profile" style="display: none;" >
             <% Html.RenderPartial("ChangeUserMail", new UserEmail(Model)); %>
        </div>    

        <div id="tabPassword" class="profile" style="display: none;" >
             <% Html.RenderPartial("ChangeUserPassword", new UserPassword(Model)); %>
        </div>
        
        <div id="tabAnswer" class="profile" style="display: none;" >
             <% Html.RenderPartial("ChangeUserAnswer", new UserAnswer(Model)); %>
        </div>
    </div> 
</div>
<div class="tooltip"></div> 

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">

<script type="text/javascript" src="/static/lib/MicrosoftAjax.js"></script>
<script type="text/javascript" src="/static/lib/MicrosoftMvcValidation.js"></script>
<script type="text/javascript" src="/static/js/account.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        <% if (ViewData["Errors"] != null) { %>
            showMessage('<%= ((string[])ViewData["Errors"])[0] %>');
        <% } %>
    });    
</script>

</asp:Content>