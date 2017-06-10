<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<Pager>" %>
<%@ Import Namespace="FashionAde.Web.Common"%>

<% if(Model.Pages.Count > 0 ){%>
<div id="Pager" name="Pager" style="float:right; left: -50%; position: relative;">
    <div style="position: relative; left: 50%;">
        <ul style="display: inline; float: left; margin-top: 0px;">
        <%
            foreach (SelectListItem item in Model.Pages)
            {
                if(item.Text == "...")
                {
                    %><li style="color: #4E679B;display: block;float: left;font-family: Verdana;font-size: 11px;font-weight: bold;margin-right: 5px;padding-left: 5px;padding-right: 5px;"><%=item.Text%></li><%
                }
                else if (!item.Selected)
                {
                    %><li class="Page" id="<%= "page_" + item.Value %>"><%=item.Text%></li><%
                }
                else
                {
                    %><li class="SelectedPage"><%=item.Text%></li><%
                }
            } %>
        </ul>
        <span style="float:left; color: #666666; font-weight: normal; font-size: 11px; margin-left: -10px;">(Showing <%= Model.PageSize %> of <%= Model.TotalRecords %> outfits)</span>
    </div>
</div><br />
<% } %>