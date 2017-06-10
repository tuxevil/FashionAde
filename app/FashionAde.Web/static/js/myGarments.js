var apiOverLay;
var apiRemoveOverlay;
var garmentSelected = 0;    
var zIndex = 1; 
var purchasedAtText = "(store)";
var purchasedOnText = "(date)";
var madeByText = "(designer)";
var madeOfText = "(fabric content)"
var careConditionsText = "(Laundering/maintenance details)";
var storeConditionsText = "(Storage details)";

$(document).ready(function() {
    $("#lnkMyGarments").css("background-color", "#F08331");
    
    $('.trashIcon').hide();        
    ApplyFunctionsToGarments();
    
    $("#MyOutfitDroppable").droppable({              
        accept: '.GarmentDragable',
        drop: function(event, ui) {
            if(allowAdd(ui.helper)){                    
                var resizeWidth = getGarmentWidth($(ui.helper)); //We need to resize tops to 75% and accesories to 50%.
                $(this).append($(ui.helper).css("cursor", "move").addClass("drag_" + $(ui.helper)[0].id).height("auto").width(resizeWidth).clone());
                
                $("#MyOutfitDroppable .GarmentDragable").addClass("item");
                $(".item").removeClass("ui-draggable GarmentDragable");
                
                $(".item").resizable({ aspectRatio: true }).parent().draggable({
                        containment: '#garmentContainment',
                        start: function(event, ui) {
                            clearDraggableItems();
                            selectDraggableItem(ui.helper);
                        }
                });
                
                $("#garmentsMessage").fadeOut("normal");
                $(".item").resizable( "option", "maxHeight", $(ui.helper)[0].height + 60 );
                $(".item").resizable( "option", "maxWidth", $(ui.helper)[0].width + 60 );                
                $(".item").resizable( "option", "minHeight", $(ui.helper)[0].height );
                $(".item").resizable( "option", "minWidth", $(ui.helper)[0].width ); 
                
                $(".ui-icon").hide();
                                
                //TODO: Remove only selected item...
                $(".MyGarment_Tooltip").removeClass("MyGarment_Tooltip");
            }
        }
    });
    
    apiOverLay = appendOverlay("#NoOne", "#Details", null, null);  //Loading....
    
    $(".DetailLink").click(function(e){        
        garmentSelected = parseInt(this.id.split("_")[1]);                                
        GetClosetGarmentData(this, $("#garment_" + garmentSelected).attr("src"));
        $("#detailsTitle").text("Although many women own " + getCategoryName($(this).attr("cat"))  + " like these, none of them is just like yours - add details!");        
    });
    
    $(".AddClosetLink").click(function(e){
        var src = getSourceElement(e);
        var img = $(src).parent().find(".GarmentDragable");
        
        if(allowAdd(img)){            
            var resizeWidth = getGarmentWidth(img); //We need to resize tops to 75% and accesories to 50%.
            var item = $(img).height("auto").width(resizeWidth).clone().css("cursor", "move").addClass("drag_" + $(img)[0].id);
            $("#garmentContainment").append(item); //Add to droppable div                
            $("#MyOutfitDroppable .GarmentDragable").addClass("item");
                            
            $(item).removeClass("ui-draggable GarmentDragable");
            $(item).resizable({ aspectRatio: true }).parent().draggable({
                    containment: '#garmentContainment',                    
                    start: function(event, ui) {                        
                        clearDraggableItems();
                        selectDraggableItem(ui.helper);                        
                    }
            });
            
            $("#garmentsMessage").fadeOut("normal");
            $(".item").resizable( "option", "maxHeight", img[0].height + 60 );
            $(".item").resizable( "option", "maxWidth", img[0].width + 60 );                
            $(".item").resizable( "option", "minHeight", img[0].height );
            $(".item").resizable( "option", "minWidth", img[0].width );
                        
            $(".ui-icon").hide();
                            
            //TODO: Remove only selected item...
            $(".MyGarment_Tooltip").removeClass("MyGarment_Tooltip");
        }
    });
    
            
    $('#MyOutfitDroppable').click(function(e){
        clearDraggableItems();
    });
    
    $("ul.tabs").tabs("div.panes > div");
    
    $(".inputField").css("padding-left", 5);
    $(".inputField").focus(function (){
        if($(this).val() == getDefaultText(this))
            $(this).val("");            
    });
    
    $(".inputField").blur(function (){
        if($(this).val() == "")
            $(this).val(getDefaultText(this));
    });
    
    $("#btnRemove").click(RemoveGarmentFromCloset);
    $("#btnUpdate").click(UpdateDetails);
    $("#btnSaveUserOutfit").click(saveUserOutfit);
    $("#PurchasedOn").datepicker( { dateFormat: 'mm/dd/yy', maxDate: '0' } );
    $("#PurchasedOn").keydown(function(e) 
        {e.preventDefault(); 
     });
});

