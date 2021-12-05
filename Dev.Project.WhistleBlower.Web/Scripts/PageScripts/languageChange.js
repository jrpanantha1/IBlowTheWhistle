$(document).ready(function () {

    getLanguageMaster();



    applyLangClickEvent();

});
function applyLangClickEvent() {
    $(".ddlLanguage a").click(function () {

        var selectedLangClassName = $(".dropdownLanguage i").attr("class");
        $(".dropdownLanguage i").removeClass();
        var lanCode = 1;

        $(".ddlLanguage a").removeClass("selected-item");
        $(this).addClass("selected-item");

        switch ($(this).find("span").text().trim()) {

            case "English":
                lanCode = 1;
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                $(".dropdownLanguage").text("EN");
                break;
            //Thai
            case "ไทย":
                lanCode = 2;
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-th");
                $(".dropdownLanguage").text("TH");
                break;
            //French
            case "Française":
                lanCode = 3;
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-fr");
                $(".dropdownLanguage").text("FR");
                break;
            //Spanish
            case "Espagnole":
                lanCode = 4;
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-es");
                $(".dropdownLanguage").text("ES");
                break;
            //Russian
            case "русский":
                lanCode = 5;
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ru");
                $(".dropdownLanguage").text("RU");
                break;
            //Kazakh
            case "Қазақ":
                lanCode = 6;
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                $(".dropdownLanguage").text("KZ");
                break;
            //Arabic
            case "عربى":
                lanCode = 7;
                //$(".langDirection").css("direction", "ltr");
                $(".langDirection").css("direction", "rtl");
                $(".langDirection").css("text-align", "left");

                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ar");
                $(".dropdownLanguage").text("AR");
                break;

            //Chinese
            case "中文":
                lanCode = 8;
                $(".dropdownLanguage").text("CN");
                break;

            //Hindi
            case "हिन्दी":
                lanCode = 9;
                $(".dropdownLanguage").text("HI");
                break;

            //Urdu
            case "اردو":
                lanCode = 10;
                $(".langDirection").css("direction", "rtl");
                $(".langDirection").css("text-align", "left");
                $(".dropdownLanguage").text("UR");
                break;

            //Malay
            case "Bahasa Melayu":
                lanCode = 11;
                $(".dropdownLanguage").text("MS");
                break;
            //Tamil
            case "தமிழ்":
                lanCode = 12;
                $(".dropdownLanguage").text("Ta");
                break;


            case "ಕನ್ನಡ":
                lanCode = 13;
                $(".dropdownLanguage").text("Kn");
                break;
            default:
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                lanCode = 1;
                $(".dropdownLanguage").text("EN");
                break;

        }
        // sessionStorage.setItem("iBlowLanguage", $(this).find("span").text());
        sessionStorage.setItem("iBlowLanguage", lanCode);
        sessionStorage.setItem("lngSelectedItemTick", $(this).attr("id"));

        localStorage.setItem("iBlowLanguage", lanCode);
        localStorage.setItem("lngSelectedItemTick", $(this).attr("id"));

        location.reload();

    });
}
function getLanguageMaster() {


    $.ajax({
        url: '/api/LanguageMasters',
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + sessionStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            constructLanguageDropdown(response);
        },
        error: function (response) {
            alert(response.responseText);
        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}

function constructLanguageDropdown(objLangMaster) {
    var langHtmlString = "";
    var langMasterCount = objLangMaster.length;
    $('.ddlLanguage').empty();
    for (var i = 0; i < langMasterCount; i++) {

        langHtmlString += '<a href="#"class="dropdown-item" id="lngID' + i + '" > <span>' + objLangMaster[i].DisplayText + '</span></a>';

    }

    $('.ddlLanguage').append(langHtmlString);
    applySelectedItemTick();
    applyLangClickEvent();

}

function applySelectedItemTick() {
    //var prefLanguage = $("#hdnPreferredLang").val();

    //if (prefLanguage != null && prefLanguage != "") {
    //    sessionStorage.setItem("iBlowLanguage", prefLanguage);
    //}
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        $(".dropdownLanguage i").removeClass();

        var sLang = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();

        if ((sessionStorage.getItem("lngSelectedItemTick") != null && sessionStorage.getItem("lngSelectedItemTick") != "") || localStorage.getItem("lngSelectedItemTick") != null) {
            var selctID = sessionStorage.getItem("lngSelectedItemTick") != null && sessionStorage.getItem("lngSelectedItemTick") != "" ? sessionStorage.getItem("lngSelectedItemTick") : localStorage.getItem("lngSelectedItemTick")
            $("#" + selctID).addClass("selected-item");

        }
        switch (sLang) {

            case "1":
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                $(".dropdownLanguage").text("EN");
                break;

            case "2":
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-th");
                $(".dropdownLanguage").text("TH");
                break;

            case "3":
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-fr");
                $(".dropdownLanguage").text("FR");
                break;

            case "4":
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-es");
                $(".dropdownLanguage").text("ES");
                break;

            case "5":
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ru");
                $(".dropdownLanguage").text("RU");
                break;

            case "6":
                // $(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                $(".dropdownLanguage").text("KZ");
                break;

            case "7":
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-ar");
                $(".langDirection").css("direction", "rtl");
                $(".langDirection").css("text-align", "right");
                $(".titleSection").removeClass("text-center");
                $(".dropdownLanguage").text("AR");
                break;

            case "8":
                // $(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                $(".dropdownLanguage").text("CN");
                break;

            case "9":
                // $(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                $(".dropdownLanguage").text("HI");
                break;

            case "10":
                // $(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                $(".langDirection").css("direction", "rtl");
                $(".langDirection").css("text-align", "right");
                $(".titleSection").removeClass("text-center");
                $(".dropdownLanguage").text("UR");
                break;

            case "11":
                // $(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                $(".dropdownLanguage").text("MS");
                break;
            case "12":
                // $(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                $(".dropdownLanguage").text("Ta");
                break;

            case "13":
                // $(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-kz");
                $(".dropdownLanguage").text("Kn");
                break;

            default:
                //$(".dropdownLanguage i").addClass("flag-icon flag-icon-squared flag-icon-us");
                $(".dropdownLanguage").text("EN");
                break;

        }

    }
    else {
        $(".dropdownLanguage").text("EN");
    }
}