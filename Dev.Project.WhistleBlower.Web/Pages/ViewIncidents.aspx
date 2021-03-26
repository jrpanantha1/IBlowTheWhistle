<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="ViewIncidents.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ViewIncidents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="/JQDatatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/JQDatatables/datatables.min.js"></script>
    <link href="/assets/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/PageScripts/ViewIncidents.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <style>
        .CSSBadge {
            box-sizing: border-box;
            color: white;
            font-family: sans-serif;
            font-size: 30px;
            letter-spacing: -1px;
            position: absolute;
            bottom: 100%;
            right: 0;
            min-width: 1em;
            padding-left: 0.2em;
            padding-right: 0.2em;
            height: 1em;
            margin-bottom: -0.6em;
            margin-right: -0.6em;
            background-color: #f00;
            border-radius: 1em;
            text-align: center;
            line-height: 1em;
        }

        .quote {
            background-color: #00B48F;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            color: #fff;
            margin: 0;
            padding: 20px;
            font-size: 20px;
        }

        .name {
            background-color: #333;
            border-bottom-left-radius: 8px;
            border-bottom-right-radius: 8px;
            color: #fff;
            font-size: 20px;
            padding: 20px;
            text-align: center;
        }

        /* Reset */
        blockquote {
            padding: 0;
            margin: 0;
        }

            blockquote::after {
                border-color: transparent #00B48F transparent transparent;
                border-image: none;
                border-style: solid;
                border-width: 20px;
                top: 40px;
                content: " ";
                display: block;
                right: 75%;
                position: relative;
            }

        .divTopSection1 {
            width: 15%;
            float: left;
            text-align: left;
            padding: 10px;
        }

        .divTopSection2 {
            width: 35%;
            float: left;
            text-align: left;
            padding: 10px;
            color: black;
            font-weight: bold;
        }

        .gridDescription {
            text-align: left;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .wd100 {
            width: 150px;
        }

        table.dataTable thead th {
            border-right: 1px solid white !important;
        }
    </style>
    <script type="text/javascript">

        $(document).on('mouseenter', ".gridDescription", function () {
            var $this = $(this);
            if (this.offsetWidth < this.scrollWidth && !$this.attr('title')) {
                $this.tooltip({
                    title: $this.text(),
                    placement: "bottom"
                });
                $this.tooltip('show');
            }
        });
    </script>
    <section class="section-content py-3" style="margin-top: 100px;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 topBanner" style="display: none">
                    <a class="ancImgTopBanner" target="_blank" href="#">
                        <img src="/assets/images/Whistle_728x90_Internalbanner.PNG" class="imgTopBanner" alt="horizontal banner" /></a>
                </div>
                <div class="col-12">
                    <div class="quote-box" style="margin-bottom: 10px;">
                        <div class="quote">
                            <blockquote>
                                <div class="divTopSection1">Company Name</div>
                                <div class="divTopSection2"><span id="spanCompany"></span></div>
                                <div class="divTopSection1 companyCode" style="display: none">Company Code</div>
                                <div class="divTopSection2 companyCode" style="display: none"><span id="spanCode"></span></div>

                            </blockquote>
                        </div>
                        <div class="name companyURLSection" style="display: none">
                            <div class="cbtooltip">
                                Company URL :<input type="text" id="txtCompanyLink" style="width: 70%;" />

                                <a onclick="copyCompanyLink();return false;" style="cursor: pointer;" data-toggle='tooltip' data-placement='bottom' data-original-title='Copy link here'><span class="cbtooltiptext" id="myTooltipPass" data-toggle='tooltip' data-placement='bottom' data-original-title='Copy link here'></span>
                                    <i class="icon-clipboard"></i></a>

                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table id="tblViewIncidents" style="width: 100%" class="table table-hover border-bottom mb-4">
                            <thead class="thead-dark">
                                <tr>
                                    <th>#</th>
                                    <th class="d-none">Tran ID</th>
                                    <th>Evidence Details</th>
                                    <th>Concern Details</th>
                                    <th class="d-none">Is Reportable</th>
                                    <th class="d-none">Supporting Evidence?</th>
                                    <th class="d-none">Have witnesses?</th>
                                    <th class="d-none">Update Progress? </th>
                                    <th class="d-none">Contact Email</th>
                                    <th class="d-none">Contact Phone</th>
                                    <th class="d-none">Anonymous Email</th>
                                    <th>Submission Date</th>
                                    <th>Actions</th>
                                    <th>
                                        <div class="dropdown">
                                            <!-- Toggle -->
                                            <a href="#" class="dropdown-toggle" id="dropdownFilter" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="icon-filter mr-2"></i>Category
                                            </a>
                                            <!-- Menu -->

                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownFilter" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(82px, 21px, 0px);">
                                                <a class="dropdown-item" href="#!">
                                                    <i class="icon-corner-up-left mr-2"></i>All
                                                </a>
                                                <a class="dropdown-item" href="#!">
                                                    <i class="icon-message-circle mr-2"></i>New

                                                </a>
                                                <a class="dropdown-item" href="#!">
                                                    <i class="icon-eye mr-2"></i>Open
                                                </a>
                                                <a class="dropdown-item" href="#!">
                                                    <i class="icon-trending-up mr-2"></i>Resource
                                                </a>
                                                <a class="dropdown-item" href="#!">
                                                    <i class="icon-zap mr-2"></i>In Progress
                                                </a>
                                                <a class="dropdown-item" href="#!">
                                                    <i class="icon-zap mr-2"></i>Closed
                                                </a>
                                            </div>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>

            </div>
        </div>
        <!--end of container-->
    </section>
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();


            $('.btn').click(function () {
                alert('hi');
            });
        });
        $(function () {
            $('.btn').popover({
                container: "body",
                html: true,
                content: function () {
                    return '<div class="popover-message">Hello</div>';
                }
            });
        });
        $('[data-toggle="tooltip"]').tooltip();
    </script>
</asp:Content>
