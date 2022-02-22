<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
     Dashboard | I Blow the Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/PageScripts/Dashboard.js"></script>
    <style>
        .right-panel {
            background: #f1f2f7;
            margin-top: 55px;
            width: 90%;
            margin: 0 auto;
        }

            .right-panel header.header {
                background: #fff;
                border-bottom: 1px solid #e8e9ed;
                -webkit-box-shadow: none;
                box-shadow: none;
                clear: both;
                padding: 0 30px;
                height: 55px;
                position: fixed;
                left: 280px;
                left: 0;
                right: 0;
                top: 0;
                z-index: 999;
            }

        .dashboardcontent {
            padding: 1.875em;
            width: 100%;
            min-height: 400px;
        }

        .pb-0 {
            padding-bottom: 0;
        }

        .pb-0, .py-0 {
            padding-bottom: 0 !important;
        }

        .card {
            margin-bottom: 1.875em;
            border-radius: 5px;
            padding: 0;
            border: 0 solid transparent;
            -webkit-box-shadow: 0 0 20px rgb(0 0 0 / 8%);
            box-shadow: 0 0 20px rgb(0 0 0 / 8%);
        }

            .card .card-body {
                float: left;
                padding: 2.25em;
                position: relative;
                width: 100%;
            }

        .card {
            position: relative;
            display: -ms-flexbox;
            display: flex;
            -ms-flex-direction: column;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 1px solid rgba(0,0,0,.125);
            border-radius: .25rem;
        }

        .stat-widget-five {
            min-height: 60px;
        }

            .stat-widget-five .stat-icon {
                font-size: 90px;
                line-height: 50px;
                position: absolute;
                left: 9px;
                top: 25px;
            }

            .stat-widget-five .stat-content {
                margin-left: 100px;
            }

            .stat-widget-five .stat-text {
                color: #455a64;
                font-size: 25px;
            }

            .stat-widget-five .stat-heading {
                color: #99abb4;
                font-size: 20px;
            }

        .main_content .main_content_iner {
            min-height: 68vh;
            transition: .5s;
            position: relative;
            background: #fff;
            margin: 0;
            z-index: 22;
            border-radius: 0px;
            padding: 30px 30px;
        }

            .main_content .main_content_iner.overly_inner::before {
                position: absolute;
                left: 0;
                top: 0;
                right: 0;
                height: 160px;
                z-index: -1;
                content: '';
                border-radius: 0px;
                left: 0;
            }

        .page_title_box {
            padding-bottom: 15px;
        }

        .f_w_700 {
            font-weight: 700;
        }

        .dashboardcontent .page_title_box {
            text-align: center;
            width: 100%;
        }

        .dashboardcontent .page_title_left {
            text-align: center;
            width: 100%;
        }

        .header-sm-title {
            text-align: center;
            font-size: 2.5vw;
            font-weight: 700;
            line-height: 1.5;
            margin-bottom: 30px;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.min.js" async defer></script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div id="right-panel" class="right-panel main_content" style="margin-top: 150px;">
        <div class="dashboardcontent pb-0 main_content_iner overly_inner ">
            <div class="page_title_box d-flex align-items-center justify-content-between">
                <div class="page_title_left">
                    <h3 class="header-sm-title">Reports Dashboard</h3>

                </div>
                <a href="#" onclick="generatePDF(); return false;" data-toggle='tooltip' data-placement='top' style="height: 24px; width: 24px;" data-original-title='Export Dashboard to PDF'>
                    <img src="/Images/PDFIcon.png" /></a>

            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="stat-widget-five">
                                <div class="stat-icon dib flat-color-1">
                                    <i class='icon-hash mx-1'></i>
                                </div>
                                <div class="stat-content">
                                    <div class="text-left dib">
                                        <div class="stat-text"><span id="totalCount" class="count"></span></div>
                                        <div class="stat-heading">Total Concerns</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="stat-widget-five">
                                <div class="stat-icon dib flat-color-2">
                                    <i class='icon-activity mx-1'></i>
                                </div>
                                <div class="stat-content">
                                    <div class="text-left dib">
                                        <div class="stat-text"><span id="unreadCount" class="count"></span></div>
                                        <div class="stat-heading">Unread</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="stat-widget-five">
                                <div class="stat-icon dib flat-color-3">
                                    <i class='icon-star mx-1'></i>
                                </div>
                                <div class="stat-content">
                                    <div class="text-left dib">
                                        <div class="stat-text"><span id="importantCount" class="count"></span></div>
                                        <div class="stat-heading">Important</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="stat-widget-five">
                                <div class="stat-icon dib flat-color-4">
                                    <i class='icon-mail mx-1'></i>
                                </div>
                                <div class="stat-content">
                                    <div class="text-left dib">
                                        <div class="stat-text"><span id="rteCount" class="count"></span></div>
                                        <div class="stat-heading">Route to email</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="box-title">No of concerns per month </h4>
                        </div>
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="card-body">

                                    <div id="barchartContainer" style="height: 370px; width: 90%; float: left;"></div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="card-body">
                                    <div id="piechartContainer" style="height: 370px; width: 90%; float: left;"></div>
                                </div>
                            </div>
                        </div>
                        <div class="card-body"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title box-title">No of concerns reportable</h4>
                            <div class="card-content">
                                <div id="barchartReportableContainer" style="height: 370px; width: 90%; float: left;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title box-title">No of concerns have witness</h4>
                            <div class="card-content">
                                <div id="barchartHaveWitnessContainer" style="height: 370px; width: 90%; float: left;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="margin-top: 100px;"></div>
    <div id="editor"></div>

    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

</asp:Content>
