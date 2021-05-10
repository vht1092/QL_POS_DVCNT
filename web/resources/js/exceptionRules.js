function keyPressWord(e)
{
    var keyword = null;
    if (window.event)
    {
        keyword = window.event.keyCode;
    } else
    {
        keyword = e.which; //NON IE;
    }

    if (keyword < 48 || keyword > 57)
    {
        if (keyword == 48 || keyword == 127)
        {
            return;
        }
        return false;
    }
}

function convert() {
    var res = "str.substr(0, 4)";
    document.getElementById("demo").innerHTML = res;
}

function change1() {
    document.getElementById("tid3").removeAttribute("disabled");
    document.getElementById("mid3").removeAttribute("disabled");
    document.getElementById("hanmucVnd").removeAttribute("disabled");
    document.getElementById("hanmucUsd").removeAttribute("disabled");
}

function xacnhan() {
    document.getElementById("_xacnhan").removeAttribute("hidden");
}

function removexacnhan() {
    document.getElementById("_xacnhan").setAttribute("hidden", "hidden");
}

function change2() {
    document.getElementById("tid3").setAttribute("disabled", "disabled");
    document.getElementById("mid3").setAttribute("disabled", "disabled");
    document.getElementById("hanmucVnd").setAttribute("disabled", "disabled");
    document.getElementById("hanmucUsd").setAttribute("disabled", "disabled");

    document.getElementById("tid3").value = "";
    document.getElementById("mid3").value = "";
    document.getElementById("hanmucVnd").value = "";
    document.getElementById("hanmucUsd").value = "";
}

function check_trung_tid() {
    var tid1 = document.getElementById("tid1").value;
    var tid2 = document.getElementById("tid2").value;
    var tid3 = document.getElementById("tid3").value;
    if (tid2 != "" && (tid2 == tid1 || tid2 == tid3)) {
        alert("TID không được trùng");
        document.getElementById("tid2").focus();
        return;
    }
    if (tid3 != "" && (tid3 == tid2 || tid3 == tid1)) {
        alert("TID không được trùng");
        document.getElementById("tid3").focus();
        return;
    }
}

function khongCoNganHangHopTac() {
    if (document.getElementById("text10").getAttribute("disabled") != "disabled") {
        document.getElementById("text10").setAttribute("disabled", "disabled");
    }
}

function coNganHangHopTac() {
    if (document.getElementById("text10").getAttribute("disabled") == "disabled") {
        document.getElementById("text10").removeAttribute("disabled", "disabled");
    }
}

function off_txtlandangky() {
    document.getElementById("_landk").setAttribute("disabled", "disabled");
}

function on_txtlandangky() {
    document.getElementById("_landk").removeAttribute("disabled", "disabled");
}

function change3() {
    if (document.getElementById("tienkyquyMoto").getAttribute("disabled") == "disabled") {
        document.getElementById("tienkyquyMoto").removeAttribute("disabled");

    } else {
        document.getElementById("tienkyquyMoto").setAttribute("disabled", "disabled");
        document.getElementById("tienkyquyMoto").value = "";
    }

    if (document.getElementById("hanmucVnd").getAttribute("disabled") == "disabled") {
        document.getElementById("hanmucVnd").removeAttribute("disabled");
    } else {
        document.getElementById("hanmucVnd").setAttribute("disabled", "disabled");
        document.getElementById("hanmucVnd").value = "";
    }

    if (document.getElementById("hanmucUsd").getAttribute("disabled") == "disabled") {
        document.getElementById("hanmucUsd").removeAttribute("disabled");

    } else {
        document.getElementById("hanmucUsd").setAttribute("disabled", "disabled");
        document.getElementById("hanmucUsd").value = "";
        document.getElementById("khongnhapCVC2").checked = false;
    }
}

function changeMotoLapThemPos() {
    if (document.getElementById("tienkyquyMoto").value != null) {
        document.getElementById("tienkyquyMoto").removeAttribute("disabled");

    } else {
        document.getElementById("tienkyquyMoto").setAttribute("disabled", "disabled");
        document.getElementById("tienkyquyMoto").value = "";
    }

    if (document.getElementById("hanmucVnd").getAttribute("disabled") == "disabled") {
        document.getElementById("hanmucVnd").removeAttribute("disabled");
    } else {
        document.getElementById("hanmucVnd").setAttribute("disabled", "disabled");
        document.getElementById("hanmucVnd").value = "";
    }

    if (document.getElementById("hanmucUsd").getAttribute("disabled") == "disabled") {
        document.getElementById("hanmucUsd").removeAttribute("disabled");

    } else {
        document.getElementById("hanmucUsd").setAttribute("disabled", "disabled");
        document.getElementById("hanmucUsd").value = "";
        document.getElementById("khongnhapCVC2").checked = false;
    }
}

