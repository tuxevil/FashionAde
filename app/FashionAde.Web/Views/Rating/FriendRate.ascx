<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<FriendRatingView>" %>
<%@ Import Namespace="FashionAde.Core.Views"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<% Html.EnableClientValidation(); %>
<% using (Html.BeginForm("Vote","Rating"))
   {
       Response.Write(Html.HiddenFor(x => x.ClosetOutfitId)); 
       Response.Write(Html.HiddenFor(x => x.InvitationId)); 
%>
    <div style="clear:both; width:580px;">
        <%  foreach (ClosetOutfitGarmentView garment in Model.ClosetOutfit.OutfitGarments)                
            { %>
                <div class="Outfit_Result_Garment"><img src="<%= Resources.GetClosetOutfitGarmentViewPath(garment) %>" alt="<%= garment.Title %>" title="<%= garment.Title %>" /></div>
        <% }
       
        if (Model.Updater != null)
        {
        %>
        <div class="Outfit_Result_Garment" style="margin-top:0px;"><a href='<%= Model.Updater.BuyUrl %>' style="border:0; display:inline; text-decoration: none;" ><span><%= Model.Updater.Partner.Name %></span><br /><img class="<%="OutfitUpdaterImg_" + Model.Updater.Partner.Code%>" src="<%= Model.Updater.ImageUrl %>" alt="<%= Model.Updater.Name %>" /><br /><span><%= Convert.ToDecimal(Model.Updater.Price).ToString("$#,##0.00")%></span></a></div>
        <%}%>
    </div>
    <div style="clear:both;"></div>
    
    <div style="margin-left: 31px;">
        <table><tr><td><div style="width: 17px; margin-top: 33px; margin-left: -3px; float: left" >
            <% = Html.RadioButtonFor(x => x.FriendRating, 1, new { @class = "friendratingstar" })%>
            <% = Html.RadioButtonFor(x => x.FriendRating, 2, new { @class = "friendratingstar" })%>
            <% = Html.RadioButtonFor(x => x.FriendRating, 3, new { @class = "friendratingstar" })%>
            <% = Html.RadioButtonFor(x => x.FriendRating, 4, new { @class = "friendratingstar" })%>
            <% = Html.RadioButtonFor(x => x.FriendRating, 5, new { @class = "friendratingstar" })%>
        </div>
        <div style="float: left;">
            <span style="color:Black; white-space:nowrap;">Rate this Outfit Combination now by entering a number in the box:</span>
            <p>Rating Scale:<br />
                1 = Never wear this!<br />
                2 = Wear it in pinch<br />
                3 = Wear it occasionally<br />
                4 = Love it – put it in regular rotation!<br />
                5 = This is a Signature Outfit*
            </p>
        </div>
        </td><td><%= Html.ValidationMessageFor(x => x.FriendRating)%></td></tr></table>
    </div>
    <div style="clear:both;" ></div>
    
    <span style="margin-left: 30px;">Share your comments with </span><span id="User2">User</span><span>:</span><br />
    <table><tr><td>
    <% = Html.TextAreaFor(x => x.Comment, new { style = "margin-left: 30px; width: 500px; height: 100px;" }) %>
    </td>
    <td><%= Html.ValidationMessageFor(x => x.Comment)%></td></tr></table><br /><br />
    
    <center>
        <input type="submit" class="divButton" value="Submit" />
    </center>
    <% }%>
    
    


