<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<FashionAde.Web.Controllers.MVCInteraction.UserPassword>" %>
<div id="div2" class="divContainer" style="width:95%;float:left; margin-bottom:20px; ">
<% using (Html.BeginForm("ChangePassword", "Account"))
    { %>
    <table style="float:left;">
        <tr>
            <td>Enter your password</td>
            <td class="profileInfo"><%= Html.Password("OldPassword", null, new { title = "Please, enter your actual password", @class = "InputForValidate" })%> </td>
            <td class="tdAlerts"><div class="formValitationAlert" id="OldPasswordCheck" style="margin-top: 0px;"></div></td>
        </tr>
        <tr>
            <td>Enter your new password</td>
            <td class="profileInfo"><%= Html.Password("NewPassword", null, new { title = "Please, enter your new password", @class = "InputForValidate" })%> </td>
            <td class="tdAlerts"><div class="formValitationAlert" id="NewPasswordCheck" style="margin-top: 0px;"></div></td>
        </tr>
        <tr>
            <td>Confirm your new password</td>
            <td class="profileInfo"><%= Html.Password("ConfirmPassword", null, new { title = "Please, confirm your new password", @class = "InputForValidate" })%> </td>
            <td class="tdAlerts"><div class="formValitationAlert" id="ConfirmPasswordCheck" style="margin-top: 0px;"></div></td>
        </tr>
    </table>
    <%= Html.ClientSideValidation(Model) %>
    <div class="centerDiv" style="width:215px;">
        <input type="image" src="../../img/buttons/btn_save_changes.gif" alt="Save My Changes" />            
    </div>
    <% } %>  
</div>
     
