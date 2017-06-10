<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IList<FashionFlavor>>" %>
<%@ Import Namespace="FashionAde.Core"%>
<%@ Import Namespace="FashionAde.Core.Accounts"%>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Fashion Flavor Weight</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">    
    <div id="buildYourCloset" >
        <div class="buildClosetTitle">
            <h1>What´s your Fashion Flavor?</h1>
            <h2>How important is each of these styles to you?<br />One style must be at least 60%.</h2>
        </div>
        
        <img id="imgBuildSteps" src="/static/img/BuildYourCloset/step1.gif" alt="Steps" />
        
        <div class="shadowUp"></div>
            <div class="styleContent">
                <div class="styleImportance" style="position:relative;">
                    <span class="sliderValues" style="top:30px; left:127px;">0%</span>
                    <span class="sliderValues" style="top:30px; left:363px;">100%</span>
                    
                    <div class="sliders" style="left: 160px;">
                        <div style="margin-bottom: 15px;">
                            <span id="spnFlavor1" class="sliderFlavor1"><%= Model[0].Name %> </span>
                            <span id="spnSlider1" class="sliderPercent">0</span>
                        </div> 
                        <div id="divSlider1" style="width:190px;background-color:#FDBF50;"></div>
                    </div>
                    
                    <span class="sliderValues" style="top:100px; left:127px;">0%</span>
                    <span class="sliderValues" style="top:100px; left:363px;">100%</span>
                    
                    <div class="sliders" style="top:70px; left:160px;">                
                        <div style="margin-bottom: 15px;">
                            <% if (Model.Count > 1) %>
                            <% { %>
                            <span id="spnFlavor2" class="sliderFlavor2"><%= Model[1].Name%> </span>
                            <span id="spnSlider2" class="sliderPercent">0</span>
                            <% } %>
                        </div> 
                        <div id="divSlider2" style="width:190px;background-color:#FDBF50;"></div>
                    </div>
                </div>
            </div>
        <div class="shadowDown"></div>
        
        <div class="divBuildBottom">
           <%  decimal fw1 = Convert.ToDecimal(50);
               decimal fw2 = Convert.ToDecimal(50);

               if (ViewData["UserFlavorSelected"] != null)
               {
                    List<UserFlavor> selectedUF = (List<UserFlavor>)ViewData["UserFlavorSelected"];
                    fw1 = (selectedUF[0].Weight != 100) ? selectedUF[0].Weight : fw1;
                    if (selectedUF.Count > 1)
                        fw2 = selectedUF[1].Weight;
               } %>
               
               
            
                <% using (Html.BeginForm("SetWeight", "FlavorWeight"))
                   { %>   
                <input type="hidden" id="Flavor1Weight" name="Flavor1Weight" value="<%= fw1 %>" />
                <input type="hidden" id="Flavor2Weight" name="Flavor2Weight" value="<%= fw2 %>" />
                
                <table style="width:450px; margin-left: auto; margin-right: auto;">
                    <tr>
                        <td align="right">                        
                            <div id="btnPrevious" class="divButtonBig">PREVIOUS</div>
                        </td>
                        <td align="left"><div id="btnWhatsYourFlavor" class="divButtonBig">NEXT</div></td>            
                    </tr>    
                </table>
                
            <% } %>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript" src="/static/js/flavorWeight.js"></script>
</asp:Content>