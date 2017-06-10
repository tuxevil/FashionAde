<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<Friend>" %>
<%@ Import Namespace="FashionAde.Core.Accounts"%>
<tr>
    <td><%= Html.CheckBox("chb_" + Model.LastName) %></td>
    <td><%= Model.EmailAddress %></td>
    <td><%= Model.FirstName %></td>
</tr>