function clearContent()
{
    document.getElementById("clear").setAttribute("disabled", "disabled");
    document.getElementById("note").style.color = "red";
    document.getElementById("thaydoi").style.backgroundColor = "white";
    document.getElementById("thaydoi").style.cursor = "none";
    document.getElementById("thaydoi").setAttribute("disabled", "disabled");
    document.getElementById("paxS90").removeAttribute("disabled");
    document.getElementById("paxS78").removeAttribute("disabled");
    document.getElementById("paxP70s").removeAttribute("disabled");
    document.getElementById("paxP80").removeAttribute("disabled");
    document.getElementById("pax78").removeAttribute("disabled");
    document.getElementById("vx520").removeAttribute("disabled");
}
function reset()
{
    document.getElementById("teninhoadon").value = "";
    document.getElementById("soTktgtt").value = "";
    document.getElementById("tenchutk").value = "";
    document.getElementById("diachiLapdat").value = "";
    document.getElementById("ghichu").value = "";
    document.getElementById("ghichu").value = "";
    document.getElementById("hanmucusd").value = "";
    document.getElementById("hanmucvnd").value = "";
    document.getElementById("tienkyquyMoto").value = "";
    document.getElementById("hanmucVnd").value = "";
    document.getElementById("hanmucUsd").value = "";
    document.getElementById("gddb1").removeAttribute("checked");
    document.getElementById("gddb2").removeAttribute("checked");
    document.getElementById("gddb3").removeAttribute("checked");
    document.getElementById("gddb4").removeAttribute("checked");
    document.getElementById("gddb5").removeAttribute("checked");
    document.getElementById("gddb6").removeAttribute("checked");
    document.getElementById("gddb7").removeAttribute("checked");
    document.getElementById("gddb8").removeAttribute("checked");
    document.getElementById("gddb9").removeAttribute("checked");
    document.getElementById("gd1").removeAttribute("checked");
}

function emtytxtSearch() {
    document.getElementById("txtsearch").value = "";
}

function format_curency(a) {
    a.value = a.value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
}

function kiemtraLonHon30tr() {
    var input = document.getElementById("doanhsothanhtoandukien").value;
    var _input = input.split(',').join('');
    var n = parseInt(_input);
    if (n < 30000000) {
        document.getElementById("alertFailValue").innerHTML = "Doanh số thanh toán dự kiến phải lớn hơn <b>30 triệu</b>";
    } else {
        document.getElementById("alertFailValue").innerHTML = "";
    }
}

