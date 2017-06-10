<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<FashionAde.Core.WishList>" %>
<%@ Import Namespace="FashionAde.Core"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>My Wish List</title>
</asp:Content>

<asp:Content ID="contentOverlay" ContentPlaceHolderID="OverlayPlaceHolder" runat="server">
    <div class="modal" id="RemoveConfirmation" style="opacity: 1;"> 
        <img src='/static/img/close.png' class='close close_Image' />    
        <center>
            <p>Are you sure to remove this item?</p> 
            <div id="btnRemove" class="divButton" >Yes </div><div class="divButton close" >No</div>
        </center>
    </div>
    
    <div class="modal" id="loading"> 
        <p>Adding garment to closet...</p>
        <img src="http://l.yimg.com/a/i/us/per/gr/gp/rel_interstitial_loading.gif" />
    </div> 
        
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

<div class="parentDiv">
    <h1 id="selectGarmetsTitle" style="margin-top:15px;">My Wish List</h1>
    <h2 style="display: inline; float: left; margin-bottom: 15px; margin-left: -255px; margin-top: 45px;">Add or remove garments to your closet.</h2>
    <%      
        IList<FashionFlavor> flavors = (List<FashionFlavor>)ViewData["FashionFlavors"];
             %>
            <div class="GarmentSelector_FilterDiv_FashionFlavorSelected" style="float: right; margin-top: 5px; display: inline; width: 280px;">
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
    <div style="clear: both; ">
        <div id="GarmentsDiv" class="MyGarments_GarmentsDiv">
            <div>
                <div class="MyGarments_Panel">
                    <% foreach (WishGarment wishGarment in Model.Garments) { %>
                            <div id="<%= "div_" + wishGarment.Garment.Id  %>" class="MyGarments_Garments" wishGarmentId="<%= wishGarment.Id %>">
                                <div class="MyGarment_Tooltip_Trash">
                                    <img class="trashIcon" src='/static/img/trash.png' alt='Close' style="display:none;"  />
		                        </div>
                                <center>                                        
                                    <img id="<%= "garment_" + wishGarment.Garment.Id %>" src="<%= Resources.GetGarmentPath(wishGarment.Garment) %>" desc="<%= wishGarment.Garment.Title%>" class="GarmentDragable" /><br />
                                    <span class="GarmentTitle"><%= wishGarment.Garment.Title %></span>                                    
                                </center>
                                <a id="g_<%= wishGarment.Garment.Id %>"  class="AddClosetLink" onclick="return false" style="color:#F38333; text-align:center; float:none; margin-right:0;">Add to Closet</a>
                            </div>
                        <%} %>
                    <div style="clear:both"></div>
                </div>
            </div>
        </div>
    </div>
    </div>
    
    <div id="FiltersDiv" class="MyGarments_OutfitDiv" style="width: 280px;">
        <% Html.RenderPartial("UpdaterTrends", ViewData["styleAlerts"]); %>         
    </div>

    <input type="hidden" id="wishListId" value="<%= Model.Id %>" /> 
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
    <script type="text/javascript" src='/static/lib/jquery.MetaData.js' language="javascript"></script>
    <script type="text/javascript" src="/static/js/wishList.js"></script>
</asp:Content>
