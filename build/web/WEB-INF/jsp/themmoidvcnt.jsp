<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>THÊM ĐVCNT MỚI</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/themmoi.css"/>
    </head>
    <body>
    <center>
        <header>
            <ul class="breadcrumb">
                <li><a href="index.html">Trang chủ</a></li>
                <li>
                    <div class="dropdown">
                        <button class="dropbtn">Quản lý ĐVCNT</button>
                        <div class="dropdown-content">
                            <c:choose>
                                <c:when test="${groupuser == 1}">
                                    <a href="themmoidvcnt.html">Thêm ĐVCNT mới</a><br/>
                                </c:when>
                            </c:choose>
                            <a href="dvcntdangxuly.html">ĐVCNT đang xử lý</a><br/>
                            <c:choose>
                                <c:when test="${groupuser == 1 || groupuser == 2}">
                                    <a href="danhsachdvcnt1.html">ĐVCNT đã lắp đặt</a><br/>
                                </c:when>
                                <c:when test="${groupuser == 3 || groupuser == 4}">
                                    <a href="danhsachdvcnt2.html">ĐVCNT đã lắp đặt</a><br/>
                                </c:when>
                                <c:when test="${groupuser == 5 || groupuser == 6}">
                                    <a href="danhsachdvcnt3.html">ĐVCNT đã lắp đặt</a><br/>
                                </c:when>
                                <c:otherwise>
                                    <a href="danhsachdvcnt.html">ĐVCNT đã lắp đặt</a><br/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </li>
                <li>Thêm mới ĐVCNT</li>
            </ul>
            <center>
                <h2>ĐƠN VỊ CHẤP NHẬN THẺ MỚI
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> &nbsp;/&nbsp; ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <form action="${pageContext.request.contextPath}/xulythemmoidvcnt" method="post" name="frm">
        <center>
            <div class="content">
                <table style="width: 100%; height: auto">
                    <tr>
                        <th colspan="4">THÔNG TIN ĐVCNT</th>
                    </tr>
                    <c:choose>
                        <c:when test="${success != null}">
                            <tr>
                                <td colspan="4" class="successAddPos"><center>${success}</center></td>
                            </tr>
                        </c:when>
                    </c:choose>
                    <tr>
                        <td colspan="2">Tên đơn vị đăng ký kinh doanh (*)</td>
                        <td colspan="2">Tên tiếng Anh</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input name="tenDvcntVn" onkeypress="return blockSpecialChar(event)" maxlength="40" id="text1" onblur="caps(this.id)" value="" autofocus="" size="60" required="required"/>
                        </td>
                        <td colspan="2">
                            <input name="tenDvcntEn" onkeypress="return blockSpecialChar(event)" maxlength="40" id="text2" onblur="caps(this.id)" value="" size="60"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Địa chỉ (*)</td>
                        <td colspan="2">Điện thoại</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input name="diaChiDvcnt" maxlength="100" onkeypress="return blockSpecialChar(event)" id="text3" onblur="caps(this.id)" value="" size="60" required="required"/>
                        </td>
                        <td colspan="2">
                            <input name="sdtDvcnt" maxlength="20" value="" onkeypress="return keyPressWord(event);"/>
                        </td>
                    </tr>

                    <tr>
                        <td>Giấy phép ĐKKD số (*)</td>
                        <td>Ngày cấp(dd/mm/yyyy)</td>
                        <td>Nơi cấp (*)</td>
                        <td>Mã số thuế (*)</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="gpdkkdso" maxlength="50" onkeypress="return blockSpecialChar(event)" value="" required="required"/>
                        </td>
                        <td>
                            <select name="ngaycap_gpkd" value="" id="ngaycap_gpkd"></select>
                            <select name="thangcap_gpkd" value="" id="thangcap_gpkd"></select>
                            <select name="namcap_gpkd" value="" id="namcap_gpkd"></select>
                        </td>
                        <td>
                            <input name="gpdkkdNoicap" maxlength="20" onkeypress="return blockSpecialChar(event)" id="textLower" onblur="caps(this.id)" value="" required="required"/>
                        </td>
                        <td>
                            <input name="masothue" maxlength="20" value="" onkeypress="return keyPressWord(event);" required="required"/>
                        </td>
                    </tr>

                    <tr>
                        <td>Người đại diện theo pháp luật trên GPĐKKD (*)</td>
                        <td colspan="3">Chức vụ (*)</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="gpdkkdTennguoidaidien" maxlength="50" onkeypress="return blockSpecialChar(event)" id="text4" onblur="caps(this.id)" value="" required="required"/>
                        </td>
                        <td colspan="3">
                            <input name="gpdkkdChucvu" maxlength="20" onkeypress="return blockSpecialChar(event)" id="text5" onblur="caps(this.id)" value="" required="required"/>
                        </td>
                    </tr>
                    <tr>
                        <td>CMND/ Thẻ căn cước / Hộ Chiếu (*)</td>
                        <td>Ngày cấp(dd/mm/yyyy)</td>
                        <td colspan="2">Nơi cấp (*)</td>

                    </tr>

                    <tr>
                        <td>
                            <input name="gpdkkdCmnd" maxlength="20" id="gpdkkdCmnd" value="" required="required"/>
                        </td>
                        <td>
                            <select name="ngaycap_cmndnguoidaidien" value="" id="ngaycap_cmndnguoidaidien"></select>
                            <select name="thangcap_cmndnguoidaidien" value="" id="thangcap_cmndnguoidaidien"></select>
                            <select name="namcap_cmndnguoidaidien" value="" id="namcap_cmndnguoidaidien"></select>
                        </td>
                        <td colspan="2">
                            <input name="gpdkkdNoicapCmnd" maxlength="20" onkeypress="return blockSpecialChar(event)" id="text6" onblur="caps(this.id)"  value="" required="required"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Người đại diện ký kết hợp đồng ĐVCNT (*)</td>
                        <td colspan="3">Chức vụ (*)</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="tennguoiKyhopdong" maxlength="50" onkeypress="return blockSpecialChar(event)" id="text7" onblur="caps(this.id)"  value="" required="required"/>
                            <span class="Copy_thongtinnguoidaidien" style="" onclick="same_thongtinnguoidaidien()">Copy</span>
                        </td>
                        <td colspan="3">
                            <input name="chucvuHopdong" maxlength="20" id="text8" onkeypress="return blockSpecialChar(event)" onblur="caps(this.id)"  value="" required="required"/>
                        </td>
                    </tr>
                    <tr>
                        <td>CMND/ Thẻ căn cước / Hộ Chiếu (*)</td>
                        <td>Ngày cấp(dd/mm/yyyy)</td>
                        <td>Nơi cấp (*)</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="cmndHopdong" maxlength="20" id="cmndHopdong" value="" required="required"/>
                        </td>
                        <td>
                            <select name="ngaycap_cmndnguoikyhd" value="" id="ngaycap_cmndnguoikyhd"></select>
                            <select name="thangcap_cmndnguoikyhd" value="" id="thangcap_cmndnguoikyhd"></select>
                            <select name="namcap_cmndnguoikyhd" value="" id="namcap_cmndnguoikyhd"></select>
                        </td>
                        <td>
                            <input name="noicapCmndHopdong" maxlength="20" onkeypress="return blockSpecialChar(event)" id="text9" onblur="caps(this.id)"  value="" required="required"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Theo ủy quyền số(nếu có)</td>
                        <td colspan="3">Ngày ủy quyền(dd/mm/yyyy)</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="soUyquyen" maxlength="20" onkeypress="return blockSpecialChar(event)" value=""/>
                        </td>
                        <td colspan="3">
                            <select name="ngay_uyquyen" value="" id="ngay_uyquyen"></select>
                            <select name="thang_uyquyen" value="" id="thang_uyquyen"></select>
                            <select name="nam_uyquyen" value="" id="nam_uyquyen"></select>
                        </td>
                    </tr>

                    <tr>
                        <td>Đang hợp tác với ngân hàng khác</td>
                        <td>
                            <input name="_nganhangHoptac" onclick="khongCoNganHangHopTac()" checked="checked" value=" " id="no" type="radio"/>
                            <label for="no" onclick="khongCoNganHangHopTac()"><span></span>Không</label>
                        </td>
                        <td colspan="2">
                            <input name="_nganhangHoptac" onkeydown="return stopTab(event);" onclick="coNganHangHopTac()" value=" " id="no1" type="radio"/>
                            <label for="no1" onclick="coNganHangHopTac()"><span></span>Có (ghi rõ)</label>
                            <input name="_coNganHangHoptac" maxlength="50" onkeydown="return stopTab(event);" onkeypress="return blockSpecialChar(event)" disabled="disabled" id="text10" onblur="caps(this.id)"  value="" size="39"/>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>Loại hình ĐVCNT</td>                        
                        <td>
                            <input name="loaiDoanhNghiep" value="KHDN" id="tochuc" type="radio"  checked="checked"/>
                            <label for="tochuc"><span></span>Tổ chức</label>
                        </td>
                        <td colspan="2">
                            <input name="loaiDoanhNghiep" value="KHCN" id="hokinhdoanh" type="radio"/>
                            <label for="hokinhdoanh"><span></span>Hộ kinh doanh cá thể</label>
                        </td>
                    </tr>

                    <tr style="visibility: hidden">
                        <td>Loại hình ĐVCNT</td>                        
                        <td>
                            <input name="loaihinhDvcnt" value="2" id="tochuc" type="radio"  checked="checked"/>
                            <label for="tochuc"><span></span>Tổ chức</label>
                        </td>
                        <td colspan="2">
                            <input name="loaihinhDvcnt" value="1" id="hokinhdoanh" type="radio" disabled/>
                            <label for="hokinhdoanh"><span></span>Hộ kinh doanh cá thể</label>
                        </td>
                    </tr>

                    <tr>
                        <th colspan="4">
                            KẾT QUẢ KHẢO SÁT
                        </th>
                    </tr>

                    <tr>
                        <td>Ngành nghề kinh doanh (*)</td>
                        <td colspan="3">Doanh số thanh toán thẻ dự kiến theo tháng (VNĐ/máy*)</td>
                    </tr>
                    <tr>
                        <td>
                            <select name="nganhnghekd" maxlength="50" onkeypress="return blockSpecialChar(event)" onblur="caps(this.id)" required="required">
                                <option value=""></option>
                                <option value="Airlines">Hàng không</option>
                                <option value="Amusement and Entertainment">Giải trí</option>
                                <option value="Automobiles and Vehicles">Ô tô và phương tiện</option>
                                <option value="Business Services">Dịch vụ kinh doanh</option>
                                <option value="Clothing Stores">Cửa hàng quần áo</option>
                                <option value="Contracted Services">Dịch vụ ký hợp đồng</option>
                                <option value="Government Services">Dịch vụ chính phủ</option>
                                <option value="Hotels and Motels">Khách sạn và nhà nghỉ</option>
                                <option value="Mail Order/Telephone Order Providers">Đặt hàng qua thư/NCC đặt hàng qua ĐT</option>
                                <option value="Miscellaneous Stores">Cửa hàng linh tinh</option>
                                <option value="Personal Service Providers">Nhà cung cấp dịch vụ cá nhân</option>
                                <option value="Professional Services and Membership Organizations">Dịch vụ chuyên nghiệp và tổ chức thành viên</option>
                                <option value="Repair Services">Dịch vụ sửa chữa</option>
                                <option value="Retail Stores">Cửa hàng bán lẻ</option>
                                <option value="Service Providers">Nhà cung cấp dịch vụ</option>
                                <option value="Transportation">Giao thông vận tải</option>
                                <option value="Utilities">Tiện ích</option>
                                <option value="Wholesale Distributors and Manufacturers">Nhà phân phối và nhà sản xuất</option>
                                <option value="Restaurant-Food Service">Nhà hàng-Dịch vụ ăn uống</option>
                                <option value="Other">Khác</option>
                            </select>
                        </td>
                        <td  colspan="3">
                            <input onChange="format_curency(this);" onclick="return IsEmptyz();" onkeypress="return keyPressWord(event);" name="_doanhsothanhtoandukien" id="doanhsothanhtoandukien" required="required" value="" size="30"/>
                            <span style="color: red" id="alertFailValue"></span>
                        </td>
                    </tr>
                    <script language="Javascript">
                        function IsEmpty() {
                            if (document.forms['frm']._doanhsothanhtoandukien.value < 30000000)
                            {
                                alert("Doanh số dự kiến phải lớn hơn 30 triệu");
                                document.getElementById("phuocedit_doanhsothanhtoandukien").focus();
                                return false;
                            }
                            return true;
                        }
                    </script>
                    <tr>
                        <td>Xếp loại theo kết quả khảo sát</td>
                        <td>
                            <input onclick="kiemtraLonHon30tr()" checked="checked" name="xeploai" value="A" id="x1" type="radio"/>
                            <label for="x1"><span></span>Loại A</label>&nbsp;&nbsp;
                        </td>
                        <td>
                            <input onclick="kiemtraLonHon30tr()" name="xeploai" value="B" id="x2" type="radio"/>
                            <label for="x2"><span></span>Loại B</label>&nbsp;&nbsp;
                        </td>
                        <td>
                            <input onclick="kiemtraLonHon30tr()" name="xeploai" value="C" id="x3" type="radio"/>
                            <label for="x3"><span></span>Loại C</label>
                        </td>
                    </tr>
                    <tr>
                        <td>Số lần lắp POS: </td>
                        <td>
                            <input name="landk" onclick="off_txtlandangky()" checked="checked" value="1" id="l1" type="radio"/>
                            <label for="l1" onclick="off_txtlandangky()"><span></span>Lần 01</label>
                        </td>
                        <td>
                            <input name="landk" onclick="off_txtlandangky()" value="2" id="l2" type="radio"/>
                            <label for="l2" onclick="off_txtlandangky()"><span></span>Lần 02</label>
                        </td>
                        <td>
                            <input name="landk" onclick="on_txtlandangky()" value="3" id="_l2" type="radio"/>
                            <label for="_l2" onclick="on_txtlandangky()"><span></span>Khác(ghi rõ)</label>
                            <input name="_landk" disabled="disabled" id="_landk" value="" maxlength="2" size="5" onkeypress="return keyPressWord(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="4">
                            SỐ LƯỢNG MÁY ĐĂNG KÝ LẮP ĐẶT
                        </th>
                    </tr>
                    <tr>
                        <td colspan="4">
                            Số lượng máy POS cần lắp thêm (*): 
                            <input name="slpos" id="slpos" onclick="check_landangky()" size="5" required="required" maxlength="3" onkeypress="return keyPressWord(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="4">
                            LOẠI THẺ CHẤP NHẬN THANH TOÁN & PHÍ CHIẾT KHẤU <i>(Đơn vị: % - Đã bao gồm VAT)</i>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <label for="t8"><span></span>Thẻ khác(nếu có)</label>
                        </td>
                        <td>
                            <label for="t8"><span></span>Tên</label>
                            <input name="tenThekhac" maxlength="50" onkeypress="return blockSpecialChar(event)" onkeydown="return stopTab(event);" id="text12" onblur="caps(this.id)"  value="" placeholder="Nhập tên thẻ"/>
                        </td>
                        <td colspan="2">
                            <span>Phí: </span>
                            <input min="0" step="0.01" onkeydown="return stopTab(event);" id="phiTheKhac" onkeypress="return isFloatNumber(this, event)" data-number-to-fixed="2" data-number-stepfactor="100" name="phiThekhac" value="" placeholder="Phí thẻ"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t1"><span></span>Thẻ ghi nợ nội địa SCB (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t1"><span></span>Phí: </label>
                            <input name="phiGhinoscb" onclick="check_emtySlPos()" onkeypress="return isFloatNumber(this, event)" required="required" value="" placeholder="Phí ghi nợ nội địa SCB"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t2"><span></span>Thẻ ghi nợ nội địa liên minh (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t2"><span></span>Phí: </label>
                            <input name="phiGhinoLienminh" onclick="check_emtySlPos()" onkeypress="return isFloatNumber(this, event)" required="required" value="" placeholder="Phí ghi nợ nội địa liên minh"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t3"><span></span>Thẻ MC/VS phát hành trong nước (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t3"><span></span>Phí: </label>
                            <input name="phiVisa" onclick="check_emtySlPos()" onkeypress="return isFloatNumber(this, event)" required="required" value="" placeholder="Phí VISA"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t4"><span></span>Thẻ MC/VS phát hành nước ngoài (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t4"><span></span>Phí: </label>
                            <input name="phiMastercard" onclick="check_emtySlPos()" onkeypress="return isFloatNumber(this, event)" required="required" value="" placeholder="Phí Mastercard"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t5"><span></span>Thẻ JCB (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t5"><span></span>Phí: </label>
                            <input name="phiJcb" onclick="check_emtySlPos()" onkeypress="return isFloatNumber(this, event)" required="required" value="" placeholder="Phí JCB"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t6"><span></span>Thẻ CUP (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t6"><span></span>Phí: </label>
                            <input name="phiCup" onkeypress="return isFloatNumber(this, event)" required="required" value="" placeholder="Phí CUP"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t7"><span></span>Thẻ Discover</label>
                        </td>
                        <td colspan="3">
                            <label for="t7"><span></span>Phí: </label>
                            <input name="phiDiscover" onkeypress="return isFloatNumber(this, event)" required="required" value="" placeholder="Phí Discover"/>
                        </td>
                    </tr>

                    <tr>
                        <th colspan="4">
                            ĐỒNG TIỀN THANH TOÁN
                        </th>
                    </tr>
                    <tr>
                        <td> 
                            <input name="loaitien" value="VND" type="radio" id="vnd" checked="checked"/>
                            <label for="vnd"><span></span>Đồng Việt Nam(VNĐ)</label>
                        </td>
                        <td>
                            <input name="loaitien" value="USD" type="radio" id="usd"/>
                            <label for="usd"><span></span>Đô la Mỹ(USD)</label>
                        </td>
                        <td colspan="2">
                            <input name="loaitien" value="VND/USD" type="radio" id="vndusd"/>
                            <label for="vndusd"><span></span>VNĐ và USD</label>
                        </td>
                    </tr>  
                    <tr>
                        <th colspan="4">
                            THÔNG TIN KHÁC
                        </th>
                    </tr>
                    <tr>
                        <td> 
                            Quan hệ khách hàng
                        </td>
                        <td>
                            Thời gian lắp đặt dự kiến
                        </td>
                        <td colspan="2">

                        </td>
                    </tr>
                    <tr>
                        <td> 
                            <select name="loaiKhachHang">
                                <option value="KH TIEN GUI">KH tiền gửi</option>
                                <option value="KH TIEN VAY">KH tiền vay</option>
                                <option value="KH BAO HIEM">KH bảo hiểm</option>
                                <option value="KH KHAC">KH khác</option>
                            </select>
                        </td>
                        <td>
                            <select name="ngay_thoigianlap" value="" id="ngay_thoigianlap"></select>
                            <select name="thang_thoigianlap" value="" id="thang_thoigianlap"></select>
                            <select name="nam_thoigianlap" value="" id="nam_thoigianlap"></select>
                        </td>
                        <td colspan="2">

                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <input id="submitTaoMoiDvcnt" type="submit" value="LƯU THÔNG TIN" class="submit"/>
                        </td>
                    </tr>
                </table>
            </div>
        </center>
    </form>

    <footer>
        <center>

            <h4><a href="index.html"><i class="fa fa-home"></i>Trở về trang chủ</a></h5>
                <span>-------------------------------------------------</span>
                <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
        </center>
    </footer>

    <script>

        function caps(id) {
            document.getElementById(id).value = document.getElementById(id).value.toUpperCase();
        }

        function isFloatNumber(item, evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 44)// sử dụng dấu phẩy để ngăn phần thập phân
            {
                var regex = new RegExp(/\./g)
                var count = $(item).val().match(regex).length;
                if (count > 1)
                {
                    return false;
                }
            }
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>
    <script src="<%=request.getContextPath()%>/resources/js/dangkydvcnt.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/jquery-1.8.3.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>   

</body>
</html>
