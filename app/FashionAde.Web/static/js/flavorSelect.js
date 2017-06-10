var popupHeight = 515;
var popupWidth = 720;

$(document).ready(function() {
    $("#lnkBuildCloset").css("background-color", "#F08331");
    $(".quizPopup").dialog({ autoOpen: false, height: popupHeight, width: popupWidth, resizable: false, modal: true, close: function(event, ui) { clearQuizCheckBoxes(); } });

    $('.startQuiz').click(function(e) {
        $("#QuizStep1").dialog('option', 'show', 'slide');
        $("#QuizStep1").dialog('open');
    });

    $('.fashionFlavorSelect').mouseover(function() {
        var $chkCount = getCheckBoxsFromDiv("divFlavorSelect", true);
        if ($chkCount.length < 2) {
            $(this).removeClass("unselectedItem");
            $(this).addClass("selectedItem");
        }
    });

    $('#btnBuildNext').click(function(e) {
        var $chk = $("#buildYourCloset input[type='checkbox']:checked"); //Get only checked
        if ($chk.length == 0) {
            e.preventDefault();
            showMessage("You must choose up to 2 types to continue.");
            trackValidationError("Need to select flavors");
        }
        else document.forms[0].submit();
    });

    $(".fashionFlavorSelect input[type='checkbox']").click(function(e) {
        var src = getSourceElement(e);
        var $chkCount = getCheckBoxsFromDiv("divFlavorSelect", true);
        if ($chkCount.length <= 2) {
            if (src.checked) src.checked = true;
            else src.checked = false;
        } else src.checked = false;
    });

    $('.fashionFlavorSelect').click(function(e) {
        var src = getSourceElement(e);
        if (src.tagName != 'INPUT') {
            var $chk = getCheckBoxsFromDiv(this.id, false);
            if ($chk[0].checked) $chk[0].checked = false
            else {
                var $chkCount = getCheckBoxsFromDiv("divFlavorSelect", true);
                if ($chkCount.length < 2) $chk[0].checked = true;
            }
        }
    });

    $('.quizPopup').click(function(e) {
        var src = getSourceElement(e);
        if ($("#quizAlert").length > 0 && src.value != "Next")
            $("#quizAlert").remove();
    });

    $('.fashionFlavorSelect').mouseout(function() {
        var $chk = getCheckBoxsFromDiv(this.id, false);
        if (!$chk[0].checked) {
            $(this).removeClass("selectedItem");
            $(this).addClass("unselectedItem");
        }
    });

    $('.Quiz_Item_Box').click(function(e) {
        var src = getSourceElement(e);
        var $chk = getCheckBoxsFromDiv(this.id, false);
        if (src.nodeName != 'INPUT')
            $chk[0].checked = ($chk[0].checked) ? false : true;

        if ($chk[0].checked) {
            $(this).removeClass("unselectedQuizItem");
            $(this).addClass("selectedQuizItem");
        } else {
            $(this).removeClass("selectedQuizItem");
            $(this).addClass("unselectedQuizItem");
        }

    });

    $('#lnkQuizStep2').click(function(e) {
        e.preventDefault();
        changeStep($(this), "QuizStep1");
    });

    $('#lnkQuizStep3').click(function(e) {
        e.preventDefault();
        changeStep($(this), "QuizStep2");
    });

    $('#lnkQuizComplete').click(function(e) {
        e.preventDefault();
        changeStep($(this), "QuizStep3");
    });

    $("#lnkPreviousStep1").click(function(e) {
        e.preventDefault();
        var src = getSourceElement(e);
        previousStep($(src), "QuizStep2");
    });


    $("#lnkPreviousStep2").click(function(e) {
        e.preventDefault();
        var src = getSourceElement(e);
        previousStep($(src), "QuizStep3");
    });

    $("#lnkRestart").click(function(e) {
        e.preventDefault();
        clearQuizCheckBoxes();
        var src = getSourceElement(e);
        previousStep($(src), "QuizComplete");
    });

    startSilouhettePreloading(1);

    $("#btnContinueBuilding").click(function(e) {
        var form = document.getElementById('QuizForm')
        form.submit();
    });
});    

