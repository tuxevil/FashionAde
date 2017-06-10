<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<IList<FashionAde.Core.Views.OutfitUpdaterView>>" %>
<%@ Import Namespace="FashionAde.Core.Views" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
 <h1 style="margin:0 0 10px 0;">Unverified Updaters</h1>

 <% 
     if (Model.Count > 0)
     {
         foreach (OutfitUpdaterView ou in Model)
             Html.RenderPartial("OutfitUpdaterReject", ou);
         %>

    <div style="clear:both"></div>
    
    <% using (Html.BeginForm("ConfirmAll", "OutfitUpdater"))
   {%>     
        <input id="search" type="submit" class="divButton" style="padding:2px 10px 2px 10px; margin:0 0 3px 5px;" value="Confirm All" />
<%
   }%>

         
         <%
     }
     else
         Response.Write("No updaters pending.");
 %>
   

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">

<script type="text/javascript">
    $(document).ready(function() {
        $("#clear").click(function(e){            
            $("#searchText").val("");
            $("#category")[0].selectedIndex = 0;
            $("#contentType")[0].selectedIndex = 0;
        });
    
        $(".reject").click(function() {
            rejectUpdater(parseInt($(this).attr("updaterid")));
            $(this).parent().remove();
        });
    });
    
    function rejectUpdater(id) {         
        var data = { outfitUpdaterId : id };
        $.ajax({
                type: "POST",
                url: "<%= Url.RouteUrl(new { controller = "OutfitUpdater", action= "Reject"}) %>",
                data: data
        });        
    }
</script> 
</asp:Content>