function getCategoryName(catId){
    if (catId < 3)  return "pants";
    if (catId < 5)  return "shorts";
    if (catId < 6)  return "dresses";
    if (catId < 9)  return "jackets";
    if (catId < 10) return "tops"; 
    if (catId < 16) return "accesories";        
}


function getDefaultText(txt){
    switch (txt.id)
    {
        case "PurchasedAt":
            return purchasedAtText;
            
        case "PurchasedOn":
            return purchasedOnText;
            
        case "MadeBy":
            return madeByText;
            
        case "MadeOf":
            return madeOfText;
            
        case "CareConditions":
            return careConditionsText;
            
        case "StoreConditions":
            return storeConditionsText;     
            
        default:
            return "";            
    }
}    

function getGarmentWidth(img){
    var resizeWidth = $(img)[0].width;
    var cat = getCategoryName($(img).attr("cat"));
                        
    if(cat == "accesories")
        resizeWidth = parseInt(resizeWidth * 0.5);
    if(cat == "tops")
        resizeWidth = parseInt(resizeWidth * 0.75);
        
    return resizeWidth;
}
    
function allowAdd(item){
    if(!$("#MyOutfitDroppable").find("#" +  item[0].id).is(":visible")
        && $("#MyOutfitDroppable").find(".item").length <= 10)
            return true;
                    
    return false;
}

function selectDraggableItem(elm){        
    $(elm).addClass("draggableOutfit"); 
    $(elm).find(".ui-icon").show();        
    $(elm).css("zIndex", zIndex++);        
            
    if($(elm).find(".closeUserGarment").length == 0){
        $(elm).css("overflow", "visible");
        $(elm).prepend("<img src='/static/img/close.png' class='closeUserGarment' />");            
        $(".closeUserGarment").click(function(e){                
            $(this).parent().hide();  
            if($(".item:visible").length == 0)
                $("#garmentsMessage").fadeIn("normal");
        }); 
        
    }
}
    
function clearDraggableItems(){        
    $(".draggableOutfit").removeClass("draggableOutfit");        
    $(".closeUserGarment").remove();
    $(".ui-icon").hide();        
}

function saveUserOutfit(){
    var userOutfitSelection = {
        "ClosetOutfits": new Array(),            
        "Season": parseInt($("#ddlSeasons option:selected").val()),
        "PrivacyStatus": parseInt (($("#PrivacyStatusPublic")[0].checked) ? 1 : 0)
    };
    
    var errorMsg = isValid();        
    if(errorMsg != ""){
        showMessage(errorMsg);
        return false;
    }
            
    $("#MyOutfitDroppable .item:visible").each( function() {            
        userOutfitSelection.ClosetOutfits.push($(this)[0].id.split('_')[1]);
    });
    
    var encoded = $.toJSON(userOutfitSelection);
    ajaxRequest("OutfitCreation", "SaveUserOutfit", encoded, saveUserOutfitResult);
}

function saveUserOutfitResult(data){
    if (data.Success == true) {
        showMessage("You have successfully saved your outfit");
        $(".item").remove();
        $("#ddlSeasons option:eq(0)").attr("selected","selected");
        $("#garmentsMessage").fadeIn("normal");
    }
    else {
        showMessage(data.Message);
    }
}

function isValid(){    
    var strError = "";
    var uniqueItems = true;
    var invalidSeason = $($("#ddlSeasons")[0].firstChild).is(":selected");        
    var atLeastTwoItems = ($("#MyOutfitDroppable .item:visible").length >= 2);
    
    for(var i = 0; i< $("#MyOutfitDroppable .item").length; i++)
    if($(".drag_" + $("#MyOutfitDroppable .item")[i].id + ":visible").length > 1)
        uniqueItems = false;
        
    if(invalidSeason)
        strError = "You must select a season.";
        
    if(!uniqueItems || !atLeastTwoItems)
        strError = "You must select at least two different garments.";
                    
    return strError;
}

