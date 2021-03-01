<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <script src="/Scripts/PageScripts/ResetPassword.js"></script>
    <section class="section-split">
        <div class="container-fluid">
            <div class="row no-gutters justify-content-center height-100">
                <div class="col-md-12 align-items-center ">
                    <div class="container">
                        <div class="row m-0 justify-content-center align-items-center height-100">
                            <div class="col-10 col-md-8">
                                <a class="navbar-brand mb-5" href="/">
                                    <img alt="Tacitous" src="/assets/images/logo-light.png" class="logo logo-lg"></a>

                                <div class="form-group">
                                    <label for="email">Enter your password</label>

                                    <input type="password" placeholder="Enter your password" class="txtboxClass" id="txtPassword" />
                                </div>
                                <div class="form-group">
                                    <label for="email">Re-Enter your password</label>

                                    <input type="password" placeholder="Re-Enter your password" class="txtboxClass" id="txtRePassword" />
                                </div>
                                <!--end of form-group-->
                                <div class="form-group">
                                    <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Reset" onclick="if (reSetValidation()) { reSetConfirmation(); }" id="btnRegister" />
                                    <input type="button" class="btn right  btn-sm btn-block btn-primary" value="Back" id="btnBack" onclick="window.location.href = '/Pages/ViewIncidents.aspx'; return false;" />
                                </div>
                                <!--end of form-group-->

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
