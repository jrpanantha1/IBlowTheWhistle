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
                    <div class="container">
                        <div class="row m-0 justify-content-center align-items-center height-100">
                            <div class="col-10 col-md-8">

                                <div class="intro mb-4">

                                    <div class="d-flex justify-content-center align-items-center pb-5 border-bottom">

                                        <!-- // no avatar -->
                                        <img class="comavatar avatar-lg" src="/assets/images/LargeAvatar.png" alt="" />
                                        <div class="avatar-change ml-4">
                                            <h6 class="mb-3 text-uppercase font-weight-normal">Your Avatar</h6>
                                            <label class="btn btn-sm btn-dark file-attachment-btn" for="profilePicAttachmentBtn">
                                                Select Profile Picture
                                                <input id="profilePicAttachmentBtn" accept="image/*" value="" name="file-attachment" type="file" class="file-attachment-btn-label" />
                                            </label>

                                        </div>
                                        <!--end of avatar change-->

                                        <!--end of form-group-->
                                    </div>
                                    `<br />
                                    <div class="form-group">
                                        <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Update" onclick="updateCompanyProfile();" id="btnUpdateAccount" />
                                        <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Back" id="btnBack" onclick="window.location.href = '/Pages/ViewIncidents.aspx'; return false;" />
                                    </div>
                                    <!--end of flex-->
                                </div>
                                <div class="intro mb-4">

                                    <div class="d-flex justify-content-center align-items-center pb-5 border-bottom">

                                        <!-- // no avatar -->
                                        <img class="topBanner" src="/assets/images/Whistle_728x90_Internalbanner.PNG" alt="" />
                                        `<br />
                                        <div class="avatar-change ml-4">
                                            <h6 class="mb-3 text-uppercase font-weight-normal">Top Banner</h6>
                                            <label class="btn btn-sm btn-dark file-attachment-btn" for="topBannerAttachmentBtn">
                                                Select Top Banner
                                                <input id="topBannerAttachmentBtn" accept="image/*" value="" name="file-attachment" type="file" class="file-attachment-btn-label" />
                                            </label>

                                        </div>
                                        <!--end of avatar change-->
                                        <!--end of flex-->
                                        
                                    </div>
                                    `<br />
                                        <div class="form-group">
                                            <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Update Banner" onclick="updateCompanyProfile();" id="btnUpdateTopBanner" />
                                            <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Back" id="btnBackBanner" onclick="window.location.href = '/Pages/ViewIncidents.aspx'; return false;" />
                                        </div>

                                </div>


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
                $('.topBanner').attr("src", e.target.result);
                cbBase64 = e.target.result;
            });
        });
    </script>
</asp:Content>
