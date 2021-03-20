<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.MyAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <script src="/Scripts/PageScripts/MyAccount.js"></script>
    <script src="/assets/js/toast.script.js"></script>
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
                                    <p class="text-xl-center">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
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
                                                <img class="imgTopBanner" src="/assets/images/Whistle_728x90_Internalbanner.PNG" alt="" />
                                                `<br />
                                                <div class="avatar-change ml-4">
                                                    <%--<h6 class="mb-3 text-uppercase font-weight-normal">r</h6>--%>
                                                    <label class="btn btn-sm btn-dark file-attachment-btn" for="topBannerAttachmentBtn">
                                                        Select Top Banner
                                                      <input id="topBannerAttachmentBtn" accept="image/*" value="" name="file-attachment" type="file" class="file-attachment-btn-label" />
                                                    </label>
                                                    <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Update Banner" onclick="updateCompanyProfile();" id="btnUpdateTopBanner" />

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
                                        <a class="toggle" href="#">Item 3</a>
                                        <p class="inner">
                                            Let's make a nice big leafy tree. You have to make those little noises or it won't work. Let's put some happy little clouds in our world. We don't really know where this goes - and I'm not sure we really care. When you do it your way you can go anywhere you choose. No worries. No cares. Just float and wait for the wind to blow you around.
                                        </p>
                                    </li>

                                    <li class="accordion-list">
                                        <a class="toggle" href="#">Item 4</a>
                                        <p class="inner">
                                            Let's make a nice big leafy tree. You have to make those little noises or it won't work. Let's put some happy little clouds in our world. We don't really know where this goes - and I'm not sure we really care. When you do it your way you can go anywhere you choose. No worries. No cares. Just float and wait for the wind to blow you around.
                                        </p>
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



        function showSuccessMessage(strMessage) {
            $.Toast("Success", strMessage, "success", {
                //has_icon: true,
                has_close_btn: true,
                stack: true,
                fullscreen: true,
                timeout: 8000,
                sticky: false,
                has_progress: true,
                rtl: false,
            });
        }
    </script>
</asp:Content>
