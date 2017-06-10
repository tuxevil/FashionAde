<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<ClosetOutfitView>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>
<%@ Import Namespace="FashionAde.Core.MVCInteraction"%>
<%@ Import Namespace="FashionAde.Core"%>

<%--<input type="hidden" id="ClosetOutfitId" name="ClosetOutfitId" value="<%= Model.Id %>" />--%>
    <div style="clear:both; width: 580px; float:left;">
        <%  foreach (ClosetOutfitGarmentView garment in Model.OutfitGarments)                
            { %>
                <div class="Outfit_Result_Garment"><img src="<%= Resources.GetPath("Garments", garment.ImageUri) %>" alt="<%= garment.Title %>" title="<%= garment.Title %>" /></div>
        <% } %>
    </div>
    <div style="clear:both;" ></div>
    <h2>Rate this look to and share feedback with <span id="User1">User</span></h2>
    
    
    <div style="margin-left: 100px;">
        <div style="width: 17px; margin-top: 33px; margin-left: -3px; float: left" >
            <input id="<%= "friendsrating"%>" name="<%= "friendsrating"%>" type="radio" class="friendratingstar" value="1" />
            <input id="<%= "friendsrating"%>" name="<%= "friendsrating"%>" type="radio" class="friendratingstar" value="2" />
            <input id="<%= "friendsrating"%>" name="<%= "friendsrating"%>" type="radio" class="friendratingstar" value="3" />
            <input id="<%= "friendsrating"%>" name="<%= "friendsrating"%>" type="radio" class="friendratingstar" value="4" />
            <input id="<%= "friendsrating"%>" name="<%= "friendsrating"%>" type="radio" class="friendratingstar" value="5" />
        </div>
        <div style="float: left">
            <span style="color:Black; margin-left: -15px;">Rate this Outfit Combination now by entering a number in the box:</span>
            <p>Rating Scale:<br />
                1 = Never wear this!<br />
                2 = Wear it in pinch<br />
                3 = Wear it occasionally<br />
                4 = Love it – put it in regular rotation!<br />
                5 = This is a Signature Outfit*
            </p>
        </div>
    </div>
    <div style="clear:both;" ></div>
    
    <span style="margin-left: 30px;">Share your comments with </span><span id="User2">User</span><span>:</span><br />
    <textarea id="Comments" style="margin-left: 30px; width: 600px; height: 100px;"></textarea><br /><br />
    
    <center>
        <input type="submit" class="divButton" value="Submit" />
    </center>
    
 <input type="hidden" id="Key" value="<%= ViewData["Key"] %>"/>   


