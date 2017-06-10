<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<List<FashionFlavor>>" %>
<%@ Import Namespace="FashionAde.Core"%>
<%@ Import Namespace="FashionAde.Core.Clothing"%>
<%@ Import Namespace="FashionAde.Data.Repository"%>
<%@ Import Namespace="FashionAde.Core.FlavorSelection"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<input id="hidMyGarmentsSelected" type="hidden" name="hidMyGarmentsSelected" />
<input id="hidMyWishListSelected" type="hidden" name="hidMyWishListSelected" />

<div class="parentDiv">
    <div class="garmenttooltip" style=" ">
        <div class="garmenttooltip_buttons_zone">
            <div id="btnAddToGarment" class="garmenttooltip_buttons" style=" top:16px; left:5px;">Add to My Garments</div>
            <div id="btnAddToWishList" class="garmenttooltip_buttons" style="top:38px; left:5px;">Add to My Wish List</div>
        </div>
    </div> 
    <h1 id="selectGarmetsTitle" style="margin-top:15px;">Select your Garments</h1>
    <img id="imgOtherWomen" src="../../img/BuildYourCloset/other_women.gif" alt="" style="margin:20px 4px 0 10px;" />
    <img id="img1" src="../../img/BuildYourCloset/arrow.gif" alt="" style="margin-top:30px;" />
    <img src="../../img/BuildYourCloset/step2.gif" alt="" style="float:right;" />     
    <h2 style="float: left; color: Black; margin-left: -248px;margin-bottom: 15px;">Choose a silhouette you own and drag your colored garments to your closet</h2>
    <div style="clear: both; ">
        <div id="GarmentsDiv" class="GarmentSelector_GarmentsDiv">            
            
            <!-- the tabs --> 

            <ul class="tabs"> 
	            <li><a href="#">1. Pants, Jeans</a></li> 
	            <li><a href="#">2. Skirts, Shorts</a></li> 
	            <li><a href="#">3. Dresses</a></li> 
	            <li><a href="#">4. Jackets</a></li> 
	            <li><a href="#">5. Tops</a></li> 
	            <li><a href="#">6. Accesories</a></li> 
            </ul>
             
             
            <!-- tab "panes" --> 
            <div class="panes"> 
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
                            <%  foreach (Silouhette silouhette in (List<Silouhette>) ViewData["Silouhettes"])                             
                                {%>                                
                                <div id="divSil<%= silouhette.Id %>"  class="silouhettesContainer" >
                                    <img id="si<%= silouhette.Id %>" src="<%= Resources.GetSilouhettePath(silouhette) %>" class="Silouhettes" rel="#loading" cat="<%= silouhette.Category.Id %>" />
                                    <span class="silouhetteDescription"><%= silouhette.Description %></span> 
                                </div>
                                <%} %>
                        </div> 
                    </div>    
                <a class="nextPage browse right"></a>
            </div> 
            <div style="background-color: #F4F4F4; height: 50px; margin-top: 5px; margin-bottom: 5px; border: 1px solid lightGrey;">
                <span style="color:#F38333; float: left; margin-left: 15px; display:inline; font-size: 19px; margin-top: 11px;">Review with another pattern or texture:</span>
                <div class="GarmentSelector_Filter" style="width:135px;">
                    <span class="GarmentSelector_Filter_Text">Patterns</span><img id="PatSelected" style="float: left; margin-left: 2px; margin-right: 2px;"></img><a id="cboPatterns" href="" onclick="return false" class="garmetSelectorCombo"><img src="../../img/dropdown.jpg" alt="" /></a>
                    <div id="PatternFilters" class="GarmentSelector_Filter_Items editList" style="left: 15px; max-height: 200px; top: 20px; width: 50px;">
                        <%  
                        string patternClass;
                        foreach (Pattern pattern in (IList<Pattern>) ViewData["Patterns"])
                        {
                            if(pattern.Description == "Solid")
                                patternClass = "PatternSelected";
                            else patternClass = "Pattern";
                            %>
                            <img class="<%= patternClass %>" id="p_<%= pattern.Id %>" src="<%= Resources.GetPatternPath(pattern) %>" alt="<%= pattern.Description %>" title="<%= pattern.Description %>" />
                        <%} %>
                    </div>
                </div>
                <div class="GarmentSelector_Filter" >
                    <span class="GarmentSelector_Filter_Text">Fabrics</span><span id="FabSelected" style="float:left; margin-left: 8px; margin-right: 2px; margin-top: 7px;"></span><a id="cbpFabrics" href="" onclick="return false" class="garmetSelectorCombo"><img src="../../img/dropdown.jpg" alt="" /></a>
                    <div id="FabricFilters" class="GarmentSelector_Filter_Items editList" style="max-height: 200px; top: 20px; left: -23px; margin-left: 72px;">
                        <%
                        string fabricClass;
                        foreach (Fabric fabric in (IList<Fabric>) ViewData["Fabrics"])
                        {
                            if (fabric.Id == Convert.ToInt32(ViewData["FabricId"]))
                                fabricClass = "FabricSelected";
                            else fabricClass = "Fabric";
                            %>
                            
                            <span class="<%= fabricClass %>" id="f_<%= fabric.Id %>"><%= fabric.Description %></span><br />
                        <%} %>
                    
                    </div>
                </div>
            </div>
            <div id="GarmentsResults" style="clear:both; " >
                <% foreach (Garment garment in ViewData["Garments"] as List<Garment>)
                    {
                    %>
                        <div id="<%= garment.Id %>" class="GarmentDragable GarmentSelector_Garments" >
                            <img id="<%= garment.Id %>" src="<%= Resources.GetGarmentPath(garment) %>" desc="<%= garment.Title %>" />
                        </div>
                    <%} %>
            </div>            
            
        </div>
        <div id="FiltersDiv" class="GarmentSelector_FiltersDiv">
            <div class="GarmentSelector_FilterDiv_FashionFlavorSelected">
                <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Title">Your Fashion Flavors:</span>
                <div class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box">
                    <center>
                    <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Title" ><%= Model[0].Name %></span>
                    <img class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Image" src="<%= Resources.GetFashionFlavorThumbnailPath(Model[0]) %>" alt="<%= Model[0].Name %>"  />
                    </center>
                </div>
                <div class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box">
                    <center>
                    <% if (Model.Count > 1){  %>
                    <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Title" ><%= Model[1].Name%></span>
                    <img class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Image" src="<%= Resources.GetFashionFlavorThumbnailPath(Model[1]) %>" alt="<%= Model[1].Name %>"  />
                    <% } %>
                    </center>
                </div>
            </div>
            
            <div style="width:83px; margin-top:10px; margin-bottom:20px; ">
                <img src="../../img/BuildYourCloset/itm_drag_items.jpg" style="" />
            </div> 

            <div id="MyGarmentsDroppable" class="GarmentSelector_DropableArea">
                            
                <img src="../../img/BuildYourCloset/mygarments.jpg" class="GarmentSelector_DropableArea_Image" alt="" />
                <span class="GarmentSelector_DropableArea_Text" style="margin:5px 8px 0 0;">My Garments</span>
                <a id="cboEditMyGarnets" href="" onclick="return false" class="garmetSelectorCombo"><img src="../../img/dropdown.jpg" alt="" /></a>
                                
                <span class="GarmentSelector_DropableArea_Total">Total:</span>
                <span id="MyGarmentCount" class="GarmentSelector_DropableArea_Count">0</span>                
                
                <div class="dragYourGarmentsHere"><img src="../../img/BuildYourCloset/img_drag_arrow.jpg" /><span>Drag your garments here!</span></div>                
                <div id="divEditGarments" class="editList" style="top:64px; left:-1px; max-height: 300px;"> 
                    
                </div>
            </div>
            
            <div id="MyWishListDropable" class="GarmentSelector_DropableArea" >
                <img src="../../img/BuildYourCloset/mywishlist.jpg" class="GarmentSelector_DropableArea_Image" alt="" />
                <span class="GarmentSelector_DropableArea_Text" style="margin:5px 22px 0 0;">My Wish List</span>
                <a id="cboEditMyWishList" href="" onclick="return false" class="garmetSelectorCombo"><img src="../../img/dropdown.jpg" alt="" /></a>
                
                <span class="GarmentSelector_DropableArea_Total">Total:</span>
                <span id="MyWishListCount" class="GarmentSelector_DropableArea_Count">0</span>
                
                <div class="dragYourGarmentsHere"><img src="../../img/BuildYourCloset/img_drag_arrow.jpg" /><span>Drag your garments here!</span></div>
                <div id="divEditMyWishList" class="editList" style="top:64px; left:-1px; max-height: 300px;">                
                    
                </div>
            </div>            
            
            <div class="divBuildBottom">
                <% using (Html.BeginForm("GoToRegistration", "BuildYourCloset")) { %>  
                <input type="hidden" id="myGarmentsItems" name="myGarmentsItems" />
                <input type="hidden" id="myWishListItems" name="myWishListItems" />            
                <input id="btnNext" type="image" src="../../img/BuildYourCloset/button_next.gif" value="Next" class="centerDiv nextStep" style="padding-top:10px;" />
                <%} %>
            </div>
                    
        </div>    
        <input id="hidSilouhetteId" type="hidden" value="<%= ViewData["SilouhetteId"] %>" />
        <input id="hidPatternId" type="hidden" value="<%= ViewData["PatternID"] %>" />
        <input id="hidFabricId" type="hidden" value="<%= ViewData["FabricId"] %>" />
        
    </div>
