var apiOverlay;
var searchText = $("#hiddenFilterText").val();

$(document).ready(function() {
    apiOverlay = appendOverlay("#NoOne", "#loading", null, null);
    var $txtSearch = $("#Search");
    $txtSearch.css("color", "gray");
    $txtSearch.val(searchText);

    $txtSearch.focus(function() {
        if ($("#Search").val() == searchText)
            $("#Search").val("");
    });

    $txtSearch.blur(function() {
        if ($("#Search").val() == "")
            $(this).val(searchText).css("color", "gray");
    });

    $txtSearch.keydown(function() { $(this).css("color", "black"); });

    $(".season").click(function(e) {
        var src = getSourceElement(e);
        var id = src.id.split("_")[1];
        var name = $(src).attr("alt");
        if (name == 'all')
            name = '';

        if ($("#Season").val() == id) {
            id = '15';
            name = '';
        }

        $("#Season").val(id);
        $("#SeasonName").val(name);
        var seasons = $(".seasonImg");
        for (var i = 0; i < seasons.length; i++) {
            $(seasons[i]).attr("src", $(seasons[i]).attr("src").substring(0, $(seasons[i]).attr("src").lastIndexOf('/') + 1) + $(seasons[i]).attr("alt") + ".gif");
        }
        $("#season_15").removeClass("allSeasonsSelected");

        if (id < 15) {
            $(src).attr("src", $(src).attr("src").substring(0, $(src).attr("src").lastIndexOf('/') + 1) + $(src).attr("alt") + "2.gif");
        }
        else $("#season_15").addClass("allSeasonsSelected");
        newSearch();
    });

    $(".filterRemove").click(removeFilter);
    InitialFunctionality();
});


function InitialFunctionality() {

    $(".Page").click(ChangePage);

    //Update master page menu
    var otherOutfits = (location.href.indexOf("PublicCloset") != -1);
    var selectedMenu = (otherOutfits) ? "#lnkOthersOutfits" : "#lnkMyOutfits";
    $(selectedMenu).css("background-color", "#F08331");

    $('input.star').rating({ required: 'hide' });

    $(".Page").bind("mouseenter", function(e) {
        $(this).removeClass();
        $(this).addClass("NextPage");
    });
    $(".Page").bind("mouseleave", function(e) {
        $(this).removeClass();
        $(this).addClass("Page");
    });
}

function trackFacebookPublish() {
    var encoded = $.toJSON("Facebook Publish");
    ajaxRequest("MyOutfits", "TrackFacebookPublish", encoded, null);
}