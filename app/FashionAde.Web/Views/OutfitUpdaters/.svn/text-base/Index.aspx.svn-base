<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<List<OutfitUpdater>>" %>
<%@ Import Namespace="FashionAde.Core.ThirdParties"%>
<%@ Import Namespace="FashionAde.Core"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Outfit Updaters</title>
</asp:Content>

<asp:Content ID="contentOverlay" ContentPlaceHolderID="OverlayPlaceHolder" runat="server">
    <div class="modal" id="loading"> 
        <p>Loading... Please Wait</p> 
        <img src="http://l.yimg.com/a/i/us/per/gr/gp/rel_interstitial_loading.gif" />
    </div> 
 
    <input type="hidden" id="NoOne" />        
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

<div class="parentDiv">
<% using (Html.BeginForm("ChangePage", "OutfitUpdaters"))
   { %>
<input id="Page" name="Page" type="hidden" />
<input id="Id" name="Id" type="hidden" value="<%= ViewData["Id"] %>" />
<%} %>
    <h1 id="H1" style="margin-top:15px;">Outfit Updaters</h1>
    <h2 style="display: inline; float: left; width:240px;">This outfit updaters match with your combination.</h2>
    <%
        IList<FashionFlavor> flavors = (List<FashionFlavor>)ViewData["FashionFlavors"];
        if (flavors != null)
        { %>
                  <div class="GarmentSelector_FilterDiv_FashionFlavorSelected" style="float: right; margin-top: -40px; display: inline; width: 280px;">
                <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Title">Your Fashion Flavors:</span>
                <div class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box">
                    <center>
                    <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Title" ><%= flavors[0].Name%></span>
                    <img class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Image" src="<%= Resources.GetFashionFlavorThumbnailPath(flavors[0]) %>" alt="<%= flavors[0].Name %>"  />
                    </center>
                </div>
                <div class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box">
                    <center>
                    <% if (flavors.Count > 1)
                       {  %>
                    <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Title" ><%= flavors[1].Name%></span>
                    <img class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Image" src="<%= Resources.GetFashionFlavorThumbnailPath(flavors[1]) %>" alt="<%= flavors[1].Name %>"  />
                    <% } %>
                    </center>
                </div>
                <div style="clear: both" ></div>
            </div>          
        <% } %>
    <div style="clear: both; ">
        <div id="Div1" class="MyGarments_GarmentsDiv">
            <div>
                <div class="MyGarments_Panel" style="overflow-y:hidden;">
                    <% if(Model.Count > 0)
                        foreach (OutfitUpdater outfitUpdater in Model) { %>
                            <div class="Outfit_Result_Garment" style="margin: 5px 0px 15px 5px; height: 100px; width: 100px;">                                
                                <a href="<%= Url.Action("TrackOutfitUpdater", "OutfitUpdaters", new { updaterId = outfitUpdater.Id, updaterOutfitId = ViewData["closetOutfitId"], updaterBuyUrl = outfitUpdater.BuyUrl } ) %>" target="_blank">
                                    <img class="<%= "OutfitUpdaterImg_" + outfitUpdater.Partner.Code %>" src="<%= outfitUpdater.ImageUrl %>" alt="<%= outfitUpdater.Name + " u$s" + outfitUpdater.Price %>" title="<%= outfitUpdater.Name + " u$s" + outfitUpdater.Price%>" />
                                </a><br />
                                <span><%= outfitUpdater.Partner.Name%></span><br />
                                <% if (outfitUpdater.Price != null)
                                   {%>
                                <span style="color: black; font-weight: normal;"><%= Convert.ToDecimal(outfitUpdater.Price).ToString("$#,##0.00")%></span>
                                <%} %>
                            </div>
                        <%} 
                       else
{%>
   <span>Sorry, no other items like this one are available right now.</span> 
<%}%>
                    <div style="clear:both"></div>
                </div>
            </div>
            <% if(ViewData["Pages"] != null) Html.RenderPartial("Paging", ViewData["Pages"]); %>
        </div>
    </div>     
</div> 
<div id="Div2" class="MyGarments_OutfitDiv" style="width: 280px; padding-top:15px;">
    <% Html.RenderPartial("UpdaterTrends", ViewData["styleAlerts"]); %> 
</div>        

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/js/outfitUpdaters.js"></script>
</asp:Content>
