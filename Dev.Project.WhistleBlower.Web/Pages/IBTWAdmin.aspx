<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="IBTWAdmin.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ManageAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/IBTWAdmin.js"></script>
    <link href="/assets/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>

    <section class="section-split">
        <div class="container-fluid">
            <div class="row no-gutters justify-content-center height-100">
                <div class="col-md-12 align-items-center ">
                    <div class="container myaccount-contanier">
                        <div class="row m-0 justify-content-center align-items-center">
                            <div class="col-12">
                                <div class="col-xl-12 top-header">
                                    <h2 class="langDirection">Create Admin Users</h2>
                                    <span class="header-line"></span>
                                    <p class="text-xl-center">Add, Edit and Delete admin users.</p>
                                </div>
                                <div class=" d-flex align-items-center">
                                    <div class="w-75 mx-auto px-lg-6 my-lg-0 mt-md-0">
                                        <div class="intro">

                                            <h3 class="mb-3">Fill New Admin User details</h3>
                                            <hr />
                                        </div>
                                        <!--end of intro-->
                                        <div class="form-group">
                                            <label for="name">Select Company</label>
                                            <select class="custom-select comanyListDDL" id="ddlCompanyList" name="CompanyLists">
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="name">Company URL</label>
                                            <input type="text" id="txtCompanyURLLink" style="width: 73%;" />
                                            <a onclick="copyCompanyLink();return false;" class="cbtooltiptextOriginal" style="cursor: pointer;" data-toggle='tooltip' data-placement='bottom' data-original-title='Copy Link here'><span class="cbtooltiptext" id="myTooltipPassCom" data-toggle='tooltip' data-placement='bottom'></span>
                                                <i class="icon-clipboard"></i></a>
                                        </div>

                                        <div class="form-group">
                                            <label for="name">First Name</label>
                                            <input id="txtFirstName" class="form-control removeLater" placeholder="Arya Stark" type="text" />
                                        </div>
                                        <div class="form-group">
                                            <label for="name">Last Name</label>
                                            <input id="txtLastName" class="form-control removeLater" placeholder="Arya Stark" type="text" />
                                        </div>
                                        <div class="form-group">
                                            <label for="name">Full Name</label>
                                            <input id="txtFullName" class="form-control removeLater" placeholder="Arya Stark" type="text" />
                                        </div>
                                        <div class="form-group">
                                            <label for="name">Is Primary Account</label>
                                            <input type="checkbox" id="chkIsPrimary" />
                                        </div>
                                        <!--end of form-group-->
                                        <div class="form-group">
                                            <label for="email">Email Address</label>
                                            <input id="txtEmail" class="form-control removeLater" placeholder="arya.stark@winterfell.com" type="email" />
                                        </div>
                                        <div class="form-group" id="divPassword" style="display: none">
                                            <label for="email">Password</label>
                                            <input id="txtPassword" class="form-control removeLater" />
                                            <a onclick="copyPassword();return false;" class="cbtooltiptextOriginal" style="cursor: pointer;" data-toggle='tooltip' data-placement='bottom' data-original-title='Copy Password'><span class="cbtooltiptext" id="myTooltipPass" data-toggle='tooltip' data-placement='bottom'></span>
                                                <i class="icon-clipboard"></i></a>
                                        </div>
                                        <div class="form-group d-none">
                                            <label for="email">Confirm Password</label>
                                            <input id="txtConPassword" class="form-control removeLater" placeholder="******" type="password" />
                                        </div>
                                        <!--end of form-group-->
                                        <div class="form-group d-none">
                                            <label for="Country">Country</label>
                                            <input id="txtCountry" class="form-control removeLater" placeholder="Enter Country" type="text" />
                                        </div>
                                        <!--end of form-group-->
                                        <div class="form-group d-none">
                                            <label for="Country">Time Zone</label>
                                            <input id="txtTime" class="form-control removeLater" placeholder="Enter Time Zone" type="text" />
                                        </div>
                                        <!--end of form-group-->

                                        <div class="form-group">
                                            <input type="button" class="btn btn-sm btn-block btn-primary" value="Create" onclick="if (newJoinCompanyAdminValidation()) { createCompanyAdminUsers(); }" id="btnAddNew" />
                                            <input type="button" class="btn btn-sm btn-block btn-primary" value="Close" onclick="window.location.href = '/Pages/ViewIncidents.aspx'" id="btnback" />
                                        </div>
                                        <!--end of form-group-->
                                        <p class="small text-center" style="margin-bottom: 20px;">By adding this new user you are allowing new user to do manager the site with full permission.</p>

                                    </div>
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
</asp:Content>
