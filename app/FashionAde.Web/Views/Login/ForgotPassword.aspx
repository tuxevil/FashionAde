<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<ForgotPasswordView>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Forgot Password</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <h1>Forgot your password?</h1>
    
    <% Html.EnableClientValidation(); %>
    
    <% 
        using (Html.BeginForm()) {
    %>
    
    <center>
    <fieldset>
    <div id="divUserName">
    <label>User Name:</label>
    <% = Html.ValidationMessageFor(x => x.UserName) %>
    <%= Html.TextBoxFor(x => x.UserName, new { maxlength = 50 })%>
    </div>
    <div>
    <label>Secret question:</label>
    <span id="Question" class="readonly">Enter your user name...</span>
    </div>
    <div>
    <label>Your Answer:</label>
    <% = Html.ValidationMessageFor(x => x.Answer)%>
    <%= Html.TextBoxFor(x => x.Answer, new { maxlength = 50 })%>
    </div>
    </fieldset>
    </center>
    
    <div class="centerDiv" style="width:150px;">
        <div class="formButtonBig" style="float:left;"><input id="SendAnswer" type="submit" value="SEND" /></div>   
    </div>
         

    <% } %>


</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/lib/MicrosoftAjax.js"></script>
<script type="text/javascript" src="/static/lib/MicrosoftMvcValidation.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $('#UserName').blur(GetQuestion);
        $('#UserName').focus();
        
        <% if (ViewData["Errors"] != null) { %>
            showMessage('<%= ViewData["Errors"] %>');
        <% } %>   
    });
</script>
<script type="text/javascript" src="/static/js/forgotPassword.js"></script>
</asp:Content>