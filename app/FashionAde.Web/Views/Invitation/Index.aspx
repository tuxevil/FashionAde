<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<Invitation>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <title>Invitation Code</title>
</asp:Content>

<asp:Content ID="contentInvitationCode" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <div id="tempMessage"></div>
    <% Html.EnableClientValidation(); %>
    
        <h1>Get your invitation code now!</h1>
        <h2>
        Please enter your email adress and we will send you an invitation code to your inbox.<br />
        Use the code received to start building your closet!
        </h2>
        <br />
        <% Html.EnableClientValidation(); %>
        <% using (Html.BeginForm()) { %>                   
            <%= Html.AntiForgeryToken() %>
            <fieldset class="fieldsetInvitationCode">
                <label>Your Email:</label>
                <%= Html.TextBoxFor(x => x.EmailAdress, new { maxlength = "120" })%>
                <%= Html.ValidationMessageFor(x => x.EmailAdress )%>            
                <div class="formButtonBig" style="float:left; display:inline; margin-left:165px; ">
                <input type="submit" value="Send Now"/>
            </div>
            </fieldset>
        <%} %>
        
</asp:Content>

<asp:Content ID="contactUsScripts" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/lib/MicrosoftAjax.js"></script>
<script type="text/javascript" src="/static/lib/MicrosoftMvcValidation.js"></script>

<script type="text/javascript">
        $(document).ready(function() {
            <% if (TempData["message"] != null) { %>
                appendMessage($("#tempMessage"), '<%= TempData["message"] %>', "error");
            <% } %>
        });
    </script>

</asp:Content>