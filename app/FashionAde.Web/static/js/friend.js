$(document).ready(function(){
    $("#lnkFriends").css("background-color", "#F08331");
    appendOverlay(".erasefriend", "#RemoveConfirmation", saveFriendId);
    $("#btnRemove").click(RemoveFriend);
});

function saveFriendId(data){
    $("#FriendId").val(parseInt(data.getTrigger()[0].id.split("_")[1]));
}

function RemoveFriend(){
    $("#RemoveForm").submit();
}