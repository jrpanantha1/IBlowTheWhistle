<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlower.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <style>
        .atooltip {
            position: relative;
            display: inline-block;
        }

            .atooltip .atooltiptext {
                visibility: hidden;
                width: 140px;
                background-color: #555;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 5px;
                position: absolute;
                z-index: 1;
                bottom: 150%;
                left: 50%;
                margin-left: -75px;
                opacity: 0;
                transition: opacity 0.3s;
            }

                .atooltip .atooltiptext::after {
                    content: "";
                    position: absolute;
                    top: 100%;
                    left: 50%;
                    margin-left: -5px;
                    border-width: 5px;
                    border-style: solid;
                    border-color: #555 transparent transparent transparent;
                }

            .atooltip:hover .atooltiptext {
                visibility: visible;
                opacity: 1;
            }
    </style>

    <p style="margin-top: 200px;">Click on the button to copy the text from the text field. Try to paste the text (e.g. ctrl+v) afterwards in a different window, to see the effect.</p>

    <input type="text" value="Hello World" id="myInput" />
    <textarea id="txtarea"></textarea>
    <div class="atooltip">
        <button onclick="myFunction()" onmouseout="outFunc()">
            <span class="atooltiptext" id="myTooltip">Copy to clipboard</span>
            Copy text
        </button>
    </div>

    <p>The document.execCommand() method is not supported in IE8 and earlier.</p>

    <script>
        function myFunction() {
            debugger;
            var copyText1 = document.getElementById("myInput");
            var copyText = document.getElementById("txtarea");

            var tempT = copyText1.value +'\n'+ copyText.value;
            alert(tempT);
            copyText.value = tempT;
            copyText.select();
            copyText.setSelectionRange(0, 99999);
            document.execCommand("copy");

            var tooltip = document.getElementById("myTooltip");
            tooltip.innerHTML = "Copied: " + copyText.value;
        }

        function outFunc() {
            var tooltip = document.getElementById("myTooltip");
            tooltip.innerHTML = "Copy to clipboard";
        }
    </script>
</asp:Content>
