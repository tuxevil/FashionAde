<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<IList<Friend>>" %>
<%@ Import Namespace="FashionAde.Core.Accounts"%>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<% using (Html.BeginForm("AddFriends", "Account"))
   {   %>
<table>
<%
    int cont = 1;
    if (Request.QueryString["page"] != null)
        cont += (Convert.ToInt32(Request.QueryString["page"]) - 1) * 10;
    foreach (Friend f in Model)
    {
        f.LastName = cont.ToString();
        Html.RenderPartial("FriendRow", f);
        cont++;
    } %>
</table>
<input type="submit" class="divButton" value="Add these friends" />
<%} %>
<% Html.RenderPartial("Paging", ViewData["Pages"]); %>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
    <script type="text/javascript">
        $(document).ready(function() {
            $(".Page").click(ChangePage);
            $(".Page").mousein
            $(".Page").bind("mouseenter",function(e) {
                $(this).removeClass();
                $(this).addClass("NextPage");
            });
            $(".Page").bind("mouseleave", function(e) {
                $(this).removeClass();
                $(this).addClass("Page");
            });
            
        });
        function ChangePage() {
            window.location = '<%= Url.RouteUrl(new { controller = "Account", action= "FriendSelection"}) %>?page=' + $(this).attr("id").split('_')[1]; 
        }
    </script>
</asp:Content>