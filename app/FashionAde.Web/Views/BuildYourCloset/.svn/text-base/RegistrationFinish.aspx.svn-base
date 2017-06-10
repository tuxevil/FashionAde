<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<UserRegistration>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<center>
<span>Thank you for your registration, <%= Model.UserName %></span>
</center>
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
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript">
    $(document).ready(function() {
        $("#ctl00_MainContentPlaceHolder_ucLogin_UserName").text('<%= Model.UserName %>');
        $("#ctl00_MainContentPlaceHolder_ucLogin_Password").focus();
    });
</script>
</asp:Content>