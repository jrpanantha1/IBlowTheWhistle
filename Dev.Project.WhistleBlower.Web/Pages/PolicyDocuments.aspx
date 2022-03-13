<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="PolicyDocuments.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.PolicyDocuments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Policy Documents | I Blow the Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/PolicyDocuments.js"></script>
    <%--<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>--%>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    <%--  <link href="/assets/css/summernote-lite.min.css" rel="stylesheet">
    <script src="/assets/js/summernote-lite.min.js"></script>--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <section class="section-split">
        <div class="container-fluid">
            <div class="row no-gutters justify-content-center height-100">
                <div class="col-md-12 align-items-center ">
                    <div class="container myaccount-contanier">
                        <div class="row m-0 justify-content-center align-items-center">
                            <div class="col-12">
                                <div class="col-xl-12 top-header">
                                    <div class="topBanner" style="display: none">
                                        <a class="ancImgTopBanner" target="_blank" href="#">
                                            <img class="imgTopBanner" alt="horizontal banner" />
                                        </a>
                                    </div>
                                </div>

                                <header class="text-center mb-1 ">

                                    <h2 class="langDirection" id="formTitle">Policy Documents</h2>
                                    <span class="header-line langDirection"></span>
                                    <p class="lead langDirection" id="formShortNote"></p>
                                </header>
                                <a href="#" onclick="window.location.href='/Pages/ManageAdmin.aspx';" data-toggle='tooltip' data-placement='top' style="height: 24px; width: 24px; padding-left: 10px;" data-original-title='Back to Administration'>
                                    <img src="/Images/backToHome.png" /></a>
                                <!-- end of header -->
                                <div class="card shadow-sm mt-5">

                                    <div id="summernote"></div>

                                </div>
                                <div class="card shadow-sm mt-5">
                                    <!-- Form -->
                                    <div class="row">
                                        <!-- Alert -->

                                        <div class="col-12" id="divSuccess" style="display: none">
                                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                <span id="successMessage"></span>
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="col-8" style="display: inline-flex; margin-bottom: 3px;">
                                            <input id="FileAttachmentDetails" name="FileAttachmentDetails" type="file" multiple="multiple" class="form-control form-control-file" />
                                            <button class="btn btn-outline-primary" onclick="uploadPolicyDocuments();return false;">Upload</button>

                                        </div>
                                    </div>
                                    <!-- end of row -->
                                </div>
                                <!--end of col-->
                                <div id="divCaseHtmContents" class="mt-4">
                                </div>
                                <div id="divCaseDocuments" class="mt-4">
                                </div>
                            </div>

                            <!--end of row-->
                        </div>
                    </div>

                    <!--end of row-->
                </div>
            </div>

            <!--end of row-->
        </div>
        <!--end of container-->
    </section>
    <!-- // Section: Report Incident -->
    <!-- Form Autosize -->
    <div id="elementH"></div>
    <script src="/assets/js/autosize.min.js" async defer></script>
    <script>
        autosize($('textarea'));

    </script>
    <script>
        $('#summernote').summernote({
            placeholder: 'Hello stand alone ui',
            tabsize: 2,
            height: 100,
            placeholder: 'Share it!',
            hintMode: 'words',
            hintSelect: 'next',
            spellCheck: true,
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture', 'video']],
                ['view', ['fullscreen', 'codeview', 'help']]
            ]
        });
        $('.note-status-output').html(
            '<button class="sendbtn" onclick="updatePolicy();return false;"><i class="icon-send"></i></button>'
        );
    </script>
    <style>
        .sendbtn {
            position: absolute;
            right: 0;
            border: 0;
            background: none;
            bottom: 0;
            font-size: 34px;
        }

        .note-status-output {
            border: 0 !important;
        }
    </style>
</asp:Content>
