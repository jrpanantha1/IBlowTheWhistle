<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Changepreferences.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Changepreferences" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Change Preferences | I Blow the Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/Changepreferences.js"></script>
    <style>
        .switch {
            position: relative;
            display: block;
            vertical-align: top;
            width: 100px;
            height: 30px;
            padding: 3px;
            margin: 0 10px 10px 0;
            background: linear-gradient(to bottom, #eeeeee, #FFFFFF 25px);
            background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF 25px);
            border-radius: 18px;
            box-shadow: inset 0 -1px white, inset 0 1px 1px rgba(0, 0, 0, 0.05);
            cursor: pointer;
        }

        .switch-input {
            position: absolute;
            top: 0;
            left: 0;
            opacity: 0;
        }

        .switch-label {
            position: relative;
            display: block;
            height: inherit;
            font-size: 10px;
            text-transform: uppercase;
            background: #eceeef;
            border-radius: inherit;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.12), inset 0 0 2px rgba(0, 0, 0, 0.15);
        }

            .switch-label:before, .switch-label:after {
                position: absolute;
                top: 50%;
                margin-top: -.5em;
                line-height: 1;
                -webkit-transition: inherit;
                -moz-transition: inherit;
                -o-transition: inherit;
                transition: inherit;
            }

            .switch-label:before {
                content: attr(data-off);
                right: 11px;
                color: #aaaaaa;
                text-shadow: 0 1px rgba(255, 255, 255, 0.5);
            }

            .switch-label:after {
                content: attr(data-on);
                left: 11px;
                color: #FFFFFF;
                text-shadow: 0 1px rgba(0, 0, 0, 0.2);
                opacity: 0;
            }

        .switch-input:checked ~ .switch-label {
            background: #00B48F;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.15), inset 0 0 3px rgba(0, 0, 0, 0.2);
        }

            .switch-input:checked ~ .switch-label:before {
                opacity: 0;
            }

            .switch-input:checked ~ .switch-label:after {
                opacity: 1;
            }

        .switch-handle {
            position: absolute;
            top: 4px;
            left: 4px;
            width: 28px;
            height: 28px;
            background: linear-gradient(to bottom, #FFFFFF 40%, #f0f0f0);
            background-image: -webkit-linear-gradient(top, #FFFFFF 40%, #f0f0f0);
            border-radius: 100%;
            box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);
        }

            .switch-handle:before {
                content: "";
                position: absolute;
                top: 50%;
                left: 50%;
                margin: -6px 0 0 -6px;
                width: 12px;
                height: 12px;
                background: linear-gradient(to bottom, #eeeeee, #FFFFFF);
                background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF);
                border-radius: 6px;
                box-shadow: inset 0 1px rgba(0, 0, 0, 0.02);
            }

        .switch-input:checked ~ .switch-handle {
            left: 74px;
            box-shadow: -1px 1px 5px rgba(0, 0, 0, 0.2);
        }
        /* Transition
        ========================== */
        .switch-label, .switch-handle {
            transition: All 0.3s ease;
            -webkit-transition: All 0.3s ease;
            -moz-transition: All 0.3s ease;
            -o-transition: All 0.3s ease;
        }
    </style>
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
            <ul class="accordion">
                <li class="accordion-list">
                    <a class="toggle langDirection" href="#" id="ancclsExpLangUpdate">Language & Default Filter</a>
                    <div class="inner intro mb-4">
                        <div class="d-flex justify-content-center align-items-center pb-3 inner-1">
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
                        <div>
                            <input type="button" class="btn-sm btn-block btn-primary" value="Update Preferences" onclick="updatePreferredLanguage();" id="btnUpdateLanguage" />
                            <button type="button" id="btnCancel" class="btn-sm btn-block btn-primary" onclick="window.location.href='/Pages/MyAccount.aspx';">Cancel</button>
                        </div>

                    </div>
                </li>
                <li class="accordion-list">
                    <a class="toggle langDirection" href="#" id="ancclsExpAutoNotification">Admin Notification</a>
                    <div class="inner intro mb-4">

                        <div class="d-flex justify-content-center align-items-center pb-3 inner-1">
                            <label class="mr-4">Send Admin Notification on New Concern Raised</label>
                            <label class="switch switch-flat">
                                <input class="switch-input" type="checkbox" />
                                <span class="switch-label" data-on="On" data-off="Off"></span>
                                <span class="switch-handle"></span>
                            </label>
                        </div>
                        <div class="d-flex justify-content-center align-items-center pb-3 inner-1">
                            <p>
                                <input type="button" class="btn-sm   btn-primary" value="Update" onclick="updateAdminNotification();return false;" id="btnUpdateNotification" /></p>

                        </div>
                    </div>
                </li>
            </ul>


            <div class="inner intro mb-4 mt-5">
            </div>


        </div>

    </section>
    <script type="text/javascript">
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