</div> 

<div class="modal" id="loading"> 
    <p>Loading... Please Wait</p> 
    <img src="http://l.yimg.com/a/i/us/per/gr/gp/rel_interstitial_loading.gif" />
</div> 
 <input type="hidden" id="NoOne" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="<%= Url.Content("~/js/jquery.toJSON.js") %>"></script>
<script type="text/javascript">
    Array.prototype.exists = function(o) {
        for(var i = 0; i < this.length; i++)
           if(this[i] === o)
             return true;
        return false;
    }
    
    var myGarmentsItems = new Array();
    var myWishListItems = new Array();
    var pattern = 0;
    var fabric = 0;
    var silouhette = 0;
    var garmentselected = 0;
    var apiOverlay;
    var apiTooltip;
    var apiSlider;
    var apiTabs;

    $(document).ready(function() {
        //****** Events ******
        $('.Silouhettes').click(function(e) {
            apiOverlay.load();
            silouhette = parseInt(this.id.substring(2));
            fabric = 0;
            pattern = 0;
            
            if ($('#FabricFilters').is(':visible'))
                $('#FabricFilters').slideToggle();
                
            if ($('#PatternFilters').is(':visible'))
                $('#PatternFilters').slideToggle();
                        
            GetSilouhette();
            Search();
        });

        $('.Fabric').click(FabricsFunctions);
        $('.FabricSelected').click(FabricsFunctions);

        $('.Pattern').click(PatternsFunctions);
        $('.PatternSelected').click(PatternsFunctions);

        $('#btnAddToGarment').click(function(e) {
            AddToMyGarment(garmentselected, $('#' + garmentselected))
            apiTooltip.hide();
        });

        $('#btnAddToWishList').click(function(e) {
            AddToMyWishList(garmentselected, $('#' + garmentselected))
            apiTooltip.hide();
        });

        $('#btnNext').click(function(e) {
            if ($('#divEditGarments')[0].childNodes.length == 0 && $('#divEditMyWishList')[0].childNodes.length == 0) {
                e.preventDefault();
                showMessage("You must add at least one garment to continue.");
            }
        });

        $('#cboEditMyGarnets').click(function(e) {
            if ($('#divEditGarments')[0].childNodes.length > 0)
                $('#divEditGarments').slideToggle();

            if ($('#divEditMyWishList').is(':visible'))
                $('#divEditMyWishList').slideToggle();
        });

        $('#cboEditMyWishList').click(function(e) {
            if ($('#divEditMyWishList')[0].childNodes.length > 0)
                $('#divEditMyWishList').slideToggle();

            if ($('#divEditGarments').is(':visible'))
                $('#divEditGarments').slideToggle();

        });

        $('#cboPatterns').click(function(e) {
            if ($('#PatternFilters')[0].childNodes.length > 0)
                $('#PatternFilters').slideToggle();

            if ($('#FabricFilters').is(':visible'))
                $('#FabricFilters').slideToggle();
        });

        $('#cbpFabrics').click(function(e) {
            if ($('#FabricFilters')[0].childNodes.length > 0)
                $('#FabricFilters').slideToggle();

            if ($('#PatternFilters').is(':visible'))
                $('#PatternFilters').slideToggle();
        });

        $('.nextPage .prevPage').click(function(e) {
            clickedTab = false;
        });


        $('.items').click(function(e) {
            $(".GarmentDragable").fadeTo("middle", 0.5);
        });

        //****** Drag and Drop******
        ApplyFunctionsToGarments();

        $("#divMyGarnets").droppable({
            drop: function(event, ui) {
                $(this).addClass('changeColor');
            }
        });

        $("#MyGarmentsDroppable").droppable({
            drop: function(event, ui) {
                AddToMyGarment(ui.draggable[0].id, ui.draggable);
            }
        });

        $("#MyWishListDropable").droppable({
            drop: function(event, ui) {
                AddToMyWishList(ui.draggable[0].id, ui.draggable);
            }
        });

        //****** Loading ******
        apiOverlay = $("#NoOne").overlay({
            // some expose tweaks suitable for modal dialogs 
            expose: {
                color: '#333',
                loadSpeed: 200,
                opacity: 0.3
            },
            target: "#loading",
            left: 350,
            top: "center",
            api: true,
            closeOnClick: false
        });

        //****** Slider ******
        apiSlider = $("#divGarmetsScroll").scrollable({ size: 4 }).mousewheel({ api: true, size: 3 });
        apiSlider.click(0); //Select first item by default
        apiSlider.onSeek(function(e, index) {
            var items = this.getVisibleItems();
            var cat = getCategoryFromItem(items[0]);
            setTab(cat);
        });


        //****** Tabs ******
        apiTabs = $("ul.tabs").tabs("div.panes > div",
            {
                api: true,
                onClick: function(event, tabIndex) {
                    if (event.originalEvent)
                        setSlider(tabIndex);
                }
            });

        //****** Inialization *****
        fabric = $("#hidFabricId").val();
        silouhette = $("#hidSilouhetteId").val();
        pattern = $("#hidPatternId").val();


        $("#FabSelected").text($(".FabricSelected").text());
        $("#PatSelected").attr("src", $(".PatternSelected").attr("src"));
        
        
        
        $('#FabricFilters').bind("mouseleave", function(e) {
            if ($('#FabricFilters').is(':visible'))
                $('#FabricFilters').slideToggle();
        });
        
        $('#PatternFilters').bind("mouseleave", function(e) {
            if ($('#PatternFilters').is(':visible'))
                $('#PatternFilters').slideToggle();
        });
        
        
        $('#divEditGarments').bind("mouseleave", function(e) {
            if ($('#divEditGarments').is(':visible'))
                $('#divEditGarments').slideToggle();
        });
        
        $('#divEditMyWishList').bind("mouseleave", function(e) {
            if ($('#divEditMyWishList').is(':visible'))
                $('#divEditMyWishList').slideToggle();
        });
    });

    function GetSilouhette() {
        var selection = {
            "SilouhetteId": silouhette,
            "FabricId": 0,
            "PatternId": 0,
            "Ids": new Array()
        };

        var encoded = $.toJSON(selection);

        $.ajax({
            type: "POST",
            url: "<%= Url.RouteUrl(new { controller = "BuildYourCloset", action= "GetSilouhette"}) %>",
            data: encoded,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                RefreshFilters(data);
            }
        });
    };

    function Search() {
        var selection = {
            "SilouhetteId": silouhette,
            "FabricId": fabric,
            "PatternId": pattern,
            "Ids": new Array()
        };
        
        var encoded = $.toJSON(selection);

        $.ajax({
            type: "POST",
            url: "<%= Url.RouteUrl(new { controller = "BuildYourCloset", action= "Search"}) %>",
            data: encoded,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                updateGarments(data);
            }
        });
    };

    function FabricsFunctions() {
        apiOverlay.load();
        var temp = this.id.split("_");
        fabric = parseInt(temp[1]);
        var $selectedFabric = $(".FabricSelected").removeClass();
        $selectedFabric.addClass("Fabric");
        $(this).removeClass();
        $(this).addClass("FabricSelected");

        $("#FabSelected").text($(this).text());

        if ($('#FabricFilters').is(':visible'))
            $('#FabricFilters').slideToggle();

        Search();
    }

    function PatternsFunctions() {
        apiOverlay.load();
        var temp = this.id.split("_");
        pattern = parseInt(temp[1]);
        var $selectedPattern = $(".PatternSelected").removeClass();
        $selectedPattern.addClass("Pattern");
        $(this).removeClass();
        $(this).addClass("PatternSelected");

        $("#PatSelected").attr("src", $(this).attr("src"));

        if ($('#PatternFilters').is(':visible'))
            $('#PatternFilters').slideToggle();

        Search();
    }

    function updateGarments(data) {
        $("#GarmentsResults").empty(); //Clear results
        var resPath = '<% = Resources.GetRootPath() %>';
        
        for (var i = 0; i < data.length; i++) {
            var garmetId = data[i].Id.toString();

            $("#GarmentsResults").append("<div id='" + data[i].Id + "' class='GarmentDragable GarmentSelector_Garments'><img src='" +
                resPath + "/Garments/" + data[i].ImageUri + "' desc='" + data[i].Title + "' /></div>");

            if (myGarmentsItems.exists(garmetId) || myWishListItems.exists(garmetId))
                $('#' + data[i].Id).hide();
        }
        
        ApplyFunctionsToGarments();
        apiOverlay.close();
    }

    function ApplyFunctionsToGarments() {
        $(".GarmentDragable").mouseover(function(e) { 
            e.preventDefault();
        })
        $(".GarmentDragable").draggable({ revert: true, stack: { group: '#set div', min: 1} });
        $(".GarmentDragable").tooltip({
            position: "center right",
            offset: [0, -60],
            effect: "fade",
            tip: '.garmenttooltip',
            relative: true,
            lazy: true,
            events: {def: 'click, mouseout' },
            onBeforeShow: function() {
                apiTooltip = this;
                garmentselected = parseInt(this.getTrigger()[0].id);
            }
        });
    }

    function AddToMyGarment(id, div) {
        if (!myGarmentsItems.exists(id)) {
            myGarmentsItems.push(id)
            $("#myGarmentsItems").val(myGarmentsItems);

            increaseCount($("#MyGarmentCount"));

            addGarmentToEditList("divEditGarments", id);
            deleteImage(div);
        }
    }

    function AddToMyWishList(id, div) {
        if (!myWishListItems.exists(id)) {
            myWishListItems.push(id)
            $("#myWishListItems").val(myWishListItems);

            increaseCount($('#MyWishListCount'));

            addGarmentToEditList("divEditMyWishList", id);
            deleteImage(div);
        }
    }

    function RefreshFilters(data) {
        $("#FabricFilters").empty(); //Clear filters
                
        var fabricclass;
        for (var i = 0; i < data.Fabrics.length; i++) {
            if (data.Fabrics[i].Id == data.FabricId)
                {
                    fabricclass = "FabricSelected";
                    $("#FabSelected").text(data.Fabrics[i].Description);
                }
            else fabricclass = "Fabric";            
            $("#FabricFilters").append("<span class='" + fabricclass + "' id='f_" + data.Fabrics[i].Id + "'>" + data.Fabrics[i].Description + "</span>");
        }
        $('.Fabric').click(FabricsFunctions);
        $('.FabricSelected').click(FabricsFunctions);


            

        $("#PatternFilters").empty();
        var patternclass;
        var resPath = '<% = Resources.GetRootPath() %>';
        
        for (var i = 0; i < data.Patterns.length; i++) {
            if (data.Patterns[i].Description == "Solid")
                {
                    patternclass = "PatternSelected";
                    $("#PatSelected").attr("src", resPath + "/Patterns/" + data.Patterns[i].ImageUri);            
                }
            else patternclass = "Pattern";
            $("#PatternFilters").append("<img class='" + patternclass + "' id='p_" + data.Patterns[i].Id + "' src='" + resPath + "/Patterns/" + data.Patterns[i].ImageUri + "' alt='" + data.Patterns[i].Description + "' title='" + data.Patterns[i].Description + "' />");
        }
        $('.Pattern').click(PatternsFunctions);
        $('.PatternSelected').click(PatternsFunctions);

    }

    function addGarmentToEditList(listId, garmentId) {    
        var id = "divGarment" + garmentId;
        var div = "<div id='" + id + "' class='Garment_Item_Box'>";
        div += "<div class='Garment_Item_Box_Image'><center><img src='" + $('#' + garmentId).find("img").attr("src") + "' /></center></div>";
        div += "<div class='Garment_Item_Box_Clear'><img src='/img/remove_item.jpg' class='removeSelected' /></div></div>";

        $('#' + listId).append(div);

        $('.removeSelected').click(function(e) {
            var src = getSourceElement(e);
            $("#" + src.parentNode.parentNode.id).remove();

            if (getGarmentIndex(garmentId) != -1) {
                myGarmentsItems.splice(getGarmentIndex(garmentId), 1); //Remove item from Array
                decreaseCount($("#MyGarmentCount"));
                if ($("#MyGarmentCount").text() == "0")
                    $("#divEditGarments").hide();
            }

            if (getWishListIndex(garmentId) != -1) {
                myWishListItems.splice(getWishListIndex(garmentId), 1); //Remove item from Array
                decreaseCount($("#MyWishListCount"));                
                if ($("#MyWishListCount").text() == "0")
                    $("#divEditMyWishList").hide();
            }
            
            showGarment(garmentId);
        });
        
    }   

    function increaseCount(obj) {
        var count = parseInt(obj.text());
        count = count + 1;
        obj.text(count);
    }

    function decreaseCount(obj) {
        var count = parseInt(obj.text());
        count = count - 1;
        obj.text(count);
    }

    function getGarmentIndex(garmentId) {
        for (var i = 0; i < myGarmentsItems.length; i++) {
            if (myGarmentsItems[i] == garmentId)
                return i;
        }
        return -1;
    }

    function getWishListIndex(garmentId) {
        for (var i = 0; i < myWishListItems.length; i++) {
            if (myWishListItems[i] == garmentId)
                return i;
        }
        return -1;
    }

    function setTab(catId) {
        catId = parseInt(catId);         
        if (catId < 3)  { apiTabs.click(0); return; }   //Pants, Jeans
        if (catId < 5)  { apiTabs.click(1); return; }   //Shorts, Skirts                
        if (catId < 6)  { apiTabs.click(2); return; }   //Dresses
        if (catId < 7)  { apiTabs.click(3); return; }   //Jackets
        if (catId < 10) { apiTabs.click(4); return; }   //Tops
        if (catId < 16) { apiTabs.click(5); return; }   //Accesories
    }

    function setSlider(tabIndex) {
        var arrCat = getCategoryFromTab(tabIndex);        
        var items = apiSlider.getItems();
                
        for(var i = 0; i <= items.size(); i++){            
            var cat = getCategoryFromItem(items[i]);                        
            
            for(var j = 0; j <= arrCat.length ; j++){
                if (arrCat[j] == cat) {
                    apiSlider.seekTo(i);
                    return;
                }
            }
        }
    }


    function getCategoryFromItem(item) {
        return $(item).find("img").attr("cat");        
    }


    function getCategoryFromTab(tabIndex) {
        var arrCat = new Array();
        switch (tabIndex) {
            case 0:
                arrCat.push(1);
                arrCat.push(2);
                break;
            case 1:
                arrCat.push(3);
                arrCat.push(4);
                break;
            case 2:
                arrCat.push(5);
                break;
            case 3:
                arrCat.push(6);
                break;
            case 4:
                arrCat.push(7);
                arrCat.push(8);
                arrCat.push(9);
                break;
            case 5:
                for (var i = 10; i < 16; i++ )
                    arrCat.push(i);                
                break;
        }
        
        return arrCat;
    } 

    function showGarment(garmentId) {
        $("#" + garmentId).show();    
    }
        
    function deleteImage($item) {
        $item.fadeOut(function() {
            $item.css("display", "none");
        });
    }
    
</script>
</asp:Content>