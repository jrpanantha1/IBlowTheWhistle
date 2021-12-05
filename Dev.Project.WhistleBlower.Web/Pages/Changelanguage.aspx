<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Changelanguage.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Changelanguage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/Changelanguage.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <section class="section-content py-3" style="margin-top: 100px;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-12 top-header">
                    <h2>Update your preferred language</h2>
                    <span class="header-line"></span>
                </div>
            </div>
            <div class="inner intro mb-4 mt-5">
                <div class="d-flex" style="height: 400px;">
                    <div class="nav-item dropdown language-switcher">
                        <%--<h6 class="mb-3 text-uppercase font-weight-normal">r</h6>--%>
                        <label>
                            Select Preferred Language                                                    
                        </label>
                        <a class="nav-link icon dropdown-toggle avatar-sm d-inline-flex dropdownLanguage" href="#" style="border: 2px solid #999; padding-left: 10px; border-radius: 50%" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">EN</a>
                        <div class="dropdown-menu dropdown-menu-right ddlLanguage" aria-labelledby="dropdownLanguage">
                            <a href="#" class="dropdown-item" id="engItem">
                                <%-- <i class="flag-icon flag-icon-squared flag-icon-us"></i>--%>
                                <span>English</span>
                            </a>
                            <a href="#" class="dropdown-item" id="thaiItem">
                                <%--<i class="flag-icon flag-icon-squared flag-icon-th"></i>--%>
                                <span>Thai</span>
                            </a>
                            <a href="#" class="dropdown-item" id="frenchItem">
                                <%--<i class="flag-icon flag-icon-squared flag-icon-fr"></i>--%>
                                <span>French</span>
                            </a>
                            <a href="#" class="dropdown-item" id="spanishItem">
                                <%--<i class="flag-icon flag-icon-squared flag-icon-es"></i>--%>
                                <span>Spanish</span>
                            </a>
                            <a href="#" class="dropdown-item" id="russianItem">
                                <%--<i class="flag-icon flag-icon-squared flag-icon-ru"></i>--%>
                                <span>Russian</span>
                            </a>
                            <a href="#" class="dropdown-item" id="kazItem">
                                <%--<i class="flag-icon flag-icon-squared flag-icon-kz"></i>--%>
                                <span>Kazakh</span>
                            </a>
                            <a href="#" class="dropdown-item" id="arabicItem">
                                <%--<i class="flag-icon flag-icon-squared flag-icon-ar"></i>--%>
                                <span>Arabic</span>
                            </a>
                        </div>

                    </div>
                    <!--end of avatar change-->
                    <!--end of flex-->
                </div>
                <div class="row mt-4 mb-2">
                    <div class="col-6">
                        <input type="button" class="btn-sm btn-block btn-primary" value="Update Language" onclick="updatePreferredLanguage();" id="btnUpdateLanguage" />
                    </div>
                    <div class="col-6">
                        <button type="button" id="btnCancel" class="btn-sm btn-block btn-primary" onclick="window.location.href='/Pages/MyAccount.aspx';">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
