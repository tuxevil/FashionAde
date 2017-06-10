<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<HomeRegisteredUserInfo>" %>
<%@ Import Namespace="FashionAde.Core" %>
<%@ Import Namespace="FashionAde.Core.Clothing" %>
<%@ Import Namespace="FashionAde.Core.Views" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction" %>
<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <div id="fb-root"></div>
    <div id="tempMessage"></div>
<%
    string userName = Model.UserName;    
    TextInfo ti = new CultureInfo("en-US", false).TextInfo;
    userName = ti.ToTitleCase(userName);        
%>

<div class="declaredHomeLeft">
    <div>
        <h1>Welcome back, <strong><%= HttpUtility.HtmlEncode(userName) %></strong></h1>        
    </div>
    <div style="clear:both" ></div>
    <img src="/static/img/Home/registeredhome_v2.png" style="float:left;"/>
    <div class="RegisteredHomeSelector">
        <div class="RegisteredHomeSelectorItem">
            <span style="font-size: 30px; ">Add</span><span style="font-weight: normal;font-size: 30px; "> Garments</span><div class="divButtonSquare" style=" vertical-align:super; margin-left: 10px;" ><a href="<%= Url.RouteUrl(new { controller = "GarmentSelector", action= "Index"}) %>" style="color: White; text-decoration: none">GO!</a></div><br />
            Add garments from our master closet.
        </div>
        <div class="RegisteredHomeSelectorItem">
            <span style="font-size: 30px; ">Upload</span><span style="font-weight: normal;font-size: 30px; "> Garments</span><div class="divButtonSquare" style=" vertical-align:super; margin-left: 10px;" ><a href="<%= Url.RouteUrl(new { controller = "UploadGarment", action= "Index"}) %>" style="color: White; text-decoration: none">GO!</a></div><br />
            Upload your own garment photos to your Closet.
        </div>
        <div class="RegisteredHomeSelectorItem">
            <span style="font-size: 30px; ">What</span><span style="font-weight: normal;font-size: 30px; ">  are other women wearing?</span><div class="divButtonSquare" style=" vertical-align:super; margin-left: 10px;" ><a href="<%= Url.RouteUrl(new { controller = "OtherOutfits", action= "Index"}) %>" style="color: White; text-decoration: none">GO!</a></div><br />
            Peak inside other women’s closets.
        </div>
        <div class="RegisteredHomeSelectorItem" style="border: none; margin-bottom: 10px;">
            <span style="font-size: 30px; ">Add</span><span style="font-weight: normal;font-size: 30px; "> Friends</span><div class="divButtonSquare" style=" vertical-align:super; margin-left: 10px;" ><a href="<%= Url.RouteUrl(new { controller = "Friend", action= "Index"}) %>" style="color: White; text-decoration: none">GO!</a></div><br />
            You dont have any contacts yet. Start Now
        </div>
    </div>
</div>

<div class="declaredHomeRight">
    <div class="GarmentSelector_FilterDiv_FashionFlavorSelected" style="clear:both; margin-left:auto; margin-right:auto;">
            <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Title">Your Fashion Flavors:</span>                
            <% foreach (FashionFlavor flavor in Model.FashionFlavors)
               {  %>        
            <div class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box">
                <center>
                    <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Title" ><%=  flavor.Name %></span>
                    <img class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Image" src="<%= Resources.GetFashionFlavorThumbnailPath(flavor) %>" alt="<%= flavor.Name %>"  />
                </center>
            </div>                
        <% } %>
        <div style="clear: both" ></div>
    </div>    
    <div style="clear:both; margin-left:auto; margin-right:auto;">
        <% Html.RenderPartial("UpdaterTrends", Model.StyleAlerts); %>     
    </div>
</div> 
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">    
    <script src='/static/lib/jquery.rating.js' type="text/javascript" language="javascript"></script> 
    <script src='/static/lib/jquery.MetaData.js' type="text/javascript" language="javascript"></script>
    
    <script type="text/javascript">
    $(document).ready(function() {
        $('input.myratingstar').rating({
                required: 'hide'
	        });
	    });
        
        
        <% if (TempData["message"] != null)
           { %>
            appendMessage($("#tempMessage"), '<%= TempData["message"] %>', "success");            
        <% } %>                
        
    </script>
    
</asp:Content>
