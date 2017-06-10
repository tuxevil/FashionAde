var tab = 0;
$(document).ready(function(){
    if ($("#Tab").val() > 0)
        tab = parseInt($("#Tab").val());

    if ($("#Alert").val() != "")
        showMessage($("#Alert").val());
        
    $("#Email").blur(CheckEmail);
    $("#ZipCode").blur(CheckZipCode);

    configureTabs();

});
    
function configureTabs(){
    var tabs = $(".accountTabs > li");
    var panes = $(".accountTabPanes > div");
    
    for(var i = 0; i < panes.length; i++)
        if(i != tab) $(panes[i]).hide(); //Hide all except the first
        else $(tabs[i]).addClass("tabSelected");
            
    $(".accountTabs").click(function(e){
        var src = getSourceElement(e);                
        if($(src).attr("className") != "tablink")
            src = $(src).children();  //if clicked the li, I get the link...
                        
        var selectedTab = $(src).parent();
        var selectedPane = $(src).attr("href");
        
        $(".accountTabs > li").removeClass("tabSelected");
        $(selectedTab).addClass("tabSelected");                        
        
        $(panes).hide();
        $(selectedPane).show();
    });
}
    
function CheckEmail(){
    temp = $(this).val().toString();
    if (temp != "") {
        var encoded = $.toJSON(temp);
        ajaxRequest("AccountValidation", "CheckEmail", encoded, ShowEmailMessage);
    }
    else {
        $("#EmailCheck").empty();
        $("#EmailCheck").hide();
    }
}

function ShowEmailMessage(data) {
    if (data.Exist == false) {
        $("#EmailCheck").empty();
        $("#EmailCheck").hide();    
        $("#btnEmail").removeAttr("disabled");
    }
    else {
        $("#EmailCheck").empty();
        if (data.RegExError == false){
            $("#EmailCheck").append("<span class='field-validation-error'>" + data.Email + " is in use</span>");
            $("#EmailCheck").show();
        }
        $("#btnEmail").attr("disabled", "disabled");
    }
}

function CheckZipCode(){
    temp = $(this).val().toString();
    
    if (temp != "") {
        var encoded = $.toJSON(temp);
        ajaxRequest("AccountValidation", "CheckZipCode", encoded, ShowZipCodeMessage);
    }
    else {
        $("#ZipCodeCheck").empty();
    }
}

function ShowZipCodeMessage(data){
    if (data.Exist == true) {
        $("#ZipCodeCheck").empty();
        $("#btnSaveInfo").removeAttr("disabled");
    }
    else {
        $("#ZipCodeCheck").empty();
        $("#ZipCodeCheck").append("<span class='field-validation-error'>The zip code " + data.ZipCode + " is not available</span>")
        $("#ZipCodeCheck").show();
        $("#btnSaveInfo").attr("disabled", "disabled");
    }
}