<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="ManageCaseStatus.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ManageCaseStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Manage Case Status | I Blow the Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="/JQDatatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/JQDatatables/datatables.min.js"></script>
    <link href="/assets/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/PageScripts/ManageCaseStatus.js"></script>
    <style>
        .error {
            border: 1px solid red;
        }

        .btn-block + .btn-block {
            margin-top: 0
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <section class="section-content py-3" style="margin-top: 100px;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-12 top-header">
                    <h2>Manage status code </h2>
                    <span class="header-line"></span>

                </div>
                <div class="col-12 mt-6" style="margin-bottom: 2%;">
                    <a href="#" onclick="shownewStatusForm(); return false;" data-toggle='tooltip' data-placement='top' style="height: 24px; width: 24px;" data-original-title='Click here to add new status code'>
                        <img src="/Images/addIncidents.png" /></a>
                    <a href="#" onclick="window.location.href='/Pages/ManageAdmin.aspx';" data-toggle='tooltip' data-placement='top' style="height: 24px; width: 24px; padding-left: 10px;" data-original-title='Back to Administration'>
                        <img src="/Images/backToHome.png" /></a>

                    <div class="row mt-2" style="margin-bottom: 2%;">
                        <input type="text" id="txtTranID" class="form-control d-none" placeholder="TranID" />
                        <div class="col">
                            <input type="text" id="txtStatusCode" class="form-control" placeholder="Status Code" />
                        </div>
                        <div class="col">
                            <input type="text" id="txtStatusDesc" class="form-control" placeholder="Status Desc" />
                        </div>
                    </div>

                    <div class="row mt-4 mb-2">
                        <div class="col-6">
                            <button type="submit" value="Update" id="btnSubmit" onclick="if (updatePreActionValidation()) { updatePreAction(); };return false;" class="btn btn-block btn-primary">Update</button>
                            <button type="submit" value="Update" id="btnAddNew" onclick="if (updatePreActionValidation()) { addNewStatusCode(); };return false;" style="display: none;" class="btn btn-block btn-primary">Create new status</button>
                        </div>
                        <div class="col-6">
                            <button type="button" id="btnCancel" class="btn btn-block btn-primary" onclick="window.location.href='/Pages/ManageCaseStatus.aspx';">Cancel</button>
                        </div>


                    </div>


                </div>
                <div class="col-12 contentarea">
                    <div class="table-responsive">
                        <div class="tableCasePreAction" style="min-height: 400px;">
                            <table id="tableCasePreAction" style="width: 100%" class="table table-hover border-bottom mb-4">
                                <thead class="thead-dark">
                                    <tr>
                                        <th class="angDirection">S.No</th>
                                        <th class="d-none">CPURN</th>
                                        <th class="d-none">CURN</th>
                                        <th class="d-none">Language ID</th>
                                        <th class="langDirection">Status Code</th>
                                        <th class="langDirection">Status Desc</th>
                                        <th class="langDirection">Select</th>
                                        <th class="langDirection">Delete</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end of container-->
    </section>
    <script type="text/javascript">
        $(document).ready(function () {


        });
    </script>
</asp:Content>
