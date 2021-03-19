<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Banners.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Banners" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/QRCode/qrcode.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <style type="text/css">
        
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.generate-qr-code').on('click', function () {

                // Clear Previous QR Code
                $('#qrcode').empty();

                // Set Size to Match User Input
                $('#qrcode').css({
                    'width': $('.qr-size').val(),
                    'height': $('.qr-size').val()
                })

                // Generate and Output QR Code
                $('#qrcode').qrcode({ width: $('.qr-size').val(), height: $('.qr-size').val(), text: $('.qr-url').val() });
                return false;
            });
        });
    </script>
    <div class="container">
        <div class="row justify-content-center align-items-center py-10 langDirection">
            <div class="col-12">
                <div class="col-xl-12 top-header">
                    <h1>Banner</h1>
                    <span class="header-line"></span>
                    <p class="text-xl-center">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
                </div>
                <div class="col-xl-12 topBanner">
                    <a class="ancImgTopBanner" target="_blank" href="https://iblowthewhistle.com/Pages/Home.aspx?kWbf0wReXWoLMLDfQVvvNA==/ibZxSe+yi7kfMi41TWwllf/g==">
                        <img src="/IBTWImages/6dafd280-6980-4691-82f9-cf71633556b2/CompanyBanners/CompanyTopBanner.jpeg" class="imgTopBanner" alt="horizontal banner" />

                    </a>
                </div>

                <div class="col-xl-12 qrcontent-txt">
                    <div class="col-xl-8 qr-code-txt">
                        <h1>Create dynamic QR code
                            <br />
                            for reporting</h1>
                        <p class="text-xl-left">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
                        <button class="generate-qr-code">Generate QR Code to Report Incident</button>
                    </div>
                    <div class="col-xl-4 qr-code-generator">

                        <input type="text" id="txtQrCode" class="qr-url" placeholder="URL or Text" style="display: none" />
                        <input type="number" class="qr-size" value="128" min="20" max="500" style="display: none" />

                        <div id="qrcode"></div>

                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
