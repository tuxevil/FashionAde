<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<FashionAde.Core.Closet>" %>
<%@ Import Namespace="FashionAde.Core.MVCInteraction"%>
<%@ Import Namespace="FashionAde.Core.Clothing"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>
<%@ Import Namespace="FashionAde.Core"%>

<asp:Content ID="contentOverlay" ContentPlaceHolderID="OverlayPlaceHolder" runat="server">
    <div id="fb-root"></div>
    <div class="modal" id="SendToFriends" style="width: 600px;opacity:1; "> 
            <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix" unselectable="on"><div class="invitefriendPopupHeader" ><span style="display: inline; color: white; margin-left: 15px; font-size: 15px;" unselectable="on" >Email this outfit:</span><img src='/img/close.png' class='close close_Image' /></div><div style="clear:both"></div></div>
            <% Html.RenderPartial("InviteFriends"); %>
            <div style="clear:both"></div>
            <center>
                <div id="btnInviteFriends" class="divButton" >Invite Friends</div><div class="divButton close">Cancel</div>
            </center>
    </div>
    
    <div class="modal" id="AddNotate" style="width: 300px; opacity:1; "> 
        <img src='/img/close.png' class='close close_Image' />
        <center>
            <p>Location: <%= Html.TextBox("Location") %></p> 
            <p>Worn Date: <%= Html.TextBox("WornDate") %></p>
            <div id="btnAddNotate" class="divButton" >Add</div><div class="divButton close">Cancel</div>
        </center>
    </div> 
        
    <div class="modal" id="loading"> 
        <p>Loading... Please Wait</p> 
        <img src="http://l.yimg.com/a/i/us/per/gr/gp/rel_interstitial_loading.gif" />
    </div> 
 
    <input type="hidden" id="NoOne" />        
 
    <div class="modal" id="favoriteConfirmation" style="opacity:1;"> 
        <img src='/img/close.png' class='close close_Image' />
            <center>
                <p>Do you want to replace youre favorite outfit with this?</p> 
                <div id="btnFavoriteConfirmation" class="divButton">Yes</div><div class="divButton close" >No</div>
            </center>
    </div> 
    
    <input type="hidden" id="Favorite" />  
    
    <div class="modal" id="RemoveConfirmation" style="opacity:1;"> 
    <img src='/img/close.png' class='close close_Image' />    
    <center>
        <p>Are you sure to remove this item?</p> 
        <div id="btnRemove" class="divButton">Yes</div><div class="divButton close" >No</div>
    </center>
