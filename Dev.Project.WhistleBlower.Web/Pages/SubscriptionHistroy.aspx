<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="SubscriptionHistroy.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.SubscriptionHistroy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
     Subscription Histroy | I Blow the Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="/JQDatatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/JQDatatables/datatables.min.js"></script>
    <link href="/assets/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/PageScripts/SubscriptionHistory.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <section class="section-content py-3 mt-3" style="margin-top: 100px;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-12 top-header">
                    <h2>Subscription History</h2>
                    <span class="header-line"></span>
                </div>
                <div class="col-12 contentarea mt-5">
                    <a href="#" onclick="window.location.href='/Pages/ManageAdmin.aspx';" data-toggle='tooltip' data-placement='top' style="height: 24px; width: 24px; padding-left: 10px;" data-original-title='Back to Manage Admin'>
                        <img src="/Images/backToHome.png" /></a>
                    <div class="table-responsive">
                        <div class="tableSubscrionHistory" style="min-height: 400px;">
                            <table id="tableSubscrionHistory" style="width: 100%" class="table table-hover border-bottom mb-4">
                                <thead class="thead-dark">
                                    <tr>
                                        <th class="langDirection">S.No</th>
                                        <th class="langDirection">Invoice No</th>
                                        <th class="langDirection">Plan Type</th>
                                        <th class="langDirection">Valid To</th>
                                        <th class="langDirection">Currency</th>
                                        <th class="langDirection">Amount</th>
                                        <th class="langDirection">PaidVia</th>
                                        <th class="langDirection">SubStatus</th>
                                        <th class="langDirection">Subscribed On</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end of container-->
    </section>
    <script type="text/javascript">
        $(document).ready(function () {
        });
    </script>
</asp:Content>
