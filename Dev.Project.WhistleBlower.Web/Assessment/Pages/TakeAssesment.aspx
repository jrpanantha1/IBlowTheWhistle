<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TakeAssesment.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Assessment.Pages.TakeAssesment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>I Blow the Whistle</title>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="manifest.json">
    <!-- Place favicon.ico in the root directory -->
    <link rel="apple-touch-icon" href="icon.png">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/css/flag-icon.min.css" rel="stylesheet">
    <link href="/assets/css/AssesmentStyle.css" rel="stylesheet" />
    <meta name="msapplication-config" content="browserconfig.xml" />
    <meta name="theme-color" content="#00B48F" />
    <script src="/Scripts/popper.min.js" async defer></script>
    <script src="/Scripts/bootstrap.min.js" async defer></script>
    <script src="/Scripts/jquery-3.3.1.min.js"></script>
    <script src="/Scripts/popper.min.js" async defer></script>
    <script src="/assets/js/toast.script.js"></script>
    <script src="/Scripts/bootstrap.min.js" async defer></script>
    <script src="/Scripts/PageScripts/Home.js"></script>
    <script src="/Scripts/Utility.js"></script>
    <script src="/Scripts/PageScripts/TakeAssesment.js"></script>
    <script src="/Scripts/Validation.js"></script>
    <style>
        .error {
            border: 1px solid red;
        }

        /*.custom-control-input {
            position: absolute;
            left: 0;
            z-index: -1;
            width: 1.2rem;
            height: 1.425rem;*/
        /* opacity: inherit;*/
        /*}*/


        .ctrlqHeaderMast {
            height: 200px;
            background: #009688;
        }

        .ctrlqFormContent {
            color: rgba(0,0,0,.87);
            padding: 20px 35px
        }

        .ctrlqFormContentWrapper {
            display: -webkit-box;
            display: -moz-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: vertical;
            box-orient: vertical;
            -webkit-flex-direction: column;
            flex-direction: column
        }

        .ctrlqAccent {
            background-color: #a7ffeb;
            height: 8px;
        }

        .ctrlqCenteredContent {
            margin: auto;
            width: 900px;
        }

        .ctrlqFormCard {
            background-color: #fff;
            margin-bottom: 48px;
            -webkit-box-shadow: 0 1px 4px 0 rgba(0,0,0,0.37);
            box-shadow: 0 1px 4px 0 rgba(0,0,0,0.37);
            word-wrap: break-word
        }

            .ctrlqFormCard:first-of-type {
                margin-top: -100px
            }

        .ctrlqHeaderTitle {
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
            font-size: 34px;
            line-height: 135%;
            max-width: 100%;
            min-width: 0%;
            margin-bottom: 22px
        }

        @media (max-width: 660px) {
            .ctrlqHeaderMast {
                height: 122px;
            }

            .ctrlqFormCard:first-of-type {
                margin-top: -50px;
            }

            .ctrlqCenteredContent {
                width: 90%;
            }
        }

        div.error {
            position: relative;
            top: -1rem;
            left: 0rem;
            font-size: 0.8rem;
            color: #FF4081;
            -webkit-transform: translateY(0%);
            -ms-transform: translateY(0%);
            -o-transform: translateY(0%);
            transform: translateY(0%);
        }
        /* design templates*/
        fieldset {
            margin-bottom: 30px;
            border: none;
            width: 100%;
        }

        legend {
            font-size: 1.4em;
            margin-bottom: 10px;
        }

        .number {
            background-color: #5fcf80;
            color: #fff;
            height: 30px;
            width: 30px;
            display: inline-block;
            font-size: 0.8em;
            margin-right: 4px;
            line-height: 30px;
            text-align: center;
            text-shadow: 0 1px 0 rgb(255 255 255 / 20%);
            border-radius: 100%;
        }

        .QuestionEnd {
            margin-bottom: 10px;
            border-bottom: 1px solid green;
            padding-bottom: 10px;
        }

        .left-griditem {
            display: flex;
        }

        .color_red1 {
            padding-left: 1px;
            padding-right: 25px;
        }
    </style>
