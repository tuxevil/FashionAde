<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<FinalResult>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

    <div id="buildYourCloset" >
        <div class="buildClosetTitle">
            <h1>What´s your Fashion Flavor?</h1>
            <h2 style="margin-top:-18px;">Your Fashion Flavor results</h2>
        </div>
        
        <img id="imgBuildSteps" src="../../img/BuildYourCloset/step1.gif" alt="Steps" />

        <div class="step1Complete">
            
            <div style="float:left; width:700px; " >
                <div class="step1CompleteBoxes" >
                    <div style="width:160px;" class="step1CompleteText">Based on your answers, you Fashion Flavor is:</div>
                    <div class="step1CompleteWhiteSpace">
                        <div class="step1CompleteResult" >
                            <img class="step1CompleteFashionFlavorImage" src="<%= Model.Flavors[0].Image %>" /><br />
                            <span><%= Model.Flavors[0].Name %></span>
                        </div>
                        <div class="step1CompleteResult" >
                            <% if(Model.Flavors.Count > 1) %>
                            <% {  %>
                                <img class="step1CompleteFashionFlavorImage" src="<%= Model.Flavors[1].Image %>" /><br />
                                <span><%= Model.Flavors[1].Name %></span>                            
                            <% }  %>
                        </div>
                    </div>
                </div>
                
                <div class="step1CompleteBoxes">
                    <div style="width:130px;" class="step1CompleteText">And you're getting dressed for:</div>
                    <div class="step1CompleteWhiteSpace" >                    
                        <div class="step1CompleteResult" >
                            <img class="step1CompleteFashionFlavorImage" src="<%= Model.EventTypes[0].Image %>" /><br />
                            <span><%= Model.EventTypes[0].Name%></span>
                        </div>
                        
                            <% if (Model.EventTypes.Count > 1) %>
                            <% {  %>
                            <div class="step1CompleteResult">
                            <img class="step1CompleteFashionFlavorImage" src="<%= Model.EventTypes[1].Image %>" /><br />
                            <span><%= Model.EventTypes[1].Name%></span>                        
                            </div>
                            <% } %>
                        
                    </div>
                </div>
            </div>
        </div>
            
        <div class="divBuildBottom">
            <% using (Html.BeginForm("GoToGarmentSelector", "BuildYourCloset")) { %>
             <table class="centerDiv">
             <tr align="center">
                <td align="center"><input id="lnkRestart" type="image" src="../../img/BuildYourCloset/restart.gif" value="Restart" class="nextStep" style="margin-left:30px" /></td>
                <td align="center"><input id="lnkQuizComplete" type="image" src="../../img/BuildYourCloset/button_next.gif" value="Next" class="nextStep" style="margin-left:30px" /></td>
             </tr>
             </table>
            <%} %>
        </div>
        
    </div>
</asp:Content>