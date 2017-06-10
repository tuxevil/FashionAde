var selected = 0;
var items = new Array();
var allSelected = false;
var total = $("#TotalCount").val();

$(document).ready(function(){
    $("#checkAll").click(function() {
        allSelected = true;
        items = new Array();
        $(".contact").each(function(i) { this.checked = true; });
        updateInputHiddenFields();
    });

    $("#uncheckAll").click(uncheckAll);    
    updateInputHiddenFields();        
    $(".contact").live("click", checkboxClick);
});


function uncheckAll() {
    allSelected = false;
    items = new Array();
    $(".contact").each(function(i) { this.checked = false; });
    updateInputHiddenFields();
}

function checkbox_state_add(id){
    checkbox_state(id, true);
    $("input[type='checkbox'][value='" + id + "']").attr("checked", true);
}

function checkbox_state_remove(id){
    checkbox_state(id, false);
    $("input[type='checkbox'][value='" + id + "']").attr("checked", false);
}

function checkbox_state(id, add){
    var value = id;
    var itemIndex = jQuery.inArray(value, items);

    if (allSelected) {
        // When allSelected is checked, the items list include the excluded items.
        if (!(add) && itemIndex == -1)
            items.push(value);
        else if (add && itemIndex != -1) {
            items = jQuery.grep(items, function(currentItem) {
                return currentItem != value;
            });
        }
    }
    else {
        // Otherwise works as expected, we maintain the list of items selected.
        if (add && itemIndex == -1)
            items.push(value);
        else if (!(add) && itemIndex != -1) {
            items = jQuery.grep(items, function(currentItem) {
                return currentItem != value;
            });
        }
    }
    updateInputHiddenFields();
}

function checkboxClick() {
    checkbox_state($(this).attr("id").split('_')[1], $(this).is(":checked"));
}

function updateInputHiddenFields(){
    $("#SelectedIndexes").val(items.join(","));
    $("#SelectedAll").val(allSelected);

    if (allSelected == false) {
        selected = items.length;
    }
    else {
        selected = total - items.length;
    }
    PressUnpress();
}

function PressUnpress(){
    if (selected > 0) {
        $("#checkAll").removeClass();
        $("#uncheckAll").removeClass();
    }
    else {
        $("#checkAll").removeClass();
        $("#uncheckAll").addClass("pressed");
    }
    if (selected == total) {
        $("#checkAll").addClass("pressed");
        $("#uncheckAll").removeClass();
    }
}