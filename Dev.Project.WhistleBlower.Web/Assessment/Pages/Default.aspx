<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Assessment.Pages.Default1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Assessment | I Blow The Whistle</title>
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
    <script src="/Scripts/Validation.js"></script>
    <script async defer src="https://cdn.boei.help/hello.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.min.js" async defer></script>
    <script src="/Scripts/PageScripts/TakeAssesment.js"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <style>
        .error {
            border: 1px solid red;
        }

        .rdberror {
            color: red;
        }
        /*  .custom-control-input {
            position: absolute;
            left: 0;
            z-index: -1;
            width: 1.2rem;
            height: 1.425rem;
            opacity: inherit;
        }*/

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
        }

        .left-griditem {
            display: flex;
        }

        .color_red1 {
            padding-left: 1px;
            padding-right: 25px;
        }

        /*success message css*/

        .wrapperAlert {
            /*width: 500px;*/
            /*height: 400px;*/
            overflow: hidden;
            border-radius: 12px;
            border: thin solid #ddd;
            text-align: center;
        }

        .topHalf {
            width: 100%;
            color: white;
            overflow: hidden;
            min-height: 250px;
            position: relative;
            padding: 40px 0;
            background: rgb(0,0,0);
            background: -webkit-linear-gradient(45deg, #019871, #a0ebcf);
        }

            .topHalf p {
                margin-bottom: 30px;
            }

        svg {
            fill: white;
        }

        .topHalf h1 {
            font-size: 2.25rem;
            display: block;
            font-weight: 500;
            letter-spacing: 0.15rem;
            text-shadow: 0 2px rgba(128, 128, 128, 0.6);
            color: white !important;
        }

        /* Original Author of Bubbles Animation -- https://codepen.io/Lewitje/pen/BNNJjo */
        .bg-bubbles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }

        li {
            position: absolute;
            list-style: none;
            display: block;
            width: 40px;
            height: 40px;
            background-color: rgba(255, 255, 255, 0.15); /* fade(green, 75%);*/
            bottom: -160px;
            -webkit-animation: square 20s infinite;
            animation: square 20s infinite;
            -webkit-transition-timing-function: linear;
            transition-timing-function: linear;
        }

            li:nth-child(1) {
                left: 10%;
            }

            li:nth-child(2) {
                left: 20%;
                width: 80px;
                height: 80px;
                animation-delay: 2s;
                animation-duration: 17s;
            }

            li:nth-child(3) {
                left: 25%;
                animation-delay: 4s;
            }

            li:nth-child(4) {
                left: 40%;
                width: 60px;
                height: 60px;
                animation-duration: 22s;
                background-color: rgba(white, 0.3); /* fade(white, 25%); */
            }

            li:nth-child(5) {
                left: 70%;
            }

            li:nth-child(6) {
                left: 80%;
                width: 120px;
                height: 120px;
                animation-delay: 3s;
                background-color: rgba(white, 0.2); /* fade(white, 20%); */
            }

            li:nth-child(7) {
                left: 32%;
                width: 160px;
                height: 160px;
                animation-delay: 7s;
            }

            li:nth-child(8) {
                left: 55%;
                width: 20px;
                height: 20px;
                animation-delay: 15s;
                animation-duration: 40s;
            }

            li:nth-child(9) {
                left: 25%;
                width: 10px;
                height: 10px;
                animation-delay: 2s;
                animation-duration: 40s;
                background-color: rgba(white, 0.3); /*fade(white, 30%);*/
            }

            li:nth-child(10) {
                left: 90%;
                width: 160px;
                height: 160px;
                animation-delay: 11s;
            }

        @-webkit-keyframes square {
            0% {
                transform: translateY(0);
            }

            100% {
                transform: translateY(-500px) rotate(600deg);
            }
        }

        @keyframes square {
            0% {
                transform: translateY(0);
            }

            100% {
                transform: translateY(-500px) rotate(600deg);
            }
        }

        .bottomHalf {
            align-items: center;
            padding: 35px;
        }

            .bottomHalf p {
                font-weight: 500;
                font-size: 1.05rem;
                margin-bottom: 20px;
            }

        button {
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 12px;
            padding: 10px 18px;
            background-color: #019871;
            text-shadow: 0 1px rgba(128, 128, 128, 0.75);
        }

            button:hover {
                background-color: #85ddbf;
            }

        .form-controlFeedBack {
            display: inline-block;
            width: 85%;
            height: calc(1.65em + 1.5rem + 2px);
            padding: .75rem 1.15rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.65;
            color: rgba(0,18,44,0.8);
            background-color: #f0f3f7;
            background-clip: padding-box;
            border: 1px solid #f0f3f7;
            border-radius: 0;
            -webkit-transition: border-color 0.15s ease-in-out,-webkit-box-shadow 0.15s ease-in-out;
            transition: border-color 0.15s ease-in-out,-webkit-box-shadow 0.15s ease-in-out;
            transition: border-color 0.15s ease-in-out,box-shadow 0.15s ease-in-out;
            transition: border-color 0.15s ease-in-out,box-shadow 0.15s ease-in-out,-webkit-box-shadow 0.15s ease-in-out
        }

        /*pdf style starts here*/
        .page-break {
            page-break-after: always;
            page-break-inside: avoid;
            clear: both;
        }

        .page-break-before {
            page-break-before: always;
            page-break-inside: avoid;
            clear: both;
        }

        #overlay {
            position: fixed;
            display: none;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: 10001 !important;
            cursor: pointer;
            background-color: #1fbc9c;
            z-index: 9999;
            opacity: 0.9;
        }

            #overlay .loaderImg {
                top: 50% !important;
                left: 50% !important;
                width: 60px !important;
                height: auto;
                margin: -43px 0 0 -30px;
                position: absolute;
            }
    </style>
