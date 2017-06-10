<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<OutfitResume>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Outfit Resume</title>
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
            <p>Location: <%= Html.TextBox("Location") %></p> 
            <p>Worn Date: <%= Html.TextBox("WornDate") %></p>
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
            <p>Do you want to replace youre favorite outfit with this?</p> 
            <div id="btnFavoriteConfirmation" class="divButton">Yes</div><div class="divButton close" >No</div>
        </center>
    </div> 
    
    <input type="hidden" id="Favorite" />  
    
    <div class="modal" id="RemoveConfirmation" style="opacity:1;"> 
        <img src='/static/img/close.png' class='close close_Image' />    
        <center>
            <p>Are you sure to remove this item?</p> 
            <div id="btnRemove" class="divButton">Yes</div><div class="divButton close" >No</div>
        </center>
    </div> 
    
    <div class="modal" id="AddToMyClosetConfirmation" style="opacity:1;"> 
        <img src='/static/img/close.png' class='close close_Image' />
        <center>
            <p>Are you sure to add this outfit to your closet?</p> 
            <div id="btnAddToMyClosetConfirmation" class="divButton">Yes</div><div class="divButton close" >No</div>
        </center>
    </div> 
    
    <input type="hidden" id="AddToMyCloset" />
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">    
    <% 
        bool isCurrentUserOutfit = (Membership.GetUser() != null && Membership.GetUser().UserName == Model.OutfitUserName) ? true : false;
        bool isFavorite = (Model.OutfitView.ClosetOutfit.IsFavouriteOutfit);
        string userName = (isCurrentUserOutfit) ? "MY" : Model.OutfitUserName.ToUpper() + "'S";
        
        if (isCurrentUserOutfit)
        { 
            if(isFavorite) { %>
                <h1>My Favorite Outfit</h1>                
            <% } else { %>
                <h1>My Outfits</h1>                
            <% } %>        
            <a href="<%= Model.UserClosetUrl %>"  class="divButton" style="padding:3px 5px 3px 5px; margin-left:20px; background-color:#496694; text-decoration:none;" >RETURN TO <%= HttpUtility.HtmlEncode(userName) %> CLOSET</a>
            <br /><br />
        <% } else {  
            if(isFavorite) { %>
                <h1><%= Model.OutfitUserName %>'s Favorite Outfit</h1>
                <br />
            <% } else { %>
            <h1><%= HttpUtility.HtmlEncode(userName) %> Outfits</h1>
            <a href="<%= Model.UserClosetUrl %>"  class="divButton" style="padding:3px 5px 3px 5px; margin-left:20px; background-color:#496694; text-decoration:none;" >RETURN TO <%= HttpUtility.HtmlEncode(userName) %> CLOSET</a>
            <br /><br />
        <% } %>
    <% } %>
    
    
    <%  Html.RenderPartial("Outfit", Model.OutfitView); %>
    
    <% if (Model.ShowRatings){%>
    <div style="width: 100%;">
        <div class="OutfitDiv" style="width: 300px; border: solid 2px #DDE4EE; float: left;">
            <div>  
                <div class="outfitHeader" style="background-color: #DDE4EE;">     
                    <span class="outfitTitle" style="margin: 11px 0 0 7px; font-size: 16px; color: #656563; font-weight: bold;"><%= Model.TotalFriendRatings%> Friends Rated this Outfit</span>
                </div>        
                <div style="padding: 10px 30px 10px 0;">
            <% if (Model.Ratings.Count > 0)
                   foreach (OutfitResumeFriendRating rating in Model.Ratings)
                   {%>        
                    <div style="margin-bottom: 3px; margin-left: 25px;"><span style="float: left; display: block;"><%= rating.Count%> Friend<% if (rating.Count > 1)
                                                                                                                                               {%>s<%} %></span> <span style="color: #656563; font-weight: normal; float: left; display: block; margin-left: 5px;">gave this a</span> <span style="margin-left: 5px; float: left; display: block; margin-right: 5px;"><%= rating.Rating%></span> <img style="float:right;" src="<%= Resources.GetRatingLargePath() + rating.Rating + ".jpg" %>" alt="<%= rating.Rating %>" /></div>
                <%}
               else
               {%> <span style="color: #656563; font-weight: normal; margin-left: 25px;">There is no ratings from friends.</span>
               <%} %>
               <div style="clear:both;" ></div>
                </div>
            </div> 
        </div>

        <div class="OutfitDiv" style="width: 375px; margin-left: 19px; border: solid 2px #DDE4EE;  float: left; clear: none;">
            <div>  
                <div class="outfitHeader" style="background-color: #DDE4EE;">     
                    <span class="outfitTitle" style="margin: 11px 0 0 7px; font-size: 16px; color: #656563; font-weight: bold;">Friends Comments</span>
                </div> 
                <div style="padding: 10px 10px 10px 10px;">       
            <% if (Model.Comments.Count > 0)
                   foreach (OutfitResumeFriendComments comment in Model.Comments)
                   {%>        
                    <div style="margin-bottom: 5px;"><span><%= HttpUtility.HtmlEncode(comment.Name) %>:</span> <span style="color: #656563; font-weight: normal;">"<%= HttpUtility.HtmlEncode(comment.Comment) %>"</span></div>
                <%}
               else
               {%> <span style="color: #656563; font-weight: normal; margin-left: 25px;">There is no comments from friends.</span>
               <%} %>
                </div>
            </div> 
        </div>
    </div>
    <%} %>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script src='/static/lib/jquery.rating.js' type="text/javascript" language="javascript"></script> 
<script src='/static/lib/jquery.MetaData.js' type="text/javascript" language="javascript"></script>
<script src='/static/lib/jquery.autocomplete.js' type="text/javascript" language="javascript"></script>
<script src='/static/lib/jquery.maxlength.js' type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="/static/js/outfitResume.js"></script>
<script type="text/javascript" src="/static/js/outfit.js"></script>

<script type="text/javascript" >
    var resGarmentPath = "<%= Resources.GetGarmentPath() %>";
</script>
<script>
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
        FB.ui(attachment);
    }
    
    $(document).ready(function() {    
        $("#txtMessage").maxlength({ maxCharacters: 10, slider: true });
    });

</script>

</asp:Content>