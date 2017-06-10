$(document).ready(function() {
    $("#lnkOthersOutfits").css("background-color", "#F08331");

    $(".Page").click(ChangePage);
    $(".Page").mousein
    $(".Page").bind("mouseenter", function(e){
        $(this).removeClass();
        $(this).addClass("NextPage");
    });
    $(".Page").bind("mouseleave", function(e){
        $(this).removeClass();
        $(this).addClass("Page");
    });
});

function ChangePage(){
    $("#pageNumber").val($(this).attr("id").split('_')[1]);
    $("#btnGo").click();
}