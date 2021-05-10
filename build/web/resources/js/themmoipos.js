var select = document.getElementById("ngay_nhapkho");
for (var i = 1; i <= 31; i++) {
    select.options[select.options.length] = new Option(i, i);
}

var select = document.getElementById("thang_nhapkho");
for (var i = 1; i <= 12; i++) {
    select.options[select.options.length] = new Option(i, i);
}

var year = new Date();
var currentYear = year.getFullYear();
var select = document.getElementById("nam_nhapkho");
for (var i = currentYear; i >= 1900; i--) {
    select.options[select.options.length] = new Option(i, i);
}