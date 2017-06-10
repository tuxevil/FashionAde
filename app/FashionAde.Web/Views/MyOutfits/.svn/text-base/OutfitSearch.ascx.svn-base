<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<OutfitSearch>" %>
<%@ Import Namespace="FashionAde.Core.Views"%>
<%@ Import Namespace="FashionAde.Core.Clothing"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>
<script language="javascript" type="text/javascript">
function newSearch(){
    apiOverlay.load(); 
    var selection = getFilters();

    var encoded = $.toJSON(selection);
    ajaxRequest("MyOutfits", "<%= (Model.ShowAsPublicCloset) ? "GetResultPublicCloset" : "GetResults" %>", encoded, rebuildOutfits);
    $("#filters_Applied").empty();
    var haveAnyFilter = false;
    if(selection.Search != "" && selection.Search  != searchText)
    {
        var texts = selection.Search.split(',');
        for (var i = 0; i < texts.length; i++) {
            $("#filters_Applied").append('<span class="filter_Applied">' + texts[i] + ' <a id="filter_search.' + texts[i] + '" class="filterRemove" href="#">x</a></span>');
        }
        
        haveAnyFilter = true;
    }
    if(selection.Garment != "" && $("#Garment option:selected").val() != "0")
    {
        $("#filters_Applied").append('<span class="filter_Applied">' + selection.Garment + ' <a id="filter_garment" class="filterRemove" href="#">x</a></span>');
        haveAnyFilter = true;
    }
    if(selection.Trend != "" && $("#Trend option:selected").val() != "0")
    {
        $("#filters_Applied").append('<span class="filter_Applied">' + selection.Trend + ' <a id="filter_trend" class="filterRemove" href="#">x</a></span>');
        haveAnyFilter = true;
    }
    if(selection.Color != "")
    {
        var selectedColors = selection.Color.split(',');
        var colors = $(".filter_Color");
        for (var i = 0; i < selectedColors.length; i++) {
            for (var j = 0; j < colors.length; j++) {
                if(selectedColors[i] == $(colors[j]).attr('title'))
                {
                    var clone = $(colors[j]).clone();
                    $(clone).removeClass('filter_Color');
                    $(clone).removeClass('color_selected');
                    $(clone).addClass('filter_Color2');
                    $(clone).attr('id', '');
                    $("#filters_Applied").append('<span class="filter_Applied">' + clone[0].outerHTML + ' <a id="filter_color.' + selectedColors[i] + '" class="filterRemove" href="#">x</a></span>');
                }
            }
        }
        
        haveAnyFilter = true;
    }
    if(selection.Pattern != "")
    {
        var selectedPatterns = selection.Pattern.split(',');
        var patterns = $(".filter_Pattern");
        for (var i = 0; i < selectedPatterns.length; i++) {
            for (var j = 0; j < patterns.length; j++) {
                if(selectedPatterns[i] == $(patterns[j]).attr('title'))
                {
                    var clone2 = $(patterns[j]).clone();
                    $(clone2).removeClass('filter_Pattern');
                    $(clone2).removeClass('pattern_selected');
                    $(clone2).addClass('filter_Pattern2');
                    $(clone2).attr('id', '');
                    $(clone2).attr("src", $(clone2).attr("src").substring(0, $(clone2).attr("src").lastIndexOf('.') - 2) + ".jpg");
                    $("#filters_Applied").append('<span class="filter_Applied">' + clone2[0].outerHTML + ' <a id="filter_pattern.' + selectedPatterns[i] + '" class="filterRemove" href="#">x</a></span>');
                }
            }
        }
        
        haveAnyFilter = true;
    }
    if(selection.SeasonName != "" && selection.SeasonName != "fall winter spring summer")
    {
        $("#filters_Applied").append('<span class="filter_Applied">' + selection.SeasonName + ' <a id="filter_seasonname" class="filterRemove" href="#">x</a></span>');
        haveAnyFilter = true;
    }
    if(selection.CreatedByMe == "true")
    {
        $("#filters_Applied").append('<span class="filter_Applied">Created By Me <a id="filter_createdbyme" class="filterRemove" href="#">x</a></span>');
        haveAnyFilter = true;
    }
    if(selection.IsRatedByMe == "true")
    {
        $("#filters_Applied").append('<span class="filter_Applied">Rated By Me <a id="filter_isratedbyme" class="filterRemove" href="#">x</a></span>');
        haveAnyFilter = true;
    }
    if(selection.IsRatedByFriends == "true")
    {
        $("#filters_Applied").append('<span class="filter_Applied">Rated By Friends <a id="filter_isratedbyfriends" class="filterRemove" href="#">x</a></span>');
        haveAnyFilter = true;
    }

    if(selection.IsUpToDate == "true")
    {
        $("#filters_Applied").append('<span class="filter_Applied">Up To Date <a id="filter_isuptodate" class="filterRemove" href="#">x</a></span>');
        haveAnyFilter = true;
    }

    
    if(selection.MyFavorites == "true")
    {
        $("#filters_Applied").append('<span class="filter_Applied">My Favorites <a id="filter_myfavorites" class="filterRemove" href="#">x</a></span>');
        haveAnyFilter = true;
    }
    
    if(selection.SelectedEvents != "")
    {
        var eventTypes = selection.SelectedEvents.split(',');
        for(var i = 0; i < eventTypes.length; i++)
        {
            $("#filters_Applied").append('<span class="filter_Applied">' + eventTypes[i] + ' <a id="filter_eventtypes.' + eventTypes[i] + '" class="filterRemove" href="#">x</a></span>');
            haveAnyFilter = true;
        }
    }
    
    if(selection.SelectedFlavors != "")
    {
        var flavors = selection.SelectedFlavors.split(',');
        for(var i = 0; i < flavors.length; i++)
        {
            var flavorName = $("#flt_" + flavors[i]).text();
            $("#filters_Applied").append('<span class="filter_Applied">' + flavorName + ' <a id="filter_flavor.' + flavors[i] + '" class="filterRemove" href="#">x</a></span>');
            haveAnyFilter = true;
        }
    }

    
    $(".filterRemove").click(removeFilter);
    
    <% if(!Model.ShowAsPublicCloset)
 {%>
    if(haveAnyFilter)
        $("#btnSaveFilters").show();
    else
        $("#btnSaveFilters").hide();
        <%
 }%>
};

