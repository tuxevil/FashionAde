<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<FashionAde.Core.FlavorSelection.BrandSet>" %>
<script type="text/javascript">var addthis_config = { "data_track_clickback": true };</script>

<%  foreach (FashionAde.Core.ContentManagement.ContentPublished content in (List<FashionAde.Core.ContentManagement.ContentPublished>)ViewData["contents"]) { %>
        <div class="styleAlertTextContainer">
            <div class="sharing">
                <a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;username=fashionade"><img src="/static/img/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a><script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=fashionade"></script>
            </div>
            <h1><%= content.Title %></h1>
            <div class="body"><%= content.Body %></div>
        </div>
<% } %>