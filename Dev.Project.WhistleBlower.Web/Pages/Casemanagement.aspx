<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Casemanagement.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Casemanagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <script src="/Scripts/PageScripts/Casemanagement.js"></script>
    <style>
        .main-body {
            padding: 15px;
        }

        .card {
            box-shadow: 0 1px 3px 0 rgba(0,0,0,.1), 0 1px 2px 0 rgba(0,0,0,.06);
        }

        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 0 solid rgba(0,0,0,.125);
            border-radius: .25rem;
        }

        .card-body {
            flex: 1 1 auto;
            min-height: 1px;
            padding: 1rem;
        }

        .gutters-sm {
            margin-right: -8px;
            margin-left: -8px;
        }

            .gutters-sm > .col, .gutters-sm > [class*=col-] {
                padding-right: 8px;
                padding-left: 8px;
            }

        .mb-3, .my-3 {
            margin-bottom: 1rem !important;
        }

        .bg-gray-300 {
            background-color: #e2e8f0;
        }

        .h-100 {
            height: 100% !important;
        }

        .shadow-none {
            box-shadow: none !important;
        }

        .warpper {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .tab {
            cursor: pointer;
            padding: 10px 20px;
            margin: 0px 2px;
            background: #000;
            display: inline-block;
            color: #fff;
            border-radius: 3px 3px 0px 0px;
            box-shadow: 0 0.5rem 0.8rem #00000080;
        }

        .panels {
            background: #fffffff6;
            box-shadow: 0 2rem 2rem #00000080;
            min-height: 200px;
            width: 100%;
            border-radius: 3px;
            overflow: hidden;
            padding: 20px;
        }

        .panel {
            display: none;
            animation: fadein .8s;
        }

        @keyframes fadein {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        .panel-title {
            font-size: 1.5em;
            font-weight: bold
        }

        .radio {
            display: none;
        }

        #one:checked ~ .panels #one-panel,
        #two:checked ~ .panels #two-panel,
        #three:checked ~ .panels #three-panel {
            display: block
        }

        #one:checked ~ .tabs #one-tab,
        #two:checked ~ .tabs #two-tab,
        #three:checked ~ .tabs #three-tab {
            background: #fffffff6;
            color: #000;
            border-top: 3px solid #000;
        }

        ul.timeline {
            list-style-type: none;
            position: relative;
        }

            ul.timeline:before {
                content: ' ';
                background: #d4d9df;
                display: inline-block;
                position: absolute;
                left: 29px;
                width: 2px;
                height: 100%;
                z-index: 400;
            }

            ul.timeline > li {
                margin: 20px 0;
                padding-left: 20px;
            }

                ul.timeline > li:before {
                    content: ' ';
                    background: white;
                    display: inline-block;
                    position: absolute;
                    border-radius: 50%;
                    border: 3px solid #22c0e8;
                    left: 20px;
                    width: 20px;
                    height: 20px;
                    z-index: 400;
                }
    </style>
    <section class="section-split">
        <div class="container-fluid">
            <div class="row no-gutters justify-content-center height-100">
                <div class="col-md-12 align-items-center ">
                    <div class="container myaccount-contanier">
                        <div class="row m-0 justify-content-center align-items-center">
                            <div class="col-12">
                                <div class="col-xl-12 top-header mb-3">
                                    <h1>Case Management</h1>
                                    <span class="header-line"></span>
                                </div>

                                <div class="main-body" style="background-color: #e2e8f0">

                                    <div class="row gutters-sm">
                                        <div class="col-md-4 mb-3">
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="d-flex flex-column align-items-center text-center">
                                                        <img src="/assets/images/avatar7.png" alt="Admin" class="rounded-circle" width="150" />
                                                        <div class="mt-3">
                                                            <h4>Annoymous User</h4>
                                                            <p class="text-secondary mb-1"></p>
                                                            <p class="text-muted font-size-sm"></p>
                                                            <a target="_blank" href="#" id="ancSendResponse" class="btn btn-outline-primary">Message</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card mt-3">
                                                <div style="display: inline-flex">
                                                    <input id="FileAttachmentDetails" name="FileAttachmentDetails" type="file" multiple="multiple" class="form-control form-control-file" />
                                                    <button class="btn btn-outline-primary" onclick="uploadCaseDocuments();return false;">Upload</button>
                                                </div>
                                                <div id="divCaseDocuments">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="card mb-3">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <h6 class="mb-0">Case Transation Number</h6>
                                                        </div>
                                                        <div class="col-sm-8 text-secondary">
                                                            <span id="spnIncID"></span>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <h6 class="mb-0">Case Rigistered</h6>
                                                        </div>
                                                        <div class="col-sm-8 text-secondary">
                                                            <span id="spnSubmissionDate"></span>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <h6 class="mb-0">Case Last Updated</h6>
                                                        </div>
                                                        <div class="col-sm-8 text-secondary">
                                                            (239) 816-9029
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="row gutters-sm">
                                                <div class="warpper">
                                                    <input class="radio" id="one" name="group" type="radio" checked />
                                                    <input class="radio" id="two" name="group" type="radio" />
                                                    <input class="radio" id="three" name="group" type="radio" />
                                                    <div class="tabs">
                                                        <label class="tab" id="one-tab" for="one">Case Updates</label>
                                                        <label class="tab" id="two-tab" for="two">Call Records</label>
                                                        <label class="tab" id="three-tab" for="three">Others</label>
                                                    </div>
                                                    <div class="panels">
                                                        <div class="panel" id="one-panel">

                                                            <div class="container mt-3 mb-3">
                                                                <div class="row">
                                                                    <div class="col ml-2">
                                                                        <!-- Textarea -->
                                                                        <textarea class="form-control" id="txtMessage" data-toggle="autosize" rows="2" placeholder="Leave followup information" required></textarea>
                                                                        <div class="txtMessage invalid-feedback">
                                                                            Please provide followup information.                                       
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-auto align-self-end">
                                                                        <!-- Icons -->
                                                                        <button id="button" type="submit" onclick="updateCaseInformation(); return false;" class="btn btn-xs btn-primary"><span id="btnUpdate">Update</span></button>
                                                                    </div>

                                                                    <div class="col-md-12 offset-md-0">
                                                                        <h4>Latest Updates</h4>
                                                                        <div id="divCaseTimeLine"></div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="panel" id="two-panel">
                                                            <div class="panel-title">Take-Away Skills</div>
                                                            <p>You will learn many aspects of styling web pages! You’ll be able to set up the correct file structure, edit text and colors, and create attractive layouts. With these skills, you’ll be able to customize the appearance of your web pages to suit your every need!</p>
                                                        </div>
                                                        <div class="panel" id="three-panel">
                                                            <div class="panel-title">Note on Prerequisites</div>
                                                            <p>We recommend that you complete Learn HTML before learning CSS.</p>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!--end of row-->
                        </div>
                    </div>
                    <!--end of container-->
                </div>
                <!--end of col-->


            </div>
            <!--end of row-->

        </div>
        <!--end of container-->
    </section>


</asp:Content>
