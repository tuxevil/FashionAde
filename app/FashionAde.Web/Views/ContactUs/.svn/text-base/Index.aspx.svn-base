<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<FeedBack>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Contact Us</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<% Html.EnableClientValidation(); %>
    <div style="width: 710px; float: left; margin-right: 5px;">
        <h1>Contact Us</h1>
        <h2>Stay in contact with us, send us your feedback!</h2>
         
        <% using (Html.BeginForm())
           { %>
           
        <fieldset>
        <div>
        <label>Your Email:</label>
        <%= Html.ValidationMessageFor(x => x.Email)%>
        <% = Html.TextBoxFor(x => x.Email, new { maxlength = "100" })%>
        </div>
        <div>
        <label>Name:</label>
        <%= Html.ValidationMessageFor(x => x.Name)%>
        <% = Html.TextBoxFor(x => x.Name, new { maxlength = "100" })%>
        </div>
        <div>
        <label>Message:</label>
        <%= Html.ValidationMessageFor(x => x.Message)%>
        <% = Html.TextAreaFor(x => x.Message, new { cols = "35", rows = "6" })%>
        </div>
        </fieldset>
        <div class="centerDiv" style="width:0px; height: 80px;">
            <div class="formButtonBig" style="float:left; "><input type="submit" value="Send Now"/></div>   
        </div>
        <%} %>
    </div>
    <div style="float: left; width:226px;">
     <% Html.RenderPartial("UpdaterTrends", Model.Content); %> 
    </div>
        
</asp:Content>

<asp:Content ID="contactUsScripts" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/lib/MicrosoftAjax.js"></script>
<script type="text/javascript" src="/static/lib/MicrosoftMvcValidation.js"></script>
</asp:Content>