function checkSoLuongPos_paxS90() {
    var slpos = document.getElementById("slpos").value;

    var check_paxS90 = document.getElementById("paxS90").checked;
    var check_paxS78 = document.getElementById("paxS78").checked;
    var check_paxP70s = document.getElementById("paxP70s").checked;

    var check_paxP80 = document.getElementById("paxP80").checked;
    var check_pax78 = document.getElementById("pax78").checked;
    var check_vx520 = document.getElementById("vx520").checked;

    var count = 0;

    if (check_paxS78 == true) {
        count++;
    }
    if (check_paxP70s == true) {
        count++;
    }
    if (check_paxP80 == true) {
        count++;
    }
    if (check_pax78 == true) {
        count++;
    }
    if (check_vx520 == true) {
        count++;
    }

    if (check_paxS90 == true) {
        count++;
        var thongbao = "Vui lòng chỉ chọn " + slpos + " dòng máy đề xuất !";

        if (slpos == "") {
            alert("Chưa nhập số lượng đăng ký lắp thêm !");
            document.getElementById("paxS90").checked = false;
            document.getElementById("slpos").focus();
        } else {
            if (count > slpos && slpos) {
                alert(thongbao);
                document.getElementById("paxS90").checked = false;
            }
        }
    }
}
function checkSoLuongPos_paxS78() {
    var slpos = document.getElementById("slpos").value;

    var check_paxS90 = document.getElementById("paxS90").checked;
    var check_paxS78 = document.getElementById("paxS78").checked;
    var check_paxP70s = document.getElementById("paxP70s").checked;

    var check_paxP80 = document.getElementById("paxP80").checked;
    var check_pax78 = document.getElementById("pax78").checked;
    var check_vx520 = document.getElementById("vx520").checked;

    var count = 0;

    if (check_paxS90 == true) {
        count++;
    }
    if (check_paxP70s == true) {
        count++;
    }
    if (check_paxP80 == true) {
        count++;
    }
    if (check_pax78 == true) {
        count++;
    }
    if (check_vx520 == true) {
        count++;
    }

    if (check_paxS78 == true) {
        count++;
        var thongbao = "Vui lòng chỉ chọn " + slpos + " dòng máy đề xuất !";

        if (slpos == "") {
            alert("Chưa nhập số lượng đăng ký lắp thêm !");
            document.getElementById("paxS78").checked = false;
            document.getElementById("slpos").focus();
        } else {
            if (count > slpos) {
                alert(thongbao);
                document.getElementById("paxS78").checked = false;
                status = 0;
            }
        }

    }
}
function checkSoLuongPos_paxP70s() {
    var slpos = document.getElementById("slpos").value;

    var check_paxS90 = document.getElementById("paxS90").checked;
    var check_paxS78 = document.getElementById("paxS78").checked;
    var check_paxP70s = document.getElementById("paxP70s").checked;

    var check_paxP80 = document.getElementById("paxP80").checked;
    var check_pax78 = document.getElementById("pax78").checked;
    var check_vx520 = document.getElementById("vx520").checked;

    var count = 0;

    if (check_paxS90 == true) {
        count++;
    }
    if (check_paxS78 == true) {
        count++;
    }
    if (check_paxP80 == true) {
        count++;
    }
    if (check_pax78 == true) {
        count++;
    }
    if (check_vx520 == true) {
        count++;
    }

    if (check_paxP70s == true) {
        count++;
        var thongbao = "Vui lòng chỉ chọn " + slpos + " dòng máy đề xuất !";

        if (slpos == "") {
            alert("Chưa nhập số lượng đăng ký lắp thêm !");
            document.getElementById("paxP70s").checked = false;
            document.getElementById("slpos").focus();
        } else {
            if (count > slpos) {
                alert(thongbao);
                document.getElementById("paxP70s").checked = false;
            }
        }

    }
}
function checkSoLuongPos_paxP80() {
    var slpos = document.getElementById("slpos").value;

    var check_paxS90 = document.getElementById("paxS90").checked;
    var check_paxS78 = document.getElementById("paxS78").checked;
    var check_paxP70s = document.getElementById("paxP70s").checked;

    var check_paxP80 = document.getElementById("paxP80").checked;
    var check_pax78 = document.getElementById("pax78").checked;
    var check_vx520 = document.getElementById("vx520").checked;

    var count = 0;

    if (check_paxS90 == true) {
        count++;
    }
    if (check_paxS78 == true) {
        count++;
    }
    if (check_paxP70s == true) {
        count++;
    }
    if (check_pax78 == true) {
        count++;
    }
    if (check_vx520 == true) {
        count++;
    }

    if (check_paxP80 == true) {
        count++;
        var thongbao = "Vui lòng chỉ chọn " + slpos + " dòng máy đề xuất !";

        if (slpos == "") {
            alert("Chưa nhập số lượng đăng ký lắp thêm !");
            document.getElementById("paxP80").checked = false;
            document.getElementById("slpos").focus();
        } else {
            if (count > slpos) {
                alert(thongbao);
                document.getElementById("paxP80").checked = false;
            }
        }

    }
}
function checkSoLuongPos_pax78() {
    var slpos = document.getElementById("slpos").value;

    var check_paxS90 = document.getElementById("paxS90").checked;
    var check_paxS78 = document.getElementById("paxS78").checked;
    var check_paxP70s = document.getElementById("paxP70s").checked;

    var check_paxP80 = document.getElementById("paxP80").checked;
    var check_pax78 = document.getElementById("pax78").checked;
    var check_vx520 = document.getElementById("vx520").checked;

    var count = 0;

    if (check_paxS90 == true) {
        count++;
    }
    if (check_paxS78 == true) {
        count++;
    }
    if (check_paxP70s == true) {
        count++;
    }
    if (check_paxP80 == true) {
        count++;
    }
    if (check_vx520 == true) {
        count++;
    }

    if (check_pax78 == true) {
        count++;
        var thongbao = "Vui lòng chỉ chọn " + slpos + " dòng máy đề xuất !";

        if (slpos == "") {
            alert("Chưa nhập số lượng đăng ký lắp thêm !");
            document.getElementById("pax78").checked = false;
            document.getElementById("slpos").focus();
        } else {
            if (count > slpos) {
                alert(thongbao);
                document.getElementById("pax78").checked = false;
            }
        }

    }
}
function checkSoLuongPos_vx520() {
    var slpos = document.getElementById("slpos").value;

    var check_paxS90 = document.getElementById("paxS90").checked;
    var check_paxS78 = document.getElementById("paxS78").checked;
    var check_paxP70s = document.getElementById("paxP70s").checked;

    var check_paxP80 = document.getElementById("paxP80").checked;
    var check_pax78 = document.getElementById("pax78").checked;
    var check_vx520 = document.getElementById("vx520").checked;

    var count = 0;

    if (check_paxS90 == true) {
        count++;
    }
    if (check_paxS78 == true) {
        count++;
    }
    if (check_paxP70s == true) {
        count++;
    }
    if (check_paxP80 == true) {
        count++;
    }
    if (check_pax78 == true) {
        count++;
    }

    if (check_vx520 == true) {
        count++;
        var thongbao = "Vui lòng chỉ chọn " + slpos + " dòng máy đề xuất !";


        if (slpos == "") {
            alert("Chưa nhập số lượng đăng ký lắp thêm !");
            document.getElementById("vx520").checked = false;
            document.getElementById("slpos").focus();
        } else {
            if (count > slpos) {
                alert(thongbao);
                document.getElementById("vx520").checked = false;
            }
        }

    }
}