function changeStep(obj, currentStep){
    var id = obj.attr('href');        
    var $isValid = getCheckBoxsFromDiv("#" + currentStep, true);
    
    if ($isValid.length == 0) {       
        var item = "";
        switch (currentStep) {
            case "QuizStep1":
                item = "photo";
                break;

            case "QuizStep2":
                item = "store";
                break;

            case "QuizStep3":
                item = "group of words"
                break;
        }
        showMessage("You must choose at least one " + item + " to continue.");
        trackValidationError("Need to select " + item);
        return;
    }

    if (id == "#QuizComplete"){
        var $inputs = getCheckBoxsFromDiv(".quizContent", true);
        getFashionFlavors($inputs);
    }
        
    //Restore div to his original state....
    $("#" + currentStep).dialog('destroy');
    $("#" + currentStep).dialog({ autoOpen: false, height: popupHeight, width: popupWidth, resizable: false, modal: true, close: function(event, ui) { clearQuizCheckBoxes(); } });
    $(id).dialog('open');
}    

function previousStep(obj, currentStep){
    var id = obj.attr('href');
    $("#" + currentStep).dialog('destroy');
    $("#" + currentStep).dialog({ autoOpen: false, height: popupHeight, width: popupWidth, resizable: false, modal: true, close: function(event, ui) { clearQuizCheckBoxes(); } });
    $(id).dialog('open');
}

function selectedCheckBoxcesCount(chkObj){
    var divId = $(chkObj).parentElement.parentElement.id;
    return (getCheckBoxsFromDiv(divId, true)).length;
}

function clearQuizCheckBoxes(){
    //Uncheck all checkboxs...
    $chks = $(".quizContent").find("input[type='checkbox']:checked");
    for (var i = 0; i < $chks.length; i++)
        $chks[i].checked = false;

    //Remove orange border from the checkboxs!
    $(".quizContent").find(".selectedQuizItem").addClass(".selectedQuizItem");
    $(".Quiz_Item_Box").removeClass("selectedQuizItem");
    $(".Quiz_Item_Box").addClass("unselectedQuizItem");    
}

function getFashionFlavors($inputs){
    temp = new Array();
    $inputs.each(function() {
        temp.push(this.id);
    });

    $("#Result1").hide();
    $("#Result2").hide();
    
    var selection = { "Ids": temp };
    var encoded = $.toJSON(selection);
    ajaxRequest("FlavorQuiz", "GetResult", encoded, showResults);
}


function showResults(data){
    $("#Flavor1Id").val(data.FashionFlavor1Id);
    $("#Flavor1Name").val(data.FashionFlavor1Name);
    $("#FashionFlavor1Name").text(data.FashionFlavor1Name);
    $("#Flavor1Image").val("shape_" + data.FashionFlavor1Id + ".gif");
    $("#FashionFlavor1Image").attr("src", resPath + "shape_" + data.FashionFlavor1Id + ".gif");
    $("#Flavor1Result").val(data.FashionFlavor1Result);
    if (!data.Single) {
        $("#Flavor2Id").val(data.FashionFlavor2Id);
        $("#Flavor2Name").val(data.FashionFlavor2Name);
        $("#FashionFlavor2Name").text(data.FashionFlavor2Name);
        $("#Flavor2Image").val("shape_" + data.FashionFlavor2Id + ".gif");
        $("#FashionFlavor2Image").attr("src", resPath + "shape_" + data.FashionFlavor2Id + ".gif");
        $("#Flavor2Result").val(data.FashionFlavor2Result);
        $("#Result1").removeAttr("style");

        $("#Result1").show();
        $("#Result2").show();
    }
    else {
        $("#Result2").hide();
        $("#Result1").show();
        $("#Result1").attr("style", "margin-left:90px;");
    }
}