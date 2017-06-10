<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<ClosetOutfitView>" %>
<%@ Import Namespace="FashionAde.Core.Views"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<table border="0" class="OutfitDiv" id="<%= "div_" + Model.Id  %>" >
    <%
    string images = string.Empty;
    string key = Model.ClosetOutfitId.ToString();
    int cant = 1;
    foreach (ClosetOutfitGarmentView garment in Model.OutfitGarments)
    {
        if (garment.GarmentId == 0)
            continue;
        if(cant <=5)
               images += "{'type':'image','src':'" + Resources.GetClosetOutfitGarmentViewPath(garment) + "','href':'" + ConfigurationManager.AppSettings["SiteURL"] + "/Outfit/Rating/Vote/" + key + "/default.aspx'},";
        cant++;
    }
    if (images.Length > 0)
        images = images.TrimEnd(','); %>           
    <%--Headers All--%>
    <tr class="outfitHeader">
        <%--Container Header--%>
        <td colspan="2" style="vertical-align:top; padding:0;">
             <a href="<%= Url.RouteUrl(new { controller = "MyOutfits", action= "OutfitResume", outfitId = Model.Id  }) %>" id="OutfitName" class="outfitName" title="Check your friend ratings and more details!"><%= Model.ShortEventTypes + Model.ClosetOutfitId %></a>
                     <% if (!Model.Disabled)
                        {%>
                <img id="<%= "cls_" + Model.ClosetOutfitId %>" src="/static/img/MyGarments/bluex.JPG" class="OutfitRemove" />
                <%} %>
                <% if (!Model.ShowAddToMyCloset)
                   { %>
            <div style="float: right; margin: 12px 15px 0px 15px">
                <form name="<%= "myRating_" + Model.ClosetOutfitId%>">
                    <input id="<%= "ratingPrevious_" + Model.ClosetOutfitId %>" type="hidden" />
                    <span id="<%= "rn_" + Model.ClosetOutfitId %>" class="rateNow">Rate now:</span>
                    <%  string disable = "";
                        if (Model.Disabled)
                            disable = "disabled='disabled'";
                        if (Model.MyRating > 0)
                        { %>
                        <div class="starImg" style="display: inline;" >
                            <% for (float count = 1; count <= 5; count++)
                               {
                                   string tooltip = "";
                                   switch (Convert.ToInt32(count))
                                   {
                                       case 1:
                                           tooltip = "Very Poor";
                                           break;
                                       case 2:
                                           tooltip = "Poor";
                                           break;
                                       case 3:
                                           tooltip = "Normal";
                                           break;
                                       case 4:
                                           tooltip = "Good";
                                           break;
                                       case 5:
                                           tooltip = "Very Good";
                                           break;

                                   }
                                   if (count == Model.MyRating)
                                   {%>
                                    <input id="<%= "myrating_" + Model.ClosetOutfitId %>" name="<%= "myrating_" + Model.ClosetOutfitId %>" type="radio" checked="checked" class="myratingstar" value="<%= count %>" title="<%= tooltip %>" <%= disable %> />
                                <% }
                                   else
                                   { %>
                                    <input id="<%= "myrating_" + Model.ClosetOutfitId %>" name="<%= "myrating_" + Model.ClosetOutfitId %>" type="radio" class="myratingstar" value="<%= count %>" title="<%= tooltip %>" <%= disable %> />
                                <% }
                               }%>
                        </div>
                    <% }
                        else
                        { %>
                        <div class="starImg">
                            <input id="<%= "myrating_" + Model.ClosetOutfitId %>" name="<%= "myrating_" + Model.ClosetOutfitId %>" type="radio" class="myratingstar" value="1" title="Very Poor" <%= disable %> />
                            <input id="<%= "myrating_" + Model.ClosetOutfitId %>" name="<%= "myrating_" + Model.ClosetOutfitId %>" type="radio" class="myratingstar" value="2" title="Poor" <%= disable %> />
                            <input id="<%= "myrating_" + Model.ClosetOutfitId %>" name="<%= "myrating_" + Model.ClosetOutfitId %>" type="radio" class="myratingstar" value="3" title="Normal" <%= disable %>/>
                            <input id="<%= "myrating_" + Model.ClosetOutfitId %>" name="<%= "myrating_" + Model.ClosetOutfitId %>" type="radio" class="myratingstar" value="4" title="Good" <%= disable %>/>
                            <input id="<%= "myrating_" + Model.ClosetOutfitId %>" name="<%= "myrating_" + Model.ClosetOutfitId %>" type="radio" class="myratingstar" value="5" title="Very Good" <%= disable %>/>
                        </div>
                    <% } %>                
                    <input class="MyRatingValue" id="<%= Model.ClosetOutfitId %>" type="hidden" value="<%= Model.MyRating %>" />
                    <img id="loadingMyRating_<%= Model.ClosetOutfitId %>" src="/static/img/ajax-loader-small.gif" alt="" style="margin-top:5px; display:none; margin-left:3px;" />
                </form>
            </div>
            <%} %>
            <%if (Model.SendToFriends){%>
            <div style="float: right; margin: 12px 5px 0px 5px"><input id="<%= "btnSendToFriends_" + Model.Id %>" class="SendToFriends" type="image" src="/static/img/FriendProviders/mail.JPG" onClick="javascript:{return false;}" value="Send Now" /><span id="<%= "spnSendToFriends_" + Model.Id %>" class="SendToFriends" onClick="javascript:{return false;}" style="text-decoration: underline;" >Send Friends</span></div>
            <%}
            if (!Model.Disabled){%>
            <div style="float: right; margin: 12px 5px 0px 5px"><input type="image" onclick="
                doPublish({method: 'stream.publish',attachment: {
                        'name':'FashionAde',
                        'href':'<%= ConfigurationManager.AppSettings["SiteURL"] %>/Outfit/Rating/Vote/<%= key %>/default.aspx',
                        'description':'I am building an outfit around this garment - click here to see the whole look and tell me what you think.',
                        'media':[<%= images %>]
                    },
                    action_link: [
                      {
                        text: 'Rate it now!',
                        href: '<%= ConfigurationManager.AppSettings["SiteURL"] %>/Outfit/Rating/Vote/<%= key %>/default.aspx'
                      }
                    ]});return false;" value="Share in Facebook" src="/static/img/f.PNG" class="shareFacebook" title="Share in Facebook" /> 
                    <span onclick="
                doPublish({method: 'stream.publish',attachment: {
                        'name':'FashionAde',
                        'href':'<%= ConfigurationManager.AppSettings["SiteURL"] %>/Outfit/Rating/Vote/<%= key %>/default.aspx',
                        'description':'I am building an outfit around this garment - click here to see the whole look and tell me what you think.',
                        'media':[<%= images %>]
                    },
                    action_link: [
                      {
                        text: 'Rate it now!',
                        href: '<%= ConfigurationManager.AppSettings["SiteURL"] %>/Outfit/Rating/Vote/<%= key %>/default.aspx'
                      }
                    ]});return false;" class="shareFacebook" style="text-decoration: underline; cursor: pointer">Share in Facebook</span></div>
            <%} %>
        </td>
    </tr>    
    <tr>
        <%--Container Content (Garments)--%>
        <td><div style="width: 440px;">
         <%
            foreach (ClosetOutfitGarmentView garment in Model.OutfitGarments)
            {
                if (garment.GarmentId == 0)
                    continue;
                 %>        
                <div class="Outfit_Result_Garment">
                    <img id="g_<%= garment.GarmentId %>" src="<%= Resources.GetClosetOutfitGarmentViewPath(garment) %>" alt="<%= garment.Title %>" title="<%= garment.Title %>" />
                </div>            
                <% 
            }%> 
            <div style="clear:both;"></div>
            </div>          
            <div style="clear: both; width: 440px;">
            <% if (!Model.Disabled) {%>
    <div id="<%= "btnSeeMannequin_" + Model.Id %>" class="seeMannequin">TRY THIS ON</div>
<% } else {  %>
    <% if (Model.ShowAddToMyCloset && Membership.GetUser() != null)
       { %>                         
            <div type="button" class="addToMyCloset" style="text-decoration: underline; cursor: pointer;" id="<%= Model.Id %>">Add To My Closet</div>
            <img id="addToClosetLoading_<%= Model.Id %>" src="/static/img/ajax-loader-small.gif" style="margin:11px 0 0 5px; float:left; display:inline; display:none;" />
       <% } %>
<% } %>
            <div style="clear:both;"></div>
            </div>
        </td>
        <%--Updater Content--%>
        <td class="outfitUpdater" style="vertical-align:top;">
            <% if (Model.OutfitUpdater != null) { %>
                <% using (Html.BeginForm("TrackOutfitUpdater", "OutfitUpdaters", FormMethod.Get)) { %> 
                    <div class="Outfit_Result_Garment" style="margin: 5px 0 15px 5px; display:block; width: 100%;">
                        <div class="outfitUpdaterContainer">
                            <a href="<%= Url.Action("TrackOutfitUpdater", "OutfitUpdaters", new { updaterId = Model.OutfitUpdater.Id, updaterOutfitId = Model.ClosetOutfitId, updaterBuyUrl = Model.OutfitUpdater.BuyUrl } ) %>" target="_blank">                        
                                <img class="<%="OutfitUpdaterImg_" + Model.OutfitUpdater.Partner.Code%>" src="<%=Model.OutfitUpdater.ImageUrl%>" alt="<%=Model.OutfitUpdater.Name + " $" + Model.OutfitUpdater.Price%>" title="<%=Model.OutfitUpdater.Name + " $" + Model.OutfitUpdater.Price%>" />
                            </a>
                        </div>
                        <div class="outfitUpdaterContainer" style="text-align: left;">
                            <%= Html.ActionLink("BUY", "TrackOutfitUpdater", "OutfitUpdaters", new { updaterId = Model.OutfitUpdater.Id, updaterOutfitId = Model.ClosetOutfitId, updaterBuyUrl = Model.OutfitUpdater.BuyUrl }, new { @class = "buyButton addThis", target = "_blank", style = "width: 50px; text-align: center; margin-bottom: 5px; margin-left: 0px; display:inline; " })%>
                            <div style="clear:both; width: 100px;"><span style="font-family: Arial; font-size: 11px;"><%= Model.OutfitUpdater.Partner.Name %></span></div>
                            <% if (Model.OutfitUpdater.Price != null) { %>
                                <span style="color: black; font-weight: normal;  font-size: 11px;"><%= Convert.ToDecimal(Model.OutfitUpdater.Price).ToString("$#,##0.00")%></span><br /><br />
                                <a href="<%= Url.RouteUrl(new { controller = "OutfitUpdaters", action= "Index", Model.OutfitUpdater.Id, Model.ClosetOutfitId }) %>" class="linkViewAll">VIEW ALL</a>   
                            <%} %>
                        </div>
                    </div>                
                    <% } %>
                <% } %>
        </td>
    </tr>
    <tr>
        <td style="margin:0; padding:0; border-top: solid 2px #C4CCDF; ">
            <div class="outfitBottom">
             <% 
                string wornDate = "?";
                string location = "?";
                if (Model.Disabled)
                {
                    wornDate = "N/A";
                    location = "N/A";
                }
                if (Model.WornDate.Year > 1)
                    wornDate = Model.WornDate.ToString("MM/dd/yyyy");
                if (!string.IsNullOrEmpty(Model.Location))
                    location = Model.Location;
             %>
            <div class="Outfit_Details" style="width: 140px; padding-left:10px;margin-top: 4px;" >
                Last worn: <span id="<%= "LastWorn_" + Model.Id %>" style="color: #767676;"><%= wornDate%></span></div>
            <div class="Outfit_Details" style="width:140px; margin-right:5px;margin-top: 4px;" >To: 
                <span id="<%= "To_" + Model.Id %>" style="color: #767676; "><%= HttpUtility.HtmlEncode(location) %></span>
            </div>
            
            <% if (!Model.Disabled) 
               { %>
                <div class="Outfit_Details" style="float: right; margin-right: 10px;">
                    <div id="<%= "btnNotation_" + Model.Id %>" class="OutfitNotate divButtonSquare addDetailsButton" >ADD UP TO DATE</div>
                </div>
            <% } %> 
            </div>
        </td>  
        <td style="border-left: solid 2px #C4CCDF;">
            <%-- Rating Content--%>       
            <div class="starRating">
                <div class="divStar"><%= Convert.ToInt16(Model.EditorRating) %></div><span style="line-height: 1 !important;">Editor Rating</span>
            </div>
            <div class="starRating">
            <%
               string myRating = "?";
               if (Model.MyRating > 0)
                   myRating = Convert.ToInt16(Model.MyRating).ToString(); %>
                <div id="<%= "MyRateValue_" + Model.ClosetOutfitId%>" class="RateNow divStar"><%= myRating %></div><span>My Rating</span>
            </div>
            <div class="starRating">
                <div class="divStar"><%= Convert.ToInt16(Model.AverageFriendRating) %></div><span>Friends Rating</span>
            </div>        
        </td>
    </tr>
</table>