</div> 
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<input id="SiteURL" type="hidden" value="<%= ConfigurationManager.AppSettings["SiteURL"] %>" />
<div style="width: 710px; float: left; margin-right: 5px;">
    <h1 style="font-weight: normal; margin-top: 0px;"><span id="Username" style="color:#F38333; font-weight: Bold;"><%= ViewData["UserName"]%></span> - <span id="OutfitQuantity" style="color:#F38333; font-weight: normal;"><%= ViewData["TotalOutfits"] %></span> Outfits</h1>
    <h2 style="float: left; width: 275px; margin-top: -15px;">Closet status: <span id="ClosetStatus" style="color:Black;"><%= ViewData["PrivacyLevel"] %></span></h2><br />
    <h2 style="float: left; width: 275px; margin-top: -15px;">Favorite Outfit: <span id="FavoriteOutfit" style="color:Black;">
    <% if (Model.FavoriteOutfit == null)
       {%>
        None Selected
        <% }
       else
       { %>
        Work 012
       <%} %>
    </span></h2>
    
    <div class="Outfit_Sponsors" style="margin-top: -40px;">
        <span>Sponsored by:</span>
        <img src="../../res/Sponsors/logo_lg.jpg" alt="Ann Taylor"  />
    </div>

    <div style="clear: both; background-color: #4D679B; height: 30px; color: White; padding: 4px 10px 2px 20px; font-weight: bold; width: 670px;" >
        <% using (Html.BeginForm())
           {%>
           <input type="hidden" id="Page" name="Page" value="1" />
           <input type="hidden" id="Season" name="Season" value="<%= ViewData["Season"] %>" />
        <div style="float:left;">Sort my outfits by: <%= Html.DropDownList("SortBy", (List<SelectListItem>)ViewData["SortBy"], new { style = "width: 120px;", onchange = "$('#btnGo').click();" })%> </div>
        <div style="float:right; position:relative; width:420px;"><div style="float:left; margin-top:5px; margin-right:4px;">Garment search:</div> <%= Html.TextBox("Search", string.Empty, new { style = "margin-right: 45px; width: 255px; font-size: 11px; padding-left:5px;" })%> <input id="btnGo" type="image" src="../../img/MyGarments/gobutton.JPG" style="float:right; position: absolute; right: 5px; top: 3px;" /></div>
        <% } %>
    </div>
    
    <div id="GarmentsDiv">
            <!-- the tabs --> 
            <ul class="tabs" style="clear: both;"> 
	            <li><a href="#1">1. Spring</a></li> 
	            <li><a href="#2">2. Summer</a></li> 
	            <li><a href="#3">3. Fall</a></li> 
	            <li><a href="#4">4. Winter</a></li> 
	            <li><a href="#5">5. All Seasons</a></li> 
            </ul>
            <!-- tab "panes" --> 
            <div class="panes" style="clear: both;"> 
	            <div>
	                <%
	                   if(ViewData["Season"].ToString() == "1")
                       {
                           Html.RenderPartial("OutfitsList", ViewData["Outfits"]);                           
                       }%>
	            </div> 
	            <div>
	                <%
	                   if(ViewData["Season"].ToString() == "2")
                       {
                           Html.RenderPartial("OutfitsList", ViewData["Outfits"]);
                       }%>
	            </div> 
	            <div>
	                <%
	                   if(ViewData["Season"].ToString() == "3")
                       {
                           Html.RenderPartial("OutfitsList", ViewData["Outfits"]);
                       }%>
	            </div> 
	            <div>
	                <%
	                   if(ViewData["Season"].ToString() == "4")
                       {
                           Html.RenderPartial("OutfitsList", ViewData["Outfits"]);
                       }%>
	            </div> 
	            <div>
	                <%
	                   if(ViewData["Season"].ToString() == "5")
                       {
                           Html.RenderPartial("OutfitsList", ViewData["Outfits"]);
                       }%>
	            </div> 
            </div>   
        </div>
</div>        

<div style="float: left; width:226px;">
    <%
        IList<FashionFlavor> flavors = (List<FashionFlavor>)ViewData["FashionFlavors"];
    %>
    
    <div class="GarmentSelector_FilterDiv_FashionFlavorSelected" style="float: left; ">
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
               {%>
            <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Title" ><%= flavors[1].Name%></span>
            <img class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Image" src="<%= Resources.GetFashionFlavorThumbnailPath(flavors[1]) %>" alt="<%= flavors[1].Name %>"  />
            <% } %>
            </center>
        </div>
    </div>
    
    <span style="float:left; display: block; color: #F67F07; font-weight: normal; font-size: 24px;">Style Alerts</span>
    
    <div class="StyleAlerts">
        <span>Lorem ipsum dolor sit amet</span>
        <p>Consectetur adipiscing elit. Aliquam ultrices vehicula felis sed congue. In gravida posuere pretium. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.</p>
        <a href="<%= Url.RouteUrl(new { controller = "MyGarments", action= "ReadMore"}) %>">Read More</a>        
    </div>
    <div class="StyleAlerts">
        <span>Lorem ipsum dolor sit amet</span>
        <p>Consectetur adipiscing elit. Aliquam ultrices vehicula felis sed congue. In gravida posuere pretium. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.</p>
        <a href="<%= Url.RouteUrl(new { controller = "MyGarments", action= "ReadMore"}) %>">Read More</a>        
    </div>
    <div class="StyleAlerts">
        <span>Lorem ipsum dolor sit amet</span>
        <p>Consectetur adipiscing elit. Aliquam ultrices vehicula felis sed congue. In gravida posuere pretium. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.</p>
        <a href="<%= Url.RouteUrl(new { controller = "MyGarments", action= "ReadMore"}) %>">Read More</a>        
    </div>
    <div class="StyleAlerts">
        <span>Lorem ipsum dolor sit amet</span>
        <p>Consectetur adipiscing elit. Aliquam ultrices vehicula felis sed congue. In gravida posuere pretium. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.</p>
        <a href="<%= Url.RouteUrl(new { controller = "MyGarments", action= "ReadMore"}) %>">Read More</a>        
    </div>
