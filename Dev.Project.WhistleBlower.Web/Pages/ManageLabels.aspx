<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="ManageLabels.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ManageLabels" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Manage Labels | I Blow the Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/ManageLabels.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
    <style>
        .table-scroll {
            position: relative;
            width: 100%;
            z-index: 1;
            margin: auto;
            overflow: auto;
            height: 600px;
        }

            .table-scroll table {
                width: 100%;
                min-width: 1280px;
                margin: auto;
                border-collapse: separate;
                border-spacing: 0;
            }

        .table-wrap {
            position: relative;
        }

        .table-scroll th,
        .table-scroll td {
            /*padding: 5px 10px;*/
            border: 1px solid #000;
            background: #fff;
            vertical-align: top;
        }

        .table-scroll thead th {
            background: #333;
            color: #fff;
            position: -webkit-sticky;
            position: sticky;
            top: 0;
        }
        /* safari and ios need the tfoot itself to be position:sticky also */
        .table-scroll tfoot,
        .table-scroll tfoot th,
        .table-scroll tfoot td {
            position: -webkit-sticky;
            position: sticky;
            bottom: 0;
            background: #666;
            color: #fff;
            z-index: 4;
        }

        a:focus {
            background: red;
        }
        /* testing links*/

        th:first-child {
            position: -webkit-sticky;
            position: sticky;
            left: 0;
            z-index: 2;
            background: #ccc;
        }

        thead th:first-child,
        tfoot th:first-child {
            z-index: 5;
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
                                    <h2 class="langDirection">Manage Labels</h2>
                                    <span class="header-line"></span>
                                    <p class="text-xl-center">Add & Update language details.</p>
                                </div>

                                <div class="mb-2">
                                    <button type="submit" value="Save" id="btnSubmit" onclick="if (updateLangDetailsValidation()) { addNewLabelText(); };return false;" class="btn btn-primary mt-1 mb-2">Save</button>
                                    <button type="submit" value="Save" id="btnRestore" onclick="callResetDefault();return false;" class="btn btn-primary mt-1 mb-2">Restore to default</button>
                                    <a href="#" onclick="window.location.href='/Pages/ManageAdmin.aspx';" data-toggle='tooltip' data-placement='top' style="height: 24px; width: 24px; padding-left: 10px;" data-original-title='Back to Administration'>
                                        <img src="/Images/backToHome.png" /></a>
                                </div>
                                <div class=" d-flex align-items-center">

                                    <div class=" mx-auto  my-lg-0 mt-md-0">
                                        <div class="table-scroll" id="divLangTable">
                                            <table id="main-table" class="main-table">
                                                <thead>
                                                    <tr>
                                                        <th style="display: none;" scope="col">ColID</th>
                                                        <th style="width: 5%; text-align: center; vertical-align: middle;" scope="col">S.No</th>
                                                        <th style="vertical-align: middle;" scope="col">Default Text</th>
                                                        <th style="width: 50%;" scope="col">Current label Text</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td style="display: none;">AckPolicy</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">1</td>
                                                        <td style="vertical-align: middle;" id="tdtxtAckPolicy"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtAckPolicy" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">AdditionalComments</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">2</td>
                                                        <td style="vertical-align: middle;" id="tdtxtAdditionalComments"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtAdditionalComments" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">AnonymousUpdate</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">3</td>
                                                        <td style="vertical-align: middle;" id="tdtxtAnonymousUpdate"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtAnonymousUpdate" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">AreYouWhistleBlower</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">4</td>
                                                        <td style="vertical-align: middle;" id="tdtxtAreYouWhistleBlower"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtAreYouWhistleBlower" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">AServiceForm</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">5</td>
                                                        <td style="vertical-align: middle;" id="tdtxtAServiceForm"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtAServiceForm" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">AuthrizeDeclaration</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">6</td>
                                                        <td style="vertical-align: middle;" id="tdtxtAuthrizeDeclaration"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtAuthrizeDeclaration" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">BrowseText</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">7</td>
                                                        <td style="vertical-align: middle;" id="tdtxtBrowseText"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtBrowseText" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">ByEmailUpdate</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">8</td>
                                                        <td style="vertical-align: middle;" id="tdtxtByEmailUpdate"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtByEmailUpdate" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">ByPhoneUpdate</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">9</td>
                                                        <td style="vertical-align: middle;" id="tdtxtByPhoneUpdate"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtByPhoneUpdate" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">CloseBtn</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">10</td>
                                                        <td style="vertical-align: middle;" id="tdtxtCloseBtn"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtCloseBtn" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">Comments</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">11</td>
                                                        <td style="vertical-align: middle;" id="tdtxtComments"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtComments" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">ConcernDetailsPHT</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">12</td>
                                                        <td style="vertical-align: middle;" id="tdtxtConcernDetailsPHT"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtConcernDetailsPHT" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">DoyouhaveanyDocument</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">13</td>
                                                        <td style="vertical-align: middle;" id="tdtxtDoyouhaveanyDocument"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtDoyouhaveanyDocument" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">EmailAddresslbl</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">14</td>
                                                        <td style="vertical-align: middle;" id="tdtxtEmailAddresslbl"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtEmailAddresslbl" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">EvidenceDetails</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">15</td>
                                                        <td style="vertical-align: middle;" id="tdtxtEvidenceDetails"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtEvidenceDetails" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">EvidenceDetailsPHT</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">16</td>
                                                        <td style="vertical-align: middle;" id="tdtxtEvidenceDetailsPHT"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtEvidenceDetailsPHT" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">HaveWitness</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">17</td>
                                                        <td style="vertical-align: middle;" id="tdtxtHaveWitness"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtHaveWitness" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">HowWouldUpdated</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">18</td>
                                                        <td style="vertical-align: middle;" id="tdtxtHowWouldUpdated"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtHowWouldUpdated" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">IdentityNeverRevel</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">19</td>
                                                        <td style="vertical-align: middle;" id="tdtxtIdentityNeverRevel"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtIdentityNeverRevel" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">IsReportable</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">20</td>
                                                        <td style="vertical-align: middle;" id="tdtxtIsReportable"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtIsReportable" style="width: 100%;"></textarea></td>
                                                    </tr>

                                                    <tr>
                                                        <td style="display: none;">No</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">22</td>
                                                        <td style="vertical-align: middle;" id="tdtxtNo"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtNo" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">NoFileSelected</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">23</td>
                                                        <td style="vertical-align: middle;" id="tdtxtNoFileSelected"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtNoFileSelected" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">Phonelbl</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">24</td>
                                                        <td style="vertical-align: middle;" id="tdtxtPhonelbl"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtPhonelbl" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">PleaseSelect</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">25</td>
                                                        <td style="vertical-align: middle;" id="tdtxtPleaseSelect"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtPleaseSelect" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">PrivacyPolicy</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">26</td>
                                                        <td style="vertical-align: middle;" id="tdtxtPrivacyPolicy"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtPrivacyPolicy" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">ReportIncident</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">27</td>
                                                        <td style="vertical-align: middle;" id="tdtxtReportIncident"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtReportIncident" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">Signin</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">28</td>
                                                        <td style="vertical-align: middle;" id="tdtxtSignin"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtSignin" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">SupportingEvidence</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">29</td>
                                                        <td style="vertical-align: middle;" id="tdtxtSupportingEvidence"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtSupportingEvidence" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">TermsofService</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">30</td>
                                                        <td style="vertical-align: middle;" id="tdtxtTermsofService"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtTermsofService" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">UpdatedOnIncident</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">31</td>
                                                        <td style="vertical-align: middle;" id="tdtxtUpdatedOnIncident"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtUpdatedOnIncident" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">ViewDocumentsLnk</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">32</td>
                                                        <td style="vertical-align: middle;" id="tdtxtViewDocumentsLnk"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtViewDocumentsLnk" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">WitnessEmail</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">33</td>
                                                        <td style="vertical-align: middle;" id="tdtxtWitnessEmail"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtWitnessEmail" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">WitnessName</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">34</td>
                                                        <td style="vertical-align: middle;" id="tdtxtWitnessName"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtWitnessName" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">WitnessPhone</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">35</td>
                                                        <td style="vertical-align: middle;" id="tdtxtWitnessPhone"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtWitnessPhone" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="display: none;">Yes</td>
                                                        <td style="width: 5%; text-align: center; vertical-align: middle;">36</td>
                                                        <td style="vertical-align: middle;" id="tdtxtYes"></td>
                                                        <td style="width: 50%;">
                                                            <textarea id="txtYes" style="width: 100%;"></textarea></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <button type="submit" value="Save" id="btnSubmit1" onclick="if (updateLangDetailsValidation()) { addNewLabelText(); };return false;" class="btn btn-primary mt-3 mb-3">Save</button>
                                </div>
                                <!--end of col-->
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
    <script src="/assets/js/autosize.min.js" async defer></script>

</asp:Content>
