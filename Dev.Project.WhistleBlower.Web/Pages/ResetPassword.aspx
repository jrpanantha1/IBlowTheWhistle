<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <script src="/Scripts/Toaster/popper.min.js"></script>
    <script src="/Scripts/Toaster/4.5.2/bootstrap.min.js"></script>
    <script src="/Scripts/PageScripts/ResetPassword.js"></script>

    <section class="section-split">
        <div class="bs-example">
            <div class="toast" id="myToast" style="position: absolute; top: 0; right: 0;">
                <div class="toast-header">
                    <strong class="mr-auto"><i class="fa fa-grav"></i>Passowrd updated successfully!</strong>
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="toast-body">
                    <div>It's been a long time since you visited us. We've something special for you. <a href="#">Click here!</a></div>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row no-gutters justify-content-center height-100">
                <div class="col-md-12 align-items-center ">
                    <div class="container">
                        <div class="row m-0 justify-content-center align-items-center height-100">
                            <div class="col-8 col-md-6 resetpw-container">
                                <a class="navbar-brand mb-5" href="/">
                                    <img alt="Tacitous" src="/assets/images/whistle-icon.png" class="logo logo-lg" /></a>

                                <h2>Reset Password</h2>
                                <p class="resetpw-text">
                                    Password must contain one lowercase letter, one number,<br />
                                    and be atleast 6 characters long
                                </p>

                                <div class="form-group">
                                    <label for="email">Enter new password</label>
                                    <input type="password" class="txtboxClass" id="txtPassword" />
                                </div>
                                <div class="form-group">
                                    <label for="email">Re-Enter new password</label>
                                    <input type="password" class="txtboxClass" id="txtRePassword" />
                                </div>
                                <!--end of form-group-->
                                <div class="form-group">
                                    <input type="button" class="btn right  btn-sm btn-block btn-primary btn-reset" value="Reset" onclick="if (reSetValidation()) { reSetConfirmation(); }" id="btnRegister" />
                                    <input type="button" class="btn right  btn-sm btn-block btn-primary btn-back" value="Back" id="btnBack" onclick="window.location.href = '/Pages/MyAccount.aspx'; return false;" />
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
