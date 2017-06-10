<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<List<FashionAde.Core.ContentManagement.ContentPublishedSection>>" %>

<% if (Model.Count > 0) { %>
<div class="StyleAlertsHorizontalContainer">        
    <span class="updaterTitle" style="color: #013D74 !important; text-align: left; margin-top: 0px; margin-left: 15px;">Style Alerts</span>
    <div style="float: left;">
    <% foreach (FashionAde.Core.ContentManagement.ContentPublishedSection section in Model)
       { %>                
        <div class="StyleAlertsHorizontal">            
            <span><% = section.Title %> </span>
            <p><% = section.Body %> </p>                
            <a href="<% = section.ContentPublished.UserFriendlyTitle %>" >Read More</a>
            <div style="clear:both"></div>      
        </div>
    <% } %>  
    </div>    
    <div style="clear:both"></div>      
</div>
<% } %>        
