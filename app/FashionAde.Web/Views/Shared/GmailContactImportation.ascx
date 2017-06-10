<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Google.GData.Client"%>
<div id="divGMailContactImportation" class="divContainer" style="width:99%;float:left; margin-bottom:20px; ">
<a href="<%= AuthSubUtil.getRequestUrl(Request.Url.ToString(), "http://www.google.com/m8/feeds/",false,true) %>" class="divButton">Get Google Contacts</a>
</div>