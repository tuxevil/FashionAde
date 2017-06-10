function GetQuestion(){
    $("#divUserName span.field-validation-error").remove();
    
    temp = $("#UserName").val().toString();
    if (temp == '')
        return;
        
    var encoded = $.toJSON(temp);
    ajaxRequest("Login", "GetQuestion", encoded, getQuestionSuccess);
}

function getQuestionSuccess(data) {
    if (data.Exist == true) {
        ShowQuestion(data.PasswordQuestion);
    }
    else {
        $("#divUserName span.field-validation-error").remove();
        var $span = $("<span>").addClass("field-validation-error").text("That username doesn't exist.");
        $("#divUserName").append($span);
    }
}

function ShowQuestion(data){
    $("#Question").text(data).css("color", "black");;
    $("#Answer").focus();
}