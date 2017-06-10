<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="FashionAde.Core.Views"%>
<%@ Import Namespace="FashionAde.Core"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>My Garments</title>
</asp:Content>

<asp:Content ID="contentOverlay" ContentPlaceHolderID="OverlayPlaceHolder" runat="server">
    <div class="modal" id="RemoveConfirmation" style="opacity: 1;"> 
        <img src='/static/img/close.png' class='close close_Image' />    
        <center>
            <p>Are you sure to remove this item?</p> 
            <div id="btnRemove" class="divButton" >Yes </div><div class="divButton close" >No</div>
        </center>
    </div>
        <input type="hidden" id="NoOne" />
    <div class="MyGarment_Modal" id="Details" style="">
        <img src='/static/img/close.png' class='close close_Image' />
        <h1>Garment Details:</h1>
        <h2 id="detailsTitle" style=" width: 400px; margin-bottom: 10px;"></h2>
        <div style="float: left; width: 100px;" >
        <center>
            <img id="PopUpImage"  />
            <span id="PopUpTitle" class="silouhetteDescription" style="float:left;"></span>
        </center>
        </div>
        <div style="float:left; width:510px;">
           <input id="ClosetGarmentId" name="ClosetGarmentId" type="hidden" />
            <table style="margin-bottom:0;">
                <tr>
                    <td class="text">I purchased this garment at:</td><td><%= Html.TextBox("PurchasedAt", null, new { @class = "inputField", maxlength = 100 })%></td>
                </tr>
                <tr>
                    <td class="text">I purchased this garment on:</td><td><%= Html.TextBox("PurchasedOn", null, new { @class = "inputField", maxlength = 10 })%></td>
                </tr>
                <tr>
                    <td class="text">My garment is made by:</td><td><%= Html.TextBox("MadeBy", null, new { @class = "inputField", maxlength = 100 })%></td>
                </tr>
                <tr>
                    <td class="text">My garment is made of:</td><td><%= Html.TextBox("MadeOf", null, new { @class = "inputField", maxlength = 100 })%></td>
                </tr>
                <tr>
                    <td class="text">I've had this garment tailored:</td><td><%= Html.RadioButton("IsTailored", true, true )%> Yes <%= Html.RadioButton("IsTailored", bool.FalseString)%> No</td>
                </tr>
                <tr>                        
                    <td class="text">How I care for this garment:</td><td><%= Html.TextArea("CareConditions", string.Empty, 4, 38, new { style = "background-color: #E1E5F1; border-color: #E1E5F1; height:70px;", @class = "inputField" })%></td>
                </tr>
                <tr>
                    <td class="text">How and where I store this garment:</td><td><%= Html.TextArea("StoreConditions", string.Empty, 4, 38, new { style = "background-color: #E1E5F1; border-color: #E1E5F1; height:70px;", @class = "inputField" })%></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><div id="btnUpdate" class="divButton">Save </div></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