</div>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="<%= Url.Content("~/js/jquery.toJSON.js") %>"></script>
<script src='<%= Url.Content("~/js/jquery.rating.js") %>' type="text/javascript" language="javascript"></script> 
<script src='<%= Url.Content("~/js/jquery.MetaData.js") %>' type="text/javascript" language="javascript"></script>
<script>
    window.fbAsyncInit = function() {
        FB.init({
            appId: '<%= ConfigurationManager.AppSettings["FacebookConnectId"] %>',
            xfbml: true,
            cookie: true,
            status: true
        });
    };
    (function() {
        var e = document.createElement('script'); e.async = true;
        e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
        document.getElementById('fb-root').appendChild(e);
    } ());

    function doPublish(attachment) {
        FB.ui(attachment);
    }
</script>
<script type="text/javascript">
var apiOverlay;
var apiFavoriteOverlay;
var outfitSelected = 0;
var apiRemoveOverlay;
var apiAddNotateOverlay;
var apiSendToFriendsOverlay;
var closetoutfitid;
var searchText = "Type a color, name or function to filter the results";
    $(document).ready(function() {
         apiOverlay = $("#NoOne").overlay({
                // some expose tweaks suitable for modal dialogs 
                expose: {
                    color: '#333',
                    loadSpeed: 200,
                    opacity: 0.3
                },
                target: "#loading",
                left: "center",
                top: "center",
                api: true,
                closeOnClick: false
            });
            
        apiFavoriteOverlay = $("#Favorite").overlay({
                // some expose tweaks suitable for modal dialogs 
                expose: {
                    color: '#333',
                    loadSpeed: 200,
                    opacity: 0.3
                },
                target: "#favoriteConfirmation",
                left: "center",
                top: "center",
                api: true,
                closeOnClick: false
            });
            
        $("ul.tabs").tabs("div.panes > div", {
            initialIndex: parseInt($("#Season").val()) - 1
        });
        $(".tabs a").click(ChangeSeason);
        $(".Page").click(ChangePage);
        
        //Update master menu
        $("#lnkMyOutfits").css("background-color", "#F08331");
        $("ul.tabs").tabs("div.panes > div");
        $('input.star').rating({
	        required: 'hide'
	    });
	    
	    $(".divButton").removeClass("hide"); //Buttons are hidden by default
	            
        $('input.myratingstar').rating({
            required: 'hide',
	        callback: function(value, link) {
	            var id = 0;
	            if( $(this).attr("id") != undefined)
	                id = $(this).attr("id").split('_')[1];
	            var selection = {
                    "ClosetOutfitId": id,
                    "Rate": value,
                    "Key": '00000000-0000-0000-0000-000000000000'
                };

                var encoded = $.toJSON(selection);

                $.ajax({
                    type: "POST",
                    url: "<%= Url.RouteUrl(new { controller = "MyGarments", action= "RateOutfit"}) %>",
                    data: encoded,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(data) {
                        if(data.Success == true)
                        {
                            if(data.WantFavorite == true)
                            {
                                apiFavoriteOverlay.load();
                                closetoutfitid = id;
                            }
                            
                            $("#RateNow_" + id).empty();
                            $("#MyRateValue_" + id).empty();
                            $("#MyRateValue_" + id).append(value);
                            
                        }
                    }
                });
             }
	    });
        
        
        $(".SendToFriends").overlay({
            // some expose tweaks suitable for modal dialogs
            expose: {
                color: '#333',
                loadSpeed: 200,
                opacity: 0.3
            },
            target: "#SendToFriends",
            left: "center",
            api: true,
            top: "center",
            onBeforeLoad: function() {
                apiSendToFriendsOverlay = this;
                outfitSelected = parseInt(this.getTrigger()[0].id.split("_")[1]);
            }
        });
	    
	    $(".OutfitRemove").overlay({            
            expose: {
                color: '#333',
                loadSpeed: 200,
                opacity: 0.3
            },
            target: "#RemoveConfirmation",
            left: "center",
            api: true,
            top: "center",
            onBeforeLoad: function() {
                apiRemoveOverlay = this;
                outfitSelected = parseInt(this.getTrigger()[0].id.split("_")[1]);
            }
        });
        
        $(".OutfitNotate").overlay({            
            expose: {
                color: '#333',
                loadSpeed: 200,
                opacity: 0.3
            },
            target: "#AddNotate",
            left: "center",
            api: true,
            top: "center",
            onBeforeLoad: function() {                
                apiAddNotateOverlay = this;
                outfitSelected = parseInt(this.getTrigger()[0].id.split("_")[1]);                
            },
            onLoad: function() {
                $("#Location").focus();
            } 
        });
            
        $("#btnRemove").click(RemoveGarmentFromCloset);
        $("#btnAddNotate").click(AddNotateToCloset);
        $("#btnInviteFriends").click(InviteFriends);
        $("#btnFavoriteConfirmation").click(SetFavorite);
        
        $(".Page").mousein
        $(".Page").bind("mouseenter",function(e) {
            $(this).removeClass();
            $(this).addClass("NextPage");
        });
        $(".Page").bind("mouseleave", function(e) {
            $(this).removeClass();
            $(this).addClass("Page");
        });
        
        $(".seeMannequin").click(function(e){            
            var src = getSourceElement(e);
            var id = $(src).parent().find(".OutfitRemove")[0].id.split("_")[1]; 
            
            var selection = {
                 "OutfitId": id,
                 "GarmentIds": new Array() 
             };
             
            var top = $(this).offset().top - 35;
            var left = $(this).offset().left - 60;            
            
            var garments = $("#div_" + id + " .Outfit_Result_Garment");
            for(var i = 0; i < garments.length -1; i++)                
                selection.GarmentIds.push($(garments[i].innerHTML)[0].id.split("_")[1]);             
                                 
            var encoded = $.toJSON(selection);

            $.ajax({
                type: "POST",
                url: "<%= Url.RouteUrl(new { controller = "MyGarments", action= "GetLayers"}) %>",
                data: encoded,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data) {                    
                    if (data.Success == true) {
                        showMannequin(data, src, id, top, left);
                    }
                }
            });   
        });
        
        
        $("#WornDate").datepicker( { dateFormat: 'dd/mm/yy' } );        
        
        var $txtSearch = $("#Search");
        $txtSearch.css("color","gray");
        $txtSearch.val(searchText);
        
        $txtSearch.focus(function () {
            if($("#Search").val() == searchText)
                $("#Search").val("");
        });
        
        $txtSearch.blur(function () {
            if($("#Search").val() == "")
                $(this).val(searchText).css("color","gray");
        });
        
        $txtSearch.keydown(function() { $(this).css("color","black"); });

    });
        
    
    function showMannequin(data, src, id, top, left)
    {
        if($("#divMannequin_" + id).length > 0)
            return;
        
        var div = "";
        div = "<div id='divMannequin_" + id + "' class='mannequin' style='top:" + top + "px; left:" + left + "px;' >";
        div += "<div class='mannequinHeader'>" + $(src).parent().find("#OutfitName").text() + "</div>";
        div += "<img src='/img/close.png' class='closeUserGarment' />";
        div += "<div class='MannequinOrder'>";
        div += "<div id='divTops_" + id + "'></div>";
        div += "<div id='divBottom_" + id + "'></div>";
        div += "<div id='divAccesories_" + id + "'></div>";
        div += "</div>";
        div += "</div>";
        $(src).parent().append(div);
                
        for(var i = 0; i < data.Layers.length; i++)
        {
            var pos = getLayerPosition(data.Layers[i].Layer);
            switch(pos) 
            {
                case "top":
                    $("#divTops_" + id).append("<img src='/res/garments/" +  data.Layers[i].ImageUri + "'/>");
                    break;
                    
                case "bottom":
                    $("#divBottom_" + id).append("<img src='/res/garments/" + data.Layers[i].ImageUri + "'/>");
                    break;
                    
                case "accesories":
                case "":
                    $("#divAccesories_" + id).append("<img src='/res/garments/" + data.Layers[i].ImageUri + "'/>");
                    break;
            }            
        }
        
        $("#divMannequin_" + id).draggable();
        $(".closeUserGarment").click(function(e){                
            $(this).parent().remove();
        });
    }
    
    function getLayerPosition(layerCode)
    {
        if(layerCode > 0 && layerCode < 3)   
            return "bottom";        //A, Ai
        else if (layerCode > 2 && layerCode < 7 )    
            return "top";           //Aii, B, C, D
        else return "accesories";    //ACC1    
    }
    
    function RemoveGarmentFromCloset() {        
        var encoded = $.toJSON(outfitSelected);

        $.ajax({
            type: "POST",
            url: "<%= Url.RouteUrl(new { controller = "MyGarments", action= "RemoveOutfitFromCloset"}) %>",
            data: encoded,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                if (data.Success == true) {
                    apiRemoveOverlay.close();
                    apiOverlay.load();
                    $("#btnGo").click();
                }
            }
        });
    }
    
    function getOutfitImage(id, position){
        var garments = $("#div_" + id + " .Outfit_Result_Garment");
        
        //for(var i = 0; i < garments.length; i++)
        //foreach hasta q coincida con el layer
        
            
    }
    
    function AddNotateToCloset() {
        var selection = {
                    "OutfitSelected": outfitSelected,
                    "Location": $("#Location").val(),
                    "WornDate": $("#WornDate").val()
                };
        
        var encoded = $.toJSON(selection);

        $.ajax({
            type: "POST",
            url: "<%= Url.RouteUrl(new { controller = "MyGarments", action= "AddNotateToCloset"}) %>",
            data: encoded,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                if (data.Success == true) {
                    apiAddNotateOverlay.close();
                    apiOverlay.load();
                    $("#btnGo").click();
                }
            }
        });
    }
    
    function InviteFriends() {
    
        var selection = {
             "FriendsEmails": $("#txtEmails").val(),
             "OutfitId": outfitSelected,
             "Message": $("#txtMessage").val(),
             "SendMe": $("#SendToMe").is(':checked'),
             "SiteURL": $("#SiteURL").val()
             };
                    
        var encoded = $.toJSON(selection);

        $.ajax({
            type: "POST",
            url: "<%= Url.RouteUrl(new { controller = "MyGarments", action= "InviteFriends"}) %>",
            data: encoded,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                if (data.Success == true) {
                    $("#txtEmails").val("");
                    $("#txtMessage").val("");
                    $("#SendToMe").removeAttr('checked');
                    apiSendToFriendsOverlay.close();
                }
            }
        });
    }

    function DisableMyRating(){
        $('input.myratingstar', this.form).rating('disable');
    }
    
    function ChangeSeason()    {
        apiOverlay.load();
        $("#Season").val($(this).attr("href").substring(1)); 
        $("#Page").val(1); 
        $("#btnGo").click();
    }
    
    function ChangePage(){
        apiOverlay.load();
        $("#Page").val($(this).attr("id").split('_')[1]); 
        $("#btnGo").click();
    }
    
    
    function SetFavorite() {
        var id = closetoutfitid;
        var selection = {
            "ClosetOutfitId": id,
            "Rate": 5
        };

        var encoded = $.toJSON(selection);

        $.ajax({
            type: "POST",
            url: "<%= Url.RouteUrl(new { controller = "MyGarments", action= "SetFavorite"}) %>",
            data: encoded,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                if(data.Success == true)
                {
                    apiFavoriteOverlay.close();
                }
            }
        });
    }
    
</script>
</asp:Content>