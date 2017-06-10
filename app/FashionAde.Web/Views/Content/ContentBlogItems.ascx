<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<FashionAde.Core.FlavorSelection.BrandSet>" %>

<% foreach (FashionAde.Core.ContentManagement.ContentPublished content in (IList<FashionAde.Core.ContentManagement.ContentPublished>)ViewData["contents"])
   { %>
    <div class="styleAlertTextContainer">
        <h1><a href="<%= content.UserFriendlyTitle %>"><%= content.Title %></a></h1>
        <div class="promotext"><%= content.PromotionalText %></div>
    </div>
<% } %>