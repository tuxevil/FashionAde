//Highlight Build Closet link if the user is in the registration process
function highlightBuildClosetLink() {
    var url = document.location.href;
    if (url.indexOf("BuildYourCloset") != -1 || url.indexOf("buildyourcloset") != -1)
        $("#lnkBuildCloset").css("background-color", "#F08331");
}

//Return the source element for all browsers
function getSourceElement(event) {
    return event.srcelement ? event.srcelement : event.target;
}

var ap;
function showMessage(msg, divId) {
    //The API needs the rel attribute because the target property is not working....
    //if ($("#" + divId).attr("rel") == undefined)
    //    $("#" + divId).attr("rel", "#divMessage");
    
    
    //$("#divMessage").find("span").text(msg);

    //ap = $("#" + divId).overlay({ effect: 'apple', api: true  });
    //ap.load();
    //ap.onClose(function(event) {
    //    event.currentTarget.unbind();
    //});
    
    
    //Despliega directamente el div sin bindear
    $("#spnMsg").text(msg);
    $("#divMessage").overlay({effect: 'apple', api: true, top: 'center', closeOnClick: false, expose: { color: '#333', loadSpeed: 200, opacity: 0.2 } }).load();
}


//Return checkboxs from a div.
function getCheckBoxsFromDiv(divId, onlyChecked) {
    if (onlyChecked)
        return $("#" + divId + " input[type='checkbox']:checked");    
    
    return $("#" + divId + " input[type='checkbox']");
}