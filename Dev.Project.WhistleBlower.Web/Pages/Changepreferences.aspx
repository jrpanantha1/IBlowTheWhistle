<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Changepreferences.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Changepreferences" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Change Preferences | I Blow the Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/Changepreferences.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <section class="section-content py-3" style="margin-top: 100px;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-12 top-header">
                    <h2>Update your preferences</h2>
                    <span class="header-line"></span>
                </div>
            </div>
            <div class="inner intro mb-4 mt-5">
                <div style="height: 450px; width: 50%; float: left; border-right: 1px solid #999; text-align: center;">
                    <div class="nav-item dropdown language-switcher">
                        <%--<h6 class="mb-3 text-uppercase font-weight-normal">r</h6>--%>
                        <label>
                            Select Preferred Language                                                    
                        </label>
                        <a class="nav-link icon dropdown-toggle avatar-sm d-inline-flex dropdownLanguage" href="#" style="border: 2px solid #999; padding-left: 10px; border-radius: 50%" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">EN</a>
                        <div class="dropdown-menu dropdown-menu-right ddlLanguage" aria-labelledby="dropdownLanguage" style="width: 20%;">
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

                <div class="dropdown" style="height: 450px; width: 50%; float: left; text-align: center;">
                    <label>
                        Select Preferred Filter                                                    
                    </label>
                    <!-- Toggle -->
                    <a href="#" class="dropdown-toggle" id="dropdownFilter" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="icon-filter mr-2"></i>All
                    </a>
                    <!-- Menu -->

                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownFilter" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(82px, 21px, 0px);">
                        <a class="dropdown-item active incCategoryClick" selectedtext="All">
                            <i class="icon-corner-up-left mr-2"></i>All
                        </a>
                        <a class="dropdown-item incCategoryClick incidenttype1" selectedtext="Unread">
                            <i class="icon-message-circle mr-2"></i>Unread
                        </a>
                        <a class="dropdown-item incCategoryClick incidenttype2" selectedtext="Read">
                            <i class="icon-eye mr-2"></i>Read
                        </a>
                        <a class="dropdown-item incCategoryClick incidenttype3" selectedtext="Important">
                            <i class="icon-star mr-2"></i>Important
                        </a>
                        <a class="dropdown-item incCategoryClick incidenttype4" selectedtext="Done">
                            <i class="icon-check-square mr-2"></i>Done
                        </a>
                        <a class="dropdown-item incCategoryClick incidenttype5" selectedtext="Discarded">
                            <i class="icon-zap mr-2"></i>Discarded
                        </a>
                        <a class="dropdown-item incCategoryClick incidenttype6" selectedtext="Route to email">
                            <i class="icon-mail mr-2"></i>Route to email
                        </a>
                    </div>
                    <!--Select Drop Down Menu-->



                </div>

            </div>
            <div class="p-10" style="margin-bottom: 10px;">
                <input type="button" class="btn-sm btn-block btn-primary" value="Update Preferences" onclick="updatePreferredLanguage();" id="btnUpdateLanguage" />
                <button type="button" id="btnCancel" class="btn-sm btn-block btn-primary" onclick="window.location.href='/Pages/MyAccount.aspx';">Cancel</button>
            </div>

        </div>

    </section>
</asp:Content>