function removeFilter(e){
    var src = getSourceElement(e);
    var filter = $(src)[0].id.split("_")[1];
       
    if(filter.split('.')[0] == "search")
    {
        var name = filter.split('.')[1];
        var texts = $("#Texts").val().split(',');
        var newTexts = '';
        for (var i = 0; i < texts.length; i++) {
            if(texts[i] != name)
                newTexts += texts[i] + ',';
        }
        if (newTexts.length > 0)
            newTexts = newTexts.substring(0, newTexts.length - 1);

        $("#Texts").val(newTexts);
    }
    else if(filter == "garment")
    {
        $("#Garment").val('0');
    }
    else if(filter == "trend")
    {
        $("#Trend").val('0')
    }
    else if(filter.split('.')[0] == "color")
    {
        var name = filter.split('.')[1];
        var selectedColorsNames = $("#Color").val().split(',');
        var selectedColorsNewNames = "";
        for (var i = 0; i < selectedColorsNames.length; i++) {
            if(selectedColorsNames[i] != name)
                selectedColorsNewNames += selectedColorsNames[i] + ",";
        }
        
        if (selectedColorsNewNames.length > 0)
            selectedColorsNewNames = selectedColorsNewNames.substring(0, selectedColorsNewNames.length - 1);

        $("#Color").val(selectedColorsNewNames);
        var selectedColors = $(".color_selected");
        for (var i = 0; i < selectedColors.length; i++) {
            if($(selectedColors[i]).attr("title") == name)
                $(selectedColors[i]).removeClass("color_selected");
        }
    }
    else if(filter.split('.')[0] == "pattern")
    {
        var name = filter.split('.')[1];
        var selectedPatternsNames = $("#Pattern").val().split(',');
        var selectedPattenrsNewNames = "";
        for (var i = 0; i < selectedPatternsNames.length; i++) {
            if(selectedPatternsNames[i] != name)
                selectedPattenrsNewNames += selectedPatternsNames[i] + ",";
        }
        
        if (selectedPattenrsNewNames.length > 0)
            selectedPattenrsNewNames = selectedPattenrsNewNames.substring(0, selectedPattenrsNewNames.length - 1);

        $("#Pattern").val(selectedPattenrsNewNames);
        var selectedPatterns = $(".pattern_selected");
        for (var i = 0; i < selectedPatterns.length; i++) {
            if($(selectedPatterns[i]).attr("title") == name){
                $(selectedPatterns[i]).removeClass("pattern_selected");
                $(selectedPatterns[i]).attr("src", $(selectedPatterns[i]).attr("src").substring(0, $(selectedPatterns[i]).attr("src").lastIndexOf('.') - 2) + ".jpg");
            }
        }
    }
    else if(filter == "seasonname")
    {
        $("#SeasonName").val("");
        var seasons = $(".seasonImg");
        for (var i = 0; i < seasons.length; i++) {
            $(seasons[i]).attr("src", $(seasons[i]).attr("src").substring(0, $(seasons[i]).attr("src").lastIndexOf('/') + 1) + $(seasons[i]).attr("alt") + ".gif");
        }
        $("#season_15").addClass("allSeasonsSelected");
    }
    else if(filter == "createdbyme")
    {
        $("#CreatedByMe").val("false");
        $('#chbCreatedByMe').attr('checked', false);
    }
    else if(filter == "isratedbyme")
    {
        $("#IsRatedByMe").val("false");
        $('#chbRatedByMe').attr('checked', false);
    }
    else if(filter == "isratedbyfriends")
    {
        $("#IsRatedByFriends").val("false");
        $('#chbRatedByFriends').attr('checked', false);
    }
        else if(filter == "isuptodate")
    {
        $("#IsUpToDate").val("false");
        $('#chbUpToDate').attr('checked', false);
    }
    else if(filter == "myfavorites")
    {
        $("#MyFavorites").val("false");
        $('#chbMyFavorites').attr('checked', false);
    }
    else if(filter.split('.')[0] == "eventtypes")
    {
        var id = filter.split('.')[1];
        var events =$("#Events").val().split(',');
        var eventsFinal = "";
        for (var i = 0; i < events.length; i++) {
            if(events[i] != id)
                eventsFinal += events[i] + ",";
        }
        if (eventsFinal.length > 0)
            eventsFinal = eventsFinal.substring(0, eventsFinal.length - 1);
        $("#Events").val(eventsFinal);
        
        $("#et_" + id.replace(/ /g, '-')).attr('checked', false);
    }
    else if(filter.split('.')[0] == "flavor")
    {
        var id = filter.split('.')[1];
        var flavors =$("#Flavors").val().split(',');
        var flavorsFinal = "";
        for (var i = 0; i < flavors.length; i++) {
            if(flavors[i] != id)
                flavorsFinal += flavors[i] + ",";
        }
        if (flavorsFinal.length > 0)
            flavorsFinal = flavorsFinal.substring(0, flavorsFinal.length - 1);
        $("#Flavors").val(flavorsFinal);
        
        $("#fl_" + id).attr('checked', false);
    }
    $(src).parent().remove();
    newSearch();
}
    
