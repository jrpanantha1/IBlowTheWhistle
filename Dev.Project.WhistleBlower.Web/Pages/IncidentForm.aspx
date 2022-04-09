<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlower.Master" AutoEventWireup="true" CodeBehind="IncidentForm.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.IncidentForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Report A Fraud | I Blow The Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="/assets/css/styles.min.css" rel="stylesheet" />
    <link href="/Scripts/DropZone/fancy_fileupload.css" rel="stylesheet" />
    <script src="/Scripts/PageScripts/IncidentForm.js"></script>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <style type="text/css">
        .section-hero {
            background: none !important;
        }

        .Pricingtag {
            display: none;
        }

        .hiddenControl {
            position: absolute;
            left: -9999px;
        }

        .cbtooltip {
            position: relative;
            display: inline-block;
        }

            .cbtooltip .cbtooltiptext {
                visibility: hidden;
                width: 140px;
                background-color: #555;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 5px;
                position: absolute;
                z-index: 1;
                bottom: 150%;
                left: 50%;
                margin-left: -75px;
                opacity: 0;
                transition: opacity 0.3s;
            }

                .cbtooltip .cbtooltiptext::after {
                    content: "";
                    position: absolute;
                    top: 100%;
                    left: 50%;
                    margin-left: -5px;
                    border-width: 5px;
                    border-style: solid;
                    border-color: #555 transparent transparent transparent;
                }

            .cbtooltip:hover .cbtooltiptext {
                visibility: visible;
                opacity: 1;
            }
    </style>
    <!-- Anonymous Modal -->
    <div class="modal fade" id="AnonymousModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="AnonymousLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content p-4">
                <div class="modal-body text-center">
                    <div id="texttocopy">
                        <h3 class="modal-title mb-3" id="successInfo">Your incident has been confirmed.</h3>
                        <p class="text-center">Please note this transaction id for future reference.</p>
                        <p class="text-center">
                            <strong>Transaction ID : </strong><span id="trxID"></span>
                            <input type="text" id="txtTran" class="hiddenControl" />
                            <div class="cbtooltip">
                                <button onclick="myFunctionTransation();return false;" onmouseout="outFuncTran()">
                                    <span class="cbtooltiptext" id="myTooltipTran">Copy to tran ID</span>
                                    <i class="icon-clipboard"></i>
                                </button>
                            </div>
                        </p>
                        <div id="annoymouslogin">
                            <h3 class="modal-title mb-3" id="AnonymousLabel">Your temporary login details</h3>
                            <p class="mb-4">Please take note of your temporary username and password.</p>
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center"><strong>User Name</strong> <span id="spanUserName"></span>
                                    <input type="text" id="txtUname" class="hiddenControl" />
                                    <div class="cbtooltip">
                                        <button onclick="myFunctionUserName();return false;" onmouseout="outFunc()">
                                            <span class="cbtooltiptext" id="myTooltipName">Copy to User Name</span>
                                            <i class="icon-clipboard"></i>
                                        </button>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center"><strong>Password</strong> <span id="spanPassword"></span>
                                    <input type="text" id="txtPass" class="hiddenControl" />
                                    <div class="cbtooltip">
                                        <button onclick="myFunctionPassword();return false;" onmouseout="outFuncPass()">
                                            <span class="cbtooltiptext" id="myTooltipPass">Copy to Password</span>
                                            <i class="icon-clipboard"></i>
                                        </button>
                                    </div>
                                </li>
                            </ul>

                        </div>
                        <div id="divAccountExistMsg">
                            <p class="mb-4" style="font-weight: bold" id="pAccountExistMsg"></p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0" style="margin: 0 auto;">
                    <button type="button" id="btnGoHome" class="btn btn-lg btn-primary" onclick="window.location.href='/Pages/Login.aspx';">Go to Login</button>
                    <button type="button" id="btnGoClose" class="btn btn-lg btn-primary" onclick="$('#AnonymousModal').modal('hide');location.reload();return false;" style="display: none">Close</button>
                </div>
            </div>
        </div>
    </div>
    <section id="reportFraud" class="section-hero">
        <div class="container">
            <div class="row justify-content-center align-items-center py-10 langDirection">
                <div class="col-lg-10 col-xl-8">
                    <div class="text-center">
                        <h1 class="display-3" style="color: #00B48F" id="h1CompanyName"></h1>
                    </div>
                    <div class="text-center titleSection">
                        <h1 class="display-4" id="ReportIncident"></h1>
                        <p class="lead" id="pAreYouWhistleBlower"></p>
                    </div>
                    <!-- end of text-center -->

                    <div class="mt-6">

                        <!-- end of hidden fields -->
                        <div class="form-group">
                            <label id="lblIsReportable"></label>
                            <select class="custom-select" id="IsReportable" name="IsReportable">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option class="optYes" value="Yes"></option>
                                <option class="optNo" value="No"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group">
                            <label for="comments" id="lblComments"></label>
                            <textarea id="comments" class="form-control" rows="6"></textarea>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group">
                            <label id="lblSupportingEvidence"></label>
                            <select class="custom-select" id="SupportingEvidence" name="SupportingEvidence">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option class="optYes" value="Yes"></option>
                                <option class="optNo" value="No"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapse collapseSupportingEvidence" id="collapseSupportingEvidence" name="collapseSupportingEvidence">
                            <label id="lblEvidenceDetails"></label>
                            <textarea id="EvidenceDetails" class="form-control" rows="6"></textarea>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapse collapseSupportingEvidence">
                            <label id="lblFileAttachment"></label>
                            <select class="custom-select" id="FileAttachment" name="FileAttachment">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option class="optYes" value="Yes"></option>
                                <option class="optNo" value="No"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapse" id="collapseFileAttachment" name="collapseFileAttachment">
                            <label id="lblBrowseText" class="sr-only"></label>
                            <input id="FileAttachmentDetails" name="FileAttachmentDetails" type="file" multiple="multiple" class="form-control form-control-file" />
                        </div>

                        <!-- end of form group -->
                        <div class="form-group">
                            <label id="lblHaveWitness">Do you have any witnesses?</label>
                            <select class="custom-select" id="HaveWitness" name="HaveWitness">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option class="optYes" value="Yes"></option>
                                <option class="optNo" value="No"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="collapse" id="collapseHaveWitness" name="collapseHaveWitness">
                            <!-- end of form group -->
                            <div class="col-12 form-group">
                                <button class="btn btn-sm btn-block btn-success btn-clone" type="button"><i class="icon-plus"></i></button>
                            </div>
                            <div class="witness clone-witness">
                                <div class="form-row">
                                    <div class="col form-group">
                                        <label id="lblWitnessFullName"></label>
                                        <input id="WitnessFullName" type="text" class="form-control" placeholder="Arya Stark" />
                                    </div>
                                    <!-- end of form group -->
                                    <div class="col form-group">
                                        <label id="lblWitnessEmail"></label>
                                        <input id="WitnessEmail" class="form-control" placeholder="arya.stark@winterfell.com" type="email" />
                                    </div>
                                    <!-- end of form group -->
                                    <div class="col-12 form-group">
                                        <label id="lblWitnessPhone"></label>
                                        <input id="WitnessPhone" class="form-control" placeholder="0123456789" type="text" />
                                    </div>
                                    <!-- end of form group -->
                                    <div class="col-12 form-group" style="display: none">
                                        <label for="WitnessModifiedDate">Witness' Modified Date</label>
                                        <input id="WitnessModifiedDate" class="form-control" type="date" />
                                    </div>
                                </div>
                            </div>



                        </div>

                        <!-- end collapse witness -->
                        <div class="form-group UpdatedOnIncidentDisableForAdmin">
                            <label id="lblUpdatedOnIncident"></label>
                            <select class="custom-select" id="UpdatedOnIncident" name="UpdatedOnIncident">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option class="optYes" value="Yes"></option>
                                <option class="optNo" value="No"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapse" id="collapseUpdatedOnIncident" name="collapseUpdatedOnIncident">
                            <label for="UpdatedOnIncidentMethod" id="lblHowWouldUpdate"></label>
                            <select class="custom-select" id="UpdatedOnIncidentMethod">
                                <option disabled value="" class="optPleaseSelect"></option>
                                <option value="Email" class="optByEmail"></option>
                                <option value="Phone" class="optByPhone"></option>
                                <option selected value="Anonymous" class="optByAnonymous"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapse" id="collapseUpdatedOnIncidentMethodEmail" name="collapseUpdatedOnIncidentMethodEmail">
                            <label for="UpdatedOnIncidentMethodEmail" id="lblEmailAddress"></label>
                            <input id="UpdatedOnIncidentMethodEmail" type="email" class="form-control" placeholder="arya.stark@winterfell.com" />
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapse" id="collapseUpdatedOnIncidentMethodPhone" name="collapseUpdatedOnIncidentMethodPhone">
                            <label for="UpdatedOnIncidentMethodPhone" id="lblPhone"></label>
                            <input id="UpdatedOnIncidentMethodPhone" type="text" class="form-control" placeholder="0123456789" />
                        </div>
                        <!-- end of form group -->
                        <div class="form-group custom-control custom-checkbox">
                            <input id="EvidenceCanBeUsedForInvestigation" type="checkbox" class="custom-control-input" />
                            <label for="EvidenceCanBeUsedForInvestigation" id="lblAuthrizeDeclaration" class="custom-control-label font-weight-normal"></label>
                        </div>
                        <!--end of custom-checkbox -->


                        <!-- end of form group -->
                        <div class="custom-control custom-checkbox">
                            <input id="customCheck1" type="checkbox" class="custom-control-input" />
                            <label for="customCheck1" id="lblAckPolicy" class="custom-control-label font-weight-normal"></label>
                        </div>
                        <!--end of custom-checkbox -->
                        <div class="form-group my-4">
                            <button type="submit" id="btnSubmit" onclick="if (IncidentFormValidation()) { submitIncidentDetails(); };return false;" class="btn btn-block btn-primary"></button>
                        </div>
                        <!-- end of form group -->
                    </div>
                    <!-- end of div -->

                    <p class="text-muted text-center" id="lblIdentityNeverRevel"><i class="icon-lock mr-1"></i></p>
                    <textarea id="txtarea" style="display: none"></textarea>
                    <!-- used for clipboard -->
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->
        </div>
        <!--end of container-->
    </section>
    <!-- // Section: Report Fraud -->

    <script src="/assets/js/form.min.js" async defer></script>
    <script type="text/javascript">
        $('#FileAttachmentDetails').on('change', function () {
            readFile(this.files[0], function (e) {
                CompanyLogoBase64 = e.target.result;
            });

            readFile(this.files[1], function (e) {
                CompanyLogoBase641 = e.target.result;
            });

            if (this.files[2].size > 0) {
                readFile(this.files[2], function (e) {
                    CompanyLogoBase642 = e.target.result;
                });
            }


        });

    </script>
</asp:Content>
