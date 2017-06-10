var apiOverlay;
var apiFavoriteOverlay;
var apiSaveFilters;
var apiSavedFiltersRemove;
var closetOutfitId;
var apiAddToMyClosetOverlay;
var outfitSelected = 0;
var apiRemoveOverlay;
var apiAddNotateOverlay;
var apiSendToFriendsOverlay;
var apiRemoveFavoriteOverlay;
var currentValue = 0;
var txtEmails = "Write a friend name or email address";
var savedfilterid;

$(document).ready(function() {
    //Overlays    
    apiFavoriteOverlay = appendOverlay("#Favorite", "#favoriteConfirmation", null, null);
    apiRemoveFavoriteOverlay = appendOverlay("#RemoveFavorite", "#RemoveFavoriteConfirmation", null, null);
    apiAddToMyClosetOverlay = appendOverlay("#AddToMyCloset", "#AddToMyClosetConfirmation", null, null);
    apiSaveFilters = appendOverlay("#SaveFilters", "#SaveFiltersPopup", null, null);
    apiSavedFiltersRemove = appendOverlay("#RemoveSavedFilter", "#SavedFilterRemoveConfirmation", null, null);

    $(".event_CheckBox").click(function(e) {
        var chbs = $(".event_CheckBox:checked");
        var events = "";
        for (var i = 0; i < chbs.length; i++) {
            var id = $(chbs[i])[0].id.split("_")[1].replace(/-/g, ' ');
            events += id + ",";
        }
        if (events.length > 0)
            events = events.substring(0, events.length - 1);
        $("#Events").val(events);
        newSearch();
    });

    $(".flavor_CheckBox").click(function(e) {
        var chbs = $(".flavor_CheckBox:checked");
        var flavors = "";
        for (var i = 0; i < chbs.length; i++) {
            var id = $(chbs[i])[0].id.split("_")[1];
            flavors += id + ",";
        }
        if (flavors.length > 0)
            flavors = flavors.substring(0, flavors.length - 1);
        $("#Flavors").val(flavors);
        newSearch();
    });

    if ($("#sa_5").length > 0)
        $("#StyleAlerts").val($("#sa_5")[0].innerHTML);

    $("#btnSaveFilters").click(function(e) {
        apiSaveFilters.load();
        $("#SaveFiltersName").focus();
    });

    $("#SaveFilterConfirm").click(saveFilters);

    $("#RemoveSavedFilterConfirm").click(function(e) {
        var encoded = $.toJSON(savedfilterid);
        ajaxRequest("MyOutfits", "RemoveSavedFilter", encoded, showSavedFilters);
    });

    $(".filter_Color").click(function(e) {
        var $colorSelected = $("#" + getSourceElement(e).id);
        if ($colorSelected.hasClass("color_selected"))
            $colorSelected.removeClass("color_selected");
        else
            $colorSelected.addClass("color_selected");

        var selectedColors = $(".color_selected");
        var selectedColorsNames = "";
        for (var i = 0; i < selectedColors.length; i++) {
            selectedColorsNames += $(selectedColors[i]).attr("title") + ",";
        }
        if (selectedColorsNames.length > 0)
            selectedColorsNames = selectedColorsNames.substring(0, selectedColorsNames.length - 1);

        $("#Color").val(selectedColorsNames);
        newSearch();
    });

    $(".filter_Pattern").click(function(e) {
        var $patternSelected = $("#" + getSourceElement(e).id);
        if ($patternSelected.hasClass("pattern_selected")) {
            $patternSelected.removeClass("pattern_selected");
            $patternSelected.attr("src", $patternSelected.attr("src").substring(0, $patternSelected.attr("src").lastIndexOf('.') - 2) + ".jpg");
        }
        else {
            $patternSelected.addClass("pattern_selected");
            $patternSelected.attr("src", $patternSelected.attr("src").substring(0, $patternSelected.attr("src").lastIndexOf('.')) + "_s.jpg");
        }

        var selectedPatterns = $(".pattern_selected");
        var selectedPatternsNames = "";
        for (var i = 0; i < selectedPatterns.length; i++) {
            selectedPatternsNames += $(selectedPatterns[i]).attr("title") + ",";
        }
        if (selectedPatternsNames.length > 0)
            selectedPatternsNames = selectedPatternsNames.substring(0, selectedPatternsNames.length - 1);

        $("#Pattern").val(selectedPatternsNames);

        newSearch();
    });

    $(".filter_Saved").click(savedFiltersClick);

    RemoveFiltersFunctionality();
    GeneralInitialFunctionality();
});

