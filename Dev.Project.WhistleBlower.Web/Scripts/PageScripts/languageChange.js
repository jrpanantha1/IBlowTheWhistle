$(document).ready(function () {

    if (sessionStorage.getItem("iBlowLanguage") != null) {
        $("#dropdownLanguage i").removeClass();
        var sLang = sessionStorage.getItem("iBlowLanguage").toString();

        if (sessionStorage.getItem("lngSelectedItemTick") != null) {
            $("#" + sessionStorage.getItem("lngSelectedItemTick")).addClass("selected-item");

        }
        switch (sLang) {

            case "1":
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                $("#dropdownLanguage").text("US");
                break;

            case "2":
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-th");
                $("#dropdownLanguage").text("TH");
                break;

            case "3":
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-fr");
                $("#dropdownLanguage").text("FR");
                break;

            case "4":
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-es");
                $("#dropdownLanguage").text("ES");
                break;

            case "5":
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ru");
                $("#dropdownLanguage").text("RU");
                break;

            case "6":
                // $("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                $("#dropdownLanguage").text("KZ");
                break;

            case "7":
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ar");
                $(".langDirection").css("direction", "rtl");
                $(".langDirection").css("text-align", "right");
                $(".titleSection").removeClass("text-center");
                $("#dropdownLanguage").text("AR");
                break;

            default:
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                $("#dropdownLanguage").text("US");
                break;

        }

    }
    else {
        $("#dropdownLanguage").text("US");
    }
    $(".ddlLanguage a").click(function () {

        var selectedLangClassName = $("#dropdownLanguage i").attr("class");
        $("#dropdownLanguage i").removeClass();
        var lanCode = 1;

        $(".ddlLanguage a").removeClass("selected-item");
        $(this).addClass("selected-item");

        switch ($(this).find("span").text()) {

            case "English":
                lanCode = 1;
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                $("#dropdownLanguage").text("US");
                break;

            case "Thai":
                lanCode = 2;
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-th");
                $("#dropdownLanguage").text("TH");
                break;

            case "French":
                lanCode = 3;
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-fr");
                $("#dropdownLanguage").text("FR");
                break;

            case "Spanish":
                lanCode = 4;
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-es");
                $("#dropdownLanguage").text("ES");
                break;

            case "Russian":
                lanCode = 5;
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ru");
                $("#dropdownLanguage").text("RU");
                break;

            case "Kazakh":
                lanCode = 6;
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                $("#dropdownLanguage").text("KZ");
                break;

            case "Arabic":
                lanCode = 7;
                //$(".langDirection").css("direction", "ltr");
                $(".langDirection").css("text-align", "left");

                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ar");
                $("#dropdownLanguage").text("AR");
                break;

            default:
                //$("#dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                $("#dropdownLanguage").text("US");
                break;

        }
        // sessionStorage.setItem("iBlowLanguage", $(this).find("span").text());
        sessionStorage.setItem("iBlowLanguage", lanCode);
        sessionStorage.setItem("lngSelectedItemTick", $(this).attr("id"));
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