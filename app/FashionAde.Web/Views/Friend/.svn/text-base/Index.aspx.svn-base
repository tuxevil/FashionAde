<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<FriendsData>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Friends</title>
</asp:Content>

<asp:Content ID="contentOverlay" ContentPlaceHolderID="OverlayPlaceHolder" runat="server">
    <div class="modal" id="RemoveConfirmation" style="opacity:1;"> 
        <img src='/static/img/close.png' class='close close_Image' />    
        <center>
            <p>Are you sure to remove this friend?</p> 
            <div id="btnRemove" class="divButton">Yes</div><div class="divButton close" >No</div>
        </center>
    </div> 
    <input type="hidden" id="userMail" value="<%= HttpUtility.HtmlEncode(Model.UserMail) %>" />
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<div id="errorMessage"></div>
    <% Html.RenderPartial("FriendMaster", Model); %>
    
    <% using (Html.BeginForm("DeleteFriend", "Friend", FormMethod.Post, new { @id = "RemoveForm" }))
       {   %>
       <%= Html.Hidden("FriendId") %>
    <%} %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/lib/MicrosoftAjax.js"></script>
<script type="text/javascript" src="/static/lib/MicrosoftMvcValidation.js"></script>
<script type="text/javascript" src="/static/js/friend.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
    <% if (Convert.ToBoolean(TempData["NewFriendsAdded"])) { %>
        appendMessage($("#errorMessage"), "Your friend/s have been added successfully", "success");
    <% } %>    
    });
    
</script>
</asp:Content>