function saveFilters() {
    var selection = getFilters();
    selection.Name = $("#SaveFiltersName").val();
    if (selection.Name == "") {
        alert("Insert a name, please.");
    }
    else {
        var encoded = $.toJSON(selection);
        ajaxRequest("MyOutfits", "SaveFilters", encoded, showSavedFilters);
    }
}

function RemoveFiltersFunctionality() {
    $(".savedFiltersRemove").click(function(e) {
        var src = getSourceElement(e);
        savedfilterid = $(src)[0].id.split("_")[1];
        apiSavedFiltersRemove.load();
    });
};

function GeneralInitialFunctionality() {

    $('input.star').rating({ required: 'hide' });
    $(".divButton").removeClass("hide"); //Buttons are hidden by default

    $('input.myratingstar').rating({
        required: 'hide',
        callback: function(value, link) {
            if ($(this).attr("id") != undefined)
                closetOutfitId = $(this).attr("id").split('_')[1];
            var selection = {
                "ClosetOutfitId": closetOutfitId,
                "Rate": value,
                "Key": '00000000-0000-0000-0000-000000000000'
            };

            var encoded = $.toJSON(selection);
            currentValue = value;
            $("#RateNow_" + closetOutfitId).empty();
            $("#MyRateValue_" + closetOutfitId).empty();
            $("#MyRateValue_" + closetOutfitId).append(value);
            $("#loadingMyRating_" + closetOutfitId).show();
            ajaxRequest("MyOutfits", "RateOutfit", encoded, rateOutfitSuccess);
        }
    });

    apiSendToFriendsOverlay = appendOverlay(".SendToFriends", "#SendToFriends", setOutfitSelected, setFriendsFocus);
    apiRemoveOverlay = appendOverlay(".OutfitRemove", "#RemoveConfirmation", setOutfitSelected, null);
    apiAddNotateOverlay = appendOverlay(".OutfitNotate", "#AddNotate", showOutfitNotate, setNotateFocus);

    $("#btnRemove").click(RemoveGarmentFromCloset);
    $("#btnAddNotate").click(AddNotateToCloset);
    $("#btnInviteFriends").click(InviteFriends);
    $("#btnFavoriteConfirmation").click(SetFavorite);
    $("#btnRemoveFavoriteConfirmation").click(ClearFavorite);

    $(".seeMannequin").click(function(e) {
        var src = getSourceElement(e);
        var id = $(src)[0].id.split("_")[1];
        var top = $(this).offset().top - 35;
        var left = $(this).offset().left - 60;

        var selection = {
            "OutfitId": id,
            "GarmentIds": new Array(),
            "Top": top,
            "Left": left
        };

        var garments = $("#div_" + id + " .Outfit_Result_Garment");
        for (var i = 0; i < garments.length - 1; i++)
            selection.GarmentIds.push($(garments[i]).find("img").attr("id").split("_")[1]);
        var encoded = $.toJSON(selection);

        ajaxRequest("UploadGarment", "GetLayers", encoded, showMannequin);
    });

    $("#WornDate").datepicker({ dateFormat: 'mm/dd/yy', maxDate: '0' });
    $("#WornDate").keydown(function(e) { e.preventDefault(); });

    var $txtEmails = $("#txtEmails");
    $txtEmails.css("color", "gray");
    $txtEmails.val(txtEmails);

    $txtEmails.focus(function() {
        if ($("#txtEmails").val() == txtEmails)
            $("#txtEmails").val("");
    });

    $txtEmails.blur(function() {
        if ($("#txtEmails").val() == "")
            $(this).val(txtEmails).css("color", "gray");
    });

    $("#txtEmails").autocomplete("/MyOutfits/GetFriends/default.aspx", {
        dataType: 'json',
        width: 300,
        multiple: true,
        matchContains: true,
        formatItem: formatItem,
        formatResult: formatItem
    });

    $("#txtEmails").result(function(event, data, formatted) {
        var hidden = $(this).parent().next().find(">:input");
        hidden.val((hidden.val() ? hidden.val() + ";" : hidden.val()) + data[1]);
    });

    $(".addToMyCloset").click(function(e) {
        apiAddToMyClosetOverlay.load();
        closetOutfitId = getSourceElement(e).id;
    });

    $("#btnAddToMyClosetConfirmation").click(function(e) {
        apiAddToMyClosetOverlay.close();
        var encoded = $.toJSON(closetOutfitId);

        $("#addToClosetLoading_" + closetOutfitId).show();
        ajaxRequest("OutfitCreation", "CopyOutfit", encoded, addToMyCloset);
    });

    $('#txtEmails').bind('keypress', function(e) {
        var code = e.keyCode || e.which;
        if (code == 13) {
            InviteFriends();
        }
    });
    
}

