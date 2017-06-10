var apiOverLay;    
var wishGarmentSelected = 0;
var garmentSelected = 0;
    
$(document).ready(function(){
    $("#lnkWishList").css("background-color", "#F08331");        
    $('.trashIcon').hide();
            
    ApplyFunctionsToGarments();
    appendOverlay(".AddClosetLink", "#loading", beforeShowAddToCloset, null);
            
    $(".AddClosetLink").click(addToCloset);        
    $("#btnRemove").click(RemoveGarmentFromWishList);
});

function beforeShowAddToCloset(data, api){
    apiOverLay = api;
}

function addToCloset(){
    var selected = {
        "GarmentId": garmentSelected,            
        "WishListId": wishGarmentSelected
    };
    
    var encoded = $.toJSON(selected);
    ajaxRequest("WishList", "AddToCloset", encoded, addToClosetSuccess);
}

function addToClosetSuccess(data){
    apiOverLay.close();
    window.location = document.location.href;
}
    
function RemoveGarmentFromWishList(){
    var encoded = $.toJSON(wishGarmentSelected);
    ajaxRequest("WishList", "Remove", encoded, RemoveGarmentSuccess);
}

function RemoveGarmentSuccess(data){
    if (data.Success == true) {
        $("#div_" + garmentSelected).remove();
        apiRemoveOverlay.close();
    }
}
    
function ApplyFunctionsToGarments(){        
    $(".MyGarments_Garments").bind("mouseenter",function(e) {            
        garmentSelected = $(this).attr("id").split("_")[1]
        wishGarmentSelected = $(this).attr("wishGarmentId");
        
        $(this).addClass("MyGarment_Tooltip");
        $(this).find(".trashIcon").show();
        appendOverlay(".trashIcon", "#RemoveConfirmation", onBeforeApplyFunction, null);
    });

    $(".MyGarments_Garments").bind("mouseleave", function(e) {
        $(this).removeClass("MyGarment_Tooltip");
        $(this).find(".trashIcon").hide();            
    });   
}

function onBeforeApplyFunction(data, api){
    apiRemoveOverlay = api;
}
