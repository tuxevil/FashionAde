<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Content</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">    
    <%Html.RenderPartial("ContentMenu");  %>
    <%Html.RenderPartial("ContentBlogItems");  %>    
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript">
    $(document).ready(function() {        
        $("#btnOrganizing").addClass("buttonSelected");
    });
</script>

</asp:Content> 