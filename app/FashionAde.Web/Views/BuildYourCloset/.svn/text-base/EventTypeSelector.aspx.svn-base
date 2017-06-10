<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<IEnumerable<FashionAde.Core.EventType>>" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<div id="buildYourCloset" >
    <div class="buildClosetTitle">
        <h1>What are you dressing for?</h1>
        <h2 style="margin-top:-18px;">Tell us where you need inspiration and we’ll tailor your outfits to work for your lifestyle. </h2>        
    </div>
    <img id="imgBuildSteps" src="../../img/BuildYourCloset/step1.gif" alt="Steps" />     
    
    <div class="shadowUp"></div>
    <div id="divFlavorSelection">
        <% using (Html.BeginForm("SelectEventType", "BuildYourCloset")) {         
               if(Model.Count() > 0)
                    foreach (var eventType in Model) { 
                        Html.RenderPartial("EventType", eventType); 
                    } %>
    </div>
    <div class="shadowDown"></div>    
    <table style="width:100%;">
        <tr>
            <td align="right">                            
                <input id="btnEventTypePrevious" type="image" src="../../img/BuildYourCloset/button_previous2.gif" value="Next" name="Previous" />
            </td>
            <td align="left"><input id="btnEventTypeNext" type="image" src="../../img/BuildYourCloset/button_next.gif" value="Next" name="Next" /></td>            
        </tr>    
    </table>            
    
        <% } %>     
</div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript">

    $(document).ready(function() {
        $('.eventTypeSelect').mouseover(function() {
            $(this).css("background-color", "#F4F4F4");
            $(this).css("border", "solid 1px #9D9C9B");
        });

        $('#btnEventTypeNext').click(function(e) {
            $checked = getCheckBoxsFromDiv("divFlavorSelection", true);
            if ($checked.length == 0) {
                e.preventDefault();
                showMessage("You must choose at least one event type.");
            }
        });

        $('.eventTypeSelect').click(function(e) {
            var src = getSourceElement(e);
            if (src.id == "") {
                var $chk = getCheckBoxsFromDiv(this.id, false);
                $chk[0].checked = ($chk[0].checked) ? false : true;
            }
        });

        $('.eventTypeSelect').mouseout(function() {
            var $chk = getCheckBoxsFromDiv(this.id, false);
            if (!$chk[0].checked) {
                $(this).css("background-color", "#FFFFFF");
                $(this).css("border", "solid 1px #FFFFFF");
            }
        });
    });

    
</script>
</asp:Content>