<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Response.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Response" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
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
                <div class="col-lg-10 col-xl-8">
                    <header class="text-center mb-6">
                        <h1 class="display-3" id="formTitle"></h1>
                        <p class="lead" id="formShortNote"></p>
                    </header>
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
                                <div class="col-auto">
                                    <!-- Avatar -->
                                    <div class="no-avatar avatar-sm">
                                        <i class="icon-user"></i>
                                    </div>
                                </div>
                                <div class="col ml-n2">

                                    <!-- Label -->
                                    <label class="sr-only" id="leaveComment"></label>
                                    <!-- Textarea -->
                                    <textarea class="form-control" id="txtMessage" data-toggle="autosize" rows="2" placeholder="Leave a comment" required></textarea>
                                    <div class="txtMessage invalid-feedback">
                                        Please provide a comment.                                       
                                    </div>


                                </div>
                                <div class="col-auto align-self-end">
                                    <!-- Icons -->
                                    <button id="button" type="submit" onclick="sendResponse(); return false;" class="btn btn-xs btn-primary"><span id="btSend"></span></button>
                                    <button type="submit" onclick="window.open('', '_self', ''); window.close();" id="btnClose" class="btn btn-xs btn-outline-danger"><span id="btClose"></span></button>

                                </div>
                            </div>
                            <!-- end of row -->
                            <div class="form-group my-4">
                            </div>
                        </div>
                        <!-- end of card body -->
                    </div>
                    <!-- end of card -->
                </div>
                <!--end of col-->

            </div>

            <!--end of row-->
        </div>
        <!--end of container-->
    </section>
    <!-- // Section: Report Incident -->
    <!-- Form Autosize -->
    <script src="/assets/js/autosize.min.js" async defer></script>

    <script>
        autosize($('textarea'));
    </script>

</asp:Content>
