<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<List<ClosetOutfitView>>" %>
<%@ Import Namespace="FashionAde.Core.MVCInteraction"%>

<%
    if (Model.Count > 0)
    {
        foreach (ClosetOutfitView outfit in Model)
            Html.RenderPartial("Outfit", outfit);
        
       if(ViewData["Pages"] != null) Html.RenderPartial("Paging", ViewData["Pages"]);
    }
    else
    {
        MembershipUser currentUser = Membership.GetUser();
        if (currentUser != null && (int)currentUser.ProviderUserKey == (int)ViewData["closetUserId"])
        { %>
            <div class="NoOutfitDiv">
                <span>Sorry we can't find outfit matches for your request. If you've just built your closet, and you've added a lot of garments, please check back shortly - we may still be working on building outfits for you.</span>
            </div>
        <% } else { %>
            <div class="NoOutfitDiv">
                <span>The user does not have Outfits for this season.</span>
            </div>
        <% } %>
<% } %>