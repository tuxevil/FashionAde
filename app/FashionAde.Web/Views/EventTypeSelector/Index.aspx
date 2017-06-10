<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<IEnumerable<FashionAde.Core.EventType>>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Event Type Selector</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<div id="buildYourCloset" >
    <div class="buildClosetTitle">
        <h1>Where do you usually go?</h1>
        <h4 style="color: #4D679B;">Choose the occasions or places that best fit your lifestyle, and we’ll tailor outfits that will work for you- right from your own closet.</h4>
        <h4>Tip:  to get the best results, be sure to choose <strong>all</strong> the occasions that relate to your lifestyle.</h4> 
    </div>
    <img id="imgBuildSteps" src="/static/img/BuildYourCloset/step1.gif" alt="Steps" />     
    
    <div class="shadowUp"></div>
    <div id="divFlavorSelection" style="margin-left:70px;">
        <% using (Html.BeginForm("SelectEventType", "EventTypeSelector"))
           {         
               if(Model.Count() > 0)
                    foreach (var eventType in Model) { 
                        Html.RenderPartial("EventType", eventType); 
                    } %>
    </div>
    <div class="shadowDown"></div>        
    <table style="width:450px; margin-left: auto; margin-right: auto;">
        <tr>
            <td align="right">                            
                <div id="btnEventTypePrevious" class="divButtonBig" >PREVIOUS</div>
            </td>
            <td align="left"><div id="btnEventTypeNext" class="divButtonBig">NEXT</div> </td>            
        </tr>    
    </table>            
    
        <% } %>     
</div>
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/js/eventTypeSelector.js"></script>
</asp:Content>