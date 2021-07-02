<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.MyAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <script src="/Scripts/PageScripts/MyAccount.js"></script>


    <style type="text/css">
        .file-attachment-btn-label {
            position: absolute;
            top: 0;
            right: 0;
            display: block;
            cursor: inherit;
            opacity: 0;
        }
    </style>
    <section class="section-split">
        <div class="container-fluid">
            <div class="row no-gutters justify-content-center height-100">
                <div class="col-md-12 align-items-center ">
                    <div class="container myaccount-contanier">
                        <div class="row m-0 justify-content-center align-items-center">
                            <div class="col-12">

                                <div class="col-xl-12 top-header">
                                    <h1>My Account</h1>
                                    <span class="header-line"></span>
                                    <p class="text-xl-center">My Account is the central customer dashboard in I Blow The Whistle. Customers can change company avatars, banners, view past orders and payment details.</p>
                                </div>

                                <ul class="accordion">
                                    <li class="accordion-list">
                                        <a class="toggle" href="#">Your Avatar</a>
                                        <div class="inner intro mb-4">

                                            <div class="d-flex justify-content-center align-items-center pb-3 inner-1">

                                                <!-- // no avatar -->
                                                <img class="comavatar avatar-lg" src="/assets/images/LargeAvatar.png" alt="" />
                                                <div class="avatar-change ml-4">
                                                    <%--<h6 class="mb-3 text-uppercase font-weight-normal">Your Avatar</h6>--%>
                                                    <label class="btn btn-sm btn-dark file-attachment-btn" for="profilePicAttachmentBtn">
                                                        Select Profile Picture
                                                        <input id="profilePicAttachmentBtn" accept="image/*" value="" name="file-attachment" type="file" class="file-attachment-btn-label" />
                                                    </label>

                                                    <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Update Picture" onclick="updateCompanyProfile();" id="btnUpdateAccount" />

                                                </div>
                                                <!--end of avatar change-->

                                                <!--end of form-group-->
                                            </div>

                                            <%--<div class="form-group">
                                                <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Update" onclick="updateCompanyProfile();" id="btnUpdateAccount" />
                                                <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Back" id="btnBack" onclick="window.location.href = '/Pages/ViewIncidents.aspx'; return false;" />
                                            </div>--%>
                                            <!--end of flex-->
                                        </div>
                                    </li>

                                    <li class="accordion-list">
                                        <a class="toggle" href="#">Top Banner</a>

                                        <div class="inner intro mb-4">

                                            <div class="d-flex justify-content-center align-items-center pb-3 inner-2">

                                                <!-- // no avatar -->
                                                <img class="imgTopBanner" src="/assets/images/WhistleDefaultTopBanner.PNG" alt="" />
                                                <br />
                                                <div class="avatar-change ml-4">
                                                    <%--<h6 class="mb-3 text-uppercase font-weight-normal">r</h6>--%>
                                                    <label class="btn btn-sm btn-dark file-attachment-btn" for="topBannerAttachmentBtn">
                                                        Select Top Banner
                                                      <input id="topBannerAttachmentBtn" accept="image/*" value="" name="file-attachment" type="file" class="file-attachment-btn-label" />
                                                    </label>
                                                    <input type="button" class="btn right  btn-sm btn-block btn-primary p-4" value="Update Banner" onclick="updateCompanyProfile();" id="btnUpdateTopBanner" />

                                                </div>
                                                <!--end of avatar change-->
                                                <!--end of flex-->

                                            </div>
                                            <%--  `<br />
                                            <div class="form-group">
                                                <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Update Banner" onclick="updateCompanyProfile();" id="btnUpdateTopBanner" />
                                                <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Back" id="btnBackBanner" onclick="window.location.href = '/Pages/ViewIncidents.aspx'; return false;" />
                                            </div>--%>
                                        </div>
                                    </li>

                                    <li class="accordion-list">
                                        <a class="toggle" href="#">Preferred Language</a>
                                        <div class="inner intro mb-4" style="height: auto; min-height: 400px;">
                                            <p class="inner">
                                                Let's make a nice big leafy tree. You have to make those little noises or it won't work. Let's put some happy little clouds in our world. We don't really know where this goes - and I'm not sure we really care. When you do it your way you can go anywhere you choose. No worries. No cares. Just float and wait for the wind to blow you around.
                                            </p>
                                            <div class="d-flex justify-content-center align-items-center pb-3 inner-2">

                                                <div class="nav-item dropdown language-switcher">
                                                    <%--<h6 class="mb-3 text-uppercase font-weight-normal">r</h6>--%>
                                                    <label>
                                                        Select Preferred Language                                                    
                                                    </label>
                                                    <a class="nav-link icon dropdown-toggle avatar-sm d-inline-flex dropdownLanguage" href="#" style="border: 2px solid #999; padding-left: 10px; border-radius: 50%" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">EN</a>
                                                    <div class="dropdown-menu dropdown-menu-right ddlLanguage" aria-labelledby="dropdownLanguage">
                                                        <a href="#" class="dropdown-item" id="engItem">
                                                            <%-- <i class="flag-icon flag-icon-squared flag-icon-us"></i>--%>
                                                            <span>English</span>
                                                        </a>
                                                        <a href="#" class="dropdown-item" id="thaiItem">
                                                            <%--<i class="flag-icon flag-icon-squared flag-icon-th"></i>--%>
                                                            <span>Thai</span>
                                                        </a>
                                                        <a href="#" class="dropdown-item" id="frenchItem">
                                                            <%--<i class="flag-icon flag-icon-squared flag-icon-fr"></i>--%>
                                                            <span>French</span>
                                                        </a>
                                                        <a href="#" class="dropdown-item" id="spanishItem">
                                                            <%--<i class="flag-icon flag-icon-squared flag-icon-es"></i>--%>
                                                            <span>Spanish</span>
                                                        </a>
                                                        <a href="#" class="dropdown-item" id="russianItem">
                                                            <%--<i class="flag-icon flag-icon-squared flag-icon-ru"></i>--%>
                                                            <span>Russian</span>
                                                        </a>
                                                        <a href="#" class="dropdown-item" id="kazItem">
                                                            <%--<i class="flag-icon flag-icon-squared flag-icon-kz"></i>--%>
                                                            <span>Kazakh</span>
                                                        </a>
                                                        <a href="#" class="dropdown-item" id="arabicItem">
                                                            <%--<i class="flag-icon flag-icon-squared flag-icon-ar"></i>--%>
                                                            <span>Arabic</span>
                                                        </a>
                                                    </div>
                                                    <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Update Language" onclick="updateCompanyProfile();" id="btnUpdateLanguage" />

                                                </div>
                                                <!--end of avatar change-->
                                                <!--end of flex-->

                                            </div>
                                        </div>
                                    </li>

                                </ul>

                            </div>
                            <!--end of col-->
                        </div>



                        <!--end of row-->
                    </div>
                    <!--end of container-->
                </div>
                <!--end of col-->


            </div>
            <!--end of row-->

        </div>
        <!--end of container-->
    </section>
    <script type="text/javascript">
        $('#profilePicAttachmentBtn').on('change', function () {
            readFile(this.files[0], function (e) {
                $('.comavatar').attr("src", e.target.result);
                ppBase64 = e.target.result;
            });
        });

        $('#topBannerAttachmentBtn').on('change', function () {
            readBannerFile(this.files[0], function (e) {
                $('.imgTopBanner').attr("src", e.target.result);
                cbBase64 = e.target.result;
            });
        });


        $('.toggle').click(function (e) {
            e.preventDefault();

            let $this = $(this);

            if ($this.next().hasClass('show')) {
                $this.next().removeClass('show');
                $this.next().slideUp(350);
            } else {
                $this.parent().parent().find('li .inner').removeClass('show');
                $this.parent().parent().find('li .inner').slideUp(350);
                $this.next().toggleClass('show');
                $this.next().slideToggle(350);
            }
        });


    </script>
</asp:Content>
