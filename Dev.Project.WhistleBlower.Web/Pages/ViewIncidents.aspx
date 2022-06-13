<%@ Page Title="View Incidents | I Blow the Whistle" Language="C#" MasterPageFile="~/WhistleBlowerUser.Master" AutoEventWireup="true" CodeBehind="ViewIncidents.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ViewIncidents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    View All Incidents | I Blow the Whistle
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <meta />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link href="/JQDatatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/JQDatatables/datatables.min.js"></script>
    <link href="/assets/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/PageScripts/ViewIncidents.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <style>
        .details-example {
            background: #efefef;
            position: relative;
            font-weight: normal;
            background-repeat: no-repeat;
            background-position: 10px 5px;
            padding-left: .6em;
            background-size: 20px 20px;
            padding: 5px 15px;
            z-index: 1;
            width: 250px;
            border-radius: 4px;
            color: #ffac2c;
            float: left;
        }

            .details-example summary {
                list-style: none;
            }

                .details-example summary::marker {
                    display: none;
                }

        details summary::after {
            content: " \25BD";
            float: right;
            color: #000;
        }

        details[open] summary::after {
            content: " \25B3";
            color: #000;
        }

        .statusmenu ul {
            position: absolute;
            left: 0;
            top: 30px;
            list-style-type: none;
            margin: 0;
            padding: 0;
            width: 100%;
            z-index: -999;
        }

        .statusmenu li, .statusmenu li:hover {
            font-weight: normal;
            padding: 5px 47px;
        }

        .statunread:hover, .statread:hover, .statimp:hover, .statdone:hover, .statdisc:hover, .statrtm:hover {
            background: #fff;
        }

        .statunread, .statread, .statimp, .statdone, .statdisc, .statrtm {
            background: #f0f3f7;
        }

            .statunread, .statunread:hover {
                background-image: url(https://img.icons8.com/pastel-glyph/2x/topic-push-notification.png);
                background-repeat: no-repeat;
                background-position: 12px 8px;
                padding-left: .8em;
                background-size: 20px 20px;
                color: #ffac2c;
            }

            .statread, .statread:hover {
                background-image: url(https://img.icons8.com/ios-glyphs/2x/eye.png);
                background-repeat: no-repeat;
                background-position: 12px 8px;
                padding-left: .8em;
                background-size: 20px 20px;
                color: #2666eb;
            }

            .statimp, .statimp:hover {
                background-image: url(https://img.icons8.com/ios-glyphs/2x/star.png);
                background-repeat: no-repeat;
                background-position: 12px 8px;
                padding-left: .8em;
                background-size: 20px 20px;
                color: #eb4329;
            }

            .statdone, .statdone:hover {
                background-image: url(https://img.icons8.com/ios-glyphs/2x/approval.png);
                background-size: 20px 20px;
                background-repeat: no-repeat;
                background-position: 12px 8px;
                padding-left: .8em;
                color: #00cb72;
            }

            .statdisc, .statdisc:hover {
                background-image: url(https://img.icons8.com/ios-glyphs/2x/conflict.png);
                background-size: 20px 20px;
                background-repeat: no-repeat;
                background-position: 12px 8px;
                padding-left: .8em;
                color: #784bd1;
            }

            .statrtm, .statrtm:hover {
                background-image: url(https://img.icons8.com/ios-glyphs/2x/feedback.png);
                background-size: 20px 20px;
                background-repeat: no-repeat;
                background-position: 12px 8px;
                padding-left: .8em;
                color: #ff0476;
            }

        #incidentstatus-active {
            width: 90%;
            float: left;
            margin: 0;
            color: #222;
        }


        .activestatus1 {
            background-image: url(https://img.icons8.com/pastel-glyph/2x/topic-push-notification.png);
            background-repeat: no-repeat;
            background-position: 0px 1px;
            padding-left: 2em;
            background-size: 20px 20px;
            color: #ffac2c !important;
        }

        .activestatus2 {
            background-image: url(https://img.icons8.com/ios-glyphs/2x/eye.png);
            background-repeat: no-repeat;
            background-position: 0px 4px;
            padding-left: 2em;
            background-size: 20px 20px;
            color: #2666eb !important;
        }

        .activestatus3 {
            background-image: url(https://img.icons8.com/ios-glyphs/2x/star.png);
            background-repeat: no-repeat;
            background-position: 0px 2px;
            padding-left: 2em;
            background-size: 20px 20px;
            color: #eb4329 !important;
        }

        .activestatus4 {
            background-image: url(https://img.icons8.com/ios-glyphs/2x/approval.png);
            background-repeat: no-repeat;
            background-position: 0px 3px;
            padding-left: 2em;
            background-size: 20px 20px;
            color: #00cb72 !important;
        }

        .activestatus5 {
            background-image: url(https://img.icons8.com/ios-glyphs/2x/conflict.png);
            background-repeat: no-repeat;
            background-position: 0px 3px;
            padding-left: 2em;
            background-size: 20px 20px;
            color: #784bd1 !important;
        }

        .activestatus6 {
            background-image: url(https://img.icons8.com/ios-glyphs/2x/feedback.png);
            background-repeat: no-repeat;
            background-position: 0px 4px;
            padding-left: 2em;
            background-size: 20px 20px;
            color: #ff0476 !important;
        }

        #spanCode {
            padding: 0 10px;
            margin-left: 10px;
            border-radius: 5px;
            border: 0;
            margin-left: 0;
        }

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
            padding: 7px;
            font-size: 20px;
            width: 100%;
            float: left;
        }

        .name {
            background-color: #333;
            border-bottom-left-radius: 8px;
            border-bottom-right-radius: 8px;
            color: #fff;
            font-size: 20px;
            padding: 20px;
            text-align: center;
            width: 100%;
            float: left;
            margin-bottom: 20px;
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
                /*top: 25px;*/
                content: " ";
                display: block;
                /* right: 50%;*/
                position: relative;
            }

        .divTopSection1 {
            min-width: 6%;
            float: left;
            text-align: left;
            padding: 10px;
        }

        .divTopSection2 {
            /* min-width: 60%;*/
            min-width: 48%;
            float: left;
            text-align: left;
            padding: 10px;
            color: black;
            font-weight: bold;
        }

        .divTopSection4 {
            min-width: 29%;
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

        .companyCode {
            float: right;
        }

            .companyCode .companyCode {
                float: left;
            }

        #companyCodelbl {
            padding-right: 10px;
            position: relative;
            top: 2px;
            color: #fff;
            font-weight: normal;
        }

        div.dt-buttons,
        .dataTables_wrapper .dataTables_filter {
            margin: 12px 0;
        }

        button.dt-button,
        div.dt-button,
        a.dt-button {
            padding: 12px;
            margin-bottom: 0;
        }

        .dataTables_wrapper .dataTables_filter label {
            margin-bottom: 0;
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
                        <img src="" class="imgTopBanner" alt="horizontal banner" /></a>
                </div>
                <div class="col-12 contentarea">

                    <!-- START HERE -->
                    <div id="topCompanySection" style="display: none">
                        <div class="d-flex justify-content-between align-items-center bg-primary p-2 rounded-top">
                            <div class="col-auto">
                                <h5 id="companyNamelbl" class="m-0 mr-2"><span class="sr-only">Name </span></h5>
                            </div>
                            <div class="col mx-n3">
                                <span id="spanCompany" class="text-white">Demo Company Bespoke</span>
                            </div>
                            <div class="col-auto">
                                <span id="companyCodelbl" class="font-weight-bold">Code</span>
                            </div>
                            <div class="col-auto mx-n3">
                                <input type="text" id="spanCode" class="form-control-sm rounded col mx-n1" />
                            </div>
                            <div class="col-auto">
                                <a onclick=" copyCompanyCode();return false;" data-toggle="tooltip" data-placement="bottom" data-original-title="Copy Link Here">
                                    <span id="myTooltipComCode" data-toggle="tooltip" data-placement="bottom" data-original-title="" title=""></span>
                                    <i class="icon-clipboard"></i></a>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center bg-dark text-white p-2 rounded-bottom">
                            <div class="col-auto">
                                <h5 id="companyURLlbl" class="m-0 mr-2">Company URL </h5>
                            </div>
                            <div class="col mx-n3">
                                <input type="text" id="txtCompanyLink" value="" class="form-control-sm rounded col mx-n1" />
                            </div>
                            <div class="col-auto">
                                <a class="text-white" onclick="copyCompanyLink();return false;" data-toggle="tooltip" data-placement="bottom" data-original-title="Copy Link Here">
                                    <span id="myTooltipPass" data-toggle="tooltip" data-placement="bottom" data-original-title="" title=""></span>
                                    <i class="icon-clipboard"></i></a>
                            </div>
                        </div>
                        <!-- // END HERE -->
                    </div>
                    <div class="table-responsive">
                        <div class="tableviewincidents height-100">
                            <table id="tblViewIncidents" style="width: 100%" class="table table-hover border-bottom mb-4">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>#</th>
                                        <th class="d-none langDirection">Tran ID</th>
                                        <th class="d-none langDirection">Evidence Details</th>
                                        <th><span id="spanConcernDetailsGrd"></span></th>
                                        <th class="d-none langDirection">Is Reportable</th>
                                        <th class="d-none langDirection">Supporting Evidence?</th>
                                        <th class="d-none langDirection">Have witnesses?</th>
                                        <th class="d-none langDirection">Update Progress? </th>
                                        <th class="d-none langDirection">Contact Email</th>
                                        <th class="d-none langDirection">Contact Phone</th>
                                        <th class="d-none langDirection">Anonymous Email</th>
                                        <th><span id="spanSubDateGrd"></span></th>
                                        <th><span id="spanActionGrd"></span></th>
                                        <th>
                                            <div class="dropdown">
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
                                        </th>

                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="statusmenu" style="display: none">
                            <details class="details-example">
                                <summary>
                                    <p id="incidentstatus-active" class="activestatus">Select</p>
                                </summary>
                                <ul id="incidentstatus-list">
                                    <li class="statunread" data-value="Unread" data-class="activestatus1">Unread</li>
                                    <li class="statread" data-value="Read" data-class="activestatus2">Read</li>
                                    <li class="statimp" data-value="Important" data-class="activestatus3">Important</li>
                                    <li class="statdone" data-value="Done" data-class="activestatus4">Done</li>
                                    <li class="statdisc" data-value="Discarded" data-class="activestatus5">Discarded</li>
                                    <li class="statrtm" data-value="Route to Mail" data-class="activestatus6">Route to Mail</li>
                                </ul>
                            </details>
                        </div>
                    </div>
                </div>

            </div>
            <input type="hidden" id="hdnCopiedText" />
            <input type="hidden" id="hdnViewDetails" />
            <input type="hidden" id="hdnResHistory" />
            <input type="hidden" id="hdnCaseMngt" />

            <input type="hidden" id="hdnbtnExcel" />
            <input type="hidden" id="hdnbtnPDF" />
            <input type="hidden" id="hdnbtnAddmore" />
            <input type="hidden" id="hdnbtnReload" />

            <input type="hidden" id="hdnTipViewDetails" />
            <input type="hidden" id="hdnTipResponseHistory" />
            <input type="hidden" id="hdnTipCaseMngt" />
        </div>
        <!--end of container-->
    </section>
    <%--   <script>

        const detailsElement = document.querySelector('.details-example');

        detailsElement.addEventListener('toggle', event => {
            if (event.target.open) {
                console.log('open');
            } else {
                console.log('closed');
            }
        });

    </script>--%>
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();

            $("#incidentstatus-list li").on("click", function () {
                var selectedvalue = $(this).attr('data-value');
                var selectedclass = $(this).attr('data-class');
                $("#incidentstatus-active").removeClass('activestatus1').removeClass('activestatus2').removeClass('activestatus3').removeClass('activestatus4').removeClass('activestatus5').removeClass('activestatus6');
                $("#incidentstatus-active").addClass(selectedclass);
                $("#incidentstatus-active").text(selectedvalue);
                //$("#incidentstatus-list").slideUp();
                $('details').removeAttr('open');
            })

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
