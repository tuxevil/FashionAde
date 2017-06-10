<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<FashionAde.Web.Controllers.Account.Views.UserLogin>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Log In</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <% Html.RenderPartial("LogIn", Model); %>
    
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/lib/MicrosoftAjax.js"></script>
<script type="text/javascript" src="/static/lib/MicrosoftMvcValidation.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#userName").focus();
        
        <% if (ViewData["Errors"] != null)
           { %>
            showMessage('<%= ViewData["Errors"] %>');
        <% } %>        
        
        <% if (Convert.ToBoolean(ViewData["validatedUser"])) { %>
            appendMessage($("#errorMessage"), "Your code has been successfully validated! Please sign in.", "success");
        <% } %>
    });
</script>
</asp:Content>