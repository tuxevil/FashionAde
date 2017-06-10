<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>
<%@ Import Namespace="FashionAde.Core.Clothing"%>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Upload Garment</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<h1>Upload images of your own clothes</h1>
<h3>Files uploaded</h3>
<h2>The following files were upload successfully:</h2>

<div class="uploadResults" style="float:left;">
    <%
        var i = 0;
        foreach (UserGarment userGarment in (List<UserGarment>)ViewData["uploadedFiles"])        
        {%>
        <div class="uploadItem">
            <a href="<%= Resources.GetGarmentLargePath() + userGarment.ImageUri %>" id="thumbnail_<%= i %>" class="viewUploadedImage" onclick="return false;" title="<%=userGarment.Title %>" >
                <img src="<%= Resources.GetGarmentLargePath() + userGarment.ImageUri %>" alt="<%=userGarment.Title %>" class="thumbnail"  />
            </a>
        </div>
    <% i++; } %>    
    <h2 style="clear:both;margin-left:10px;">Changed your mind? Return to <a href="<%= Url.RouteUrl(new { controller = "MyGarments", action= "Index" }) %>">My Garments</a></h2>
</div>



<div class="createOutfitDropable" style="float: left; width:400px; display:inline; margin-left:30px;">
    <div class="createYourOutfitTitle">  
        <div>
            <span>Image Edit Panel</span>                    
        </div>                    
    </div>   
    
    <div class="outfitDisplay" style="display:none;">
        <img id="imgOutfitUp" src="/static/img/MyGarments/outfit_up.jpg" /> Forward
        <img id="imgOutfitDown" src="/static/img/MyGarments/outfit_down.jpg" style="margin-left:10px;" /> Back
    </div>                
    
    <div id="MyOutfitDroppable" class="outfitDropable">
        <span style="margin-top:10px; display:block;">Do you want to crop your image, or are you ready to save it?</span>
        <div id="garmentContainment" class="dragGarmentsMessage" >            
            <div id="divImageEdit" style="margin-top:50px;"><img id="imgEdit" class="cropImage" /> </div>            
        </div>        
        Select or drag here the image that you want to edit.
        <div id="btnSave" class="cropSave divButtonBig">SAVE</div>            
    </div>
</div>

<input type="hidden" id="X" />
<input type="hidden" id="Y" />
<input type="hidden" id="W" />
<input type="hidden" id="H" />

</asp:Content>
<asp:Content ID="cropScripts" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
    <script src="/static/lib/jquery.jcrop.min.js"  type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="/static/js/cropImage.js"></script>
</asp:Content>