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
            //return false;

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
        function downloadAsImage(imageName) {
            var canvas = $('#qrcode canvas');
            var imageSRC = $(imageName).attr('src');

            var img = imageSRC;
            var src = imageSRC.split('/');
            var fileName = src[src.length - 1];

            var a = document.createElement('a');
            a.href = img;
            a.download = fileName;
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

                    <div class="col-xl-12 qrcontent-txt">
                        <div class="col-xl-8 qr-code-txt">
                            <h1>Create dynamic QR code
                            <br />
                                for reporting</h1>
                            <p class="text-xl-left">A dynamic QR Code is a quick way for people to access the site and create reports easily from their phones. Rather than typing in a unique web address, a person can point their phone camera at a QR Code and be directed to your companies particular Reporting area. From below, you can download your QR Code or cut and paste the image into your communication medium.</p>
                            <button class="generate-qr-code">Generate QR Code to Report Incident</button>
                        </div>
                        <div class="col-xl-4 qr-code-generator">

                            <input type="text" id="txtQrCode" class="qr-url" placeholder="URL or Text" style="display: none" />
                            <input type="number" class="qr-size" value="128" min="20" max="500" style="display: none" />

                            <div id="qrcode" style="border: 1px solid black"></div>
                            <button class="generate-qr-code" style="margin: 0 auto; margin-top: 5px;" id="btnSaveasImage" onclick="saveQRCodeAsImage(); return false;">Save as Image</button>

                        </div>
                    </div>


                    <div class="clearfix"></div>
                    <hr />
                    <%-- <a class="ancImgTopBanner" target="_blank" href="#">
                        <img class="imgTopBanner" src="/assets/images/WhistleDefaultTopBanner.PNG" alt="horizontal banner" />

                    </a>--%>
                    <div class="banner-container">

                        <a target="_blank" href="#" class="bannerimg-1">
                            <img src="/assets/images/Whistle_Long_Internalbanner.png" onclick="downloadAsImage(this); return false;" alt="horizontal banner" />
                            <p>728 x 90</p>

                        </a>
                        <a target="_blank" href="#" class="bannerimg-2">
                            <img src="/assets/images/Whistle_Long.jpg" onclick="downloadAsImage(this); return false;" alt="horizontal banner" />
                            <p>728 x 90</p>
                        </a>
                        <a target="_blank" href="#" class="bannerimg-3">
                            <img src="/assets/images/Whistle_SquareLarge.jpg" onclick="downloadAsImage(this); return false;" alt="horizontal banner" />
                            <p>250x 250</p>
                        </a>
                        <a target="_blank" href="#" class="bannerimg-4">
                            <img src="/assets/images/IblowTheWhistleCustomerBanner.png" onclick="downloadAsImage(this); return false;" alt="horizontal banner" />
                            <p>413 x 1231</p>
                        </a>
                        <a target="_blank" href="#" class="bannerimg-9">
                            <img src="/assets/images/Whistle_Small_Square.jpg" onclick="downloadAsImage(this); return false;" alt="horizontal banner" />
                            <p>125 x 125</p>
                        </a>
                        <a target="_blank" href="#" class="bannerimg-5">
                            <img src="/assets/images/Whistle_Rect.jpg" onclick="downloadAsImage(this); return false;" alt="horizontal banner" />
                            <p>300 x 600</p>
                        </a>

                        <a target="_blank" href="#" class="bannerimg-6">
                            <img src="/assets/images/Whistle_Tall.jpg" onclick="downloadAsImage(this); return false;" alt="horizontal banner" />
                            <p>160 x 600</p>
                        </a>


                        <a target="_blank" href="#" class="bannerimg-7">
                            <img src="/assets/images/Whistle_MediumSquare.jpg"  onclick="downloadAsImage(this); return false;" alt="horizontal banner" />
                            <p>300 x 250</p>
                        </a>

                        <a target="_blank" href="#" class="bannerimg-8">
                            <img src="/assets/images/Whistle_small.jpg" onclick="downloadAsImage(this); return false;" alt="horizontal banner" />
                            <p>20 x 240</p>
                        </a>


                    </div>

                </div>


            </div>
        </div>
    </div>


</asp:Content>
