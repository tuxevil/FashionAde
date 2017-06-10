<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<List<ClosetOutfitView>>" %>
<%@ Import Namespace="FashionAde.Core.MVCInteraction"%>
<% 
    if (Model.Count > 0)
    { 
       //Html.RenderPartial("Paging", ViewData["Pages"]);
       foreach (ClosetOutfitView outfit in Model)
           Html.RenderPartial("Outfit", outfit);
       Html.RenderPartial("Paging", ViewData["Pages"]);
    }
    else
    {
       %><div class="NoOutfitDiv"><span>There is no Outfits for this season. If you want, you can add garments <a href='<%= Url.RouteUrl(new { controller = "MyGarments", action= "UploadGarment"}) %>' style="color:#F67F07; display: inline;">here</a></span></div> <%
    }
%>