$(document).ready(function () {

    if (sessionStorage.getItem("iBlowLanguage") != null) {
        $("#dropdownLanguage i").removeClass();
        var sLang = sessionStorage.getItem("iBlowLanguage").toString();
        switch (sLang) {

            case "1":
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                break;

            case "2":
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-th");
                break;

            case "3":
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-fr");
                break;

            case "4":
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-es");
                break;

            case "5":
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ru");
                break;

            case "6":
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                break;

            case "7":
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ar");
                $(".langDirection").css("direction", "rtl");
                $(".langDirection").css("text-align", "right");
                $(".titleSection").removeClass("text-center");
                break;

            default:
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                break;

        }

    }
    $(".ddlLanguage a").click(function () {

        var selectedLangClassName = $("#dropdownLanguage i").attr("class");
        $("#dropdownLanguage i").removeClass();
        var lanCode = 1;


        switch ($(this).find("span").text()) {

            case "English":
                lanCode = 1;
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                break;

            case "Thai":
                lanCode = 2;
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-th");
                break;

            case "French":
                lanCode = 3;
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-fr");
                break;

            case "Spanish":
                lanCode = 4;
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-es");
                break;

            case "Russian":
                lanCode = 5;
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ru");
                break;

            case "Kazakh":
                lanCode = 6;
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                break;

            case "Arabic":
                lanCode = 7;
                $(".langDirection").css("direction", "ltr");
                $(".langDirection").css("text-align", "left");

                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ar");
                break;

            default:
                $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                break;

        }
        // sessionStorage.setItem("iBlowLanguage", $(this).find("span").text());
        sessionStorage.setItem("iBlowLanguage", lanCode);
        location.reload();

    });



});
function applyLanguageOnDemand(sLang) {
    $("#dropdownLanguage i").removeClass();
    switch (sLang) {

        case "English":
            $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
            break;

        case "Arabic":
            $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ar");
            break;

        default:
            $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
            break;

    }
}