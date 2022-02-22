<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="ManageAdmin.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ManageAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Manage Admin | I Blow the Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/ManageAdmin.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <style>
        .adminNameContent:before {
            content: " ";
            display: block;
            width: 0;
            height: 0;
            border-top: 9px solid transparent;
            border-bottom: 8px solid transparent;
            border-right: 8px solid hsl(200, 33%, 58%);
            position: absolute;
            top: 50%;
            margin-top: -9px;
            right: 100%;
            z-index: 2;
        }


        .adminNameContent {
            background-color: hsl(200, 33%, 58%);
            color: white;
            text-decoration: none;
            text-transform: uppercase;
            padding: 1px 4px 1px 2px;
            background: hsl(200, 33%, 58%);
            position: relative;
            display: block;
            float: left;
            position: relative;
            font-size: 13px;
            height: 15px;
            margin: 10px;
        }
    </style>
    <section class="section-split">
        <div class="container-fluid">
            <div class="row no-gutters justify-content-center height-100">
                <div class="col-md-12 align-items-center ">
                    <div class="container myaccount-contanier">
                        <div class="row m-0 justify-content-center align-items-center">
                            <div class="col-12">
                                <div class="col-xl-12 top-header">
                                    <h2 class="langDirection" id="formTitle"></h2>
                                    <span class="header-line langDirection"></span>
                                    <p class="text-xl-center langDirection" id="formShortNote"></p>
                                    <h6 id="lblshowLimit" style="color: red; text-align: center"></h6>
                                </div>

                                <ul class="accordion" id="ulclsExpMngAdminAccount">
                                    <li class="accordion-list">
                                        <a class="toggle" href="#" id="ancclsExpMngAdminAccount"></a>

                                        <div class="inner intro mb-2 justify-content-center align-items-center">
                                            <a href="/Pages/AdminAccounts.aspx">
                                                <img alt="Qries" src="/Images/Click Here.png" />
                                            </a>
                                        </div>
                                    </li>
                                </ul>
                                <ul class="accordion">
                                    <li class="accordion-list">
                                        <a class="toggle" href="#" id="ancclsExpMngStatusCode"></a>
                                        <div class="inner intro mb-4">
                                            <div class="topbanner  pb-3 inner-2">
                                                <div class="avatar-change ">
                                                    <a href="/Pages/ManageCaseStatus.aspx">
                                                        <img alt="Qries" src="/Images/Click Here.png" /></a>
                                                </div>
                                            </div>

                                        </div>
                                    </li>
                                </ul>

                                <ul class="accordion">
                                    <li class="accordion-list">
                                        <a class="toggle" href="#" id="ancclsExpVwSubsHistroy"></a>
                                        <div class="inner intro mb-4">
                                            <div class="topbanner  pb-3 inner-2">
                                                <div class="avatar-change ">
                                                    <a href="/Pages/SubscriptionHistroy.aspx">
                                                        <img alt="Qries" src="/Images/Click Here.png" /></a>
                                                </div>
                                            </div>

                                        </div>
                                    </li>
                                </ul>

                                <ul class="accordion">
                                    <li class="accordion-list">
                                        <a class="toggle" href="#" id="ancclsExpVwPolicyDocuments"></a>
                                        <div class="inner intro mb-4">
                                            <div class="topbanner  pb-3 inner-2">
                                                <div class="avatar-change ">
                                                    <a href="/Pages/PolicyDocuments.aspx">
                                                        <img alt="Qries" src="/Images/Click Here.png" /></a>
                                                </div>
                                            </div>

                                        </div>
                                    </li>
                                </ul>

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
