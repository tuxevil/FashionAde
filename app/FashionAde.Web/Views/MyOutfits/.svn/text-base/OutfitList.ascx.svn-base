<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<FashionAde.Web.Controllers.MVCInteraction.OutfitView>" %>
<%@ Import Namespace="FashionAde.Core.Views"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>
<%@ Import Namespace="FashionAde.Core.Clothing"%>

<div style="float: left; ">
    <input id="SiteURL" type="hidden" value="<%= ConfigurationManager.AppSettings["SiteURL"] %>" />
    <div class="search_Container" style="width: 710px; margin-right: 5px;">
        <div><span id="OutfitQuantity" style="color: Black; margin-top: 8px; float: left; margin-left: 10px; font-size: 14px;"><%= Model.TotalOutfits %> Outfits found</span></div>
        <% List<SelectListItem> pages = new List<SelectListItem>();
           SelectListItem page = new SelectListItem();
           page = new SelectListItem();
           page.Text = 25.ToString();
           page.Value = 25.ToString();
           page.Selected = true;
           pages.Add(page);
           page = new SelectListItem();
           page.Text = 50.ToString();
           page.Value = 50.ToString();
           pages.Add(page);
           page = new SelectListItem();
           page.Text = 100.ToString();
           page.Value = 100.ToString();
           pages.Add(page);
             %>
        <div style="float:right; margin-top: 3px; margin-bottom: 2px; color: #475F8F !important; font-size: 11px;font-weight: bold;"> Sort by <%= Html.DropDownList("SortBy", (List<SelectListItem>)ViewData["SortBy"], new { style = "width: 120px; margin-right: 20px;", onchange = "$('#btnGo').click();" })%> Page Size <%= Html.DropDownList("Pages", pages, new { style = "width: 50px;", onchange = "$('#btnGo').click();" })%> </div>
        <div style="clear:both"></div>
    </div>
    <div style="width: 710px; float: left; margin-right: 5px;">
       <div id="GarmentsDiv">
            <div>
                <%
    if (Model.Outfits.Count > 0)
    {
        int count = 0;
        foreach (ClosetOutfitView outfit in Model.Outfits)
        {
            if(count % Convert.ToInt32(ViewData["StyleAlertsStep"]) == 0 && count > 0)
            {%>
                <div id="<%= "sa_" + count %>">
                <%Html.RenderPartial("HorizontalUpdaterTrends", Model.StyleAlerts);%>
                </div>
            <%}
            Html.RenderPartial("Outfit", outfit);
            count++;
        }
        
       if(ViewData["Pages"] != null) Html.RenderPartial("Paging", ViewData["Pages"]);
    }
    else
    {
        MembershipUser currentUser = Membership.GetUser();
        if (currentUser != null && (int)currentUser.ProviderUserKey == (int)ViewData["closetUserId"])
        { %>
            <div class="NoOutfitDiv">
                <span>Sorry we can't find outfit matches for your request. If you've just built your closet, <a href="<%= Url.RouteUrl(new { controller = "GarmentSelector", action= "AddGarments"}) %>">try to add more garments for this season from the master closet.</a></span>
            </div>
        <% } else { %>
            <div class="NoOutfitDiv">
                <span>The user does not have Outfits for this season.</span>
            </div>
        <% } %>
<% } %>
            </div>
        </div>
    </div>
</div>