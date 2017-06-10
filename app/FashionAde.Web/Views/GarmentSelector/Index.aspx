<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<GarmentsListData>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Garment Selector</title>
</asp:Content>

<asp:Content ID="popupContent" ContentPlaceHolderID="OverlayPlaceHolder" runat="server">
<div class="modal" id="loading" style="width:350px; opacity:1; text-align:center;"> 
    <p>Loading - please wait - don't hit back button or refresh page until you've saved your closet items</p>
    <img src="http://l.yimg.com/a/i/us/per/gr/gp/rel_interstitial_loading.gif" />
</div> 
<input type="hidden" id="NoOne" />
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<% Html.RenderPartial("GarmentsList", Model); %>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">    
    <script type="text/javascript">        
        var resGarmentPath = '<% = Resources.GetGarmentLargePath() %>';
        var resPatternPath = '<% = Resources.GetPatternPath() %>';
        var buildYourCloset = '<% = !Model.ForEdit %>';        
    </script>
    <script type="text/javascript" src="/static/js/garmentSelector.js" ></script>
</asp:Content>