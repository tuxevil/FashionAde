<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title><%= ((List<FashionAde.Core.ContentManagement.ContentPublished>)ViewData["contents"])[0].Title %></title>
<meta name="keywords" content="<%= ((List<FashionAde.Core.ContentManagement.ContentPublished>)ViewData["contents"])[0].Title %>" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">    
    <%Html.RenderPartial("ContentMenu");  %>    
    <%Html.RenderPartial("ContentItem");  %>    
</asp:Content>