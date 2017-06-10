<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <div id="tempMessage"></div>
      
    <div class="home">
        <div id="homeLeft">
            <table class="imgTable" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td><img src="/static/img/Home/img_outfits1_v2.jpg" /></td>
                    <td><img src="/static/img/Home/img_outfits2_v2.jpg" /></td>
                </tr>
                <tr>
                    <td><img src="/static/img/Home/img_outfits3_v2.jpg" /></td>
                    <td><img src="/static/img/Home/img_outfits4_v2.jpg" /></td>
                </tr>                
            </table>
            <div id="divBuildVirtualCloset">
                Set your closet free! <strong>There are thousands</strong>                 
                <span>of outfits just waiting to be worn</span>
            </div>
            <div>
                <img id="imgFun" src="/static/img/img_fun.gif" />
                <img id="imgShoes" src="/static/img/Home/img_shoes_v2.gif" />
            </div>
        </div>
        
        <div id="homeRight" style="position:relative;">
        <img src="/static/img/Home/animation-home.gif" style="position:absolute; top: 38px; left: 22px;" />
            <table class="imgTable" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td><img id="img1" src="/static/img/img_steps1.gif" /></td>
                    <td><img id="img2" src="/static/img/img_steps2.gif" /></td>
                </tr>
                <tr>
                    <td><img id="img3" src="/static/img/img_steps3.gif" /></td>
                    <td><img id="img4" src="/static/img/img_steps4.gif" />
                            <a id="lnkBtnBuildCloset" href="<%= Url.RouteUrl(new { controller = "FlavorSelect", action= "Index"}) %>">
                                <img id="btnBuildCloset" src="/static/img/buttons/btn_build_closet.gif" alt="Build Closet" style="margin-top: -50px;"/>
                            </a>
                    </td>
                </tr>
            </table>
    
        </div>
    </div>        
    
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">    
    <script type="text/javascript">
        $(document).ready(function() {
            startSilouhettePreloading();
            
            <% if (TempData["message"] != null) { %>
                appendMessage($("#tempMessage"), '<%= TempData["message"] %>', "success");
            <% } %>
        });
    </script>
</asp:Content>