function savedFiltersClick(e) {

    //$(".filter_Saved_Selected").addClass("filter_Saved");
    $(".filter_Saved_Selected").removeClass("filter_Saved_Selected");
    var id = getSourceElement(e).id.split("_")[1];
    //$("#sf_" + id).removeClass("filter_Saved");
    $("#sf_" + id).addClass("filter_Saved_Selected");
    $("#SaveFiltersName").val($("#sf_" + id).text());
    var encoded = $.toJSON(id);
    ajaxRequest("MyOutfits", "GetSavedFilter", encoded, showFilters);
}

function showFilters(data) {
    $("#Texts").val(data.Search);
    $("#Garment").val(data.Garment);
    $("#Trend").val(data.Trend);
    $(".color_selected").removeClass("color_selected");
    if (data.Color != null) {
        var selectedColors = data.Color.split(',');
        var selectedColorsNames = "";
        for (var i = 0; i < selectedColors.length; i++) {
            var color = $("#c_" + selectedColors[i]);
            $(color).addClass("color_selected");
            selectedColorsNames += $(color).attr("title") + ",";
        }
        if (selectedColorsNames.length > 0)
            selectedColorsNames = selectedColorsNames.substring(0, selectedColorsNames.length - 1);
        $("#Color").val(selectedColorsNames);
    }
    else $("#Color").val('');
    var lastPatterns = $(".pattern_selected");
    for (var i = 0; i < lastPatterns.length; i++) {
        $(lastPatterns[i]).removeClass("pattern_selected");
        $(lastPatterns[i]).attr("src", $(lastPatterns[i]).attr("src").substring(0, $(lastPatterns[i]).attr("src").lastIndexOf('.') - 2) + ".jpg");
    }
    if (data.Pattern != null) {
        var selectedPatterns = data.Pattern.split(',');
        var selectedPatternsNames = "";
        for (var i = 0; i < selectedPatterns.length; i++) {
            var pattern = $("#p_" + selectedPatterns[i]);
            $(pattern).addClass("pattern_selected");
            $(pattern).attr("src", $(pattern).attr("src").substring(0, $(pattern).attr("src").lastIndexOf('.')) + "_s.jpg");
            selectedPatternsNames += $(pattern).attr("title") + ",";
        }
        if (selectedPatternsNames.length > 0)
            selectedPatternsNames = selectedPatternsNames.substring(0, selectedPatternsNames.length - 1);
        $("#Pattern").val(selectedPatternsNames);
    }
    else $("#Pattern").val('');
    $("#SeasonName").val(data.SeasonName);
    if (data.CreatedByMe == true)
        $('#chbCreatedByMe').attr('checked', true);
    else
        $('#chbCreatedByMe').attr('checked', false);
    $("#CreatedByMe").val(data.CreatedByMe);
    if (data.IsRatedByMe == true)
        $('#chbRatedByMe').attr('checked', true);
    else
        $('#chbRatedByMe').attr('checked', false);
    $("#IsRatedByMe").val(data.IsRatedByMe);
    if (data.IsRatedByFriends == true)
        $('#chbRatedByFriends').attr('checked', true);
    else
        $('#chbRatedByFriends').attr('checked', false);
    $("#IsRatedByFriends").val(data.IsRatedByFriends);
    if (data.IsUpToDate == true)
        $('#chbUpToDate').attr('checked', true);
    else
        $('#chbUpToDate').attr('checked', false);
    $("#IsUpToDate").val(data.IsUpToDate);
    $("#Events").val(data.SelectedEvents);

    var eventCheckBoxes = $(".event_CheckBox");
    for (var i = 0; i < eventCheckBoxes.length; i++) {
        $(eventCheckBoxes[i]).attr('checked', false);
    }
    if (data.SelectedEvents.split(',').length > 0) {
        var events = $("#Events").val().split(',');
        for (var i = 0; i < events.length; i++) {
            $("#et_" + events[i].replace(/ /g, '-')).attr('checked', true);
        }
    }

    $("#Flavors").val(data.SelectedFlavors);

    var flavorCheckBoxes = $(".flavor_CheckBox");
    for (var i = 0; i < flavorCheckBoxes.length; i++) {
        $(flavorCheckBoxes[i]).attr('checked', false);
    }
    if (data.SelectedFlavors.split(',').length > 0) {
        var flavors = $("#Flavors").val().split(',');
        for (var i = 0; i < flavors.length; i++) {
            $("#fl_" + flavors[i]).attr('checked', true);
        }
    }

    $("#MyFavorites").val(data.MyFavorites);
    $("#IsUpToDate").val(data.IsUpToDate);
    newSearch();
}