function RemoveGarmentFromCloset(){
    var encoded = $.toJSON(garmentSelected);
    ajaxRequest("MyGarments", "RemoveGarmentFromCloset", encoded, removeGarmentResult);
}

function removeGarmentResult(data){
    if (data.Success == true) {
        $("#div_" + garmentSelected).remove();
        apiRemoveOverlay.close();
    }
}

function GetClosetGarmentData(element, imgSrc){
    $("#PopUpImage").attr("src", imgSrc);
    $("#PopUpTitle").text($(element).parents().children(".GarmentTitle").text());
    
    var encoded = $.toJSON(garmentSelected);
    ajaxRequest("MyGarmentsDetail", "GetClosetGarmentDetails", encoded, LoadGarmentData);
}

function LoadGarmentData(data){
    $("#ClosetGarmentId").val(garmentSelected);
    $("#PurchasedAt").val((data.PurchasedAt != "") ? data.PurchasedAt : purchasedAtText );
    $("#PurchasedOn").val((data.PurchasedOn != "" && data.PurchasedOn != "01/01/0001") ? data.PurchasedOn : purchasedOnText );
    $("#MadeBy").val((data.MadeBy != "") ? data.MadeBy : madeByText );
    $("#MadeOf").val((data.MadeOf != "") ? data.MadeOf : madeOfText );
    $("input[name='IsTailored']").each(function() {
        if($(this).val() == data.IsTailored) {
            $(this).attr("checked", "checked");
        }
    });
    $("#CareConditions").val((data.CareConditions != "") ? data.CareConditions : careConditionsText);
    $("#StoreConditions").val((data.StoreConditions != "" ) ? data.StoreConditions : storeConditionsText );
    apiOverLay.load();
}

function UpdateDetails(){
    var detail = {
        "ClosetGarmentId": $("#ClosetGarmentId").val(),
        "PurchasedAt": ($("#PurchasedAt").val() != purchasedAtText) ? $("#PurchasedAt").val() : "",
        "PurchasedOn": ($("#PurchasedOn").val() != purchasedOnText) ? $("#PurchasedOn").val() : "",
        "MadeBy": ($("#MadeBy").val() != madeByText) ? $("#MadeBy").val() : "",
        "MadeOf": ($("#MadeOf").val() != madeOfText) ? $("#MadeOf").val() : "",
        "IsTailored": $("#IsTailored").val(),
        "CareConditions": ($("#CareConditions").val() != careConditionsText) ? $("#CareConditions").val() : "",
        "StoreConditions": ($("#StoreConditions").val() != storeConditionsText) ?  $("#StoreConditions").val() : ""
    };

    var encoded = $.toJSON(detail);
    ajaxRequest("MyGarmentsDetail", "SaveDetails", encoded, CloseDetails);
}

function CloseDetails(){
    apiOverLay.close();
    $("#ClosetGarmentId").val("");
    $("#PurchasedAt").val("");
    $("#PurchasedOn").val("");
    $("#MadeBy").val("");
    $("#MadeOf").val("");
    $("#IsTailored").val("");
    $("#CareConditions").val("");
    $("#StoreConditions").val("");
}

function ApplyFunctionsToGarments() {        
    $(".GarmentDragable").draggable({ helper: 'clone', zIndex:1, stack: { group: '#set div', min: 1} });

    $(".MyGarments_Garments").bind("mouseenter", function(e){
        garmentSelected = $(this).find(".GarmentDragable").attr("id").split("_")[1]
        $(this).addClass("MyGarment_Tooltip");
        $(this).find(".trashIcon").show();
        apiRemoveOverlay = appendOverlay(".trashIcon", "#RemoveConfirmation", beforeRemove, null);
    });

    $(".MyGarments_Garments").bind("mouseleave", function(e) {
        $(this).removeClass("MyGarment_Tooltip");
        $(this).find(".trashIcon").hide();            
    });
}

function beforeRemove(data, api) {
    apiRemoveOverlay = api;
}