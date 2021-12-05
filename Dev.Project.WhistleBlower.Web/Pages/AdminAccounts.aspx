<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="AdminAccounts.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ManageCaseStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="/JQDatatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/JQDatatables/datatables.min.js"></script>
    <link href="/assets/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/PageScripts/AdminAccounts.js"></script>
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
                    <h2>Manage Admin Accounts</h2>
                    <span class="header-line"></span>

                </div>
                <div class="col-12 mt-2">
                    <a href="#" onclick="shownewForm(); return false;" data-toggle='tooltip' data-placement='top' style="height: 24px; width: 24px;" data-original-title='Click here to create new admin'>
                        <img src="/Images/addNewPerson.png" /></a>
                    <a href="#" onclick="window.location.href='/Pages/ManageAdmin.aspx';" data-toggle='tooltip' data-placement='top' style="height: 24px; width: 24px; padding-left: 10px;" data-original-title='Back to Manage Admin'>
                        <img src="/Images/backToHome.png" /></a>
                    <div class="row" style="margin-bottom: 2%;">
                        <input type="hidden" id="txtRegID" />
                    </div>
                    <div class="row" style="margin-bottom: 2%;">
                        <div class="col">
                            <input id="txtFirstName" class="form-control removeLater" placeholder="First Name" type="text" />
                        </div>
                        <div class="col">
                            <input id="txtLastName" class="form-control removeLater" placeholder="Last Name" type="text" />
                        </div>
                    </div>
                    <div class="row" style="margin-bottom: 2%;">
                        <div class="col">
                            <input id="txtFullName" class="form-control removeLater" placeholder="Full Name" type="text" />
                        </div>
                        <div class="col">
                            <input id="txtEmail" class="form-control removeLater" placeholder="Email Address" type="text" disabled />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <input id="txtPassword" class="form-control removeLater" placeholder="Password" type="password" />
                        </div>
                        <div class="col">
                            <input id="txtConfirmPassword" class="form-control removeLater" placeholder="Confirm Password" type="password" />
                        </div>
                    </div>
                    <div class="row mt-4 mb-2">
                        <div class="col-6">
                            <button type="submit" value="Update" id="btnSubmit" onclick="if (updateAdminAccValidation()) { updateAdminAccounts(); };return false;" class="btn btn-block btn-primary">Update Password</button>
                            <button type="submit" value="Update" id="btnAddNew" onclick="if (newJoinValidation()) { createNewAdminUsers(); };return false;" class="btn btn-block btn-primary d-none">Create new account</button>
                        </div>
                        <div class="col-6">
                            <button type="button" id="btnCancel" class="btn btn-block btn-primary" onclick="window.location.href='/Pages/AdminAccounts.aspx';">Cancel</button>
                        </div>
                    </div>


                </div>
                <div class="col-12 contentarea">
                    <div class="table-responsive">
                        <div class="tableCasePreAction" style="min-height: 400px;">
                            <table id="tableAdminAccounts" style="width: 100%" class="table table-hover border-bottom mb-4">
                                <thead class="thead-dark">
                                    <tr>

                                        <th class="angDirection">S.No</th>
                                        <th class="langDirection">First Name</th>
                                        <th class="langDirection">Last Name</th>
                                        <th class="langDirection">Full Name</th>
                                        <th class="langDirection">Email</th>
                                         <th class="langDirection">Is Primary</th>
                                        <th class="angDirection d-none">Reg UserID</th>
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
            $('[data-toggle="tooltip"]').tooltip();
        });

        $('.toggle').click(function (e) {
            e.preventDefault();
            let $this = $(this);
            if ($this.next().hasClass('show')) {
                $this.next().removeClass('show');
                $this.next().slideUp(350);
            } else {
                $this.parent().parent().find('li .inner').removeClass('show');
                $this.parent().parent().find('li .inner').slideUp(350);
                $this.next().toggleClass('show');
                $this.next().slideToggle(350);
            }
        });
    </script>
</asp:Content>