function showSavedFilters(data) {
    $("#savedFilters").empty();
    var _class = "filter_Saved";
    if (data.length > 0) {
        $("#savedFilterCombinationContainer").show();
        for (var i = 0; i < data.length; i++) {
            if (data[i].Selected == true)
                _class += " filter_Saved_Selected";
            else _class = "filter_Saved";
            $("#savedFilters").append('<div style="margin-bottom: 10px;"><span id="sf_' + data[i].SavedFilter.Id + '" class="' + _class + '">' + data[i].SavedFilter.Name + ' </span><a id="rf_' + data[i].SavedFilter.Id + '" href="#" class="savedFiltersRemove">Delete</a></div>');
        }
    }
    else {
        $("#savedFilterCombinationContainer").hide();
    }
    $(".filter_Saved").click(savedFiltersClick);
    RemoveFiltersFunctionality();
    apiSaveFilters.close();
    apiSavedFiltersRemove.close();
}


function getFilters() {
    var selection = {
        "Page": $("#Page").val(),
        "Season": $("#Season").val(),
        "Search": $("#Texts").val(),
        "SortBy": $("#SortBy").val(),
        "Username": $("#UserName").val(),
        "PageSize": $("#Pages").val(),
        "Garment": $("#Garment option:selected").text(),
        "Trend": $("#Trend option:selected").text(),
        "Color": $("#Color").val(),
        "Pattern": $("#Pattern").val(),
        "SeasonName": $("#SeasonName").val(),
        "CreatedByMe": $("#CreatedByMe").val(),
        "IsRatedByMe": $("#IsRatedByMe").val(),
        "IsRatedByFriends": $("#IsRatedByFriends").val(),
        "SelectedEvents": $("#Events").val(),
        "SelectedFlavors": $("#Flavors").val(),
        "Name": "",
        "MyFavorites": $("#MyFavorites").val(),
        "IsUpToDate": $("#IsUpToDate").val()
    };
    return selection;
}

function rateOutfitSuccess(data) {
    if (data.Success == true) {
        if (data.RemoveFavorite) {
            apiRemoveFavoriteOverlay.load();
        } else if (data.ReplaceFavorite) {
            apiFavoriteOverlay.load();
        } else if (data.SetFavorite) {
            DisplayFavorite(closetOutfitId, data.Name);
            showMessage("This outfit now designated as your favorite oufit.");
        }
        $("#loadingMyRating_" + closetOutfitId).hide();
        $("#rn_" + closetOutfitId).hide();
    }
}

function addToMyCloset(data) {
    $("#addToClosetLoading_" + closetOutfitId).hide();
    if (data.Success == true) {
        if (data.RegisteredUser)
            showMessage("You added the outfit to your closet successfully!");
        else
            window.location.href = loginUrl;
    }
}

function setOutfitSelected(data, api) {
    outfitSelected = parseInt(data.getTrigger()[0].id.split("_")[1]);
    apiSendToFriendsOverlay = api;
}

function showOutfitNotate(data, api) {
    $("#Location").val("");
    $("#WornDate").val("");
    $("#requiredLocation").removeClass().addClass("hide");
    $("#requiredWornDate").removeClass().addClass("hide");
    apiAddNotateOverlay = api;
    setOutfitSelected(data, api);
}

function setNotateFocus(data) {
    $("#Location").focus();
}

function setFriendsFocus(data) {
    $("#txtEmails").focus();
}

function formatItem(row) {
    return row[0] + "\" [" + row[1] + "]";
}
function formatResult(row) {
    return row[1].replace(/(<.+?>)/gi, '');
}

