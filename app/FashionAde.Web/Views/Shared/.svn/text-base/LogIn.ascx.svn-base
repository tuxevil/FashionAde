<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl" %>
<form id="Form1" runat="server">
    <h1>Sign In to your Closet Account</h1>
    <h2 style="color: Black; margin-top:-18px;">Don’t have an account yet? Create one <a href="<%= Url.RouteUrl(new { controller = "BuildYourCloset", action= "Index"}) %>" style="color: #F38333; display:inline;" >here</a></h2>    
    <div style="float:left;">
        <div id="divLogin">        
            <asp:Login  ID="ucLogin" 
                        runat="server" 
                        TitleText="" 
                        UserNameLabelText="UserName*" 
                        PasswordLabelText="Password*" 
                        RememberMeText=" Remember my user email address and password on future visits" 
                        RememberMeSet="true" 
                        LoginButtonImageUrl="~/img/buttons/btn_login.gif" 
                        LoginButtonType="Image"                         
                        FailureText="Sorry, we don’t recognize that account; please try again."
                        CheckBoxStyle-CssClass="loginRememberMe" 
                        LoginButtonStyle-CssClass="loginButton" DestinationPageUrl="/home/index/default.aspx">
            </asp:Login>            
        </div>        
    </div>    
      
    <div id="divRememberPass">
        <img src="../../img/img_forgot_pass.gif" alt="" style="float:left;" />
        <a id="btnForgotPassword" href="<%= Url.RouteUrl(new { controller = "Login", action= "ForgotPassword"}) %>" >
            <img id="btnForgotPass" src="../../img/buttons/btn_forgot_pass.gif" alt="Forgot Password?" />
        </a>        
    </div>
    
</form>