<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<ContactView>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction"%>
<%@ Import Namespace="ContactProvider"%>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Contacts</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<div style="width: 900px; margin-left: auto; margin-right: auto;">
    <span class="ContactList_Title">Contacts</span><br /><br />
    <div class="Contact_LeftBarContainer" >
        <div class="ContactList_Header">
            <h2 style="display: inline; margin-left: 10px;">Imported contacts from your </h2><img src="<%= Resources.GetFriendProviderPath(Model.ProviderImg) %>" alt="<%= Model.ProviderName %>" />
            <span class="ContactList_Header_Item">Select:</span>
            <ul id="ulCheck" class="actions" >
                <li id="MarkedAll"><a id="checkAll" class="link" href="#Actions" style="color: #4E6398; display: inline;" >All</a></li>
                <li> , </li>
                <li id="UnMarkedAll"><a id="uncheckAll" class="link" style="color: #4E6398;">None</a></li>
            </ul>
        </div>
        <div class="Contact_ContactContainer">
            <table width="100%" style="margin: 0px 0px 0px 0px;">
            <%
                foreach (IContact c in Model.Contacts)
                {
            %>
                <tr style="background-color:#EDEDED; border: solid 2px white;">
                    <td><%= Html.CheckBox("chb_" + c.Index, false, new { @class = "contact", title = "Check for Add" })%></td>
                    <td><span style="font-weight: normal; font-size: 11px;"><%= HttpUtility.HtmlEncode(c.Email) %></span></td>
                    <td><span style="font-weight: bold; margin-right: 10px; font-size: 11px;" ><%= HttpUtility.HtmlEncode(c.FirstName) %> <%= HttpUtility.HtmlEncode(c.LastName) %></span></td>
                </tr>            
            <%
                }
            %>
            </table>
        </div>
    </div>
    

    <div style="width:45%; margin-left: 20px; float: left;">
        <% 
            Html.EnableClientValidation();
            
            using (Html.BeginForm())
           {
        %>
        <span>Include a personal note (optional):</span><br /><br />
        <% Response.Write(Html.TextAreaFor(x => x.Comments, new { style = "background-color:#E1E5F1; width: 100%", rows = "14" })); %>
        <% Response.Write(Html.ValidationMessageFor(x => x.Comments)); %>
        <% 
            Response.Write(Html.HiddenFor(x => x.Provider));
            Response.Write(Html.HiddenFor(x => x.SelectedAll));
            Response.Write(Html.HiddenFor(x => x.SelectedIndexes));
            Response.Write(Html.HiddenFor(x => x.TotalCount));
        %>
        <center><div class="divButtonBig" style="margin-top: 10px; margin-bottom: 10px;" onclick="document.forms[0].submit();">ADD FRIENDS</div></center>
        <%} %>
    </div>
</div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
    <script type="text/javascript" src="/static/lib/MicrosoftAjax.js"></script>
    <script type="text/javascript" src="/static/lib/MicrosoftMvcValidation.js"></script>
    <script type="text/javascript" src="/static/js/contact.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function() {
            function ChangePage() {
                window.location = '<%= Url.RouteUrl(new { controller = "Contact", action= "Index"}) %>?page=' + $(this).attr("id").split('_')[1];
            };
        });
    </script>
</asp:Content>