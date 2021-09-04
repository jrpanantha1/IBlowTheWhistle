<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="ViewForm.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ViewForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.disableControls').attr('disabled', true);
        });
    </script>
    <script src="/Scripts/PageScripts/ViewFormV1.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <section id="reportFraud" class="section-hero">
        <div class="container">
            <div class="row justify-content-center align-items-center py-10 langDirection">
                <div class="col-12 topBanner" style="display: none">
                    <a class="ancImgTopBanner" target="_blank" href="#">
                        <img class="imgTopBanner" alt="horizontal banner" src="" />

                    </a>
                </div>
                <div class="col-12">

                    <div class="text-center">
                        <h1 class="display-5" style="color: #00B48F" id="h1CompanyName"></h1>
                    </div>
                    <div class="text-center">
                        <h2 class="display-5" id="ReportIncident"></h2>
                        <p class="lead" id="pAreYouWhistleBlower"></p>
                    </div>
                    <!-- end of text-center -->

                    <div class="mt-6">

                        <!-- end of hidden fields -->
                        <div class="form-group">
                            <label id="lblIsReportable"></label>
                            <select class="custom-select disableControls" id="IsReportable" name="IsReportable">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option class="optYes" value="Yes"></option>
                                <option class="optNo" value="No"></option>
                            </select>
                        </div>
                        <!-- end of form group -->

                        <div class="form-group">
                            <label for="comments" id="lblComments"></label>
                            <textarea id="comments" disabled class="form-control disableControls" rows="6" placeholder="Additinal comments"></textarea>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group">
                            <label id="lblSupportingEvidence"></label>
                            <select class="custom-select disableControls" id="SupportingEvidence" name="SupportingEvidence">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option class="optYes" value="Yes"></option>
                                <option class="optNo" value="No"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapseSupportingEvidence" id="collapseSupportingEvidence" name="collapseSupportingEvidence">
                            <label id="lblEvidenceDetails"></label>
                            <textarea id="EvidenceDetails" class="form-control disableControls" rows="6" placeholder="Evidence details"></textarea>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapseSupportingEvidence">
                            <label id="lblFileAttachment"></label>
                            <select class="custom-select disableControls" id="FileAttachment" name="FileAttachment">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option class="optYes" value="Yes"></option>
                                <option class="optNo" value="No"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapseSupportingEvidence" id="collapseFileAttachment" name="collapseFileAttachment">
                            <label id="lblBrowseText" class="sr-only"></label>
                            <a class="ancViewDoc"></a>
                            <hr />
                            <div id="divAttachements">
                            </div>

                        </div>
                        <!-- end of form group -->
                        <div class="form-group">
                            <label id="lblHaveWitness">Do you have any witnesses?</label>
                            <select class="custom-select disableControls" id="HaveWitness" name="HaveWitness">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option class="optYes" value="Yes"></option>
                                <option class="optNo" value="No"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="" id="collapseHaveWitness" name="collapseHaveWitness">
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
                        <div class="form-group">
                            <label id="lblUpdatedOnIncident"></label>
                            <select class="custom-select disableControls" id="UpdatedOnIncident" name="UpdatedOnIncident">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option class="optYes" value="Yes"></option>
                                <option class="optNo" value="No"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapse" id="collapseUpdatedOnIncident" name="collapseUpdatedOnIncident">
                            <label for="UpdatedOnIncidentMethod" id="lblHowWouldUpdate"></label>
                            <select class="custom-select disableControls" id="UpdatedOnIncidentMethod">
                                <option selected disabled value="" class="optPleaseSelect"></option>
                                <option value="Email" class="optByEmail"></option>
                                <option value="Phone" class="optByPhone"></option>
                                <option value="Anonymous" class="optByAnonymous"></option>
                            </select>
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapse" id="collapseUpdatedOnIncidentMethodEmail" name="collapseUpdatedOnIncidentMethodEmail">
                            <label for="UpdatedOnIncidentMethodEmail" id="lblEmailAddress"></label>
                            <input id="UpdatedOnIncidentMethodEmail" disabled type="email" class="form-control disableControls" placeholder="arya.stark@winterfell.com" />
                        </div>
                        <!-- end of form group -->
                        <div class="form-group collapse" id="collapseUpdatedOnIncidentMethodPhone" name="collapseUpdatedOnIncidentMethodPhone">
                            <label for="UpdatedOnIncidentMethodPhone" id="lblPhone"></label>
                            <input id="UpdatedOnIncidentMethodPhone" type="text" disabled class="form-control disableControls" placeholder="0123456789" />
                        </div>
                        <!-- end of form group -->
                        <div class="form-group custom-control custom-checkbox">
                            <input id="EvidenceCanBeUsedForInvestigation" disabled type="checkbox" class="custom-control-input disableControls" />
                            <label for="EvidenceCanBeUsedForInvestigation" id="lblAuthrizeDeclaration" class="custom-control-label font-weight-normal"></label>
                        </div>
                        <!--end of custom-checkbox -->
                        <div class="form-row" style="display: none">
                            <div class="form-group col-md-6">
                                <label for="SubmissionDate">Submission Date</label>
                                <input id="SubmissionDate" disabled type="date" class="form-control" />
                            </div>
                            <!-- end of form group -->
                            <div class="form-group col-md-6">
                                <label for="SubmissionTime">Submission Time</label>
                                <input id="SubmissionTime" type="time" class="form-control" />
                            </div>
                            <!-- end of form group -->
                        </div>
                        <!-- end of form row -->
                        <div class="form-group" style="display: none">
                            <label for="SubmissionModifiedDate">Submission Modified Date</label>
                            <input id="SubmissionModifiedDate" disabled type="date" class="form-control" />
                        </div>

                        <!-- end of form group -->
                        <div class="custom-control custom-checkbox">
                            <input id="customCheck1" type="checkbox" class="custom-control-input disableControls" disabled />
                            <label for="customCheck1" id="lblAckPolicy" class="custom-control-label font-weight-normal"></label>
                        </div>

                        <!--end of custom-checkbox -->
                        <div class="form-group my-4">
                            <button type="submit" onclick="window.open('', '_self', ''); window.close();" id="btnClose" class="btn btn-block btn-primary"></button>
                        </div>
                        <!-- end of form group -->
                    </div>
                    <!-- end of div -->

                    <p class="text-muted text-center" id="lblIdentityNeverRevel"><i class="icon-lock mr-1"></i></p>
                    <p class="text-muted text-center">Transaction Ref ID: <strong><span class='spanTraxID'></span></strong></p>
                    <p class="text-muted text-center">Submission Date Time : <strong><span class='spanTraxDate'></span></strong></p>
                </div>
                <!--end of col-->

            </div>
            <!--end of row-->
        </div>
        <!--end of container-->
    </section>
</asp:Content>
