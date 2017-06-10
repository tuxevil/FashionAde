<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<UserRegistration>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

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
    <h1 style="float:left">Create Your Closet Account</h1>
    <img src="../../img/BuildYourCloset/already_registered.gif" alt="Already registered" style="margin-left:150px; display:inline; margin-top: 0px;" usemap="#shapes"/>
    <img src="../../img/BuildYourCloset/step3.gif" alt="" style="float:right; margin-right: 16px; display: inline;" />     
    
    <div style="clear: both; ">
    <div class="tooltip"></div> 
        <div id="GarmentsDiv"> 
            <div id="divProfContainer" style="width:95%;float:left; margin-bottom:20px; ">
            <% using (Html.BeginForm("Register", "BuildYourCloset"))
                { %>
                    <table style="margin-left: auto; margin-right: auto;">
                        <tr>
                            <td style="text-align:right;">Valid Email Address*</td>
                            <td class="profileInfo"><%=Html.TextBox("Email", string.Empty, new { title = "Please, insert a valid email", @class = "InputForValidate" })%></td>
                            <td class="tdAlerts"><div class="formValitationAlert" id="EmailCheck"></div></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">User Name*</td>
                            <td class="profileInfo"><%= Html.TextBox("UserName", string.Empty, new { title = "Please, insert youre user name", @class = "InputForValidate", maxlength = 25 })%></td>
                            <td class="tdAlerts"><div class="formValitationAlert" id="UserNameCheck"></div></td>
                        </tr>

                        <tr>
                            <td style="text-align:right;">Password*</td>
                            <td class="profileInfo"><%= Html.Password("Password", string.Empty, new { title = "Please, insert a password", @class = "InputForValidate" })%></td>
                            <td class="tdAlerts"><div class="formValitationAlert" id="PasswordCheck"></div></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Confirm Password*</td>
                            <td class="profileInfo"><%= Html.Password("ConfirmPassword", string.Empty, new { title = "Please, re type your password", @class = "InputForValidate" })%></td>                
                            <td class="tdAlerts"><div class="formValitationAlert" id="ConfirmPasswordCheck"></div></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Security Question*</td>
                            <td class="profileInfo"><%= Html.DropDownList("SecurityQuestion", ViewData["securityQuestions"] as List<SelectListItem>, new {title = "Please, select a security question" })%> </td>
                            <td class="tdAlerts"><div class="formValitationAlert" id="SecurityQuestionCheck"></div></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Security Answer*</td>
                            <td class="profileInfo"><%= Html.TextBox("SecurityAnswer", string.Empty, new { title = "Please, insert your security answer", @class = "InputForValidate" })%> </td>
                            <td class="tdAlerts"><div class="formValitationAlert" id="SecurityAnswerCheck"></div></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Zip Code*</td>            
                            <td class="profileInfo"><%= Html.TextBox("ZipCode", string.Empty, new { title = "Please, insert a zipcode", @class = "InputForValidate" })%></td>
                            <td class="tdAlerts"><div class="formValitationAlert" id="ZipCodeCheck"></div></td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">Size Category*</td>            
                            <td class="profileInfo"><%= Html.DropDownList("UserSize", ViewData["UserSizes"] as List<SelectListItem>, new { title = "Please, select a user size" })%> </td>
                            <td class="tdAlerts"><div class="formValitationAlert" id="UserSizeCheck"></div></td>
                        </tr>
                    </table>
                    <div style="margin-left: 40px; width: 550px;">
                        <div style="width:550px; margin-left:auto; margin-right: auto; border-top: dotted 1px gray">
                        <p style="font-size:11px; display: block; width: 425px; margin-left:auto; margin-right: auto; margin-top: 5px; color: #475F8F; font-family: Verdana; ">
                        <%= Html.CheckBox("TermOfUse", new { @class = "check" })%> I have read the <a style="color: #475F8F; display:inline; text-decoration: underline;" href="<%= Url.RouteUrl(new { controller = "Home", action= "TermOfUse"}) %>">Terms of Use</a> and agree to comply with these terms.<br />
                        <span style="margin-left: 15px; color: Black; font-weight:normal;">We care about your privacy - review our <a style="color: Black; text-decoration: underline; display:inline;" href="<%= Url.RouteUrl(new { controller = "Home", action= "Privacy"}) %>" target="_blank">privacy policy.</a></span>
                        </p>
                        </div>
                    </div>
                </div>
                <div style="width: 180px; margin-left: 200px;">
                <%= Html.ClientSideValidation(Model) %>
                <input id="btnRegister" type="image" src="../../img/BuildYourCloset/button_build_your_closet.gif" value="Build Your Closet" title="Finish the form"/>
                </div>
                <% } %>
        </div>
    </div>
