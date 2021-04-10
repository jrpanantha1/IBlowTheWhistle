

function GetTextBoxEmptyValidation(elm) {
    var flag = true;
    if (elm.val() == null || elm.val() == "") {
        flag = false;
        elm.addClass('error');
    }
    else {
        elm.removeClass('error');
    }
    return flag;
}

function GetDropdownSelectedValidation(elm) {
    var flag = true;
    if (elm.val() == null || elm.val() == "Please select" || elm.val() == "") {
        flag = false;
        elm.addClass('error');
    }
    else {
        elm.removeClass('error');
    }
    return flag;
}

function GetCheckboxValidation(elm) {
    var flag = true;
    if (elm.val() == null || elm.prop('checked') == false) {
        flag = false;
        elm.addClass('error');
    }
    else {
        elm.removeClass('error');
    }
    return flag;
}
function GetCheckboxWithLabelValidation(elm, labelElm) {
    var flag = true;
    if (elm.val() == null || elm.prop('checked') == false) {
        flag = false;
        elm.addClass('error');
        labelElm.addClass('error');
    }
    else {
        elm.removeClass('error');
        labelElm.removeClass('error');
    }
    return flag;
}


function GetDropdownSelectedIndexValidation(elm) {
    var flag = true;
    if (elm.val() == null || elm.find(":selected").index() == 0 || elm.val() == "") {
        flag = false;
        elm.addClass('error');
    }
    else {
        elm.removeClass('error');
    }
    return flag;
}
function dropdownYesValidateText(elm, validateElm) {
    var flag = true;
    if (elm.find(":selected").index() == 1) {

        if (validateElm.val() == null || validateElm.val() == "") {
            flag = false;
            validateElm.addClass('error');
        }
        else {
            validateElm.removeClass('error');
        }

    }
    else {
        validateElm.removeClass('error');
        elm.removeClass('error');
    }
    return flag;
}
function dropdownYesValidateSelect(elm, validateElm) {
    var flag = true;
    if (elm.find(":selected").index() == 1) {

        if (validateElm.val() == null || validateElm.find(":selected").index() == 0 || validateElm.val() == "") {
            flag = false;
            validateElm.addClass('error');
        }
        else {
            validateElm.removeClass('error');
        }

    }
    else {
        validateElm.removeClass('error');
        elm.removeClass('error');
    }
    return flag;
}
function ValidateEmail(elm) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    var chkVal = re.test(String(elm.val()).toLowerCase())
    if (!chkVal) {
        flag = false;
        elm.addClass('error');
    }
    else {
        elm.removeClass('error');
    }
    return chkVal;
}

function ConfirmPassword(elm1, elm2) {
    var flag = true;

    if (elm1.val() != elm2.val()) {
        elm1.addClass('error');
        elm2.addClass('error');
        flag = false;
    }
    else {
        elm1.removeClass('error');
        elm2.removeClass('error');
    }

    return flag;
}


function CheckNull(obj) {

    var flag = true;
    if (obj == null || obj == 'null' || typeof obj === "undefined" || obj == "") {
        flag = false
    }

    return flag;
}
function getUrlVars() {
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1].replace(/#/, "");
    }

    return vars;
}