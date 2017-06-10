<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<GarmentsListData>" %>
<%@ Import Namespace="FashionAde.Core"%>
<%@ Import Namespace="FashionAde.Core.Clothing"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<input id="hidMyGarmentsSelected" type="hidden" name="hidMyGarmentsSelected" />
<input id="hidMyWishListSelected" type="hidden" name="hidMyWishListSelected" />

<div class="parentDiv">

    <%
        Html.BeginForm(Model.Action, Model.Controller, FormMethod.Post,
                       new {@id = "frmNext", onSubmit = "apiOverlay.load();"}); %>

    <%
           string myGarmentsItems = "";
           string myWishListItems = "";
           if (!string.IsNullOrEmpty(Model.MyGarmentsIds) || !string.IsNullOrEmpty(Model.NewGarmentsIds))
               myGarmentsItems = Model.MyGarmentsIds + "," + Model.NewGarmentsIds;
           if (!string.IsNullOrEmpty(Model.MyWishGarmentsIds) ||
               !string.IsNullOrEmpty(Model.NewWishGarmentsIds))
               myWishListItems = Model.MyWishGarmentsIds + "," + Model.NewWishGarmentsIds;
    %>  
    <input id="hidSilouhetteId" type="hidden" value="<%= Model.SilouhetteId %>" />
    <input id="hidPatternId" type="hidden" value="<%= Model.PatternId %>" />
    <input id="hidFabricId" type="hidden" value="<%= Model.FabricId %>" />
    <input type="hidden" id="myGarmentsItems" name="myGarmentsItems" value="<%=myGarmentsItems%>" />
    <input type="hidden" id="myWishListItems" name="myWishListItems" value="<%=myWishListItems%>" />
    
    <div style="width: 690px; float: left;">
        <div class="garmenttooltip">
            <div class="garmenttooltip_buttons_zone">
                <div id="btnAddToGarment" class="garmenttooltip_buttons" style=" top:16px; left:5px;">Add to My Garments</div>
                <div id="btnAddToWishList" class="garmenttooltip_buttons" style="top:38px; left:5px;">Add to My Wish List</div>
            </div>
        </div> 
        <% if (!Model.ForEdit)
           {%>
            <h1 id="selectGarmetsTitle" style="background:none; margin:15px 0 0 0; padding:0;">Select your Garments</h1>
            <img id="imgOtherWomen" src="/static/img/BuildYourCloset/other_women.gif" alt="" style="margin: 20px 4px 4px;" />
            <img id="img1" src="/static/img/BuildYourCloset/arrow.gif" alt="" style="margin-top:30px;" />
        <%}
           else
           { %>
            <h1 id="H1" style="margin-top:15px;">Add from our Master Closet</h1>
           <%} %>
            <h2 style="float:left; color:#000; margin:0 0 10px 0; width:100%;">Just click on a garment, choose it in the color you own and drag that piece into your closet.</h2> <br /><h2 style="color: #476BA9; float:left; margin: -20px 0 0 0; width:100%;">Yes, it’s that easy!</h2>
    
        <div id="GarmentsDiv" class="GarmentSelector_GarmentsDiv">            
            
            <!-- the tabs --> 
            <ul class="tabs"> 
	            <li><a href="#">1. Pants, Jeans</a></li> 
	            <li><a href="#">2. Skirts, Shorts</a></li> 
	            <li class="smallTab"><a href="#" style="width: 82px;">3. Dresses</a></li> 
	            <li class="smallTab"><a href="#" style="width: 82px;">4. Jackets</a></li> 
	            <li class="smallTab"><a href="#" style="width: 82px;">5. Tops</a></li> 
	            <li class="smallTab"><a href="#" style="width: 82px;">6. Shoes</a></li> 
	            <li><a href="#" style="width: 110px;">7. Accesories</a></li> 
            </ul>
             
             
            <!-- tab "panes" --> 
            <div class="panes"> 
	            <div></div> 
	            <div></div> 
	            <div></div> 
	            <div></div> 
	            <div></div> 
	            <div></div> 
	            <div></div> 	
            </div>   


            <div class="sliderDiv"> 
                <a class="prevPage browse left"></a>     
                    <div id="divGarmetsScroll" class="scrollable">                
                        <div class="items">
                            <%  foreach (Silouhette silouhette in Model.Silouhettes)                             
                                {%>                                
                                <div id="divSil_<%= silouhette.Id %>"  class="silouhettesContainer" >
                                    <img id="si_<%= silouhette.Id %>" src="<%= Resources.GetSilouhettePath(silouhette) %>" class="Silouhettes" rel="#loading" cat="<%= silouhette.Category.Id %>" />
                                    <span class="silouhetteDescription"><%= silouhette.Description %></span> 
                                </div>
                                <%} %>
                        </div> 
                    </div>    
                <a class="nextPage browse right"></a>
            </div> 
            <div style="background-color: #E4E4E4; height: 35px; margin-top: 5px; margin-bottom: 5px; border: 1px solid #3F669D; position: relative;">
                <span style="background-color: #3F669D; color: white; display: block; float: left; font-size: 15px; height: 27px; padding: 8px 10px 0px 5px;">Filter by</span>
                <img src="/static/img/trinangulo.jpg" style="position: absolute; top: 11px; left: 62px;" />
                <div class="GarmentSelector_Filter" style="width:115px;">
                    <span class="GarmentSelector_Filter_Text">Patterns:</span>
                    <div id="PatternFilters" style="display: block; width: 405px; float: left; margin-left: 63px; margin-top: -32px; height: 47px;  ">
                        <%
                        foreach (Pattern pattern in Model.Patterns)
                        {
                            string patternClass = pattern.Description == "Solid" ? "PatternSelected" : "Pattern";
                            %>
                            <img class="<%= patternClass %>" id="p_<%= pattern.Id %>" src="<%= Resources.GetPatternPath(pattern) %>" alt="<%= pattern.Description %>" title="<%= pattern.Description %>" />
                        <%} %>
                    </div>
                </div>
                <div class="GarmentSelector_Filter" style="float: right; border-left: solid 2px #D9D9D9; height: 32px; margin-top: 0px; padding-top: 3px;">
                    <span class="GarmentSelector_Filter_Text">Fabrics:</span><div style="border: solid 1px white; background-color: White; height: 21px; float:left; margin-left: 8px; margin-right: 2px; margin-top: 4px;"><span id="FabSelected" style="float:left; margin-top: 2.5px; color: #656565; width: 70px;"></span><a id="cbpFabrics"  onclick="return false" class="garmetSelectorCombo" style="margin: 0 0 0 0;"><img src="/static/img/fabric-dropdown.jpg" alt="" /></a></div>
                    <div id="FabricFilters" class="GarmentSelector_Filter_Items editList" style="max-height: 200px; top: 20px; left: -23px; margin-left: 72px;">
                        <%
                        foreach (Fabric fabric in Model.Fabrics)
                        {
                            string fabricClass = fabric.Id == Convert.ToInt32(Model.FabricId) ? "FabricSelected" : "Fabric";
                            %>
                            
                            <span class="<%= fabricClass %>" id="f_<%= fabric.Id %>"><%= fabric.Description %></span><br />
                        <%} %>
                    
                    </div>
                </div>
            </div>
            <div id="GarmentsResults" >
                <% foreach (MasterGarment garment in Model.Garments)
                    {
                    %>
                        <div id="<%= garment.Id %>" class="GarmentDragable GarmentSelector_Garments" >
                            <img id="<%= garment.Id %>" src="<%= Resources.GetGarmentLargePath(garment) %>" desc="<%= garment.Title %>" />
                        </div>
                    <%} %>
            </div>            
            
        </div>
        
        <div style="clear: both;" ></div>
        <div id="divBuildBottom" class="divBuildBottom">
                <%
                       if (!Model.ForEdit)
                       {%>
                <a class="centerDiv nextStep divButtonBig" style="clear:none; float: left; margin-bottom: 10px; margin-left: 150px; " href="<%=Url.RouteUrl(new {controller = "EventTypeSelector", action = "Index"})%>" >PREVIOUS</a>
                <div id="btnNext" class="centerDiv nextStep divButtonBig" style="clear:none; float: right; margin-bottom: 10px; margin-right: 150px;" >NEXT</div>
                
                <%
                       }
                 %>
                
                <input type="hidden" id="NewGarmentsItems" name="NewGarmentsItems" value="<%= Model.NewGarmentsIds %>"/>
                <input type="hidden" id="NewWishListItems" name="NewWishListItems" value="<%= Model.NewWishGarmentsIds %>"/>
            </div>
        
    </div>
    <div id="FiltersDiv" class="GarmentSelector_FiltersDiv">
            <% if (!Model.ForEdit)
           {%><img src="/static/img/BuildYourCloset/step2.gif" alt="" style="float:left; margin-right:5px; margin-bottom: 5px;" /><%}
               else
     {%>
        <% Html.RenderPartial("UpdaterTrends", ViewData["styleAlerts"]); %>  
     <%}%>
    
            
            <%if (!Model.ForEdit)
           {%>
                <div class="GarmentSelector_FilterDiv_FashionFlavorSelected">
                    <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Title">Your Fashion Flavors:</span>
                <div class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box">
                    <center>
                    <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Title" ><%= Model.FashionFlavors[0].Name %></span>
                    <img class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Image" src="<%= Resources.GetFashionFlavorThumbnailPath(Model.FashionFlavors[0]) %>" alt="<%= Model.FashionFlavors[0].Name %>"  />
                    </center>
                </div>
                <div class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box">
                    <center>
                    <% if (Model.FashionFlavors.Count > 1){  %>
                    <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Title" ><%= Model.FashionFlavors[1].Name%></span>
                    <img class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Image" src="<%= Resources.GetFashionFlavorThumbnailPath(Model.FashionFlavors[1]) %>" alt="<%= Model.FashionFlavors[1].Name %>"  />
                    <% } %>
                    </center>
                </div>
                <div style="clear: both" ></div>
            </div>
            <%} %>
                
            
            <div class="GarmentListBox">
                <span style="color: Black; font-size: 17px; margin-bottom: 5px;">Don't see a garment you're  looking for?</span><br />
                <span style="font-weight: Normal; color: Black; font-size: 11px;">Tell us and we'll <a href="<%= Url.RouteUrl(new { controller = "ContactUs", action= "Index"}) %>" target="_blank">add it</a><br />
                You can personalize them or upload your garments later.</span>
            </div> 

        <div class="GarmentListClosetWishlistContainer">
            <div style="width: 160px; margin-right: auto; margin-left: auto; margin-top: 15px; margin-bottom: 15px; color: #BDCFDB; font-size: 11px; font-weight: bold; text-align: center;">Drag colorized garments here to store them in your <span style="color: White; font-size: 11px;">Closet</span> or your <span style="color: White; font-size: 11px;">Wish List</span></div>
            <div id="MyGarmentsDroppable" class="GarmentSelector_DropableArea" style="z-index:100">
                            
                <img src="/static/img/BuildYourCloset/mygarments.jpg" class="GarmentSelector_DropableArea_Image" alt="" />
                <span class="GarmentSelector_DropableArea_Text" style="margin:5px 8px 0 0;">My Garments</span>
                <a id="cboEditMyGarnets"  onclick="return false" class="garmetSelectorCombo"><img src="/static/img/new-dropdown.jpg" alt="" /></a>
                                
                <span class="GarmentSelector_DropableArea_Total">Total:</span>
                <span id="MyGarmentCount" class="GarmentSelector_DropableArea_Count"><%= Model.MyGarments.Count + Model.NewGarments.Count %></span>                
                
                <div class="dragYourGarmentsHere"><img src="/static/img/BuildYourCloset/drag.png" /><span>DRAG YOUR GARMENTS HERE!</span></div>                
                <div id="divEditGarments" class="editList" style="top:64px; left:-1px; max-height: 300px;"> 
                 <% foreach(ClosetGarment garment in Model.MyGarments)
    {
        string id = "divGarment" + garment.Garment.Id;
        string div = "<div id='" + id + "' class='Garment_Item_Box'>";
        div += "<div class='Garment_Item_Box_Image'><center><img src='" + Resources.GetGarmentLargePath(garment.Garment) + "' /></center></div>";
        div += "<div class='Garment_Item_Box_Clear'></div></div>"; 
                        %><%= div %>
    <%} %>   
    <% foreach(Garment garment in Model.NewGarments)
    {
        string id = "divGarment" + garment.Id;
        string div = "<div id='" + id + "' class='Garment_Item_Box'>";
        div += "<div class='Garment_Item_Box_Image'><center><img src='" + Resources.GetGarmentLargePath(garment) + "' /></center></div>";
        div += "<div class='Garment_Item_Box_Clear'><img id='erase_" + garment.Id + "' src='/static/img/remove_item.jpg' class='removeSelected' /></div></div>"; 
                        %><%= div %>
    <%} %>
                </div>
            </div>
            
            <div id="MyWishListDropable" class="GarmentSelector_DropableArea" >
                <img src="/static/img/BuildYourCloset/mywishlist.jpg" class="GarmentSelector_DropableArea_Image" alt="" />
                <span class="GarmentSelector_DropableArea_Text" style="margin:5px 22px 0 0;">My Wish List</span>
                <a id="cboEditMyWishList"  onclick="return false" class="garmetSelectorCombo"><img src="/static/img/new-dropdown.jpg" alt="" /></a>
                
                <span class="GarmentSelector_DropableArea_Total">Total:</span>
                <span id="MyWishListCount" class="GarmentSelector_DropableArea_Count"><%= Model.MyWishGarments.Count + Model.NewWishGarments.Count %></span>
                
                <div class="dragYourGarmentsHere"><img src="/static/img/BuildYourCloset/drag.png" /><span>DRAG YOUR GARMENTS HERE!</span></div>
                <div id="divEditMyWishList" class="editList" style="top:64px; left:-1px; max-height: 300px;">                
                    <% foreach(WishGarment garment in Model.MyWishGarments)
    {
        string id = "divGarment" + garment.Garment.Id;
        string div = "<div id='" + id + "' class='Garment_Item_Box'>";
        div += "<div class='Garment_Item_Box_Image'><center><img src='" + Resources.GetGarmentLargePath(garment.Garment) + "' /></center></div>";
        div += "<div class='Garment_Item_Box_Clear'></div></div>"; 
                        %><%= div %>
    <%} %>
    <% foreach(Garment garment in Model.NewWishGarments)
    {
        string id = "divGarment" + garment.Id;
        string div = "<div id='" + id + "' class='Garment_Item_Box'>";
        div += "<div class='Garment_Item_Box_Image'><center><img src='" + Resources.GetGarmentLargePath(garment) + "' /></center></div>";
        div += "<div class='Garment_Item_Box_Clear'><img id='erase_" + garment.Id + "' src='/static/img/remove_item.jpg' class='removeSelected' /></div></div>"; 
                        %><%= div %>
    <%} %>
                </div>
            </div>            
        </div>
        
        <% if (Model.ForEdit)
           {%>
           <div style="clear:both;padding-top: 10px;">
                <div id="btnNext" class="divButtonBig">SAVE</div>
           </div>
        <% }%>

        </div>
     
    <% Html.EndForm(); %>
</div> 