</div> 
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="<%= Url.Content("~/js/jquery.toJSON.js") %>"></script>
<script type="text/javascript">
    var apiOverlay;
    var emailvalid = true;
    var uservalid = true;
    var zipcodevalid = true;
    $(document).ready(function() {
        apiOverlay = $("#NoOne").overlay({
                    // some expose tweaks suitable for modal dialogs 
                    expose: {
                        color: '#333',
                        loadSpeed: 200,
                        opacity: 0.3
                    },
                    target: "#loading",
                    left: "center",
                    top: "center",
                    api: true,
                    closeOnClick: false
                });
    
        $("#Email").blur(CheckEmail);
        $("#UserName").blur(CheckUsername);
        $("#ZipCode").blur(CheckZipCode);
        
        $(".InputForValidate").blur(ValidationForBackground);
        $(".InputForValidate").focus(ClearBackgroundValidation);
        //$("#btnRegister").click(OpenModal);
    });
    
    function OpenModal(){
        apiOverlay.load();
    }
    
    function ClearBackgroundValidation(){
        $("#" + $(this)[0].id + "Check").hide();
    }

    function ValidationForBackground(){
        if($(this)[0].id == "UserName")
            $("#" + $(this)[0].id + "Check").removeAttr("style");
        if($(this).val() == "")
            $("#" + $(this)[0].id + "Check").show();
        else if($(this)[0].id == "UserName")
            {
                $("#" + $(this)[0].id + "Check").attr("style","padding-bottom: 5px; height: auto;");
                $("#" + $(this)[0].id + "Check").show();
            }
    }

    function CheckEmail() {
        temp = $(this).val().toString();

        if (temp != "") {
            var encoded = $.toJSON(temp);

            $.ajax({
                type: "POST",
                url: "<%= Url.RouteUrl(new { controller = "BuildYourCloset", action= "CheckEmail"}) %>",
                data: encoded,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data) {
                    ShowEmailMessage(data);
                }
            });
        }
        else {
            $("#EmailCheck").empty();
            $("#EmailCheck").hide();
            //$("#Email").removeAttr("style");
        }
    }

    function ShowEmailMessage(data) {
        if (data.Exist == false) {
            //$("#Email").attr("style", "border-color: #007934; background: #E1E5F1 url(http://cdn.stumble-upon.com/i/forms/formSymbol.gif) no-repeat 99% -29px;");
            $("#EmailCheck").empty();
            $("#EmailCheck").hide();    
            emailvalid = true;
            if (emailvalid && uservalid && zipcodevalid)
                $("#btnRegister").removeAttr("disabled");
        }
        else {
            //$("#Email").attr("style", "border-color: #BD1A00; background: #E1E5F1 url(http://cdn.stumble-upon.com/i/forms/formSymbol.gif) no-repeat 99% 1px;");
            $("#EmailCheck").empty();
            if (data.RegExError == false)
                {
                    $("#EmailCheck").append(data.Email + " is in use");
                    $("#EmailCheck").show();
                }
                
            $("#btnRegister").attr("disabled", "disabled");
            emailvalid = false;
        }
    }

    function CheckUsername() {
        temp = $(this).val().toString();

        if (temp != "") {
            var encoded = $.toJSON(temp);

            $.ajax({
                type: "POST",
                url: "<%= Url.RouteUrl(new { controller = "BuildYourCloset", action= "CheckUsername"}) %>",
                data: encoded,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data) {
                    ShowUsernameMessage(data);
                }
            });
        }
        else {
            $("#UserNameCheck").empty();
            $("#UserNameCheck").hide();
            //$("#UserName").removeAttr("style");
        }
    }

    function ShowUsernameMessage(data) {
        if (data.Exist == false) {
            if (data.Reserved == false) {
                //$("#UserName").attr("style", "border-color: #007934; background: #E1E5F1 url(http://cdn.stumble-upon.com/i/forms/formSymbol.gif) no-repeat 99% -29px;");
                $("#UserNameCheck").empty();
                $("#UserNameCheck").hide();
                uservalid = true;
                if (emailvalid && uservalid && zipcodevalid)
                    $("#btnRegister").removeAttr("disabled");
            }
            else {
                //$("#UserName").attr("style", "border-color: #BD1A00; background: #E1E5F1 url(http://cdn.stumble-upon.com/i/forms/formSymbol.gif) no-repeat 99% 1px;");
                $("#UserNameCheck").empty();
                $("#UserNameCheck").append("The username " + data.Username + " is reserved.")
                $("#UserNameCheck").show();
                $("#btnRegister").attr("disabled", "disabled");
                uservalid = false;
            }
        }
        else {
            //$("#UserName").attr("style", "border-color: #BD1A00; background: #E1E5F1 url(http://cdn.stumble-upon.com/i/forms/formSymbol.gif) no-repeat 99% 1px;");
            $("#UserNameCheck").empty();
            $("#UserNameCheck").append("The username " + data.Username + " is not available but <a id='UserRecommended' style='color: #0A466E; font-weight: bold; display: inline;' href='#" + data.Recommended + "'>" + data.Recommended + "</a> is.")
            $("#UserNameCheck").show();
            $("#btnRegister").attr("disabled", "disabled");
            $("#UserRecommended").click(function(e) {
                e.preventDefault();
                $("#UserName").val(data.Recommended);
                $("#UserName").blur();
            })
            uservalid = false;
        }
    }

    function CheckZipCode() {
        temp = $(this).val().toString();

        if (temp != "") {
            var encoded = $.toJSON(temp);

            $.ajax({
                type: "POST",
                url: "<%= Url.RouteUrl(new { controller = "BuildYourCloset", action= "CheckZipCode"}) %>",
                data: encoded,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data) {
                    ShowZipCodeMessage(data);
                }
            });
        }
        else {
            $("#ZipCodeCheck").empty();
            //$("#ZipCode").removeAttr("style");
        }
    }

    function ShowZipCodeMessage(data) {
        if (data.Exist == true) {
            //$("#ZipCode").attr("style", "border-color: #007934; background: #E1E5F1 url(http://cdn.stumble-upon.com/i/forms/formSymbol.gif) no-repeat 99% -29px;");
            $("#ZipCodeCheck").empty();
            zipcodevalid = true;
            if (emailvalid && uservalid && zipcodevalid)
                $("#btnRegister").removeAttr("disabled");
        }
        else {
            //$("#ZipCode").attr("style", "border-color: #BD1A00; background: #E1E5F1 url(http://cdn.stumble-upon.com/i/forms/formSymbol.gif) no-repeat 99% 1px;");
            $("#ZipCodeCheck").empty();
            $("#ZipCodeCheck").append("<span style='font-size: 10px; font-weight: normal;'>The zip code " + data.ZipCode + " is not available</span>")
            $("#ZipCodeCheck").show();
            $("#btnRegister").attr("disabled", "disabled");
            zipcodevalid = false;
        }
    }
</script>
</asp:Content>