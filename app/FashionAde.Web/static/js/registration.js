var apiOverlay;
var emailvalid = true;
var uservalid = true;
var zipcodevalid = true;

$(document).ready(function() {
    $("#lnkBuildCloset").css("background-color", "#F08331");
    $("#Email").blur(CheckEmail);
    $("#UserName").blur(CheckUsername);
    $("#ZipCode").blur(CheckZipCode);

    apiOverlay = appendOverlay("#NoOne", "#loading", null, null);
    
    $("#TermOfUse").click(function(e) {
        if ($(this).is(":checked"))
            $("#termsOfUseCheck").hide();
    });

    $("form").submit(function() {
        if (!$("#TermOfUse").is(":checked")) {
            $("#termsOfUseCheck").show();
            return false;
        }
    });

    $("#btnPrevious").click(GoToPreviousStep)
});

function GoToPreviousStep() {
    document.forms[0].action = "/Registration/SaveTempData/default.aspx"
    document.forms[0].submit();
}

function OpenModal(){
    apiOverlay.load();
}

function CheckEmail(){
    temp = $(this).val().toString();

    if (temp != "") {
        var encoded = $.toJSON(temp);        
        ajaxRequest("AccountValidation", "CheckNewEmail", encoded, ShowEmailMessage);
    }
    else {
        $("#EmailCheck").empty();
        $("#EmailCheck").hide();
    }
}

function ShowEmailMessage(data){
    if (data.Exist == false) {
        $("#EmailCheck").empty();
        $("#EmailCheck").hide();    
        emailvalid = true;
        if (emailvalid && uservalid && zipcodevalid)
            $("#btnRegister").removeAttr("disabled");
    }
    else {
        $("#EmailCheck").empty();
        if (data.RegExError == false)
            {
                $("#EmailCheck").append("<span class='field-validation-error'>" + data.Email + " is in use</span>");
                $("#EmailCheck").show();
            }
            
        $("#btnRegister").attr("disabled", "disabled");
        emailvalid = false;
    }
}

function CheckUsername() {
    temp = $(this).val().toString();

    if (temp != "") {
        var encoded = $.toJSON(temp);        
        ajaxRequest("AccountValidation", "CheckUsername", encoded, ShowUsernameMessage);
    }
    else {
        $("#UserNameCheck").empty();
        $("#UserNameCheck").hide();
    }
}

function ShowUsernameMessage(data) {
    if (data.Exist == false) {
        if (data.Reserved == false) {
            $("#UserNameCheck").empty();
            $("#UserNameCheck").hide();
            uservalid = true;
            if (emailvalid && uservalid && zipcodevalid)
                $("#btnRegister").removeAttr("disabled");
        }
        else {
            $("#UserNameCheck").empty();
            $("#UserNameCheck").append("<span class='field-validation-error'>The username " + data.Username + " is reserved.</span>")
            $("#UserNameCheck").show();
            $("#btnRegister").attr("disabled", "disabled");
            uservalid = false;
        }
    }
    else {
        $("#UserNameCheck").empty();
        $("#UserNameCheck").append("<span class='field-validation-error'>The username " + data.Username + " is not available but <a id='UserRecommended' style='color: #0A466E; font-weight: bold; display: inline;' href='#" + data.Recommended + "'>" + data.Recommended + "</a> is.</span>")
        $("#UserNameCheck").show();
        $("#btnRegister").attr("disabled", "disabled");
        $("#UserRecommended").click(function(e) {
            e.preventDefault();
            $("#UserName").val(data.Recommended);
            $("#UserName").blur();
        })
        uservalid = false;
    }
}

function CheckZipCode() {
    temp = $(this).val().toString();

    if (temp != "") {
        var encoded = $.toJSON(temp);
        ajaxRequest("AccountValidation", "CheckZipCode", encoded, ShowZipCodeMessage);
    }
    else {
        $("#ZipCodeCheck").empty();
    }
}

function ShowZipCodeMessage(data) {
    if (data.Exist == true) {
        $("#ZipCodeCheck").empty();
        zipcodevalid = true;
        if (emailvalid && uservalid && zipcodevalid)
            $("#btnRegister").removeAttr("disabled");
    }
    else {
        $("#ZipCodeCheck").empty();
        $("#ZipCodeCheck").append("<span class='field-validation-error'>The zip code " + data.ZipCode + " is not available</span>")
        $("#ZipCodeCheck").show();
        $("#btnRegister").attr("disabled", "disabled");
        zipcodevalid = false;
    }
}