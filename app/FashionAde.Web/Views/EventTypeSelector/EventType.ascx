<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<FashionAde.Core.EventType>" %>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction" %>
<%@ Import Namespace="FashionAde.Core" %>

<%
    bool check = false;
    string className = "eventTypeSelect";

    if (ViewData["EventTypeSelected"] != null)
    {
        List<EventType> selectedEt = (List<EventType>)ViewData["EventTypeSelected"];
        foreach (EventType eventType in selectedEt)
            if (eventType.Id == Model.Id)
            {
                check = true;
                className = "eventTypeSelect selectedItem";
            }
    }
    else
    {
        check = true;
        className = "eventTypeSelect selectedItem";
    }
%>

<div class="<%= className %>" id="div_EV<%= Model.Id %>" >
    <div><img src="<%= Resources.GetEventTypePath(Model) %>" alt="<%= Model.Description %>" /></div>
    <div><%= Model.Description %></div>
    <div><%= Html.CheckBox("chb_ET_" + Model.Id, check)%></div>
</div>