</head>

<body class="h-100">
    <section class="d-flex flex-column flex-root">
        <div class="d-flex flex-column flex-lg-row flex-column-fluid">
            <div class="d-flex flex-column flex-lg-row-auto bg-dark w-xl-600px positon-xl-relativ order-2 order-lg-1">
                <div class="d-flex flex-column position-xl-fixed top-0 bottom-0 w-xl-600px scroll-y">
                    <div class="d-flex flex-row-fluid flex-column text-center p-5 pt-lg-10">
                        <a href="https://iblowthewhistle.com/">
                            <img src="/assets/images/logo-light.png" alt="" class="logo-60 mx-auto img-fluid" /></a>
                        <h1 class="h3 text-white mt-5 mb-4">What is IBTW?
                        </h1>
                        <p class="text-white lead">
                            Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsam fugit doloremque totam rem repellat sit necessitatibus ullam architecto provident.
                       
                        </p>
                    </div>
                    <div class="d-flex flex-row-auto bgi-no-repeat bgi-position-x-center bgi-size-contain bgi-position-y-bottom min-h-200px min-h-lg-350px" style="background-image: url(/assets/images/woman-laptop.svg)"></div>
                </div>
            </div>
            <div class="d-flex flex-column flex-lg-row-fluid order-1 order-lg-2">
                <div class="d-flex flex-column flex-column-fluid">
                    <div class="w-lg-600px mx-auto p-5 py-lg-10">
                        <div class="intro mb-5">
                            <a href="https://iblowthewhistle.com/">
                                <img src="/assets/images/logo-icon.png" alt="" class="logo-70 mr-md-3 mb-3 mb-md-0 img-fluid" />
                                <img src="/assets/images/logo-wbuk.png" alt="Whistleblowers UK" class="logo-70 mx-auto img-fluid" /></a>
                            <h2 class="h3 mt-5 mb-4">Assessment Form
                            </h2>
                            <p class="lead">
                                Let's start with the basic. Please enter the following information below to begin.
                           
                            </p>
                        </div>
                        <!--end of intro-->
                        <form action="form-assessment-questionaire-v2.html" method="get" class="needs-validation" novalidate>
                            <div id="divUserDetails">
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input id="txtName" class="form-control" placeholder="Jon Snow" type="text" required>
                                    <div class="invalid-feedback">
                                        Name is not valid.                               
                                    </div>
                                </div>
                                <!--end of form-group-->
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input id="txtEmail" class="form-control" placeholder="jon.snow@winterfell.com" type="email" required />
                                    <div class="invalid-feedback">
                                        Email address is not valid.
                               
                                    </div>
                                </div>
                                <!--end of form-group-->
                                <div class="form-group">
                                    <label for="organisationName">Organisation</label>
                                    <input id="txtOrganisation" class="form-control" placeholder="Winterfell" type="organisationName" />
                                    <div class="invalid-feedback">
                                        Please enter the Organisation Name.
                               
                                    </div>
                                </div>
                                <!--end of form-group-->
                                <div class="form-group">
                                    <label for="organisationName">Role</label>
                                    <input id="txtRole" class="form-control" placeholder="Consultant" type="roleName" />
                                    <div class="invalid-feedback">
                                        Please enter the Role Name.                               
                                    </div>
                                </div>
                                <!--end of form-group-->
                                <div class="form-group">
                                    <label for="phoneNumber">Phone</label>
                                    <small id="phoneNumberHelpInline" class="text-muted">(Optional)</small>
                                    <input id="txtPhone" class="form-control" placeholder="Optional" type="phoneNumber" aria-describedby="phoneNumberHelpInline" />
                                    <div class="invalid-feedback">
                                        Phone Number is not valid.
                               
                                    </div>
                                </div>

                                <!--end of form-group-->
                                <div class="form-group">

                                    <input type="button" class="btn btn-sm btn-block btn-primary" value="Continue" onclick="if (AddNewExaminorValidation()) { showAssessment(); }" id="btnJoin" />
                                    <input type="button" class="btn btn-sm btn-block btn-primary" value="Close" onclick="window.location.href = '/Pages/Default.aspx'" id="btnClose" />
                                </div>
                                <!--end of form-group-->
                                <p class="small">
                                    <input id="chkTerms" type="checkbox" checked="checked" class="custom-control-input" />
                                    <p class="small text-center" style="margin-bottom: 20px;">By registering with Iblowthewhistle, I agree and consent to Iblowthewhistle to contact me and process my details in relation registering Interest in using Iblowthewhistle platform . My details will be processed in accordance with our Terms and Conditions, Privacy Policy and my consent to receiving Iblowthewhistle related information from I Blow The Whistle. Before applying please <a href="https://apps.iblowthewhistle.com/assessment/Eligibility.aspx" style="color: blue;">click</a> here to know about the eligibility criteria.</p>

                                    By clicking "<strong>Continue</strong>", I agree to I Blow The Whistle's <a href="#" class="text-muted">Terms of Service</a> and <a href="#" class="text-muted">Privacy Policy</a>.
                           
                                </p>
                            </div>
                            <div id="divQuestionaire" style="display: none">
                                <div class="d-flex flex-column flex-column-fluid">
                                    <div class="w-lg-600px mx-auto p-5 py-lg-10">
                                        <div class="intro mb-5">

                                            <h2 class="h3 mt-5 mb-4">Questionaire</h2>
                                            <p class="lead">
                                                You're almost there. Quibusdam 5 categories containing 15 questions. Click "<strong>Begin Assessment</strong>" when you're ready to start.
                           
                                            </p>
                                        </div>
                                        <div class="d-flex justify-content-between pb-3 mb-3 border-bottom">
                                            <span class="h6 mb-0 align-self-end">TRUST</span>
                                            <span class="h6 mb-0">Multichoice                               
                                                <i class="icon-check-square ml-2"></i>
                                            </span>
                                        </div>
                                        <div class="d-flex justify-content-between pb-3 mb-3 border-bottom">
                                            <span class="h6 mb-0 align-self-end">IMPARTIALITY</span>
                                            <span class="h6 mb-0">Multichoice                               
                                                <i class="icon-check-square ml-2"></i>
                                            </span>
                                        </div>
                                        <div class="d-flex justify-content-between pb-3 mb-3 border-bottom">
                                            <span class="h6 mb-0 align-self-end">PROTECTION</span>
                                            <span class="h6 mb-0">Multichoice                               
                                                <i class="icon-check-square ml-2"></i>
                                            </span>
                                        </div>
                                        <!--end of fkex-->
                                        <button id="buttonBegin" type="submit" class="btn btn-block btn-sm btn-primary mt-4">
                                            Begin Assessment</button>
                                        <!--end of form-->
                                    </div>
                                </div>

                            </div>
                            <div id="divAssesmentDetails" style="display: none">
                                <div class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
                                    <p class="h6 mb-0">
                                        <span class="badge badge-primary badge-question">1</span>
                                        TRUST                        
                                    </p>
                                    <p class="h6 mb-0">
                                        Multichoice<i class="icon-check-square ml-2"></i>
                                    </p>
                                </div>

                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ1">1. Does your organisation have a WB policy? </p>

                                    <div class="custom-control custom-radio">
                                        <input name="WBpolicy" type="radio" id="rdbYes1" class="custom-control-input" value="Yes" data-error="#e4" required />
                                        <label class="custom-control-label" for="rdbYes1">Yes</label>
                                    </div>

                                    <div class="custom-control custom-radio">
                                        <input name="WBpolicy" type="radio" id="rdbNo1" class="custom-control-input" value="Yes" data-error="#e4" required />
                                        <label class="custom-control-label" for="rdbNo1">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="WBpolicy" type="radio" id="rdbDK1" class="custom-control-input" value="Yes" data-error="#e4" required />
                                        <label class="custom-control-label" for="rdbDK1">Don't Know</label>
                                    </div>

                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ2">2. Does everyone understand the policy and their role/responsibility  </p>
                                    <div class="custom-control custom-radio">
                                        <input name="responsibility" type="radio" id="rdbYes2" class="custom-control-input" value="Yes" data-error="#e4" required />
                                        <label class="custom-control-label" for="rdbYes2">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="responsibility" type="radio" id="rdbNo2" class="custom-control-input" value="No" />
                                        <label for="rdbNo2" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="responsibility" type="radio" id="rdbPassibly1" class="custom-control-input" value="Don't Know" />
                                        <label for="rdbPassibly1" class="custom-control-label">Possibly</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="responsibility" type="radio" id="rdbDK2" class="custom-control-input" value="Don't Know" />
                                        <label for="rdbDK2" class="custom-control-label">Don't Know</label>
                                    </div>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ3" class="mb-3">3. How is this policy communicated:</p>
                                    <div class="custom-control custom-radio">
                                        <input name="communicated" type="radio" id="rdbIntranet" class="custom-control-input" data-error="#e4" required />
                                        <label for="rdbIntranet" class="custom-control-label">Intranet</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="communicated" type="radio" id="rdbStaff" class="custom-control-input" />
                                        <label for="rdbStaff" class="custom-control-label">Staff Handbook</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="communicated" type="radio" id="rdbTraining" class="custom-control-input" />
                                        <label for="rdbTraining" class="custom-control-label">Training</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="communicated" type="radio" id="rdbOthers" class="custom-control-input" />
                                        <label for="rdbOthers" class="custom-control-label">Other/s – please state</label>
                                    </div>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ4" class="mb-4">4. Is the whistleblowing policy available to contractors/third parties?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="contractors" type="radio" id="rdbYes3" class="custom-control-input" value="Yes" data-error="#e4" required />
                                        <label for="rdbYes3" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="contractors" type="radio" id="rdbNo3" class="custom-control-input" value="No" />
                                        <label for="rdbNo3" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="contractors" type="radio" id="rdbDK3" class="custom-control-input" value="Don't Know" />
                                        <label for="rdbDK3" class="custom-control-label">Don't Know</label>
                                    </div>
                                </div>
                                <div class="input-field col s12 mb-4">
                                    <p id="pQ5" class="mb-4">5. Are whistleblowers guaranteed confidentiality? </p>
                                    <div class="custom-control custom-radio">
                                        <input name="confidentiality" type="radio" id="rdbYes4" value="Yes" class="custom-control-input" data-error="#e4" required />
                                        <label for="rdbYes4" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="confidentiality" type="radio" id="rdbNo4" class="custom-control-input" value="No" />
                                        <label for="rdbNo4" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="confidentiality" type="radio" id="rdbDK4" class="custom-control-input" value="Don't Know" />
                                        <label for="rdbDK4" class="custom-control-label">Don't Know</label>
                                    </div>
                                </div>


                                <div class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
                                    <p class="h6 mb-0">
                                        <span class="badge badge-primary badge-question">2</span>
                                        IMPARTIALITY                        
                                    </p>
                                    <p class="h6 mb-0">
                                        Multichoice<i class="icon-check-square ml-2"></i>
                                    </p>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ6" class="mb-4">1. Do you have a whistleblowing champion? </p>
                                    <div class="custom-control custom-radio">
                                        <input name="champion" type="radio" id="rdbYes11" value="Yes" class="custom-control-input" data-error="#e4" required />
                                        <label for="rdbYes11" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="champion" type="radio" id="rdbNo11" value="No" class="custom-control-input" />
                                        <label for="rdbNo11" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="champion" type="radio" id="rdbDK11" value="Don't Know" class="custom-control-input" />
                                        <label for="rdbDK11" class="custom-control-label">Don't Know</label>
                                    </div>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ7" class="mb-4">2. Are they contactable and do they have autonomy to act? </p>
                                    <div class="custom-control custom-radio">
                                        <input name="autonomy" type="radio" id="rdbYes22" value="Yes" data-error="#e4" class="custom-control-input" required />
                                        <label for="rdbYes22" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="autonomy" type="radio" id="rdbNo22" value="No" class="custom-control-input" />
                                        <label for="rdbNo22" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="autonomy" type="radio" id="rdbDK22" value="Don't Know" class="custom-control-input" />
                                        <label for="rdbDK22" class="custom-control-label">Don't Know</label>
                                    </div>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ8" class="mb-4">3. Is the person/s who reviews the whistleblowing reports trained and acredited?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="trained" type="radio" id="rdbYes33" value="Yes" data-error="#e4" class="custom-control-input" required />
                                        <label for="rdbYes33" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="trained" type="radio" id="rdbNo33" value="No" class="custom-control-input" />
                                        <label for="rdbNo33" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="trained" type="radio" id="rdbDK33" value="Don't Know" class="custom-control-input" />
                                        <label for="rdbDK33" class="custom-control-label">Don't Know</label>
                                    </div>

                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ9" class="mb-4">4. Does your system provide regular feedback to the whistleblower?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="whistleblower" type="radio" id="rdbYes44" value="Yes" class="custom-control-input" data-error="#e4" required />
                                        <label for="rdbYes44" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="whistleblower" type="radio" id="rdbNo44" class="custom-control-input" value="No" />
                                        <label for="rdbNo44" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="whistleblower" type="radio" id="rdbDK44" class="custom-control-input" value="Don't Know" />
                                        <label for="rdbDK44" class="custom-control-label">Don't Know</label>
                                    </div>
                                </div>
                                <div class="input-field col s12 ">
                                    <p id="pQ10" class="mb-4">5. What information does the board receive?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="receive" type="radio" id="rdbNothing" value="Yes" class="custom-control-input" data-error="#e4" />
                                        <label for="rdbNothing" class="custom-control-label">Nothing</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="receive" type="radio" id="rdbBare" value="No" class="custom-control-input" />
                                        <label for="rdbBare" class="custom-control-label">Bare facts with no identifying data</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="receive" type="radio" id="rdbTheySee" value="Don't Know" class="custom-control-input" />
                                        <label for="rdbTheySee" class="custom-control-label">They see everything</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="receive" type="radio" id="rdbDK55" value="Don't Know" class="custom-control-input" />
                                        <label for="rdbDK55" class="custom-control-label">Don't Know</label>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
                                    <p class="h6 mb-0">
                                        <span class="badge badge-primary badge-question">3</span>
                                        PROTECTION                        
                                    </p>
                                    <p class="h6 mb-0">
                                        Multichoice<i class="icon-check-square ml-2"></i>
                                    </p>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ11" class="mb-4">1. On a scale of 1- 6 do staff feel safe to speak up?  </p>
                                    <div class="left-griditem">
                                        <div class="custom-control custom-radio">
                                            <input name="speak" type="radio" id="rdbRating1" value="Yes" data-error="#e4" class="custom-control-input" />
                                            <label for="rdbRating1" class="custom-control-label color_red1 ">1</label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input name="speak" type="radio" id="rdbRating2" value="Yes" data-error="#e4" class="custom-control-input" />
                                            <label for="rdbRating2" class="custom-control-label color_red1">2</label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input name="speak" type="radio" id="rdbRating3" value="Yes" data-error="#e4" class="custom-control-input" />
                                            <label for="rdbRating3" class="custom-control-label color_red1">3</label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input name="speak" type="radio" id="rdbRating4" value="Yes" data-error="#e4" class="custom-control-input" />
                                            <label for="rdbRating4" class="custom-control-label color_red1">4</label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input name="speak" type="radio" id="rdbRating5" value="Yes" data-error="#e4" class="custom-control-input" />
                                            <label for="rdbRating5" class="custom-control-label color_red1">5</label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input name="speak" type="radio" id="rdbRating6" value="Yes" data-error="#e4" class="custom-control-input" />
                                            <label for="rdbRating6" class="custom-control-label color_red1">6</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ12" class="mb-4">2. Does your system accept and act on anonymous reports?  </p>
                                    <div class="custom-control custom-radio">
                                        <input name="anonymous" type="radio" id="rdbYes111" value="Yes" data-error="#e4" class="custom-control-input" />
                                        <label for="rdbYes111" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="anonymous" type="radio" id="rdbNo111" value="No" class="custom-control-input" />
                                        <label for="rdbNo111" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="anonymous" type="radio" id="rdbDK111" value="Don't Know" class="custom-control-input" />
                                        <label for="rdbDK111" class="custom-control-label">Don't Know</label>
                                    </div>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ13" class="mb-4">3. Does your organisation have an anti-retaliation policy?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="retaliation" type="radio" id="rdbYes222" value="Yes" class="custom-control-input" data-error="#e4" />
                                        <label for="rdbYes222" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="retaliation" type="radio" id="rdbNo222" value="No" class="custom-control-input" />
                                        <label for="rdbNo222" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="retaliation" type="radio" id="rdbDK222" value="Don't Know" class="custom-control-input" />
                                        <label for="rdbDK222" class="custom-control-label">Don't Know</label>
                                    </div>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ14" class="mb-4">4. Does your organisation operate an independent whistleblower reporting platform? </p>
                                    <div class="custom-control custom-radio">
                                        <input name="independent" type="radio" id="rdbYes333" value="Yes" data-error="#e4" class="custom-control-input" />
                                        <label for="rdbYes333" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="independent" type="radio" id="rdbNo333" value="No" class="custom-control-input" />
                                        <label for="rdbNo333" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="independent" type="radio" id="rdbDK333" value="Don't Know" class="custom-control-input" />
                                        <label for="rdbDK333" class="custom-control-label">Don't Know</label>
                                    </div>
                                </div>
                                <div class="input-field col s12 mb-5">
                                    <p id="pQ15" class="mb-4">5. Would an external reporting platform encourage more people to speak up?  </p>
                                    <div class="custom-control custom-radio">
                                        <input name="encourage" type="radio" id="rdbDefinitely" value="Yes" data-error="#e4" class="custom-control-input" />
                                        <label for="rdbDefinitely" class="custom-control-label">Definitely</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="encourage" type="radio" id="rdbPossibly" value="No" class="custom-control-input" />
                                        <label for="rdbPossibly" class="custom-control-label">Possibly</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="encourage" type="radio" id="rdbNoTrust" value="Don't Know" class="custom-control-input" />
                                        <label for="rdbNoTrust" class="custom-control-label">No don’t trust the organisation</label>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="input-field col m6 s12">
                                        <input type="button" class="btn btn-sm btn-block btn-primary" value="Submit" onclick="if (AddNewAssesmentValidation()) { AddNewAssesment(); }" id="btnSubmit" />
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!--end of form-->
                        <div class="d-flex flex-center flex-wrap p-5 pb-0 align-items-end">
                            <div class="d-flex flex-center small">
                                <a href="#" class="text-uppercase text-muted font-weight-bold px-2">About
                                </a>
                                <a href="#" class="text-uppercase text-muted font-weight-bold px-2">Support
                                </a>
                            </div>
                        </div>
                        <!--end of footer links-->
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- // Section -->
    <!-- JS -->
    <script src="/assets/js/pace.min.js"></script>
    <script src="/assets/js/form.validate.min.js"></script>
</body>

</html>