function rebuildOutfits(data){
    $("#OutfitQuantity").text(data.TotalOutfits + " Outfits found");
    $("#GarmentsDiv").empty();
    if(data.Outfits.length > 0)
    {
        for (var i = 0; i < data.Outfits.length; i++) {
            if(i % $("#StyleAlertsStep").val() == 0 && i > 0)
                $("#GarmentsDiv").append($("#StyleAlerts").val());
        
            var outfit = recreateOutfit(data.Outfits[i]);
            $("#GarmentsDiv").append(outfit);
        }
        
        if(data.Pager.Pages.length > 0)
        {
            var pager = RegeneratePager(data.Pager);
            $("#GarmentsDiv").append(pager);
        }
     
        InitialFunctionality();
        GeneralInitialFunctionality();
    }
    else
    {
        $("#GarmentsDiv").append('<div><div class="NoOutfitDiv"><span>Sorry we can&#39;t find outfit matches for your request. If you&#39;ve just built your closet, <a href="/GarmentSelector/AddGarments/default.aspx">try to add more garments for this season from the master closet.</a></span></div></div>');
    }
    apiOverlay.close();
};

function recreateOutfit(outfit){
    var template = '<table border="0" class="OutfitDiv" id="div_' + outfit.ClosetOutfitId + '">';
    template += '<tbody><tr class="outfitHeader">';
    template += '<td colspan="2" style="vertical-align:top; padding:0;">';
    template += '<a href="/MyOutfits/OutfitResume/default.aspx?outfitId=' + outfit.ClosetOutfitId + '" id="OutfitName" class="outfitName" title="Check your friend ratings and more details!">' + outfit.ShortEventTypes + ' ' + outfit.ClosetOutfitId + '</a>';
    <% if(!Model.ShowAsPublicCloset)
 {%>
    template += '<img id="cls_' + outfit.ClosetOutfitId + '" src="/static/img/MyGarments/bluex.JPG" class="OutfitRemove">';
    template += '<div style="float: right; margin: 12px 15px 0px 15px">';
    template += '<form name="myRating_' + outfit.ClosetOutfitId + '">';
    template += '<input id="ratingPrevious_' + outfit.ClosetOutfitId + '" type="hidden">';
    template += '<span id="rn_' + outfit.ClosetOutfitId + '" class="rateNow">Rate now:</span><div class="starImg" style="display: inline;">';
        
    if(outfit.MyRating > 0)
    {
        for (var count = 1; count <= 5; count++)
           {
                var tooltip = "";
                if(count == 1)
                    tooltip = "Very Poor";
                else if(count == 2)
                    tooltip = "Poor";
                else if(count == 3)
                    tooltip = "Normal";
                else if(count == 4)
                    tooltip = "Good";
                else if(count == 5)
                    tooltip = "Very Good";
                if (count == outfit.MyRating)
                    template += '<input id="myrating_' + outfit.ClosetOutfitId + '" name="myrating_' + outfit.ClosetOutfitId + '" type="radio" checked="checked" class="myratingstar" value="' + count +  '" title="' + tooltip + '" />';
               else
                    template += '<input id="myrating_' + outfit.ClosetOutfitId + '" name="myrating_' + outfit.ClosetOutfitId + '" type="radio" class="myratingstar" value="' + count +  '" title="' + tooltip + '" />';
           }
    }
    else
    {
        template += '<input id="myrating_' + outfit.ClosetOutfitId + '" name="myrating_' + outfit.ClosetOutfitId + '" type="radio" class="myratingstar" value="1" title="Very Poor" style="display: none; ">';
        template += '<input id="myrating_' + outfit.ClosetOutfitId + '" name="myrating_' + outfit.ClosetOutfitId + '" type="radio" class="myratingstar" value="2" title="Poor" style="display: none; ">';
        template += '<input id="myrating_' + outfit.ClosetOutfitId + '" name="myrating_' + outfit.ClosetOutfitId + '" type="radio" class="myratingstar" value="3" title="Normal" style="display: none; ">';
        template += '<input id="myrating_' + outfit.ClosetOutfitId + '" name="myrating_' + outfit.ClosetOutfitId + '" type="radio" class="myratingstar" value="4" title="Good" style="display: none; ">';
        template += '<input id="myrating_' + outfit.ClosetOutfitId + '" name="myrating_' + outfit.ClosetOutfitId + '" type="radio" class="myratingstar" value="5" title="Very Good" style="display: none; ">';
    }
    
    template += '</div>';
    template += '<input class="MyRatingValue" id="' + outfit.ClosetOutfitId + '" type="hidden" value="' + outfit.MyRating + '">';
    template += '<img id="loadingMyRating_' + outfit.ClosetOutfitId + '" src="/static/img/ajax-loader-small.gif" alt="" style="margin-top:5px; display:none; margin-left:3px;">';
    template += '</form>';
    template += '</div>';
    template += '<div style="float: right; margin: 12px 5px 0px 5px"><input id="btnSendToFriends_' + outfit.ClosetOutfitId + '" class="SendToFriends" type="image" src="/static/img/FriendProviders/mail.JPG" onclick="javascript:{return false;}" value="Send Now"><span id="spnSendToFriends_' + outfit.ClosetOutfitId + '" class="SendToFriends" onclick="javascript:{return false;}" style="text-decoration: underline;">Send Friends</span></div>';
    template += '<div style="float: right; margin: 12px 5px 0px 5px">';
    
    template += '<input type=\'image\' onclick=\'doPublish({method: "stream.publish",attachment: {';
    template += '"name":"FashionAde",';
    template += '"href":"http://www.fashion-ade.com/Outfit/Rating/Vote/' + outfit.ClosetOutfitId + '/default.aspx",';
    template += '"description":"I am building an outfit around this garment - click here to see the whole look and tell me what you think.",';
    template += '"media":['
    var media = '';
    for(var j = 0; j < outfit.OutfitGarments.length && j < 5; j++) 
    {
        media += '{"type":"image","src":"' + $("#ImagePath").val() + '/res/Garments/65/' + outfit.OutfitGarments[j].ImageUri + '","href":"http://www.fashion-ade.com/outfit/rating/index/' + outfit.ClosetOutfitId + '/default.aspx"}';
        if(j + 1 < outfit.OutfitGarments.length && j + 1 < 5)
        {
            media += ',';
        }
    }           
    template += media; 
    template += ']},';
    template += 'action_link: [';
    template += '{';
    template += 'text: "Rate it now!",';
    template += 'href: "http://www.fashion-ade.com/Outfit/Rating/Vote/' + outfit.ClosetOutfitId + '/default.aspx"';
    template += '}';
    template += ']});return false;\' value=\'Share in Facebook\' src=\'/static/img/f.PNG\' class=\'shareFacebook\' title=\'Share in Facebook\'> ';
    
    template += '<span onclick=\'doPublish({method: "stream.publish",attachment: {';
    template += '"name":"FashionAde",';
    template += '"href":"http://www.fashion-ade.com/Outfit/Rating/Vote/' + outfit.ClosetOutfitId + '/default.aspx",';
    template += '"description":"I am building an outfit around this garment - click here to see the whole look and tell me what you think.",';
    template += '"media":[' + media + ']';
    template += '},';
    template += 'action_link: [';
    template += '{';
    template += 'text: "Rate it now!",';
    template += 'href: "http://www.fashion-ade.com/Outfit/Rating/Vote/' + outfit.ClosetOutfitId + '/default.aspx"';
    template += '}';
    template += ']});return false;\' class="shareFacebook" style="text-decoration: underline; cursor: pointer">Share in Facebook</span></div>';
    <%
 }%>
    template += '</td>';
    template += '</tr>';
    template += '<tr>';
    template += '<td><div style="width: 440px;">';
    for(var i = 0; i < outfit.OutfitGarments.length; i++) {
        template += '<div class="Outfit_Result_Garment">';
        template += '<img id="g_' + outfit.OutfitGarments[i].GarmentId + '" src="' + $("#ImagePath").val() + '/res/Garments/65/' + outfit.OutfitGarments[i].ImageUri + '" alt="' + outfit.OutfitGarments[i].Title + '" title="' + outfit.OutfitGarments[i].Title + '">';
        template += '</div>';
    }
    template += '<div style="clear:both;"></div></div><div style="clear: both; width: 440px;">';
    <% if(!Model.Public){%>
        template += '<div id="btnSeeMannequin_' + outfit.ClosetOutfitId + '" class="seeMannequin">TRY THIS ON</div>';
    <%} else{%>
        template += '<div type="button" class="addToMyCloset" style="text-decoration: underline; cursor: pointer;" id="' + outfit.ClosetOutfitId + '">Add To My Closet</div>';
        template += '<img id="addToClosetLoading_' + outfit.ClosetOutfitId + '" src="/static/img/ajax-loader-small.gif" style="margin:11px 0 0 5px; float:left; display:inline; display:none;">';
        template += '</div>';
    <%}%>
    template += '<div style="clear:both;"></div></div>';
    template += '</td>';
    template += '<td class="outfitUpdater" style="vertical-align:top;">';
    template += '<form action="/OutfitUpdaters/TrackOutfitUpdater/default.aspx" method="get">';
    template += '<div class="Outfit_Result_Garment" style="margin: 5px 0 15px 5px; display:block; width: 100%;">';
    template += '<div class="outfitUpdaterContainer">';
    template += "<a href='/OutfitUpdaters/TrackOutfitUpdater/default.aspx?updaterId=" + outfit.OutfitUpdater.Id + "&amp;updaterOutfitId=" + outfit.ClosetOutfitId + "&amp;updaterBuyUrl=" + outfit.OutfitUpdater.BuyUrl + "' target='_blank'>";
    template += '<img class="OutfitUpdaterImg_' + outfit.OutfitUpdater.PartnerCode + '" src="' + outfit.OutfitUpdater.ImageUrl + '" alt="' + outfit.OutfitUpdater.Description + ' $' + outfit.OutfitUpdater.Price + '" title="' + outfit.OutfitUpdater.Description + ' $' + outfit.OutfitUpdater.Price + '">';
    template += '</a>';
    template += '</div>';
    template += '<div class="outfitUpdaterContainer" style="text-align: left;">';
    template += '<a class="buyButton addThis" href="/OutfitUpdaters/TrackOutfitUpdater/default.aspx?updaterId=' + outfit.OutfitUpdater.Id + '&amp;updaterOutfitId=' + outfit.ClosetOutfitId + '&amp;updaterBuyUrl="' + outfit.OutfitUpdater.BuyUrl + '" style="width: 50px; text-align: center; margin-bottom: 5px; margin-left: 0px; display:inline; " target="_blank">BUY</a>';
    template += '<div style="clear:both; width: 100px;"><span style="font-family: Arial; font-size: 11px;">' + outfit.OutfitUpdater.PartnerName + '</span></div>';
    template += '<span style="color: black; font-weight: normal; font-size: 11px;">' + outfit.OutfitUpdater.Price + '</span><br /><br />';
    template += '<a href="/OutfitUpdaters/Index/default.aspx?Id=' + outfit.OutfitUpdater.Id + '&amp;ClosetOutfitId=' + outfit.ClosetOutfitId + '" class="linkViewAll">VIEW ALL</a>';
    template += '</div>';
    template += '</div>';  
    template += '</form>';
    template += '</td>';
    template += '</tr>';
    template += '<tr>';
    template += '<td style="margin:0; padding:0; border-top: solid 2px #C4CCDF; ">';
    template += '<div class="outfitBottom">';
    template += '<div class="Outfit_Details" style="width: 140px; padding-left:10px;margin-top: 4px;">';
    <% if(Model.Public){%>
    if(outfit.WornDate == "?")
    {
        outfit.WornDate == "N/A"
    }
    if(outfit.Location == "?")
    {
        outfit.Location == "N/A"
    }
    <%}%>
    template += 'Last worn: <span id="LastWorn_' + outfit.ClosetOutfitId + '" style="color: #767676;">' + outfit.WornDate + '</span></div>';
    template += '<div class="Outfit_Details" style="width:140px; margin-right:5px;margin-top: 4px;">To: ';
    template += '<span id="To_' + outfit.ClosetOutfitId + '" style="color: #767676; ">' + outfit.Location + '</span>';
    template += '</div>';
    <% if(!Model.Public){%>
    template += '<div class="Outfit_Details" style="float: right; margin-right: 10px;">';
    template += '<div id="btnNotation_' + outfit.ClosetOutfitId + '" class="OutfitNotate divButtonSquare addDetailsButton" >ADD UP TO DATE</div>';
    template += '</div>';
    <%}%>
    template += '</div>';
    template += '</td>';
    template += '<td style="border-left: solid 2px #C4CCDF;">';
    template += '<div class="starRating">';
    template += '<div class="divStar">' + outfit.EditorRating + '</div><span>Editor Rating</span>';
    template += '</div>';
    template += '<div class="starRating">';
    var myRating = "?";
    if(outfit.MyRating > 0)
        myRating = outfit.MyRating;
    template += '<div id="MyRateValue_' + outfit.ClosetOutfitId + '" class="RateNow divStar">' + myRating + '</div><span>My Rating</span>';
    template += '</div>';
    template += '<div class="starRating">';
    template += '<div class="divStar">' + outfit.AverageFriendRating + '</div><span>Friends Rating</span>';
    template += '</div>';      
    template += '</td>';
    template += '</tr>';
    template += '</tbody></table>';
    return template;
}

