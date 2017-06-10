<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<FashionAde.Core.ContentManagement.ContentPublished>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title><%= Model.Title %></title>
<meta name="keywords" content="<%= Model.Keywords %>" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<h1><%= Model.Title %></h1>
<p><%= Model.Body %></p>

</asp:Content>