function check_emtySlPos() {
//    var check_paxS90 = document.getElementById("paxS90").checked;
//    var check_paxS78 = document.getElementById("paxS78").checked;
//    var check_paxP70s = document.getElementById("paxP70s").checked;
//
//    var check_paxP80 = document.getElementById("paxP80").checked;
//    var check_pax78 = document.getElementById("pax78").checked;
//    var check_vx520 = document.getElementById("vx520").checked;

    var soluongPos = document.getElementById("slpos").value;

    if (soluongPos == null || soluongPos == "" || soluongPos <= 0) {
        alert("Số lượng máy lắp đặt không hợp lệ !");
        document.getElementById("slpos").focus();
    }

    var tenTheKhac = document.getElementById("text12").value;
    var phiTheKhac = document.getElementById("phiTheKhac").value;

    if (tenTheKhac != "" && phiTheKhac == "") {
        alert("Chưa nhập phí thẻ khác !");
        document.getElementById("phiTheKhac").focus();
    }
    if (tenTheKhac == "" && phiTheKhac != "") {
        alert("Chưa nhập tên thẻ khác !");
        document.getElementById("text12").focus();
    }
    var check_landangkyKhac = document.getElementById("_l2").checked;
    var check_solandangkyKhac = document.getElementById("_landk").value;

    if (check_landangkyKhac == true && check_solandangkyKhac == "") {
        alert("Chưa nhập số lần đăng ký !");
        document.getElementById("_landk").focus();
    }
}

function check_nganhanghoptac() {
    var check_CoNganHangHopTac = document.getElementById("no1").checked;
    var check_TenNganHangHopTac = document.getElementById("text10").value;

    if (check_CoNganHangHopTac == true && check_TenNganHangHopTac == "") {
        alert("Chưa nhập tên Ngân hàng hợp tác");
        document.getElementById("text10").focus();
    }
}

function check_landangky() {
    var check_landangkyKhac = document.getElementById("_l2").checked;
    var check_solandangkyKhac = document.getElementById("_landk").value;

    if (check_landangkyKhac == true && check_solandangkyKhac == "") {
        alert("Chưa nhập số lần đăng ký !");
        document.getElementById("_landk").focus();
    }
}

