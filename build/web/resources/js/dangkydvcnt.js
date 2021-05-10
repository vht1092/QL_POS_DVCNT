var select = document.getElementById("ngaycap_cmndnguoidaidien");
var select2 = document.getElementById("ngaycap_gpkd");
var select3 = document.getElementById("ngaycap_cmndnguoikyhd");
var select4 = document.getElementById("ngay_uyquyen");
var select5 = document.getElementById("ngay_thoigianlap");
for (var i = 1; i <= 31; i++) {
    select.options[select.options.length] = new Option(i, i);
    select2.options[select2.options.length] = new Option(i, i);
    select3.options[select3.options.length] = new Option(i, i);
    select4.options[select4.options.length] = new Option(i, i);
    select5.options[select5.options.length] = new Option(i, i);
}

var select = document.getElementById("thangcap_cmndnguoidaidien");
var select2 = document.getElementById("thangcap_gpkd");
var select3 = document.getElementById("thangcap_cmndnguoikyhd");
var select4 = document.getElementById("thang_uyquyen");
var select5 = document.getElementById("thang_thoigianlap");
for (var i = 1; i <= 12; i++) {
    select.options[select.options.length] = new Option(i, i);
    select2.options[select2.options.length] = new Option(i, i);
    select3.options[select3.options.length] = new Option(i, i);
    select4.options[select4.options.length] = new Option(i, i);
    select5.options[select5.options.length] = new Option(i, i);
}

var year = new Date();
var currentYear = year.getFullYear();
var select = document.getElementById("namcap_cmndnguoidaidien");
var select2 = document.getElementById("namcap_gpkd");
var select3 = document.getElementById("namcap_cmndnguoikyhd");
var select4 = document.getElementById("nam_uyquyen");
var select5 = document.getElementById("nam_thoigianlap");
for (var i = currentYear; i >= 1900; i--) {
    select.options[select.options.length] = new Option(i, i);
    select2.options[select2.options.length] = new Option(i, i);
    select3.options[select3.options.length] = new Option(i, i);
    select4.options[select4.options.length] = new Option(i, i);
    select5.options[select5.options.length] = new Option(i, i);
}