function showMannequin(data) {
    if ($("#divMannequin_" + data.id).length > 0)
        return;

    var src = $("#btnSeeMannequin_" + data.id);

    var div = "";
    div = "<div id='divMannequin_" + data.id + "' class='mannequin' style='top:" + data.top + "px; left:" + data.left + "px;' >";
    div += "<div class='mannequinHeader'>" + $(src).parent().parent().parent().parent().find("#OutfitName").text() + "</div>";
    div += "<img src='/static/img/close.png' class='closeUserGarment' />";
    div += "<div class='MannequinOrder'>";
    div += "<div id='divTops_" + data.id + "'></div>";
    div += "<div id='divBottom_" + data.id + "'></div>";
    div += "<div id='divAccesories_" + data.id + "'></div>";
    div += "</div>";
    div += "</div>";
    $(src).parent().append(div);

    for (var i = 0; i < data.Layers.length; i++) {
        var pos = getLayerPosition(data.Layers[i].Layer);
        switch (pos) {
            case "top":
                $("#divTops_" + data.id).append("<img src='" + resGarmentPath + data.Layers[i].ImageUri + "'/>");
                break;

            case "bottom":
                $("#divBottom_" + data.id).append("<img src='" + resGarmentPath + data.Layers[i].ImageUri + "'/>");
                break;

            case "accesories":
            case "":
                $("#divAccesories_" + data.id).append("<img src='" + resGarmentPath + data.Layers[i].ImageUri + "'/>");
                break;
        }
    }

    $("#divMannequin_" + data.id).draggable();
    $(".closeUserGarment").click(function(e) {
        $(this).parent().remove();
    });
}

function getLayerPosition(layerCode) {
    if (layerCode > 0 && layerCode < 3)
        return "bottom";        //A, Ai
    else if (layerCode > 2 && layerCode < 7)
        return "top";           //Aii, B, C, D
    else return "accesories";    //ACC1    
}

function RemoveGarmentFromCloset() {
    var encoded = $.toJSON(outfitSelected);
    ajaxRequest("MyOutfits", "RemoveOutfitFromCloset", encoded, removeGarmentResult);
}

function removeGarmentResult(data) {
    if (data.Success == true) {
        apiRemoveOverlay.close();
        apiOverlay.load();
        $("#btnGo").click();
    }
}

function getOutfitImage(id, position) {
    var garments = $("#div_" + id + " .Outfit_Result_Garment");
}

function AddNotateToCloset() {
    if ($("#Location").val() == "" || $("#WornDate").val() == "") {
        ($("#Location").val() == "")
                    ? $("#requiredLocation").removeClass("hide")
                    : $("#requiredLocation").addClass("hide");

        ($("#WornDate").val() == "")
                    ? $("#requiredWornDate").removeClass("hide")
                    : $("#requiredWornDate").addClass("hide");

        return;
    }


    var selection = {
        "OutfitSelected": outfitSelected,
        "Location": $("#Location").val(),
        "WornDate": $("#WornDate").val()
    };

    var encoded = $.toJSON(selection);
    ajaxRequest("MyOutfits", "AddNotateToCloset", encoded, addNotateSuccess);
}

function addNotateSuccess(data) {
    if (data.Success == true) {
        apiAddNotateOverlay.close();
        $("#LastWorn_" + outfitSelected).text(data.WornDate);
        $("#To_" + outfitSelected).text(data.Location);
    }
}

function InviteFriends() {
    $("#imgLoading").show();

    var selection = {
        "FriendsEmails": $("#txtEmails").val(),
        "OutfitId": outfitSelected,
        "Message": $("#txtMessage").val(),
        "SendMe": $("#SendToMe").is(':checked'),
        "SiteURL": $("#SiteURL").val()
    };

    var encoded = $.toJSON(selection);
    ajaxRequest("MyOutfits", "InviteFriends", encoded, InviteFriendsSuccess);
}

function InviteFriendsSuccess(data){
    if (data.Success == true) {
        $("#txtEmails").val("");
        $("#txtMessage").val("");
        $("#SendToMe").removeAttr('checked');
        $("#imgLoading").hide();
        apiSendToFriendsOverlay.close();
    }
}

function DisableMyRating(){
    $('input.myratingstar', this.form).rating('disable');
}

function ClearFavorite(){
    var encoded = $.toJSON(closetOutfitId);
    ajaxRequest("MyOutfits", "ClearFavorite", encoded, clearFavoriteSuccess);
}

function clearFavoriteSuccess(data){
    if (data.Success == true) {
        apiRemoveFavoriteOverlay.close();
    }
}

function SetFavorite(){
    var selection = {
        "ClosetOutfitId": closetOutfitId,
        "Rate": 5
    };

    var encoded = $.toJSON(selection);
    ajaxRequest("MyOutfits", "SetFavorite", encoded, setFavoriteSuccess);
}

function setFavoriteSuccess(data){
    if (data.Success == true) {
        apiFavoriteOverlay.close();
        showMessage("This outfit now designated as your favorite oufit.");
    }
}