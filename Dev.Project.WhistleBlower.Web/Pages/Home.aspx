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
            <div class="row justify-content-center mb-5">
                <div class="col-lg-10 col-xl-9 text-center">
                    <h2 class="display-5">Everything you need to know about whistleblowing</h2>
                    <p class="lead">If you experience an instance of incident or you have been scammed by a company you work with or a company you have worked for, you can expose them risk free with our website. Spread the word and make sure that others do not get taken advantage of. Rather than having a company pursue legal action against you for publishing the report, get the news out with an anonymous tip!</p>
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->
        </div>
        <!--end of container-->
        <div class="container-fluid px-lg-10 mt-7">
            <div class="row row-cols-md-2 row-cols-lg-4">
                <div class="col">
                    <div class="card h-100 p-4 shadow-sm">
                        <div class="card-body bg-white dummy">
                            <i class="icon-info icon-3x text-primary d-block mb-4"></i>
                            <h5>What is a whistleblower?</h5>
                            <p>A whistleblower is someone that comes forward with a report to protect the safety and security of others. With our site, you can submit information safely and make sure that others can avoid falling into the same situation.</p>
                            <div id="collapse" style="display: none">
                                <p>Whistleblowers are often individuals that come forward and report instances of incident or misdeeds within their own company.</p>
                            </div>
                            <a href="#collapse" class="nav-toggle">Read More</a>


                        </div>
                        <!--end of card-body-->
                    </div>
                    <!--end of card-->
                </div>
                <!--end of col-->
                <div class="col">
                    <div class="card h-100 p-4 shadow-sm">
                        <div class="card-body bg-white">
                            <i class="icon-bell icon-3x text-primary d-block mb-4"></i>
                            <h5>Reasons to consider whistleblowing?</h5>
                            <p>
                                You can act as a whistleblower if a company or your own organization has scammed you out of money, participated in something illegal, used your identity improperly, shared information without your consent or worked to represent a product or service improperly.
                            </p>

                            <div id="collapse1" style="display: none">
                                <p>
                                    There are many reasons a person may consider whistleblowing from financial scams, to false advertising or a company not disclosing how they use submitted information. Many people perform this operation to report corruption within the organization they work for as well.
                                </p>
                            </div>
                            <a href="#collapse1" class="nav-toggle">Read More</a>
                        </div>
                        <!--end of card-body-->
                    </div>
                    <!--end of card-->
                </div>
                <!--end of col-->
                <div class="col">
                    <div class="card h-100 p-4 shadow-sm">
                        <div class="card-body bg-white">
                            <i class="icon-check-square icon-3x text-primary d-block mb-4"></i>
                            <h5>How to start whistleblowing?</h5>
                            <p>If you have felt wronged by a company or even within your own company, you can start by writing a report with our website. Disclose any information you have on the subject, and any evidence you have of the wrongdoing.</p>
                            <div id="collapse2" style="display: none">

                                <p>We will verify the information and help you get in contact with an authorized recipient anonymously.</p>
                            </div>
                            <a href="#collapse2" class="nav-toggle">Read More</a>
                        </div>
                        <!--end of card-body-->
                    </div>
                    <!--end of card-->
                </div>
                <!--end of col-->
                <div class="col">
                    <div class="card h-100 p-4 shadow-sm">
                        <div class="card-body bg-white">
                            <i class="icon-shield icon-3x text-primary d-block mb-4"></i>
                            <h5>How are you protected as a whistleblower?</h5>
                            <p>As our site is free and protected by strong 2048-bit encryption and SHA-2 security which keeps whistleblowers completely anonymous. You can submit your report knowing that your responses are completely encrypted. You also receive workflow alerts to see when your report has been viewed and if a response has been published.</p>
                            <div id="collapse3" style="display: none">
                                <p>Your identity will never be revealed and a report about the scam or incident you experienced will be published online to prevent others from falling victim to the same experience. You will remain completely protected throughout the entire situation. You will not face legal action as a result of your post, because it is heavily encrypted and nearly untraceable.</p>
                            </div>
                            <a href="#collapse3" class="nav-toggle">Read More</a>
                        </div>
                        <!--end of card-body-->
                    </div>
                    <!--end of card-->
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->
        </div>
        <!--end of container-->
    </section>
    <!-- // Section: Highlights -->
    <aside class="border-top py-3">
        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-auto" style="text-align: center;">
                    <small>Not ready yet? Let's learn more</small><br />
                    <strong>Whistleblowing Free Guide</strong><br />
                    <p>Use our guide to better understand Whistleblowing and how it can affect your business. Note that these resources form only a small portion of what is available on the web, and we encourage you to do additional research.</p>
                    <a href="../Images/IBTWGuidebook.pdf" download>
                        <img style="width: 50%; height: 250px;" src="../Images/IBTWBook.png" alt="IBTW Pricing" /></a>
                    <%--<a href="#" class="h6 small text-uppercase">A service from
                        <img src="/assets/images/logo-eformulus.png" alt="EFormulus" class="logo logo-xs ml-2"></a>--%>
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->
        </div>
        <!--end of container-->
    </aside>
    <!-- // Aside: Service By -->
    <section class="section-signup py-8 bg-dark text-light">
        <div class="container">
            <div class="row">
                <div class="col text-center mb-5">
                    <h3 class="h1 mb-4">Are you interested in becoming a company whistleblower or encouraging employees to come forward for information on your own business? Contact us today to establish a whistleblower service for your company.</h3>
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->

            <div class="row">
                <div class="col-md-6 col-lg-3">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input id="firstName" class="form-control" placeholder="Arya" type="text" required="required" />
                    </div>
                </div>
                <!--end of col-->
                <div class="col-md-6 col-lg-3">
                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input id="lastName" class="form-control" placeholder="Stark" type="text" required="required" />
                    </div>
                </div>
                <!--end of col-->
                <div class="col-md-6 col-lg-3">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input id="email" class="form-control" placeholder="arya.stark@winterfell.com" type="email" required="required" />
                    </div>
                </div>
                <!--end of col-->
                <div class="col-md-6 col-lg-3">
                    <div class="form-group">
                        <label for="button">&nbsp;</label>
                        <button id="button" type="submit" class="btn btn-block btn-primary" onclick="if (enquryFormValidation()) { SendEmailNotification(); };return false;">Send</button>
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
