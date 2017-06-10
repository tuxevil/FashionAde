$(document).ready(function(){
    $("#lnkBuildCloset").css("background-color", "#F08331");
    $("#divSlider1").slider({
        min: 0,
        max: 100,
        step: 10,
        slide: function(event, ui) {
            if (ui.value == 100 || ui.value == 0)
                return false;                
            $("#spnSlider1").text(ui.value + '%');
            $("#Flavor1Weight").val(ui.value);
            $("#spnSlider2").text(100 - ui.value + '%');
            $("#Flavor2Weight").val(100 - ui.value);
            $("#divSlider2").slider('value', 100 - ui.value);
        }
    });

    $("#divSlider2").slider({
        min: 0,
        max: 100,
        step: 10,
        slide: function(event, ui) {
            if (ui.value == 100 || ui.value == 0)
                return false;
            $("#spnSlider2").text(ui.value + '%');
            $("#Flavor2Weight").val(ui.value);
            $("#spnSlider1").text(100 - ui.value + '%');
            $("#Flavor1Weight").val(100 - ui.value);
            $("#divSlider1").slider('value', 100 - ui.value);
        }
    });

    $("#divSlider1").slider('option', 'value', $("#Flavor1Weight").val());
    $("#divSlider2").slider('option', 'value', $("#Flavor2Weight").val());

    $("#spnSlider1").text($("#divSlider1").slider("value") + '%');
    $("#spnSlider2").text($("#divSlider2").slider("value") + '%');

    $("#btnWhatsYourFlavor").click(function(e){
        if ($("#divSlider2").slider("value") == 50) {
            e.preventDefault();
            showMessage("One style must be at least 60%.");
        }
        else document.forms[0].submit();
    });

    $("#spnSlider2").text($("#divSlider2").slider("value") + '%');
    startSilouhettePreloading(2);

    $("#btnPrevious").click(GoToPreviousStep)

});

function GoToPreviousStep() {
    document.forms[0].action = "/FlavorWeight/GoBack/default.aspx"
    document.forms[0].submit();
}