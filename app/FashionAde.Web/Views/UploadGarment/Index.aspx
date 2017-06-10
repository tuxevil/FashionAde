<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>
<%@ Import Namespace="FashionAde.Core"%>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Upload Garment</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <h1>Upload images of your own clothes</h1>
    <h2 style="float: left; width: 275px;">Get <a href="<%= Url.RouteUrl(new { controller = "Content", action= "Recommendations"}) %>" style=" color:#3C3A3B; display: inline; text-decoration: underline" >recommendations</a> for taking photos of your personal garments.</h2>
    <%
        IList<FashionFlavor> flavors = (List<FashionFlavor>)ViewData["FashionFlavors"];
    %>
    <div class="GarmentSelector_FilterDiv_FashionFlavorSelected" style="display: inline; float: right; margin-right: 10px; margin-top: -10px; ">
        <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Title">Your Fashion Flavors:</span>
        <div class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box">
            <center>
            <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Title" ><%= flavors[0].Name%></span>
            <img class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Image" src="<%= Resources.GetFashionFlavorThumbnailPath(flavors[0]) %>" alt="<%= flavors[0].Name %>"  />
            </center>
        </div>
        <div class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box">
            <center>
            <% if (flavors.Count > 1)
               {  %>
            <span class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Title" ><%= flavors[1].Name%></span>
            <img class="GarmentSelector_FilterDiv_FashionFlavorSelected_Box_Image" src="<%= Resources.GetFashionFlavorThumbnailPath(flavors[1]) %>" alt="<%= flavors[1].Name %>"  />
            <% } %>
            </center>
        </div>
        <div style="clear: both" ></div>
    </div>    
    <br /><br />    
        
        
    <% using (Html.BeginForm("UploadFile", "UploadGarment", FormMethod.Post, new { enctype = "multipart/form-data" }))
    { %>     
    <div id="MyGarments_Panel1" class="MyGarments_Panel" style="height:auto; overflow:auto;">
        <div id="divUpload1" class="upload">
            <span class="add-image">Add Image</span> Click "browse" to select an Image. <br />                
            <div class="fileinputs">
            <input type="file" id="file1" name="file1" class="file" />            
            <div class="fakefile">
                <input id="Text1" type="text" />
                <img src="/static/img/browse.jpg" />
            </div>
            </div>
        </div>        
        <div id="divUploadInfo1" class="uploadInfo" style="display:none;">            
            <img id="uploadImage1" class="uploadImage" />
            <span id="uploadName1" class="uploadName"></span>            
            <img id="uploadRemove1" src="/static/img/MyGarments/remove.jpg" class="uploadRemove" />
            <div class="fileErrorContainer">
                <label for="file1" generated="false" class="labelError error"></label>
            </div>
            <br style="clear:both;" />&nbsp;&nbsp;Tell us about this garment so we can put it in the right place in your closet:<br />
                        
            <table class="uploadTable">
                <tr>
                    <td style="text-align: right;">Garment Title:*</td>
                    <td class="uploadTitle"><%= Html.DropDownList("Title1", (List<SelectListItem>)ViewData["Titles"], "Select...")%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">The pattern is:*</td>
                    <td class="uploadPattern"><%= Html.DropDownList("Pattern1", (List<SelectListItem>)ViewData["Patterns"], "Select...")%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">The fabric is:*</td>
                    <td class="uploadFabric"><%= Html.DropDownList("Fabric1", (List<SelectListItem>)ViewData["Fabrics"], "Select...")%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">The primary color of this garment is:*</td>
                    <td class="uploadPrimaryColor"><%= Html.DropDownList("PrimaryColor1", (List<SelectListItem>)ViewData["Colors"], "Select...")%></td>
                </tr>                
                <tr>
                    <td style="text-align: right;">I primarily wear this garment in:*</td>
                    <td class="uploadSeason"><%= Html.DropDownList("Season1", (List<SelectListItem>)ViewData["Seasons"], "Select...")%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">I primarily wear this garment to:*</td>
                    <td class="uploadEventType"><%= Html.DropDownList("EventType1", (List<SelectListItem>)ViewData["EventTypes"], "Select...")%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">This garmet should be stored in:</td>
                    <td style="font-size: 10px;" class="uploadPrivacy">
                        <% =Html.RadioButton("PrivacyStatus1", false, false)%> My Private Closet - only I will see it <br />
                        <% =Html.RadioButton("PrivacyStatus1", true, true)%> The Public Closet - anyone with my style type can see it                    
                    </td>
                </tr>
            </table>            
        </div> 
    </div>
    
    <div id="btnUpload" class="uploadButton divButtonBig" style="clear: both; margin-bottom: 10px;" >UPLOAD GARMENTS</div>        
    <img id="imgLoading" src="/static/img/MyGarments/Ajax-loader.gif" class="uploadLoading" /> 
    
    <% } %>  
    
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script src="/static/lib/jquery.validate.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/js/uploadGarment.js"></script>
</asp:Content>