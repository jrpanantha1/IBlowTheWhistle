<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Casemanagement.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Casemanagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <script src="/Scripts/PageScripts/Casemanagement.js"></script>

    <section class="section-split">
        <div class="container-fluid">
            <div class="row no-gutters justify-content-center height-100">
                <div class="col-md-12 align-items-center ">
                    <div class="container myaccount-contanier">
                        <div class="row m-0 justify-content-center align-items-center">
                            <div class="col-12 contentarea">
                                <div class="col-xl-12 top-header mb-3">
                                    <h1>Case Management</h1>
                                    <span class="header-line"></span>
                                </div>

                                <div class="main-body casehistory-container" style="background-color: #e2e8f0">

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
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="card mb-3">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <h6 class="mb-0">Case Transaction Number</h6>
                                                        </div>
                                                        <div class="col-sm-8 text-secondary">
                                                            <span id="spnIncID"></span>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <h6 class="mb-0">Case Registered</h6>
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
                                                            <span id="spnLastModifiyDate"></span>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="row gutters-sm casemanage-container">
                                                <div class="warpper">
                                                    <input class="radio" id="one" name="group" type="radio" checked />
                                                    <input class="radio" id="two" name="group" type="radio" />
                                                    <input class="radio d-none" id="three" name="group" type="radio" />
                                                    <div class="tabs">
                                                        <label class="tab" id="one-tab" for="one">Case Updates</label>
                                                        <label class="tab" id="two-tab" for="two">Files</label>
                                                        <label class="tab d-none" id="three-tab" for="three">PDF</label>
                                                    </div>
                                                    <div class="panels">
                                                        <div class="panel" id="one-panel">

                                                            <div class="container mt-3 mb-3">
                                                                <div class="row">
                                                                    <div class="col-9 ml-2">
                                                                        <!-- Textarea -->
                                                                        <textarea class="form-control" id="txtMessage" data-toggle="autosize" rows="2" placeholder="Leave follow up information" required></textarea>

                                                                        <div class="txtMessage invalid-feedback">
                                                                            Please provide follo wup information.                                       
                                                                        </div>

                                                                    </div>
                                                                    <div class="col ml-2">
                                                                        <button id="button" style="position: absolute; bottom: 0; width: 100px;" type="submit" onclick="updateCaseInformation(''); return false;" class="btn btn-xs btn-primary"><span id="btnUpdate">Update</span></button>
                                                                    </div>

                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-9 ml-2">
                                                                        <select name="preAction" id="ddlCasePre" size="5" multiple="multiple" class="form-control" style="margin-top: 5px;">
                                                                        </select>

                                                                    </div>
                                                                    <div class="col ml-2">
                                                                        <button id="btnAdd" style="position: absolute; bottom: 0; width: 100px;" type="submit" onclick="if(!validateSelectCaseTemplate()){return false;}updateCaseInformation($('#ddlCasePre option:selected').val()); return false;" class="btn btn-xs btn-primary"><span id="spanBtnAdd">Add</span></button>
                                                                    </div>
                                                                </div>
                                                                <div class="col-auto align-self-end">
                                                                    <!-- Icons -->


                                                                </div>

                                                                <div class="col-md-12 offset-md-0">
                                                                    <h4>Latest Updates</h4>
                                                                    <div id="wrapper"></div>
                                                                </div>


                                                            </div>
                                                        </div>
                                                        <div class="panel" id="two-panel">
                                                            <div style="display: inline-flex">
                                                                <input id="FileAttachmentDetails" name="FileAttachmentDetails" type="file" multiple="multiple" class="form-control form-control-file" />
                                                                <button class="btn btn-outline-primary" onclick="uploadCaseDocuments();return false;">Upload</button>
                                                            </div>
                                                            <div id="divCaseDocuments">
                                                            </div>
                                                        </div>
                                                        <div class="panel d-none" id="three-panel">
                                                            <div class="panel-title">Note on Prerequisites</div>
                                                            <p>We recommend that you complete Learn HTML before learning CSS.</p>
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
