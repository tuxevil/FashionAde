var apiOverlay;
$(document).ready(function() {
    apiOverlay = appendOverlay("#NoOne", "#loading", null, null);
    $(".Page").click(ChangePage);
    $(".Page").bind("mouseenter", function(e) {
        $(this).removeClass();
        $(this).addClass("NextPage");
    });
    $(".Page").bind("mouseleave", function(e) {
        $(this).removeClass();
        $(this).addClass("Page");
    });
});

function ChangePage(){
    apiOverlay.load();
    $("#Page").val($(this).attr("id").split('_')[1]);
    document.forms[0].submit();
}