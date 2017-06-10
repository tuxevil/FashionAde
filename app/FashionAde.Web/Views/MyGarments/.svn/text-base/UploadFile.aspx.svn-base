<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>
<%@ Import Namespace="FashionAde.Core.Clothing"%>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<link rel="stylesheet" href="../../css/jquery.Jcrop.css" type="text/css" />
<h1>Files uploaded</h1>
<div class="uploadResults">
    The following files were upload successfully:<br /><br />
    
    <div class="thumbnailContainer">
    <%
        var i = 0;
        foreach (UserGarment userGarment in (List<UserGarment>)ViewData["uploadedFiles"])        
        {%>
        <div class="uploadItem">
            <a href="/res/Garments/<%=userGarment.ImageUri %>" id="thumbnail_<%= i %>" class="viewUploadedImage" onclick="return false;" title="<%=userGarment.Title %>" >
                <img src="/res/Garments/<%=userGarment.ImageUri %>" alt="<%=userGarment.Title %>" class="thumbnail"  />
            </a>            
        </div>        
    <% i++; } %>    
    </div> 
    
    <br style="clear:both;" />
    
    <div class="cropContainer">
    <span class="cropTitle">If you want to edit the image, please select the part you want to conserve and click save.</span>        
    <div id="divImageEdit"><img id="imgEdit" class="cropImage" /> </div>
    <img id="btnSave" src="/img/MyGarments/img_save.gif" class="cropSave" />    
    </div>
</div>

<input type="hidden" id="X" />
<input type="hidden" id="Y" />
<input type="hidden" id="W" />
<input type="hidden" id="H" />

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="<%= Url.Content("~/js/jquery.toJSON.js") %>"></script>
<script src="<%= Url.Content("~/js/jquery.Jcrop.min.js") %>"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
    var apiJcrop;    
    
    $(document).ready(function() {
        $("#lnkUploadGarments").css("background-color", "#F08331");

        $("#btnSave").click(function(e) {                    
            var co = {
                "X": $("#X").val(),
                "Y": $("#Y").val(),
                "Width": $("#W").val(),
                "Height": $("#H").val(),
                "ImageUri": $("#imgEdit").attr("src").split("?")[0]
             };
                               
            var encoded = $.toJSON(co);

            $.ajax({
                type: "POST",
                url: "<%= Url.RouteUrl(new { controller = "MyGarments", action= "CropImage"}) %>",
                data: encoded,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data) {
                    if (data.Success == true) {
                        showMessage("Your image has been saved!");
                        reloadThumbnailImages();
                                                
                        var src =  $("#imgEdit").attr("src");
                        $("#imgEdit").attr("src", src + "?" + new Date().getTime());
                        $("#imgEdit").css("height", apiJcrop.tellScaled().h);
                        $("#imgEdit").css("width", apiJcrop.tellScaled().w);
                        
                        bindJcrop();    
                    }
                }
            });
        });
        
        /*
        TODO: Ver como usar las imagenes de forma simetrica (y agregar padding)
        $(".thumbnail").each(function (i) {            
            var newSize = scaleSize(50, 50, $(this)[0].width, $(this)[0].height);
            $(this).css("width", newSize[0]);
            $(this).css("height", newSize[1]);
        });
        */
        
        bindThumbnail();
                
        $("#imgEdit").load(function(e) {
            if (jQuery.browser.safari)
            {
                $(this).removeAttr("width")
                    .removeAttr("height")
                    .css({ width: "", height: "" }); 
                            
                $('#imgEdit').css("width", this.width);
                $('#imgEdit').css("height", this.height);
                
                bindJcrop();
            }
        });
        
        clearCache();        
        $("#thumbnail_0").click();        
    }); 
    
    
    function scaleSize(maxW, maxH, currW, currH){
        var ratio = currH / currW;

        if(currW >= maxW && ratio <= 1){
        currW = maxW;
        currH = currW * ratio;
        } else if(currH >= maxH){
        currH = maxH;
        currW = currH / ratio;
        }
        return [currW, currH];
    }
           
    function bindThumbnail()
    {
        $(".viewUploadedImage").click(function(e){                
            var src = getSourceElement(e);            
            var imageUri = ($(src).attr("src")) ? $(src).attr("src") : $(src).attr("href");
            
            $("#imgEdit").attr("src", "");
            $('#imgEdit').attr("src", imageUri);
            
            if (!jQuery.browser.safari)                
                bindJcrop();
        });
    }
    
    function reloadThumbnailImages()
    {   
        var arrIds = new Array();
        var arrSrc = new Array();
        var arrTitle = new Array();
        
        $(".thumbnail").each(function (i) {
            arrIds.push($(this).attr("id"));
            arrSrc.push($(this).attr("src"));            
            arrTitle.push($(this).attr("alt"));
        });
        
        $(".thumbnailContainer").empty();
        
        for(var i = 0; i < arrIds.length; i++ )
        {
            var img = "";
            img = "<div class='uploadItem'>";
            img += "<a href='" + arrSrc[i] + "' id='thumbnail_" + arrIds[i]  + "' class='viewUploadedImage' onclick='return false;' title='" + arrTitle[i]  + "' >";
            img += "<img src='" + arrSrc[i]  + "?" + new Date().getTime() + "' alt='" + arrTitle[i]  + "' class='thumbnail'  />";
            img += "</a></div>";
            $(".thumbnailContainer").append(img);
        }
        
        bindThumbnail();         
    }
    
    
    function clearCache() // Triggers onload if image is cached
    {
        var src = $("#imgEdit").attr("src");
        $("#imgEdit").attr("src", "");
        $("#imgEdit").attr("src", src);  
    }
        
    function bindJcrop()
    {
        if(apiJcrop != undefined)
            apiJcrop.destroy(); 
            
        apiJcrop = $.Jcrop('#imgEdit');
        apiJcrop.setOptions({ onSelect: storeCoords });
        apiJcrop.release();
    }
    
    function storeCoords(c) {
            $("#X").val(c.x);   //X Coord
            $("#Y").val(c.y);   //Y Coord
            $("#W").val(c.w);   //Width
            $("#H").val(c.h);   //Height            
    }
       
</script>
</asp:Content>