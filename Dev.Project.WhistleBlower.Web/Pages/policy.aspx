<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlower.Master" AutoEventWireup="true" CodeBehind="policy.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.policy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    policy | I Blow The Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/policy.js"></script>
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
                                <div id="divCaseDocuments" class="mt-5">
                                </div>
                                <div id="divCaseHtmContents" class="mt-4">
                                </div>
                                <div class="alert alert-info alert-dismissible fade show" style="display: none" role="alert" id="divInfo">
                                    <span id="successMessage">There is no policies</span>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
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
</asp:Content>
