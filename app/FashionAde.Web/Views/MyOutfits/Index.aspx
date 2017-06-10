<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<FashionAde.Web.Controllers.MVCInteraction.OutfitView>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>
<%@ Import Namespace="FashionAde.Core"%>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>My Outfits</title>
</asp:Content>

<asp:Content ID="contentOverlay" ContentPlaceHolderID="OverlayPlaceHolder" runat="server">
    <div id="fb-root"></div>
    <div class="modal" id="SendToFriends" style="width: 600px;opacity:1; "> 
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix" unselectable="on">
            <span class="inviteFriendTitle"  unselectable="on" >Email this outfit:</span>
            <img src='/static/img/close.png' class='close close_Image' />
            
        <div style="clear:both"></div>
        </div>
        <% Html.RenderPartial("InviteFriends"); %>        
        <div style="clear:both"></div>        
        <center>
            <div id="btnInviteFriends" class="divButton" style="margin-right:10px;" >INVITE FRIENDS</div>
            <div class="divButton close">CANCEL</div>            
        </center>
        <img id="imgLoading" src="/static/img/MyGarments/Ajax-loader.gif" style="float:right; display:block; margin-top:-32px; display:none;" />
    </div>
    
    <div class="modal" id="AddNotate" style="width: 300px; opacity:1; "> 
        <img src='/static/img/close.png' class='close close_Image' />
        <center>
            <p>Location: <%= Html.TextBox("Location", string.Empty, new { maxlength = 100 }) %> <span id="requiredLocation" class="hide" style="color:Red;">*</span></p>
            <p>Worn Date: <%= Html.TextBox("WornDate", string.Empty, new { maxlength = 10 })%> <span id="requiredWornDate" class="hide" style="color:Red;">*</span></p>
            <div id="btnAddNotate" class="divButton" >Add</div><div class="divButton close">Cancel</div>
        </center>
    </div> 
        
    <div class="modal" id="loading"> 
        <p>Loading... Please Wait</p> 
        <img src="http://l.yimg.com/a/i/us/per/gr/gp/rel_interstitial_loading.gif" />
    </div> 
 
    <input type="hidden" id="NoOne" />        
 
    <div class="modal" id="favoriteConfirmation" style="opacity:1;"> 
        <img src='/static/img/close.png' class='close close_Image' />
        <center>
            <p>Do you want to replace your favorite outfit with this?</p> 
            <div id="btnFavoriteConfirmation" class="divButton">Yes</div><div class="divButton close" >No</div>
        </center>
    </div> 
    
    <div class="modal" id="RemoveFavoriteConfirmation" style="opacity:1;"> 
        <img src='/static/img/close.png' class='close close_Image' />
        <center>
            <p>This is your favorite outfit. Are you sure to remove it as a favorite?</p> 
            <div id="btnRemoveFavoriteConfirmation" class="divButton">Yes</div><div class="divButton close" >No</div>
        </center>
    </div> 
    
    <div class="modal" id="AddToMyClosetConfirmation" style="opacity:1;"> 
        <img src='/static/img/close.png' class='close close_Image' />
        <center>
            <p>Are you sure to add this outfit to your closet?</p> 
            <div id="btnAddToMyClosetConfirmation" class="divButton">Yes</div><div class="divButton close" >No</div>
        </center>
    </div> 
    
    <div class="modal" id="SaveFiltersPopup" style="opacity:1;"> 
        <img src='/static/img/close.png' class='close close_Image' />
        <center>
            <p style="margin-bottom: 5px;">Filters combination name</p> 
            <input type="text" id="SaveFiltersName" style="width: 200px; margin-bottom: 15px;" maxlength= "30" onkeydown="if ((event.which && event.which == 13) || (event.keyCode && event.keyCode == 13)){saveFilters();return false;} else return true;" /><br />
            <div id="SaveFilterConfirm" class="divButton">Ok</div><div class="divButton close" >Cancel</div>
        </center>
    </div> 
    
    <div class="modal" id="SavedFilterRemoveConfirmation" style="opacity:1;"> 
        <img src='/static/img/close.png' class='close close_Image' />
        <center>
            <p>Are you sure to remove this saved filter?</p> 
            <div id="RemoveSavedFilterConfirm" class="divButton">Yes</div><div class="divButton close" >No</div>
        </center>
    </div> 
    
    <input type="hidden" id="Favorite" />  
    <input type="hidden" id="RemoveFavorite" />
    <input type="hidden" id="AddToMyCloset" /> 
    <input type="hidden" id="SaveFilters" /> 
    <input type="hidden" id="RemoveSavedFilter" />  
    
    <div class="modal" id="RemoveConfirmation" style="opacity:1;"> 
        <img src='/static/img/close.png' class='close close_Image' />    
        <center>
            <p>Are you sure to remove this item?</p> 
            <div id="btnRemove" class="divButton">Yes</div><div class="divButton close" >No</div>
        </center>
    </div> 
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<div id="errorMessage"></div>
<%
    string title = "My Outfits";
    if (Request.QueryString["userName"] != null)
        title = Request.QueryString["userName"].ToUpper() + "'s Outfits"; %>
    <h1><%= title %></h1>
    <% Html.RenderPartial("OutfitSearch", Model.Search); %>  
   
    <% Html.RenderPartial("OutfitList", Model); %>  

<input type="hidden" id="hiddenFilterText" value="<%= HttpUtility.HtmlEncode(Model.FilterText) %>" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script src='/static/lib/jquery.rating.js' type="text/javascript" language="javascript"></script> 
<script src='/static/lib/jquery.MetaData.js' type="text/javascript" language="javascript"></script>
<script src='/static/lib/jquery.autocomplete.js' type="text/javascript" language="javascript"></script>
<script src='/static/lib/jquery.maxlength.js' type="text/javascript" language="javascript"></script>
<script src='/static/js/myOutfits.js' type="text/javascript" language="javascript"></script>
<script src='/static/js/outfit.js' type="text/javascript" language="javascript"></script>

<script type="text/javascript" >
    var resGarmentPath = "<%= Resources.GetGarmentPath() %>";
    var loginUrl = "<%= Url.RouteUrl(new { controller = "Login", action= "Index"}) %>";    
    
    $(document).ready(function() {    
        <% if (Convert.ToBoolean(ViewData["procesingCloset"])) { %>
            appendMessage($("#errorMessage"), "As you can see, there are a lot of outfits in your closet! It may take us a few minutes to put all the combinations together, but in the meantime, you can consider these.", "info");
        <% } %>
        
        $("#txtMessage").maxlength({ maxCharacters: 240, slider: true });
    });
    
    function DisplayFavorite(id, name){
//        $("#FavoriteOutfit").html('<a href="<%= Url.RouteUrl(new { controller = "MyOutfits", action= "OutfitResume", outfitId = "code"  }) %>" >' + name + '</a>');
//        $("#FavoriteOutfit").html($("#FavoriteOutfit").html().replace("code", id));
    }
    
    function ChangePage(){
        apiOverlay.load();    
        $("#Page").val($(this).attr("id").split('_')[1]); 
        
        newSearch();
    }
</script>

<script type="text/javascript">
    window.fbAsyncInit = function() {
        FB.init({
            appId: '<%= ConfigurationManager.AppSettings["FacebookConnectId"] %>',
            xfbml: true,
            cookie: true,
            status: true
        });
    };
    (function() {
        var e = document.createElement('script'); e.async = true;
        e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
        document.getElementById('fb-root').appendChild(e);
    } ());

    function doPublish(attachment) {
        trackFacebookPublish();
        FB.ui(attachment);
    }
</script>
</asp:Content>