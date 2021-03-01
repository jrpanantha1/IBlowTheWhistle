<%@ Page Title="" Language="C#" MasterPageFile="~/WhistleBlower.Master" AutoEventWireup="true" CodeBehind="Confirmation.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Confirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        .ibtwModel {
            max-width: 50% !important;
        }

        .modal-confirm {
            color: #636363;
        }

            .modal-confirm .modal-content {
                padding: 20px;
                border-radius: 5px;
                border: none;
            }

            .modal-confirm .modal-header {
                border-bottom: none;
                position: relative;
            }

            .modal-confirm h4 {
                text-align: center;
                font-size: 26px;
                margin: 30px 0 -15px;
                width: 100%;
            }

            .modal-confirm .form-control, .modal-confirm .btn {
                min-height: 40px;
                border-radius: 3px;
            }

            .modal-confirm .close {
                position: absolute;
                top: -5px;
                right: -5px;
            }

            .modal-confirm .modal-footer {
                border: none;
                text-align: center;
                border-radius: 5px;
                font-size: 13px;
            }

            .modal-confirm .icon-box {
                color: #fff;
                position: absolute;
                margin: 0 auto;
                left: 0;
                right: 0;
                top: -70px;
                width: 95px;
                height: 95px;
                border-radius: 50%;
                z-index: 9;
                background: #82ce34;
                padding: 15px;
                text-align: center;
                box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
            }

                .modal-confirm .icon-box i {
                    font-size: 58px;
                    position: relative;
                    top: 3px;
                }

            .modal-confirm.modal-dialog {
                margin-top: 80px;
            }

            .modal-confirm .btn {
                color: #fff;
                border-radius: 4px;
                background: #82ce34;
                text-decoration: none;
                transition: all 0.4s;
                line-height: normal;
                border: none;
            }

                .modal-confirm .btn:hover, .modal-confirm .btn:focus {
                    background: #6fb32b;
                    outline: none;
                }

        .trigger-btn {
            display: inline-block;
            margin: 100px auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div id="myModal" tabindex="-1" style="margin-top: 15%;">
        <div class="modal-dialog modal-confirm ibtwModel">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="material-icons">&#xE876;</i>
                    </div>
                    <h4 class="modal-title">Awesome!</h4>
                </div>
                <div class="modal-body">
                    <p class="text-center">Your incident has been confirmed. Please note this transation id for future referance.</p>
                    <p class="text-center"><strong>Transaction ID : </strong><span id="trxID"></span></p>
                    <hr />
                    <div id="divAnnonymous">
                        <p class="text-center">Please note the below username and password to trace your incident status in future.</p>
                        <p class="text-center"><strong>Temporary User Name : </strong><span id="uName"></span></p>
                        <p class="text-center"><strong>Temporary Password  : </strong><span id="uPassword"></span></p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-success btn-block" onclick="redirecttoHomePage();return false;" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!-- // end confirmation model dialog-->
    <script type="text/javascript">

        $(document).ready(function () {
            var aCode = getUrlVars()["trxID"];
            $('#trxID').text(aCode);
        });

        function redirecttoHomePage() {
            window.location.href = "/Pages/Home.aspx";
        }
    </script>
</asp:Content>
