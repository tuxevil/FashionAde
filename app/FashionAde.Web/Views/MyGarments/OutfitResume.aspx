<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="FashionAde.Core.MVCInteraction"%>
<%@ Import Namespace="FashionAde.Core"%>
<%@ Import Namespace="FashionAde.Core.Clothing"%>
<%@ Import Namespace="FashionAde.Data.Repository"%>
<%@ Import Namespace="FashionAde.Core.FlavorSelection"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction" %>


<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

    <% string userName = ViewData["UserName"].ToString().ToUpper(); %>
    
    <h1 style="margin-bottom:5px;">My Outfits</h1>
    <div class="divButton" style="padding:3px 5px 3px 5px; margin-left:20px; background-color:#496694;">RETURN TO <%= userName %>'S CLOSET</div>
    <br /><br />
    
    <%  Html.RenderPartial("Outfit", ViewData["outfitView"]); %>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">    
    <script type="text/javascript" src="<%= Url.Content("~/js/jquery.toJSON.js") %>"></script>
    <script src='<%= Url.Content("~/js/jquery.rating.js") %>' type="text/javascript" language="javascript"></script> 
    <script src='<%= Url.Content("~/js/jquery.MetaData.js") %>' type="text/javascript" language="javascript"></script>
    
    <script type="text/javascript">
    $(document).ready(function() {
        
        $(".outfitName").css("cursor", "default");
        $(".outfitName").click(function(){ 
            return false;        
        });
    
        $('input.myratingstar').rating({
                required: 'hide',
	            callback: function(value, link) {
	                var id = 0;
	                if( $(this).attr("id") != undefined)
	                    id = $(this).attr("id").split('_')[1];
	                var selection = {
                        "ClosetOutfitId": id,
                        "Rate": value,
                        "Key": '00000000-0000-0000-0000-000000000000'
                    };

                    var encoded = $.toJSON(selection);

                    $.ajax({
                        type: "POST",
                        url: "<%= Url.RouteUrl(new { controller = "MyGarments", action= "RateOutfit"}) %>",
                        data: encoded,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function(data) {
                            if(data.Success == true)
                            {
                                if(data.WantFavorite == true)
                                {
                                    apiFavoriteOverlay.load();
                                    closetoutfitid = id;
                                }
                                
                                $("#RateNow_" + id).empty();
                                $("#MyRateValue_" + id).empty();
                                $("#MyRateValue_" + id).append(value);
                                
                            }
                        }
                    });
                 }
	        });
	    });
    
    </script>
    
</asp:Content>