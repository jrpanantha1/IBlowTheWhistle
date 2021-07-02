<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Banners.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Banners" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/Banner.js"></script>
    <script src="/Scripts/QRCode/jquery.qrcode.js"></script>
    <script src="/Scripts/QRCode/qrcode.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <link href="../assets/css/overall.css" rel="stylesheet" />
    <script type="text/javascript">
        var dataURL = "";
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();

            $('#qrcode').empty();

            // Set Size to Match User Input
            $('#qrcode').css({
                'width': $('.qr-size').val(),
                'height': $('.qr-size').val()
            })

            // Generate and Output QR Code
            $('#qrcode').qrcode({ width: $('.qr-size').val(), height: $('.qr-size').val(), text: $('.qr-url').val() });
            //dataURL = document.getElementById('qrcode').toDataURL();
            return false;

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
                //dataURL = document.getElementById('qrcode').toDataURL();
                return false;
            });
        });
        function saveQRCodeAsImage() {
            var canvas = $('#qrcode canvas');
            var img = canvas.get(0).toDataURL("image/png");
            var a = document.createElement('a');
            a.href = img;
            a.download = 'IBTWQRCode.png';
            a.click()
        }
    </script>
    <div class="container">
        <div class="row justify-content-center align-items-center py-10 langDirection">
            <div class="col-12">
                <div class="col-xl-12 top-header">
                    <h1>Banner</h1>
                    <span class="header-line"></span>
                    <p class="text-xl-center">We have added a selection of banners for you to use in your company.  The banners and their code link directly to your own company’s safe concern area.</p>
                </div>
                <div class="col-xl-12 topBanner">
                    <div class="bannername">
                        <div class="bannername-area">
                            <span class="bannertitletxt">Banner URL</span>
                            <input type="text" id="txtBannerText" />
                            <a onclick="copyBannerLink();return false;" style="cursor: pointer;" data-toggle='tooltip' data-placement='top' data-original-title='Copy link here'><span class="cbtooltiptext" id="myTooltipPass" data-toggle='tooltip' data-placement='top' data-original-title='Copy link here'></span>
                                <i class="icon-clipboard"></i></a>

                        </div>
                    </div>


                    <%-- <a class="ancImgTopBanner" target="_blank" href="#">
                        <img class="imgTopBanner" src="/assets/images/WhistleDefaultTopBanner.PNG" alt="horizontal banner" />

                    </a>--%>
                    <div class="banner-container">

                        <a target="_blank" href="#" class="bannerimg-1">
                            <img src="/assets/images/Whistle_Long_Internalbanner.png" alt="horizontal banner" />
                            <p>Banner Size</p>
                        </a>
                        <a target="_blank" href="#" class="bannerimg-2">
                            <img src="/assets/images/Whistle_Long.jpg" alt="horizontal banner" />
                            <p>Banner Size</p>
                        </a>
                        <a target="_blank" href="#" class="bannerimg-3">
                            <img src="/assets/images/Whistle_SquareLarge.jpg" alt="horizontal banner" />
                            <p>Banner Size</p>
                        </a>
                        <a target="_blank" href="#" class="bannerimg-4">
                            <img src="/assets/images/IblowTheWhistleCustomerBanner.png" alt="horizontal banner" />
                            <p>Banner Size</p>
                        </a>
                        <a target="_blank" href="#" class="bannerimg-9">
                            <img src="/assets/images/Whistle_Small_Square.jpg" alt="horizontal banner" />
                            <p>Banner Size</p>
                        </a>
                        <a target="_blank" href="#" class="bannerimg-5">
                            <img src="/assets/images/Whistle_Rect.jpg" alt="horizontal banner" />
                            <p>Banner Size</p>
                        </a>

                        <a target="_blank" href="#" class="bannerimg-6">
                            <img src="/assets/images/Whistle_Tall.jpg" alt="horizontal banner" />
                            <p>Banner Size</p>
                        </a>


                        <a target="_blank" href="#" class="bannerimg-7">
                            <img src="/assets/images/Whistle_MediumSquare.jpg" alt="horizontal banner" />
                            <p>Banner Size</p>
                        </a>

                        <a target="_blank" href="#" class="bannerimg-8">
                            <img src="/assets/images/Whistle_small.jpg" alt="horizontal banner" />
                            <p>Banner Size</p>
                        </a>


                    </div>

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

                        <div id="qrcode" style="border: 1px solid black"></div>
                        <button class="generate-qr-code " style="margin: 0 auto; margin-top: 5px;" id="btnSaveasImage" onclick="saveQRCodeAsImage(); return false;">Save as Image</button>

                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
