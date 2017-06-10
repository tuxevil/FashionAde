<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<UserRegistration>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Registration</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<map name="shapes" id="shapes">    
    <area id="lnkSignIn" shape="rect" coords="92,43,156,59" href="<%= Url.RouteUrl(new { controller = "Login", action= "Index"}) %>" title="Sign In Here" alt="" />
</map>

<div class="modal" id="loading" style="width: 275px;"> 
    <p>Please wait, we are creating your outfits, this may take a few minutes..</p> 
    <center><img src="http://l.yimg.com/a/i/us/per/gr/gp/rel_interstitial_loading.gif" /></center>
</div> 
<input type="hidden" id="NoOne" />

<div class="parentDiv">
    <h1 style="float:left">Create Your Closet Account</h1><br /><br /><br />
    <h2 style="float:left; width: 450px;">Please complete the following information to build your closet. We will send you an email to validate your email address once completed.</h2>
    <img src="/static/img/BuildYourCloset/step3.gif" alt="" style="float:right; margin-right: 16px; display: inline; margin-top:-50px;" />         
    <img src="/static/img/BuildYourCloset/already_registered.gif" alt="Already registered" style="margin-rigth:50px; display:inline; margin-top: -50px; float:right;" usemap="#shapes"/>
    
    <div style="clear: both; ">
    <div class="tooltip"></div> 
        <div id="GarmentsDiv"> 
            <div id="divProfContainer" style="width:95%;float:left; margin-bottom:20px; ">
            
            <% Html.EnableClientValidation(); %>
            <% using (Html.BeginForm("Register", "Registration"))
                {%>
                    <table style="margin-left: auto; margin-right: auto;">
                        <tr>
                            <td style="text-align:right;">Valid Email Address*</td>
                            <td class="profileInfo"><%=Html.TextBox("Email", Model.Email, new { title = "Please, insert a valid email", @class = "InputForValidate", maxlength = 100 })%></td>
                            <td class="tdAlerts"><div id="EmailCheck"></div><%= Html.ValidationMessageFor(x => x.Email) %></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Confirm Email Address*</td>
                            <td class="profileInfo"><%=Html.TextBox("EmailConfirmation", Model.EmailConfirmation, new { title = "Please, confirm your email", @class = "InputForValidate", maxlength = 100 })%></td>
                            <td class="tdAlerts"><div id="EmailConfirmationCheck"></div><%= Html.ValidationMessageFor(x => x.EmailConfirmation) %></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">First Name</td>
                            <td class="profileInfo"><%=Html.TextBox("FirstName", Model.FirstName, new { @class = "InputForValidate", maxlength = 100 })%></td>
                            <td class="tdAlerts"></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Last Name</td>
                            <td class="profileInfo"><%=Html.TextBox("LastName", Model.LastName, new { @class = "InputForValidate", maxlength = 100 })%></td>
                            <td class="tdAlerts"></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">User Name*</td>
                            <td class="profileInfo"><%= Html.TextBox("UserName", Model.UserName, new { title = "Please, insert youre user name", @class = "InputForValidate", maxlength = 50 })%></td>
                            <td class="tdAlerts"><div id="UserNameCheck"></div><%= Html.ValidationMessageFor(x => x.UserName) %></td>
                        </tr>

                        <tr>
                            <td style="text-align:right;">Password*</td>
                            <td class="profileInfo"><%= Html.Password("Password", string.Empty, new { title = "Please, insert a password", @class = "InputForValidate", maxlength = 50 })%></td>
                            <td class="tdAlerts"><span style="color:green" id='result'></span> <%= Html.ValidationMessageFor(x => x.Password) %></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Confirm Password*</td>
                            <td class="profileInfo"><%= Html.Password("ConfirmPassword", string.Empty, new { title = "Please, re type your password", @class = "InputForValidate", maxlength = 50 })%></td>                
                            <td class="tdAlerts"><%= Html.ValidationMessageFor(x => x.ConfirmPassword) %></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Security Question*</td>
                            <td class="profileInfo"><%= Html.DropDownList("SecurityQuestion", ViewData["securityQuestions"] as List<SelectListItem>, new { title = "Please, select a security question" })%> </td>
                            <td class="tdAlerts"><%= Html.ValidationMessageFor(x => x.SecurityQuestion) %></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Security Answer*</td>
                            <td class="profileInfo"><%= Html.TextBox("SecurityAnswer", Model.SecurityAnswer, new { title = "Please, insert your security answer", @class = "InputForValidate", maxlength = 50 })%> </td>
                            <td class="tdAlerts"><%= Html.ValidationMessageFor(x => x.SecurityAnswer) %></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Zip Code*</td>            
                            <td class="profileInfo"><%= Html.TextBox("ZipCode", Model.ZipCode, new { title = "Please, insert a zipcode", @class = "InputForValidate", maxlength = 6 })%></td>
                            <td class="tdAlerts"><div id="ZipCodeCheck"></div><%= Html.ValidationMessageFor(x => x.ZipCode) %></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Size Category*</td>            
                            <td class="profileInfo"><%= Html.DropDownList("UserSize", ViewData["UserSizes"] as List<SelectListItem>, new { title = "Please, select a user size" })%> </td>
                            <td class="tdAlerts"></td>
                        </tr>                        
                    </table>
                    <div style="width:490px; float:left;">
                        <div style="width:550px; margin-left:auto; margin-right: auto; border-top: dotted 1px gray">
                        <p style="font-size:11px; display: block; width: 425px; margin-left:auto; margin-right: auto; margin-top: 5px; color: #475F8F; font-family: Verdana; ">
                        <%= Html.CheckBox("TermOfUse", new { @class = "check" })%> I have read the <a style="color: #475F8F; display:inline; text-decoration: underline;" href="<%= Url.RouteUrl(new { controller = "Content", action= "TermsOfUse"}) %>">Terms of Use</a> and agree to comply with these terms.<br /><%= Html.ValidationMessageFor(x => x.TermOfUse) %>
                        <span style="margin-left: 15px; color: Black; font-weight:normal;">We care about your privacy - review our <a style="color: Black; text-decoration: underline; display:inline;" href="<%= Url.RouteUrl(new { controller = "Content", action= "Privacy"}) %>" target="_blank">privacy policy.</a></span>                        
                        </p>
                        </div>                        
                    </div>
                    <span class="field-validation-error" id="termsOfUseCheck" style="float:left; margin-top:10px; display:none;">You must accept to continue.</span>
                </div>
                <div>
                <div id="btnPrevious" class="centerDiv nextStep divButtonBig" style="clear:none; float: left; margin-bottom: 10px; margin-left: 200px; margin-right: 30px;" >PREVIOUS</div>
                <div class="formButtonBig" style="float:left"><input type="submit" id="btnRegister" value="BUILD YOUR CLOSET" /></div>                
                </div>
                <% } %>
        </div>
    </div>
</div> 
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/lib/MicrosoftAjax.js"></script>
<script type="text/javascript" src="/static/lib/MicrosoftMvcValidation.js"></script>
<script type="text/javascript" src="/static/js/registration.js">
    
    
</script>
</asp:Content>