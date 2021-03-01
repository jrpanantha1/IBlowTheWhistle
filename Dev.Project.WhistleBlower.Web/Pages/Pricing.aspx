<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlower.Master" AutoEventWireup="true" CodeBehind="Pricing.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Pricing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <section class="section-hero bg-dark">
        <img src="/assets/images/laptop-woman.jpg" alt="" class="bg-image hero opacity-10">
        <div class="container">
            <div class="row justify-content-center align-items-center pt-5 pb-0">
                <div class="col-lg-10 col-xl-8">
                    <div class="text-white text-center mb-4">
                        <h1 class="display-3">Pricing </h1>
                        <p class="lead">Transparency is a recurring value that is reflected in our promise, our security protocol and our legal agreements.</p>
                    </div>
                    <!-- end of text-center -->
                    <ul class="nav nav-tabs nav-tabs-line justify-content-center" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" href="#terms" data-toggle="tab" role="tab" aria-selected="true">Price Structure</a>
                        </li>

                    </ul>
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->
        </div>
        <!--end of container-->
    </section>
    <!-- // Section: Legal -->
    <section class="section-blog py-10">
        <div class="container">
            <div class="row justify-content-center mb-5">
                <div class="col-lg-12 col-xl-10">
                    <div class="tab-content">
                        <div id="terms" class="tab-pane fade show active" role="tabpanel">
                            <img style="width: 100%" src="../Images/PricingStructure.jpg" alt="IBTW Pricing" />
                        </div>

                        <!--end of terms-->

                    </div>
                    <!--end of tab-content-->
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->
        </div>
        <!--end of container-->
    </section>
    <!-- // Section: Highlights -->
</asp:Content>
