$(document).ready(function(){
    $("#lnkBuildCloset").css("background-color", "#F08331");
    
    $('.eventTypeSelect').mouseover(function() {
        $(this).css("background-color", "#F4F4F4");
        $(this).css("border", "solid 1px #9D9C9B");
    });

    $('#btnEventTypeNext').click(function(e){
        $checked = getCheckBoxsFromDiv("divFlavorSelection", true);
        if ($checked.length == 0) {
            e.preventDefault();
            showMessage("You must choose at least one event type.");
            trackValidationError("Need to select Event Type");
        }
        else document.forms[0].submit();
    });

    $('.eventTypeSelect').click(function(e){
        var src = getSourceElement(e);
        if (src.id == "") {
            var $chk = getCheckBoxsFromDiv(this.id, false);
            $chk[0].checked = ($chk[0].checked) ? false : true;
        }
    });

    $('.eventTypeSelect').mouseout(function(){
        var $chk = getCheckBoxsFromDiv(this.id, false);
        if (!$chk[0].checked) {
            $(this).css("background-color", "#FFFFFF");
            $(this).css("border", "solid 1px #FFFFFF");
        }
    });

    startSilouhettePreloading(2);

    $("#btnEventTypePrevious").click(GoToPreviousStep)
});

function GoToPreviousStep() {
    document.forms[0].action = "/EventTypeSelector/GoBack/default.aspx"
    document.forms[0].submit();
}