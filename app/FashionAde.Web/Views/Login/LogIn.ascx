<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<UserLogin>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.Account.Views"%>
<div id="errorMessage"></div>
<h1>Sign In to your Closet Account</h1>
<h2 style="color:#000;">Don&#8217;t have an account yet? Create one <a href="<%= Url.RouteUrl(new { controller = "FlavorSelect", action= "Index"}) %>" style="color: #F38333; display:inline;" >here</a></h2>    

<% Html.EnableClientValidation(); %>    
<%  using (Html.BeginForm("Validate", "Login")) { %>
    
        <fieldset class="login">
            <div id="divUserName">
                <label>UserName*</label>
                <%=Html.TextBox("UserName", string.Empty, new { maxlength = 50 })%>
                <%= Html.ValidationMessageFor(x => x.UserName) %>
            </div>    
            <div>
                <label>Password*</label>
                <%=Html.Password("Password", string.Empty, new { maxlength = 50 })%>
                <%= Html.ValidationMessageFor(x => x.Password) %>
            </div>
            <div id="rememberMe">
                <input type="checkbox" name="RememberMe" value="true"  />
                <label style="float:none;">Remember me next time.</label>
            </div>
            
            <input type="hidden" id="ReturnUrl" name="ReturnUrl" value="<%= Request.QueryString["ReturnUrl"] %>" />
            <div class="centerDiv" style="width:350px; height: 80px;">
                <div class="formButtonBig" style="float: left; margin-left:150px; display:inline; "><input id="btnLogin" type="submit" value="SIGN IN" style="margin:0;" /></div>
            </div>
            
        </fieldset>
<% } %>

<div id="divRememberPass">
    <img src="/static/img/img_forgot_pass.gif" alt="" style="float:left;" />
    <a id="btnForgotPassword" href="<%= Url.RouteUrl(new { controller = "Login", action= "ForgotPassword"}) %>" >
        <img id="btnForgotPass" src="/static/img/buttons/btn_forgot_pass.gif" alt="Forgot Password?" />
    </a>
</div>