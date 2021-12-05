<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlower.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        #more {
            display: none;
        }
    </style>
    <script>
        $(document).ready(function () {
            sessionStorage.clear();
        });
        window.onload = function () {
            document.getElementById("CompanyURN").focus();
        };
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>

    <script src="/Scripts/PageScripts/Home.js"></script>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">




    <section id="reportFraud" class="section-hero">
        <img src="/assets/images/bg--hero.jpg" alt="" class="bg-image hero">
        <div class="container">
            <div class="row justify-content-center align-items-center height-60 py-10 py-lg-0">
                <div class="col-lg-10 col-xl-9 text-center hero-text">
                    <h2 class="display-5">Report concerns without risk</h2>


                    <div class="form-inline justify-content-center mb-4">
                        <label class="sr-only" for="CompanyURN">CompanyURN</label>
                        <input id="CompanyURN" type="text" required placeholder="CompanyURN i.e. NG123456" class="form-control form-control-lg w-50" />
                        <button type="submit" onclick="if (Validation()) { validateCompanyKey();} return false;" class="btn btn-lg btn-primary">Click here</button>
                        <div class="clearfix"></div>


                    </div>
                    <p class="lead">We help your company understand your Employees Critical Concerns with Total Anonymity.  We connect the concerns of your employees with the right people within the organization that needs to hear those concerns.</p>
                    <!--end of form inline -->

                    <p class="text-muted"><i class="icon-lock mr-1"></i>Your identity is protected by 2048 bit inscription and SHA-2 security protocols.</p>
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->
        </div>
        <!--end of container-->
    </section>
    <!-- // Section: Hero -->
    <section id="highlights" class="py-5 bg-light">
        <div class="container">
            <div class="row justify-content-center mb-3">
                <div class="col-lg-10 col-xl-9 text-center">
                    <h2 class="display-5">Everything you need to know about whistleblowing</h2>
                    <p class="lead">If you experience an instance of incident or you have been scammed by a company you work with or a company you have worked for, you can expose them risk free with our website. Spread the word and make sure that others do not get taken advantage of. Rather than having a company pursue legal action against you for publishing the report, get the news out with an anonymous tip!</p>
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->
        </div>
        <!--end of container-->

    </section>

    <!-- // Aside: Service By -->
    <section class="section-signup py-2 bg-dark text-light">
        <div class="container">
            <div class="row">
                <div class="col text-center mb-5">
                    <h3 class="display-5 mb-4">Are you interested in becoming a company whistleblower or encouraging employees to come forward for information on your own business? <a href="https://info.iblowthewhistle.com/contact-us/" target="_blank">Contact us</a> today to establish a whistleblower service for your company.</h3>
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->

            <div class="row">
                <div class="col-md-6 col-lg-4">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input id="firstName" class="form-control" placeholder="Arya" type="text" required="required" />
                    </div>
                </div>
                <!--end of col-->
                <div class="col-md-6 col-lg-4">
                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input id="lastName" class="form-control" placeholder="Stark" type="text" required="required" />
                    </div>
                </div>
                <!--end of col-->
                <div class="col-md-6 col-lg-4">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input id="email" class="form-control" placeholder="arya.stark@winterfell.com" type="email" required="required" />
                    </div>

                </div>

                <div class="col-md-6 col-lg-12">
                    <div class="promotioncheck form-group">
                        <label>
                            <input type="checkbox" />
                            <span>Yes, I want to receive the latest marketing information from I Blow The Whistle. Read more about how we use your info <a target="_blank" href="http://blog.iblowthewhistle.com/Privacy">here</a></span></label>
                    </div>
                </div>
                <!--end of col-->
                <div class="col-md-6 col-lg-12">

                    <div class="sendbtn form-group">
                        <label for="button">&nbsp;</label>
                        <button id="button" type="submit" class="btn btn-block btn-primary" onclick="enquryFormValidation();return false;">Send</button>
                    </div>

                </div>
                <!--end of col-->
            </div>
            <!--end of row-->

            <!--end of form-->
        </div>
        <!--end of container-->
    </section>
    <!-- // Section: Signup -->

    <!-- Modal HTML -->
    <div id="myModal" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="material-icons">&#xE876;</i>
                    </div>
                    <h4 class="modal-title">Awesome!</h4>
                </div>
                <div class="modal-body">
                    <p class="text-center">Your booking has been confirmed. Check your email for detials.</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-success btn-block" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        $('.nav-toggle').click(function () {
            var collapse_content_selector = $(this).attr('href');
            var toggle_switch = $(this);
            $(collapse_content_selector).toggle(function () {
                if ($(this).css('display') == 'none') {
                    toggle_switch.html('Read More');
                } else {
                    toggle_switch.html('Read Less');
                }
            });
            return false;
        });

    </script>

</asp:Content>
