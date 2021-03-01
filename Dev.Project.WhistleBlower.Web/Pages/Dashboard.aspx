<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/Dashboard.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <div style="margin-top: 100px;"></div>
  <div style="width:100%">
       <div id="barchartContainer" style="height: 370px; width: 50%;float:left;"></div>
     <div id="piechartContainer" style="height: 370px; width: 50%;float:left;"></div>
  </div>
   
    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

</asp:Content>