function RegeneratePager(pager){
    var template = '<div id="Pager" name="Pager" style="float:right; left: -50%; position: relative;">';
    template += '<div style="position: relative; left: 50%;">';
    template += '<ul style="display: inline; float: left; margin-top: 0px;">';
    for(var i = 0; i < pager.Pages.length; i++) {
        if(pager.Pages[i].Text == "...")
        {
            template += '<li style="color: #4E679B;display: block;float: left;font-family: Verdana;font-size: 11px;font-weight: bold;margin-right: 5px;padding-left: 5px;padding-right: 5px;">' + pager.Pages[i].Text + '</li>';
        }
        else if(pager.Pages[i].Selected == true)
        {
            template += '<li class="SelectedPage">' + pager.Pages[i].Text + '</li>';
            $("#Page").val(pager.Pages[i].Text);
        }
        else template += '<li class="Page" id="page_' + pager.Pages[i].Value + '">' + pager.Pages[i].Text + '</li>';
    }
    template += '</ul>';
    template += '<span style="float:left; color: #666666; font-weight: normal; font-size: 11px; margin-left: -10px;">(Showing ' + pager.PageSize + ' of ' + pager.TotalRecords + ' ourfits)</span>';
    template += '</div>';
    template += '</div>';
    return template;
}

function createdByMeChange()
{
    if($("#CreatedByMe").val() == "true")
    {
        $("#CreatedByMe").val("false");
    }
    else $("#CreatedByMe").val("true");
    newSearch();
}

