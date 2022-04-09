<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Response.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Response" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Response | I Blow the Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.min.js" async defer></script>
    <script src="/Scripts/PageScripts/ResponseV1.js"></script>
    <style type="text/css">
        .error {
            border: 1px solid red !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <section class="py-10">
        <div class="container">
            <div class="row justify-content-center">

                <div class="col-12 col-10">
                    <div class="topBanner" style="display: none">
                        <a class="ancImgTopBanner" target="_blank" href="#">
                            <img class="imgTopBanner" alt="horizontal banner" />
                        </a>
                    </div>
                    <header class="text-center mb-2">
                        <h1 class="display-5 langDirection" id="formTitle"></h1>
                        <p class="lead langDirection" id="formShortNote"></p>
                    </header>
                    <a onclick="getResponseHistory();return false;" href="#" id="ancRefresh" data-toggle='tooltip' data-placement='left' data-original-title='Reload response' class="smooth-scroll">
                        <img alt="reload" src="/Images/reloadBidir.png" /></a>
                    <!-- end of header -->
                    <div class="card shadow-sm">
                        <div class="card-body p-5">

                            <div id="chartDiv">
                            </div>


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
                                <div class="col-auto d-none">
                                    <!-- Avatar -->
                                    <div class="no-avatar avatar-sm">
                                        <i class="icon-user"></i>
                                    </div>
                                </div>
                                <div class="col">

                                    <!-- Label -->
                                    <label class="sr-only" id="leaveComment"></label>
                                    <!-- Textarea -->
                                    <textarea class="form-control langDirection" id="txtMessage" data-toggle="autosize" rows="2" placeholder="Leave a comment" required></textarea>
                                    <div class="txtMessage invalid-feedback langDirection">
                                        Please provide a comment.                                       
                                    </div>


                                </div>
                                <div class="col-auto align-self-end">
                                    <!-- Icons -->
                                    <button id="button" type="submit" onclick="sendResponse(); return false;" class="btn btn-xs btn-primary langDirection"><span id="btSend"></span></button>
                                    <button type="button" onclick="window.location.href = '/Pages/ViewIncidents.aspx'" id="btnClose" class="btn btn-xs btn-outline-danger langDirection"><span id="btClose"></span></button>
                                    <a href="#" onclick="exportToPDF(); return false;" data-toggle='tooltip' data-placement='top' style="height: 24px; width: 24px;" data-original-title='Export chat info to PDF'>
                                        <img class="imgPDFIcon" src="/Images/PDFIcon.png" /></a>
                                    <a id="ancSaveChatInfotoCaseMngt" onclick="saveChatInfotoCaseMngt(); return false;" style="height: 24px; width: 24px; display: none;" href="#" data-toggle='tooltip' data-placement='top' data-original-title='Save to Case Tracking' class="smooth-scroll">
                                        <img src="/Images/uploadIntoCaseTrack.png" /></a>
                                </div>

                            </div>
                            <!-- end of row -->





                        </div>
                        <!-- end of card body -->

                    </div>
                    <!-- end of card -->
                    <br />
                    <div class="row">

                        <div class="col-8" style="display: inline-flex; margin-bottom: 3px;">
                            <input id="FileAttachmentDetails" name="FileAttachmentDetails" type="file" multiple="multiple" class="form-control form-control-file" />
                            <button class="btn btn-outline-primary" onclick="uploadIncidentDocumentsinResponse();return false;">Upload</button>

                        </div>


                    </div>
                    <div id="divCaseDocuments">
                    </div>
                </div>
                <!--end of col-->

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

</asp:Content>
