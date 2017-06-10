<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<FriendRatingInvitation>" %>
<%@ Import Namespace="FashionAde.Core.UserCloset"%>
<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <h1>Rate <%= Model.User.FullName %>'s Go-To outfit</h1>

    <div class="Outfit_Sponsors" style="margin-top: -55px;" >
        <span>Sponsored by:</span>
        <img src="/res/Sponsors/logo_lg.jpg" alt="Ann Taylor"  />
    </div>
    <% using (Html.BeginForm())
       { %>
    <% Html.RenderPartial("FriendRate", Model.Outfit);%>
    
    <input type="hidden" id="User" value="<%= Model.User.FullName %>" />
    <input type="hidden" id="Key" name="Key" value="<%= ViewData["Key"] %>" />
    <% }%>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="<%= Url.Content("~/js/jquery.toJSON.js") %>"></script>
<script src='<%= Url.Content("~/js/jquery.rating.js") %>' type="text/javascript" language="javascript"></script> 
<script src='<%= Url.Content("~/js/jquery.MetaData.js") %>' type="text/javascript" language="javascript"></script>
<script type="text/javascript">
    $(document).ready(function() {

        $('input.friendratingstar').rating({
            required: 'hide'
        });
        $('#User1').text($('#User').val());
        $('#User2').text($('#User').val());
    });
</script>
</asp:Content>