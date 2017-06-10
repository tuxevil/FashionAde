<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<FashionAde.Web.Controllers.MVCInteraction.FriendRatingView>" %>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Rating</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <h1>Rate <%= HttpUtility.HtmlEncode(Model.UserName) %>'s Go-To outfit</h1>    

    <% Html.RenderPartial("FriendRate", Model);%>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/lib/MicrosoftAjax.js"></script>
<script type="text/javascript" src="/static/lib/MicrosoftMvcValidation.js"></script>
<script src='/static/lib/jquery.rating.js' type="text/javascript" language="javascript"></script> 
<script src='/static/lib/jquery.MetaData.js' type="text/javascript" language="javascript"></script>

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