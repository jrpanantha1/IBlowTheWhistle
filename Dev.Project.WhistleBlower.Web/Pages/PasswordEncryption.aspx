<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="PasswordEncryption.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.PasswordEncryption" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/PasswordEncryption.js"></script>
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
                                    <h1>Manage Passwords</h1>
                                    <span class="header-line"></span>
                                    <p class="text-xl-center">Get Encrypted Password.</p>
                                </div>
                                <div class=" d-flex align-items-center">
                                    <div class="w-75 mx-auto px-lg-6 my-lg-0 mt-md-0">

                                        <!--end of intro-->
                                        <div class="form-group">
                                            <label for="name">Select Account</label>
                                            <select class="custom-select comanyListDDL" id="ddlAccountList" name="CompanyLists">
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="name">Encrypted Password</label>
                                            <input type="text" id="txtEncPassowrd" style="width: 73%;" />
                                            <a onclick="copyCompanyLink();return false;" class="cbtooltiptextOriginal" style="cursor: pointer;" data-toggle='tooltip' data-placement='bottom' data-original-title='Copy Link here'><span class="cbtooltiptext" id="myTooltipPassCom" data-toggle='tooltip' data-placement='bottom'></span>
                                                <i class="icon-clipboard"></i></a>
                                        </div>

                                        <div class="form-group">
                                            <label for="name">Password</label>
                                            <input id="txtPWD" class="form-control removeLater" placeholder="Arya Stark" type="text" />
                                        </div>

                                        <div class="form-group">
                                            <input type="button" class="btn btn-sm btn-block btn-primary" value="Close" onclick="window.location.href = '/Pages/ViewIncidents.aspx'" id="btnback" />
                                        </div>
                                        <!--end of form-group-->

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