<div class="parentDiv">
    <h1 id="selectGarmetsTitle" style="margin-top:15px;">My Garments</h1>
    <h2 style="display: inline; float:left; margin-bottom: 15px; margin-left: -255px; margin-top: 45px;">Review your garments and create your own outfit</h2>
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
            
            <!-- the tabs --> 

            <ul class="tabs"> 
	            <li style="margin-right:1px;"><a href="#">1. Pants, Jeans</a></li> 
	            <li style="margin-right:1px;"><a href="#">2. Skirts, Shorts</a></li> 
	            <li style="margin-right:1px;"><a href="#">3. Dresses</a></li> 
	            <li style="margin-right:1px;"><a href="#">4. Jackets</a></li> 
	            <li style="margin-right:1px;"><a href="#">5. Tops</a></li> 
	            <li style="margin-right:1px;"><a href="#">6. Accesories</a></li> 
            </ul>
            
	        <div class="panes"> 
	            <div style="display: none;" >
	                <div class="MyGarments_Panel">
                        <% foreach (WebClosetGarment closetGarment in (List<WebClosetGarment>)ViewData["pants_jeans"])
                            {
                            %>
                                <div id="<%= "div_" + closetGarment.Id %>" class="MyGarments_Garments" >
                                    <div class="MyGarment_Tooltip_Trash">
                                        <img class="trashIcon" src='/static/img/trash.png' alt='Close' style="display:none;"  />
			                        </div>
                                    <center>                                        
                                        <img id="<%= "garment_" + closetGarment.Id %>" src="<%= Resources.GetWebClosetGarmentPath(closetGarment) %>" cat="<%= closetGarment.CatId %>" desc="<%= closetGarment.Title %>" class="GarmentDragable" /><br />
                                        <span class="GarmentTitle"><%= closetGarment.Title %></span>
                                    </center>
                                    <a id="pantsAdd_<%= closetGarment.Id %>"  class="AddClosetLink" onclick="return false" style="color:#F38333;">Add to Outfit</a> 
                                    <a id="pantsDetails_<%= closetGarment.Id %>"  class="DetailLink" onclick="return false" style="color:#F38333;" cat="<%= closetGarment.CatId %>">Details</a>                                    
                                </div>
                            <%} %>
                        <div style="clear:both"></div>
                    </div>
	            </div> 
	            <div style="display: none;" >
	                <div class="MyGarments_Panel" >
                        <% foreach (WebClosetGarment closetGarment in (List<WebClosetGarment>)ViewData["skirts_shorts"])
                            {
                            %>
                                <div id="<%= "div_" + closetGarment.Id %>" class="MyGarments_Garments" >
                                    <div class="MyGarment_Tooltip_Trash">
                                        <img class="trashIcon" src='/static/img/trash.png' alt='Close' style="display:none;"  />
			                        </div>
                                    <center>
                                        <img id="<%= "garment_" + closetGarment.Id %>" src="<%= Resources.GetWebClosetGarmentPath(closetGarment) %>" cat="<%= closetGarment.CatId %>" desc="<%= closetGarment.Title %>" class="GarmentDragable" /><br />
                                        <span class="GarmentTitle"><%= closetGarment.Title %></span><br />
                                        <a id="skirtsAdd_<%= closetGarment.Id %>"  class="AddClosetLink" onclick="return false" style="color:#F38333;">Add to Outfit</a> 
                                        <a id="skirtsDetails_<%= closetGarment.Id %>"  class="DetailLink" onclick="return false" style="color:#F38333;" cat="<%= closetGarment.CatId %>">Details</a>
                                    </center>
                                </div>
                            <%} %>
                        <div style="clear:both"></div>
                    </div> 
	            </div> 
	            <div style="display: none;" >
	                <div class="MyGarments_Panel" >
                        <% foreach (WebClosetGarment closetGarment in (List<WebClosetGarment>)ViewData["dresses"])
                            {
                            %>
                                <div id="<%= "div_" + closetGarment.Id %>" class="MyGarments_Garments" >
                                    <div class="MyGarment_Tooltip_Trash">
                                        <img class="trashIcon" src='/static/img/trash.png' alt='Close' style="display:none;"  />
			                        </div>
                                    <center>
                                        <img id="<%= "garment_" + closetGarment.Id %>" src="<%= Resources.GetWebClosetGarmentPath(closetGarment) %>" cat="<%= closetGarment.CatId %>" desc="<%= closetGarment.Title %>" class="GarmentDragable" /><br />
                                        <span class="GarmentTitle"><%= closetGarment.Title %></span><br />
                                        <a id="dressesAdd_<%= closetGarment.Id %>"  class="AddClosetLink" onclick="return false" style="color:#F38333;">Add to Outfit</a> 
                                        <a id="dressesDetails_<%= closetGarment.Id %>"  class="DetailLink" onclick="return false" style="color:#F38333;" cat="<%= closetGarment.CatId %>">Details</a>
                                    </center>
                                </div>
                            <%} %>
                        <div style="clear:both"></div>
                    </div> 
	            </div> 
	            <div style="display: none;" >
	                <div class="MyGarments_Panel" >
                        <% foreach (WebClosetGarment closetGarment in (List<WebClosetGarment>)ViewData["jackets"])
                            {
                            %>
                                <div id="<%= "div_" + closetGarment.Id %>" class="MyGarments_Garments" >
                                    <div class  ="MyGarment_Tooltip_Trash">
                                        <img class="trashIcon" src='/static/img/trash.png' alt='Close' style="display:none;"  />
			                        </div>
                                    <center>
                                        <img id="<%= "garment_" + closetGarment.Id %>" src="<%= Resources.GetWebClosetGarmentPath(closetGarment) %>" cat="<%= closetGarment.CatId %>" desc="<%= closetGarment.Title %>" class="GarmentDragable" /><br />
                                        <span class="GarmentTitle"><%= closetGarment.Title %></span><br />
                                        <a id="jacketsAdd_<%= closetGarment.Id %>"  class="AddClosetLink" onclick="return false" style="color:#F38333;">Add to Outfit</a> 
                                        <a id="jacketsDetails_<%= closetGarment.Id %>"  class="DetailLink" onclick="return false" style="color:#F38333;" cat="<%= closetGarment.CatId %>">Details</a>
                                    </center>
                                </div>
                            <%} %>
                        <div style="clear:both"></div>
                    </div> 
	            </div> 
	            <div style="display: none;" >
	                <div class="MyGarments_Panel" >
                        <% foreach (WebClosetGarment closetGarment in (List<WebClosetGarment>)ViewData["tops"])
                            {
                            %>
                                <div id="<%= "div_" + closetGarment.Id %>" class="MyGarments_Garments" >
                                    <div class="MyGarment_Tooltip_Trash">
                                        <img class="trashIcon" src='/static/img/trash.png' alt='Close' style="display:none;"  />
			                        </div>
                                    <center>
                                        <img id="<%= "garment_" + closetGarment.Id %>" src="<%= Resources.GetWebClosetGarmentPath(closetGarment) %>" cat="<%= closetGarment.CatId %>" desc="<%= closetGarment.Title %>" class="GarmentDragable" /><br />
                                        <span class="GarmentTitle"><%= closetGarment.Title %></span><br />
                                        <a id="topsAdd_<%= closetGarment.Id %>"  class="AddClosetLink" onclick="return false" style="color:#F38333;">Add to Outfit</a> 
                                        <a id="topsDetails_<%= closetGarment.Id %>"  class="DetailLink" onclick="return false" style="color:#F38333;" cat="<%= closetGarment.CatId %>">Details</a>
                                    </center>
                                </div>
                            <%} %>
                        <div style="clear:both"></div>
                    </div> 
	            </div> 
	            <div style="display: none;" >
	                <div class="MyGarments_Panel" >
                        <% foreach (WebClosetGarment closetGarment in (List<WebClosetGarment>)ViewData["accesories"])
                            {
                            %>
                                <div id="<%= "div_" + closetGarment.Id %>" class="MyGarments_Garments" >
                                    <div class="MyGarment_Tooltip_Trash">
                                        <img class="trashIcon" src='/static/img/trash.png' alt='Close' style="display:none;"  />
			                        </div>
                                    <center>
                                        <img id="<%= "garment_" + closetGarment.Id %>" src="<%= Resources.GetWebClosetGarmentPath(closetGarment) %>" desc="<%= closetGarment.Title %>" cat="<%= closetGarment.CatId %>" class="GarmentDragable" /><br />
                                        <span class="GarmentTitle"><%= closetGarment.Title %></span><br />
                                        <a id="accAdd_<%= closetGarment.Id %>"  class="AddClosetLink" onclick="return false" style="color:#F38333;">Add to Outfit</a> 
                                        <a id="accDetails_<%= closetGarment.Id %>"  class="DetailLink" onclick="return false" style="color:#F38333;" cat="<%= closetGarment.CatId %>">Details</a>
                                    </center>
                                </div>
                            <%} %>
                        <div style="clear:both"></div>
                    </div> 
	            </div> 	
            </div>   
        </div>
	         
        </div>
    </div>
    
    <div id="FiltersDiv" class="MyGarments_OutfitDiv" style="width: 280px;">
        <div class="createOutfitDropable" style="float: left;">
                <div class="createYourOutfitTitle">  
                    <div>
                        <span>Create Your Own Outfit</span>                    
                    </div>                    
                </div>   
                
                <div class="outfitDisplay" style="display:none;">
                    <img id="imgOutfitUp" src="/static/img/MyGarments/outfit_up.jpg" /> Forward
                    <img id="imgOutfitDown" src="/static/img/MyGarments/outfit_down.jpg" style="margin-left:10px;" /> Back
                </div>                
                
                <div id="MyOutfitDroppable" class="outfitDropable">                
                    <div id="garmentContainment" class="dragGarmentsMessage" >
                        <span id="garmentsMessage">Drag your garments here</span>                
                    </div>                    
                    <div class="createYourOutfitBottom" >                        
                        <div>
                            <%= Html.DropDownList("ddlSeasons", (List<SelectListItem>)ViewData["Seasons"], "Select...") %>
                            <% =Html.RadioButton("PrivacyStatus",  true, true, new { id = "PrivacyStatusPublic" })%> Save to Public Closet<br />
                            <% =Html.RadioButton("PrivacyStatus", false, false, new { id = "PrivacyStatusPrivate" })%> Save to Private Closet
                        </div>                                    
                        <div id="btnSaveUserOutfit" class="divButtonBig">SAVE TO OUTFITS</div>
                    </div>                
                </div>
            </div>
        </div>        
    
 
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/js/myGarments.js"></script>
</asp:Content>