</head>

<body class="h-100">
    <div id="overlay" style="z-index: 101">
        <img class="loaderImg" src="/Images/Loader.gif">
    </div>
    <section class="d-flex flex-column flex-root">
        <div class="d-flex flex-column flex-lg-row flex-column-fluid">
            <div class="d-flex flex-column flex-lg-row-auto bg-dark w-xl-600px positon-xl-relativ order-2 order-lg-1">
                <div class="d-flex flex-column position-xl-fixed top-0 bottom-0 w-xl-600px scroll-y">
                    <div class="d-flex flex-row-fluid flex-column text-center p-5 pt-lg-10">
                        <a href="https://www.wbuk.org/">
                            <img src="/assets/images/logo-wbuk-white.png" alt="homme" class="logo-60 mx-auto img-fluid" /></a>
                        <h1 class="h3 text-white mt-5 mb-4">Whistleblowing wellness check
                        </h1>
                        <p class="text-white lead">
                            Our Assessment Tool  can be used to help you and your organisation understand whistleblowing and maximise the opportunities that whistleblowers present.
                       
                        </p>
                        <p class="text-white lead">
                            Whistleblowers are the boards best friend, the first and most cost effective alert to all forms of risk to your companies health and wellbeing.
                        </p>
                    </div>
                    <div class="d-flex flex-row-auto bgi-no-repeat bgi-position-x-center bgi-size-contain bgi-position-y-bottom min-h-200px min-h-lg-350px" style="background-image: url(/assets/images/woman-laptop.svg)"></div>
                </div>
            </div>
            <div class="d-flex flex-column flex-lg-row-fluid order-1 order-lg-2">
                <div class="d-flex flex-column flex-column-fluid">
                    <div class="w-lg-800px mx-auto p-5 py-lg-10">
                        <div class="intro mb-5 text-xl-center" id="divTopHead">
                            <a target="_blank" href="https://iblowthewhistle.com/">
                                <img src="/assets/images/logo-icon.png" alt="" class="logo-70 mr-md-3 mb-3 mb-md-0 img-fluid" /></a>
                            <a target="_blank" href="https://www.wbuk.org/">
                                <img src="/assets/images/logo-wbuk.png" alt="Whistleblowers UK" class="logo-70 mx-auto img-fluid" /></a>
                            <h2 class="h3 mt-5 mb-4"><a style="color: inherit !important;" href="https://apps.iblowthewhistle.com/assessment/"> Whistleblowing Readiness Assessment</a>
                            </h2>
                            <p class="lead">
                                Is your company whistleblowers friendly and whistleblower ready?
                           
                            </p>
                        </div>
                        <!--end of intro-->
                        <input type="button" class="btn btn-sm btn-block btn-primary" value="test" style="display: none;" onclick="generate();return false;" id="btnTest" />
                        <form class="needs-validation" novalidate>
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
                                    <input id="txtPhone" class="form-control" placeholder="23-456" type="phoneNumber" aria-describedby="phoneNumberHelpInline" />
                                    <div class="invalid-feedback">
                                        Phone Number is not valid.
                               
                                    </div>
                                </div>

                                <!--end of form-group-->
                                <div class="form-group">

                                    <input type="button" class="btn btn-sm btn-block btn-primary" value="Continue" onclick="if (AddNewExaminorValidation()) { showAssessment(); }" id="btnJoin" />
                                    <input type="button" class="btn btn-sm btn-block btn-primary d-none" value="Close" onclick="window.location.href = '/Pages/Default.aspx'" id="btnClose" />
                                </div>
                                <!--end of form-group-->
                                <p class="small">
                                    <input id="chkTerms" type="checkbox" checked="checked" class="custom-control-input" />
                                    <p class="small text-center" style="margin-bottom: 20px;">By registering with Iblowthewhistle, I agree and consent to Iblowthewhistle to contact me and process my details in relation registering Interest in using Iblowthewhistle platform . My details will be processed in accordance with our Terms and Conditions, Privacy Policy and my consent to receiving Iblowthewhistle related information from I Blow The Whistle. Before applying please <a href="https://iblowthewhistle.com/eligibility/" style="color: blue;">click</a> here to know about the eligibility criteria.</p>

                                    <p class="small text-center">By clicking "<strong>Continue</strong>", I agree to I Blow The Whistle's <a href="https://iblowthewhistle.com/terms-conditions/" class="text-muted">Terms of Service</a> and <a href="https://iblowthewhistle.com/privacy-policy/" class="text-muted">Privacy Policy</a>.</p>

                                </p>
                            </div>
                            <div id="divQuestionaire" style="display: none">

                                <div>
                                    <p class="lead">
                                        Whistleblowing is not complicated and should be a top priority for every company. Our assessment tool can be used to help you and your organisation understand whistleblowing and maximise the opportunities that whistleblowers present.
                                    </p>
                                    <p class="lead">
                                        Whistleblowers are the boards best friend, the first and most cost effective alert to all forms of risk to your organisations health and wellbeing. 
                                    </p>
                                    <p class="lead">
                                        Before we being:
                                    </p>

                                </div>
                                <div class="input-field col s12 QuestionEnd  p-5">
                                    <p id="pQ0" class="mb-3">What is Whistleblowing?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="Whistleblowing" type="radio" id="rdbcorruption" class="custom-control-input" value="A disclosure of information that exposes a crime, corruption or cover up?" data-error="#e4" required />
                                        <label class="custom-control-label" for="rdbcorruption">A disclosure of information that exposes a crime, corruption or cover up?</label>
                                    </div>

                                    <div class="custom-control custom-radio">
                                        <input name="Whistleblowing" type="radio" id="rdbunethical" class="custom-control-input" value="Reports about illegal or unethical activities?" data-error="#e4" />
                                        <label class="custom-control-label" for="rdbunethical">Reports about illegal or unethical activities?</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="Whistleblowing" type="radio" id="rdbillegal" class="custom-control-input" value="A breach of contract or illegal act by the employee?" data-error="#e4" />
                                        <label class="custom-control-label" for="rdbillegal">A breach of contract or illegal act by the employee?</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="Whistleblowing" type="radio" id="rdbAllAbove" class="custom-control-input" value="All of the above." data-error="#e4" />
                                        <label class="custom-control-label" for="rdbAllAbove">All of the above.</label>
                                    </div>
                                    <span id="Whistleblowing" style="display: none">Please select value</span>

                                </div>
                                <div class="d-flex flex-column flex-column-fluid">
                                    <div class="">
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
                                        <input type="button" class="btn btn-sm btn-block btn-primary" value="Begin Assessment" onclick="if (assesmentBeginValidation()) { BeginAssessment(); }" id="btnTakeAssemenst" />

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
                                    <p id="pQ1" class="mb-3">1. Does your organisation have a WB policy? </p>
                                    <div class="custom-control custom-radio">
                                        <input name="WBpolicy" type="radio" id="rdbYes1" class="custom-control-input" value="2:Yes" data-error="#e4" required />
                                        <label class="custom-control-label" for="rdbYes1">Yes</label>
                                    </div>

                                    <div class="custom-control custom-radio">
                                        <input name="WBpolicy" type="radio" id="rdbNo1" class="custom-control-input" value="1:No" data-error="#e4" required />
                                        <label class="custom-control-label" for="rdbNo1">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="WBpolicy" type="radio" id="rdbDK1" class="custom-control-input" value="0:Don't Know" data-error="#e4" required />
                                        <label class="custom-control-label" for="rdbDK1">Don't Know</label>
                                    </div>
                                    <span id="WBpolicy" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ2" class="mb-3">2. Does everyone understand the policy and their role/responsibility  </p>
                                    <div class="custom-control custom-radio">
                                        <input name="responsibility" type="radio" id="rdbYes2" class="custom-control-input" value="2:Yes" data-error="#e4" required />
                                        <label class="custom-control-label" for="rdbYes2">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="responsibility" type="radio" id="rdbNo2" class="custom-control-input" value="1:No" />
                                        <label for="rdbNo2" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="responsibility" type="radio" id="rdbPassibly1" class="custom-control-input" value="0.5:Possibly" />
                                        <label for="rdbPassibly1" class="custom-control-label">Possibly</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="responsibility" type="radio" id="rdbDK2" class="custom-control-input" value="0:Don't Know" />
                                        <label for="rdbDK2" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="responsibility" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ3" class="mb-3">3. How is this policy communicated:</p>
                                    <div class="custom-control custom-radio">
                                        <input name="communicated" type="radio" id="rdbIntranet" class="custom-control-input" value="2:Intranet" data-error="#e4" required />
                                        <label for="rdbIntranet" class="custom-control-label">Intranet</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="communicated" type="radio" id="rdbStaff" class="custom-control-input" value="2:Staff Handbook" />
                                        <label for="rdbStaff" class="custom-control-label">Staff Handbook</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="communicated" type="radio" id="rdbTraining" class="custom-control-input" value="2:Training" />
                                        <label for="rdbTraining" class="custom-control-label">Training</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="communicated" type="radio" id="rdbOthers" class="custom-control-input" value="1:Other's" />
                                        <label for="rdbOthers" class="custom-control-label">Other's</label>
                                    </div>
                                    <span id="communicated" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ4" class="mb-4">4. Is the whistleblowing policy available to contractors/third parties?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="contractors" type="radio" id="rdbYes3" class="custom-control-input" value="2:Yes" data-error="#e4" required />
                                        <label for="rdbYes3" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="contractors" type="radio" id="rdbNo3" class="custom-control-input" value="1:No" />
                                        <label for="rdbNo3" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="contractors" type="radio" id="rdbDK3" class="custom-control-input" value="0.5:Don't Know" />
                                        <label for="rdbDK3" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="contractors" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12 mb-4">
                                    <p id="pQ5" class="mb-4">5. Are whistleblowers guaranteed confidentiality? </p>
                                    <div class="custom-control custom-radio">
                                        <input name="confidentiality" type="radio" id="rdbYes4" value="2:Yes" class="custom-control-input" data-error="#e4" required />
                                        <label for="rdbYes4" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="confidentiality" type="radio" id="rdbNo4" class="custom-control-input" value="0:No" />
                                        <label for="rdbNo4" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="confidentiality" type="radio" id="rdbDK4" class="custom-control-input" value="0.5:Don't Know" />
                                        <label for="rdbDK4" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="confidentiality" style="display: none">Please select value</span>
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
                                        <input name="champion" type="radio" id="rdbYes11" value="2:Yes" class="custom-control-input" data-error="#e4" required />
                                        <label for="rdbYes11" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="champion" type="radio" id="rdbNo11" value="0:No" class="custom-control-input" />
                                        <label for="rdbNo11" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="champion" type="radio" id="rdbDK11" value="1:Don't Know" class="custom-control-input" />
                                        <label for="rdbDK11" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="champion" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ7" class="mb-4">2. Are they contactable and do they have autonomy to act? </p>
                                    <div class="custom-control custom-radio">
                                        <input name="autonomy" type="radio" id="rdbYes22" value="2:Yes" data-error="#e4" class="custom-control-input" required />
                                        <label for="rdbYes22" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="autonomy" type="radio" id="rdbNo22" value="0:No" class="custom-control-input" />
                                        <label for="rdbNo22" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="autonomy" type="radio" id="rdbDK22" value="1:Don't Know" class="custom-control-input" />
                                        <label for="rdbDK22" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="autonomy" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ8" class="mb-4">3. Is the person(s) who reviews the whistleblowing reports trained and accredited?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="trained" type="radio" id="rdbYes33" value="2:Yes" data-error="#e4" class="custom-control-input" required />
                                        <label for="rdbYes33" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="trained" type="radio" id="rdbNo33" value="0:No" class="custom-control-input" />
                                        <label for="rdbNo33" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="trained" type="radio" id="rdbDK33" value="1:Don't Know" class="custom-control-input" />
                                        <label for="rdbDK33" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="trained" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ9" class="mb-4">4. Does your system provide regular feedback to the whistleblower?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="whistleblower" type="radio" id="rdbYes44" value="2:Yes" class="custom-control-input" data-error="#e4" required />
                                        <label for="rdbYes44" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="whistleblower" type="radio" id="rdbNo44" class="custom-control-input" value="0:No" />
                                        <label for="rdbNo44" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="whistleblower" type="radio" id="rdbDK44" class="custom-control-input" value="1:Don't Know" />
                                        <label for="rdbDK44" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="whistleblower" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12  mb-4">
                                    <p id="pQ10" class="mb-4">5. What information does the board receive?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="receive" type="radio" id="rdbNothing" value="0:Nothing" class="custom-control-input" data-error="#e4" />
                                        <label for="rdbNothing" class="custom-control-label">Nothing</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="receive" type="radio" id="rdbBare" value="1:Bare facts with no identifying data" class="custom-control-input" />
                                        <label for="rdbBare" class="custom-control-label">Bare facts with no identifying data</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="receive" type="radio" id="rdbTheySee" value="1:They see everything" class="custom-control-input" />
                                        <label for="rdbTheySee" class="custom-control-label">They see everything</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="receive" type="radio" id="rdbDK55" value="1:Don't Know" class="custom-control-input" />
                                        <label for="rdbDK55" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="receive" style="display: none">Please select value</span>
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
                                    <p id="pQ11" class="mb-4">1. Do staff feel safe to speak up?  </p>
                                    <%--<div class="left-griditem">--%>
                                    <div class="custom-control custom-radio">
                                        <input name="speak" type="radio" id="rdbRating1" value="2:Yes" data-error="#e4" class="custom-control-input" />
                                        <label for="rdbRating1" class="custom-control-label color_red1 ">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="speak" type="radio" id="rdbRating2" value="0:No" data-error="#e4" class="custom-control-input" />
                                        <label for="rdbRating2" class="custom-control-label color_red1">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="speak" type="radio" id="rdbRating3" value="1:Don't Know" data-error="#e4" class="custom-control-input" />
                                        <label for="rdbRating3" class="custom-control-label color_red1">Don't Know</label>
                                    </div>
                                    <%--<div class="custom-control custom-radio">
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
                                        </div>--%>
                                    <span id="speak" style="display: none">Please select value</span>
                                    <%--</div>--%>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ12" class="mb-4">2. Does your system accept and act on anonymous reports?  </p>
                                    <div class="custom-control custom-radio">
                                        <input name="anonymous" type="radio" id="rdbYes111" value="2:Yes" data-error="#e4" class="custom-control-input" />
                                        <label for="rdbYes111" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="anonymous" type="radio" id="rdbNo111" value="0:No" class="custom-control-input" />
                                        <label for="rdbNo111" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="anonymous" type="radio" id="rdbDK111" value="1:Don't Know" class="custom-control-input" />
                                        <label for="rdbDK111" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="anonymous" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ13" class="mb-4">3. Does your organisation have an anti-retaliation policy?</p>
                                    <div class="custom-control custom-radio">
                                        <input name="retaliation" type="radio" id="rdbYes222" value="2:Yes" class="custom-control-input" data-error="#e4" />
                                        <label for="rdbYes222" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="retaliation" type="radio" id="rdbNo222" value="0:No" class="custom-control-input" />
                                        <label for="rdbNo222" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="retaliation" type="radio" id="rdbDK222" value="1:Don't Know" class="custom-control-input" />
                                        <label for="rdbDK222" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="retaliation" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12 QuestionEnd">
                                    <p id="pQ14" class="mb-4">4. Does your organisation operate an independent whistleblower reporting platform? </p>
                                    <div class="custom-control custom-radio">
                                        <input name="independent" type="radio" id="rdbYes333" value="2:Yes" data-error="#e4" class="custom-control-input" />
                                        <label for="rdbYes333" class="custom-control-label">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="independent" type="radio" id="rdbNo333" value="0:No" class="custom-control-input" />
                                        <label for="rdbNo333" class="custom-control-label">No</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="independent" type="radio" id="rdbDK333" value="1:Don't Know" class="custom-control-input" />
                                        <label for="rdbDK333" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="independent" style="display: none">Please select value</span>
                                </div>
                                <div class="input-field col s12 mb-5">
                                    <p id="pQ15" class="mb-4">5. Would an external reporting platform encourage more people to speak up?  </p>
                                    <div class="custom-control custom-radio">
                                        <input name="encourage" type="radio" id="rdbDefinitely" value="2:Definitely" data-error="#e4" class="custom-control-input" />
                                        <label for="rdbDefinitely" class="custom-control-label">Definitely</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="encourage" type="radio" id="rdbPossibly" value="1:Possibly" class="custom-control-input" />
                                        <label for="rdbPossibly" class="custom-control-label">Possibly</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input name="encourage" type="radio" id="rdbNoTrust" value="0:Don't Know" class="custom-control-input" />
                                        <label for="rdbNoTrust" class="custom-control-label">Don't Know</label>
                                    </div>
                                    <span id="encourage" style="display: none">Please select value</span>
                                </div>

                                <div class="row">
                                    <div class="input-field col m6 s12">
                                        <%--<input type="button" class="btn btn-sm btn-block btn-primary" value="Submit" onclick="if (assesmentSectionValidation()) { AddNewAssesment(); }" id="btnSubmit" />--%>
                                        <input type="button" class="btn btn-sm btn-block btn-primary" value="Submit"  id="btnSubmit" />

                                    </div>
                                </div>
                            </div>
                            <div id="divSuccess" class="wrapperAlert" style="display: none">
                                <div class="contentAlert">
                                    <div class="topHalf">
                                        <p>
                                            <svg viewBox="0 0 512 512" width="100" title="check-circle">
                                                <path d="M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z" />
                                            </svg>
                                        </p>
                                        <h1>Thank You</h1>

                                        <ul class="bg-bubbles">
                                            <li></li>
                                            <li></li>
                                            <li></li>
                                            <li></li>
                                            <li></li>
                                            <li></li>
                                            <li></li>
                                            <li></li>
                                            <li></li>
                                            <li></li>
                                        </ul>
                                    </div>

                                    <div class="bottomHalf">

                                        <p>Thank you for submitting your Whistle blowing Assessment.  Your report is being generated and will be sent directly to your email address</p>
                                        <p>If you’d like to learn more,  let us know below so we can demonstrate how our expert people can accelerate compliant ethics in your organisation.  </p>

                                    </div>
                                    <div class="mb-4">

                                        <p>Do you need immediate assistance or help? Feel free to ask us any question regarding Whistleblowing using the link below</p>
                                        <textarea id="txtFeedback" class="form-control d-none" style="margin: 0 auto; width: 80%; border-radius: 20px" rows="2"></textarea>
                                        <button id="btnFeedback" class="d-none">Send</button>
                                    </div>
                                    <div class="mt-4 mb-4">
                                        <p class="mb-3 d-none">Alternative you can contact us via the link below</p>
                                        <a class="btn btn-primary" target="_blank" href="https://us20.list-manage.com/contact-form?form_id=51228940eb5bcfa9c6c804e27060996b&u=ae7e4e97017c498951b4403f6">
                                            <%--<button id="btnConytactUS">Contact Us</button>--%>Contact Us</a>
                                    </div>

                                    <div class="mb-5">
                                        <a target="_blank" href="Iblowthewhistle.com">
                                            <img src="/assets/images/logo-icon.png" alt="" class="logo-70 mr-md-3 mb-3 mb-md-0 img-fluid" /></a>
                                        <a target="_blank" href="https://www.wbuk.org/">
                                            <img src="/assets/images/logo-wbuk.png" alt="Whistleblowers UK" class="logo-70 mx-auto img-fluid" /></a>

                                    </div>

                                </div>

                            </div>

                            <div id="html-2-pdfwrapper" style="display: none;">
                                <div style="background-color: #ddd">
                                    <p style="margin-top: 30px;">
                                        <span style='color: rgba(0,0,0,0.37); font-size: 1.9rem; margin-top: 5px; text-align: center;'>Whistleblower Assessment Tool Report</span>
                                    </p>
                                    <p class="mt-1">
                                        <span style='color: red; font-size: 1.2rem; margin-top: 5px; text-align: center;'>Why Whistleblowing fosters a growing organisation</span>
                                    </p>
                                    <p class="mt-2">
                                        Whistleblowers are the board's best friend and it is a fact that organisations with the most whistleblower reports are the healthiest.
                                    </p>
                                    <p class="mt-2">
                                        One of the most effective ways of understanding the culture of your organization is to ask the staff (including the SMT and Board!), shareholders and stakeholders, and your clients for their opinions. The simplest best way to get them is to use an online assessment.
                                    </p>
                                    <p class="mt-2">
                                        An online assessment not only provides your organisation with vital information but done properly it promotes ethical behavior, compliance with the law, it also helps identify training needs and provides valuable feedback and information to the board.
                                    </p>
                                    <p class="mt-2">
                                        Whistleblowing is a term that most people recognise, but few actually understand, this might explain why it has attracted negative stereotyping reported in the press.
                                    </p>
                                    <p class="mt-2">
                                        Legislation around the world is universally complex and policies and procedures are often out of date or out of line with the law, poorly understood and rarely used until it is too late.
                                    </p>
                                    <p class="mt-2">
                                        This leads to misunderstandings and disruption in the workplace which can result in retaliation against the whistleblower, the suppression of compliance failures and increased risk to the wellbeing of the organisation and all concerned.
                                    </p>
                                    <p class="mt-2">
                                        Our assessment tool is a quick and reliable health check for your organisation giving you the knowledge to help you put in place measures that eliminate costly disciplinary action, litigation and fines and penalties that arise as a result of conflict with regulators.
                                    </p>
                                    <p class="mt-2">
                                        The Importance of Organisational Trust
                                    </p>
                                    <p class="mt-2">
                                        The world is transforming, people care about the way that organisations operate. The rise of 'ESG'* has shone a light on the importance of ethical practices to customers who are demanding ever greater transparency from the companies they do business with.
                                    Trust is a commodity that no organisation can afford to overlook.
                                    The rise of the internet and social media has put businesses under constant scrutiny from their staff, customers, employees, and shareholders.
                                    A strong culture of organisational trust can help a business weather these challenges and retain or increase its reputation for being open, honest, and reliable.
                                    However, organisational trust can be difficult to establish and maintain.
                                    Whistleblowers are the informed insiders who when taken seriously and protect your organisation from fraud and other crimes and ethical failures. They can be difficult to persuade to come forward because of the horror stories in the press but proper protection against retaliation will properly protect your company and your bottom line.
                                    Many organisations get the balance wrong and good intentions on both sides backfire resulting in the broken relationships and a universal break down of trust that can have crippling consequences
                                    </p>
                                </div>
                            </div>
                        </form>
                        <!--end of form-->
                        <div class="d-flex flex-center flex-wrap p-5 pb-0 align-items-end">
                            <div class="d-flex flex-center small">
                                <a href="https://iblowthewhistle.com/" class="text-uppercase text-muted font-weight-bold px-2">Home
                                </a>
                                <a href="https://iblowthewhistle.com/support/" class="text-uppercase text-muted font-weight-bold px-2">Support
                                </a>
                                <a href="https://www.wbuk.org/privacy-policy/" class="text-uppercase text-muted font-weight-bold px-2">Privacy
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
    <div id='recaptcha' class="g-recaptcha"
        data-sitekey="<%=Dev.Project.WhistleBlower.Web.Data.WhistleContants.googleCAPTCHAKey%>"
        data-callback="onSubmit"
        data-size="invisible">
    </div>
</body>
</html>