function same_thongtinnguoidaidien() {
    var tenNguoiDaiDien = document.getElementById("text4").value;
    document.getElementById("text7").value = tenNguoiDaiDien;

    var tenNguoiDaiDien = document.getElementById("text5").value;
    document.getElementById("text8").value = tenNguoiDaiDien;

    var tenNguoiDaiDien = document.getElementById("gpdkkdCmnd").value;
    document.getElementById("cmndHopdong").value = tenNguoiDaiDien;

    var tenNguoiDaiDien = document.getElementById("text6").value;
    document.getElementById("text9").value = tenNguoiDaiDien;

    var tenNguoiDaiDien = document.getElementById("ngaycap_cmndnguoidaidien").value;
    document.getElementById("ngaycap_cmndnguoikyhd").value = tenNguoiDaiDien;

    var tenNguoiDaiDien = document.getElementById("thangcap_cmndnguoidaidien").value;
    document.getElementById("thangcap_cmndnguoikyhd").value = tenNguoiDaiDien;

    var tenNguoiDaiDien = document.getElementById("namcap_cmndnguoidaidien").value;
    document.getElementById("namcap_cmndnguoikyhd").value = tenNguoiDaiDien;

}

function nhapTaySoThe() {
    var giaodichdatphong2 = document.getElementById("giaodichdatphong2").checked;
    var nhapTaySoThe2 = document.getElementById("nhapTaySoThe2").checked;
    var khongnhapCVC2 = document.getElementById("khongnhapCVC2").checked;
    var boQuaBuocNhapCVCPreAuth = document.getElementById("boQuaBuocNhapCVCPreAuth").checked;
    //document.getElementById("_gd2").checked = true;
    //alert("ABC");

    if (giaodichdatphong2 == false && nhapTaySoThe2 == false) {
        document.getElementById("giaodichdatphong2").checked = true;
    }

    if (khongnhapCVC2 == true && nhapTaySoThe2 == true) {
        document.getElementById("nhapTaySoThe2").checked = true;
    }

    if (boQuaBuocNhapCVCPreAuth == true) {
        document.getElementById("boQuaBuocNhapCVCPreAuth").checked = false;
    }
}

function giaodichdatphong() {
    var nhapTaySoThe2 = document.getElementById("nhapTaySoThe2").checked;
    var boQuaBuocNhapCVCPreAuth = document.getElementById("boQuaBuocNhapCVCPreAuth").checked;
    //document.getElementById("_gd2").checked = true;
    //alert("ABC");

    if (nhapTaySoThe2 == true) {
        document.getElementById("nhapTaySoThe2").checked = false;
    }
    if (boQuaBuocNhapCVCPreAuth == true) {
        document.getElementById("boQuaBuocNhapCVCPreAuth").checked = false;
    }

}

function khongnhapCVC() {
    var khongxuattrinhMoto2 = document.getElementById("khongxuattrinhMoto2").checked;
    if (khongxuattrinhMoto2 == false) {
        document.getElementById("khongxuattrinhMoto2").checked = true;
        document.getElementById("tienkyquyMoto").checked = true;
    }
}

function checkUpload() {
    var filename = document.getElementById("fileNameUploaded").value;

    if (filename != "") {
        alert(filename);
        document.getElementById("check_guiduyet").style.visibility = 'hidden'; //.setAttribute("visibility", "hidden");
        document.getElementById("guiduyet").style.visibility = 'visible';
    } else {
        alert("Chưa upload Hồ sơ pháp lý ĐVCNT !");
    }
}

function boQuaBuocNhapCVCPreAuth() {
    var giaodichdatphong2 = document.getElementById("giaodichdatphong2").checked;
    var nhapTaySoThe2 = document.getElementById("nhapTaySoThe2").checked;

    if (giaodichdatphong2 == false) {
        document.getElementById("giaodichdatphong2").checked = true;
    } else {
        //document.getElementById("giaodichdatphong2").checked = false;
    }
    //
    if (nhapTaySoThe2 == false) {
        document.getElementById("nhapTaySoThe2").checked = true;
    } else {
        //document.getElementById("nhapTaySoThe2").checked = false;
    }
}

function stopTab(e) {
    var evt = e || window.event
    if (evt.keyCode === 9) {
        return false
    }
}

function blockSpecialChar(e) {
    var k = e.keyCode;
    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57)
            || (k >= 44 && k <= 47));
}