function isRatedByMeChange()
{
    if($("#IsRatedByMe").val() == "true")
    {
        $("#IsRatedByMe").val("false");
    }
    else $("#IsRatedByMe").val("true");
    newSearch();
}

function isRatedByFriendsChange()
{
    if($("#IsRatedByFriends").val() == "true")
    {
        $("#IsRatedByFriends").val("false");
    }
    else $("#IsRatedByFriends").val("true");
    newSearch();
}

function isUpToDateChange()
{
    if($("#IsUpToDate").val() == "true")
    {
        $("#IsUpToDate").val("false");
    }
    else $("#IsUpToDate").val("true");
    newSearch();
}


function myFavoritesChange()
{
    if($("#MyFavorites").val() == "true")
    {
        $("#MyFavorites").val("false");
    }
    else $("#MyFavorites").val("true");
    newSearch();
}

function addText(){
    var newText = $("#Search").val();
    //Inputs encode
    newText = escape(newText);
    if(newText != escape(searchText))
    {
        var texts = '';
        if($("#Texts").val() != '')
            texts = $("#Texts").val() + ',' + newText;
        else texts = newText;
        $("#Texts").val(texts);
        $("#Search").val('');
        $("#btnGo").focus();
    }
    newSearch();
}

</script>
<div style="float: left; width:226px;">
    <div class="search_Container" >
        <input type="hidden" id="UserName" name="UserName" value="<%= Request.QueryString["UserName"] %>" />
        <input type="hidden" id="ImagePath" name="ImagePath" value="<%= HtmlHelpers.GetStaticUri() %>" />
        <input type="hidden" id="Page" name="Page" value="<%= Model.Page %>" />
        <input type="hidden" id="Season" name="Season" value="<%= Model.Season %>" />            
        <input type="hidden" id="SeasonName" name="SeasonName" value="<%= Model.SeasonName %>" />            
        <input type="hidden" id="Color" name="Color" value="" />    
        <input type="hidden" id="Pattern" name="Pattern" value="" />
        <input type="hidden" id="CreatedByMe" name="CreatedByMe" value="false" />
        <input type="hidden" id="IsRatedByMe" name="IsRatedByMe" value="false" />
        <input type="hidden" id="IsRatedByFriends" name="IsRatedByFriends" value="false" />
        <input type="hidden" id="IsUpToDate" name="IsUpToDate" value="false" />
        <input type="hidden" id="MyFavorites" name="MyFavorites" value="false" />
        <input type="hidden" id="Events" name="Events" value="" />
        <input type="hidden" id="Flavors" name="Flavors" value="" />
        <input type="hidden" id="StyleAlerts" name="StyleAlerts" value="" />
        <input type="hidden" id="StyleAlertsStep" name="StyleAlertsStep" value="<%= ViewData["StyleAlertsStep"] %>" />
        <input type="hidden" id="Texts" name="Texts" value="" />
        <div class="search_Textbox_Container"><%= Html.TextBox("Search", string.Empty, new { @class = "search_Textbox", style = "width: 145px; height: 19px; margin: 2px;", maxlength = 100, onkeydown = "if ((event.which && event.which == 13) || (event.keyCode && event.keyCode == 13)){addText();return false;} else return true;" })%> <input id="btnGo" type="image" src="/static/img/MyGarments/gobutton.JPG" class="search_Button" onclick="addText();" /></div><div style="clear: both"></div>
    </div> 
    <div class="filter_Container" >
        <% if (!Model.ShowAsPublicCloset)
           {
               string style = string.Empty;
               if (Model.SavedFilters.Count == 0)
                   style = "style=\"display:none;\"";%>
           
        <div id="savedFilterCombinationContainer" class="filter_SubContainer" <%=style %>>
            <span class="filter_Title">Saved Filters Combination</span><br />
            <div id="savedFilters">
                <%if (Model.SavedFilters.Count > 0)
                  {
                      foreach (SavedFilter savedFilter in Model.SavedFilters)
                      {%>
                <div style="margin-bottom: 10px;"><span id="<%= "sf_" + savedFilter.Id %>" class="filter_Saved"><%= savedFilter.Name%> </span><a id="<%= "rf_" + savedFilter.Id %> "href="#" class="savedFiltersRemove">Delete</a></div>
                      <% }
                  } %>
            </div>
            <div style="clear:both"></div>
        </div>
        <%} %>
        <div class="filter_SubContainer">
            <span class="filter_Title">Applied Filters</span><br />
            <div id="filters_Applied">
               <%= "<span class=\"filter_Applied\">" + SeasonHelper.GetSeason(Convert.ToInt32(Model.Season)) + " <a id=\"filter_seasonname\" class=\"filterRemove\" href=\"#\">x</a></span>" %>
            </div>
            <span id="btnSaveFilters" class="filter_Applied_Save" style="display:none;">SAVE THIS FILTER</span>
            <div style="clear:both"></div>
        </div>
        <div class="filter_SubContainer">
            <div class="filter_Title2"><img src="/static/img/filter-arrow.jpg"/><span>By Garment</span></div>
            <%= Html.DropDownList("Garment", Model.Categories, new { @class = "filter_Dropdown", onchange = "$('#btnGo').click();" })%>
            <hr />
        </div>
        <div class="filter_SubContainer">
            <div class="filter_Title2"><img src="/static/img/filter-arrow.jpg"/><span>By Trends</span></div>
            <%= Html.DropDownList("Trend", Model.Trends, new { @class = "filter_Dropdown", onchange = "$('#btnGo').click();" })%>
            <hr />
        </div>
        <div class="filter_SubContainer">
            <div class="filter_Title2"><img src="/static/img/filter-arrow.jpg"/><span>By Color</span></div>
            <%
            foreach (Color color in Model.Colors)
            {%>
                <div class="filter_Color" id="c_<%= color.Id %>" style="background-color: <%= color.ColorCode %>" title="<%= color.Description %>" ></div>
            <%} %>
            <hr style="float: left; margin-top: 10px; width: 100%;"/>
        </div>
        <div class="filter_SubContainer">
            <div class="filter_Title2"><img src="/static/img/filter-arrow.jpg"/><span>By Pattern</span></div>
            <%
            foreach (Pattern pattern in Model.Patterns)
            {%>
                <img class="filter_Pattern" id="p_<%= pattern.Id %>" src="<%= Resources.GetPatternPath(pattern) %>" alt="<%= pattern.Description %>" title="<%= pattern.Description %>" />
            <%} %>
            <hr />
        </div>
        <div class="filter_SubContainer">
            <div class="filter_Title2"><img src="/static/img/filter-arrow.jpg"/><span>By Season</span></div>
            <center>
            <div id="seasons">
            <% int count = 1;
            IList<Season> seasons = SeasonHelper.ListSeasons();                
            foreach (Season season in seasons) {
                string className = "";
                string current = "";              
                if (Model.Season == ((int)season).ToString())
                {
                    className = "allSeasonsSelected";
                    current = "2";
                }
                if (season != Season.All)
                {%>                    
                <img id="<%= "season_" + (int)season %>" src="/static/img/<%= season.ToString().ToLower() + current %>.gif" class="season seasonImg" alt="<%= season.ToString().ToLower() %>" />
                <% 
                }
                else
                {%>
                    <br />
                    or <a id="<%= "season_" + (int)season %>" season="<%=((int)season).ToString()%>" href="#<%= count %>" class="season <%= className %>" alt="<%= season.ToString().ToLower() %>">All seasons</a>
                <%}
                count++; %>
            <% } %>
            </div>
            </center>
            <hr />
        </div>
        <div class="filter_SubContainer">
            <div class="filter_Title2"><img src="/static/img/filter-arrow.jpg"/><span>By Entries</span></div>
            <ul style=" list-style-image: none;">
            <%
            string byMe = "Created by me";
            if (Model.ShowAsPublicCloset)
                byMe = "Created by owner";%>
                <li class="filter_Input"><input id="chbCreatedByMe" type="checkbox" onclick="createdByMeChange();" /><span><%= byMe %></span></li>
                <li class="filter_Input"><input id="chbRatedByMe" type="checkbox" onclick="isRatedByMeChange();" /><span>Rated by me</span></li>
                <li class="filter_Input"><input id="chbRatedByFriends" type="checkbox" onclick="isRatedByFriendsChange();" /><span>Rated by friends</span></li>
                <li class="filter_Input"><input id="chbMyFavorites" type="checkbox" onclick="myFavoritesChange();" /><span>My Favorites</span></li>
                <li class="filter_Input"><input id="chbUpToDate" type="checkbox" onclick="isUpToDateChange();" /><span>Up to Date</span></li>
            </ul>
            <hr />
        </div>
        <div class="filter_SubContainer">
            <div class="filter_Title2"><img src="/static/img/filter-arrow.jpg"/><span>By Event Types</span></div>
            <ul>
            <%foreach (SelectListItem eventType in Model.EventTypes){%>
                <li class="filter_Input"><input id="<%="et_" + eventType.Text.Replace(' ', '-') %>" type="checkbox" class="event_CheckBox"/><span id="<%="ets_" + eventType.Text %>" ><%= eventType.Text %></span></li>
            <%} %>
            </ul>
            <hr />
        </div>
        <div class="filter_SubContainer">
            <div class="filter_Title2"><img src="/static/img/filter-arrow.jpg"/><span>By Flavor</span></div>
            <ul>
            <%foreach (SelectListItem flavor in Model.Flavors){%>
                <li class="filter_Input"><input id="<%= "fl_" + flavor.Value %>" type="checkbox" class="flavor_CheckBox" /><span id="<%= "flt_" + flavor.Value %>"><%= flavor.Text %></span></li>
            <%} %>
            </ul>
            <hr />
        </div>
    </div> 
</div>