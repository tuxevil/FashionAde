<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

<h1>Password Change</h1>
<div id="divLogin">
<% using (Html.BeginForm("ChangePassword", "Login"))
           {%>   
        <table>
            <tr>
                <td><label for="">Current Password*</label></td>
                <td><%=Html.TextBox("currentPassword")%></td>
                <td><%=Html.ValidationMessage("currentPassword") %></td>
            </tr>
            <tr>
                <td><label for="">Password*</label></td>
                <td><%=Html.Password("newPassword")%></td>
                <td><%=Html.ValidationMessage("newPassword")%></td>
            </tr>
            <tr>
                <td><label for="">Password*</label></td>
                <td><%=Html.Password("confirmPassword")%></td>
                <td><%=Html.ValidationMessage("confirmPassword")%></td>
            </tr>
        </table>
        <div style="margin-left: 100px;"><input type="button" value="Change" /></div><br /><br />
<% }%>    

</div> 
        

</asp:Content>

