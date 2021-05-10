<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: white">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>CHỈNH SỬA LẮP ĐẶT POS</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/themmoi.css"/>
    </head>
    <body>
    <center>
        <header class="header-lapdatpos">
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
                <li>Thông tin lắp POS</li>
            </ul>
            <center>
                <h2>CHỈNH SỬA THÔNG TIN LẮP ĐẶT POS
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> / ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <form action="${pageContext.request.contextPath}/xulychinhsuathongtinlapdat" method="get">
        <center>
            <div class="content-pos" style="height: 700px">
                <table style="width: 100%; height: auto;">
                    <tr>
                        <td colspan="2">Mã ĐVCNT</td>
                        <td colspan="2">
                            Tên ĐVCNT
                            <p id="clear" onclick="reset()" class="reset" style="float: right; font-size: 12px; border-radius: 4px; cursor: pointer; font-weight: bold; background-color: #F5F5F5; padding: 4px; color: gray">Reset</p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input name="maDvcnt" value="${_id}" size="10" readonly="readonly"/>
                            <input style="border: 0x white; color: white" name="id_edit" value="${_idedit}" size="5" hidden="hidden"/>
                        </td>
                        <td colspan="2">
                            <input name="tenDvcnt" value="${tendvcnt}" readonly="readonly"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Loại máy</td>
                        <td colspan="2">Tên in trên hóa đơn</td>
                    </tr>                    
                    <tr>
                        <td colspan="2">                    
                            <select name="dongmay">
                                <c:choose>
                                    <c:when test="${_dongmay == 'PAX_S90'}">
                                        <option value="PAX_S90" selected="selected">PAX S90</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_S90">PAX S90</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${_dongmay == 'PAX_S78'}">
                                        <option value="PAX_S78" selected="selected">PAX S78</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_S78">PAX S78</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${_dongmay == 'PAX_P70S'}">
                                        <option value="PAX_P70S" selected="selected">PAX P70-S</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_P70S">PAX P70-S</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${_dongmay == 'PAX_P80'}">
                                        <option value="PAX_P80" selected="selected">PAX P80</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_P80">PAX P80</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${_dongmay == 'PAX_78'}">
                                        <option value="PAX_78" selected="selected">PAX 78</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_78">PAX 78</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${_dongmay == 'VX520'}">
                                        <option value="VX520" selected="selected">VX520</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="VX520">VX520</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${_teninhoadon != ''}">
                                    <input name="teninhoadon" onblur="caps(this.id)" required="required" value="${_teninhoadon}" id="teninhoadon" maxlength="22"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="teninhoadon" onblur="caps(this.id)" required="required" value="" id="teninhoadon" maxlength="22"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Số TK TGTT báo có:</td>
                        <td colspan="2">Tên chủ TK</td>
                    </tr>
                    <tr>
                        <td colspan="2"> 
                            <c:choose>
                                <c:when test="${_soTktgtt != ''}">
                                    <input name="soTktgtt" value="${_soTktgtt}" id="soTktgtt" maxlength="16" onkeypress="return keyPressWord(event);"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="soTktgtt" id="soTktgtt" maxlength="16" onkeypress="return keyPressWord(event);"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${_tenchutk != ''}">
                                    <input name="tenchutk" onblur="caps(this.id)" required="required" value="${_tenchutk}" id="tenchutk" maxlength="50"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="tenchutk" onblur="caps(this.id)" required="required" id="tenchutk" maxlength="50"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">Địa chỉ lắp đặt</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${_diachiLapdat != ''}">
                                    <input name="diachiLapdat" onblur="caps(this.id)" value="${_diachiLapdat}" id="diachiLapdat" maxlength="44" size="40"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="diachiLapdat" onblur="caps(this.id)" id="diachiLapdat" value="" maxlength="44" size="44"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td colspan="2">
                            <select name="tenNganhNghe" required style="width: 312px">
                                <c:choose>
                                    <c:when test="${tenNganhNghe == ''}">
                                        <option value="" selected></option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value=""></option>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${tenNganhNghe == 'A'}">
                                        <option value="A" selected>A - ĂN UỐNG (bao gồm quán ăn nhà hàng, quán nước , cafe trà sữa..)</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="A">A - ĂN UỐNG (bao gồm quán ăn nhà hàng, quán nước , cafe trà sữa..)</option>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${tenNganhNghe == 'B'}">
                                        <option value="B" selected>B - THỜI TRANG (bao gồm kinh doanh quần áo, giày dép, phụ kiện hóa mỹ phẩm….)</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="B">B - THỜI TRANG (bao gồm kinh doanh quần áo, giày dép, phụ kiện hóa mỹ phẩm….)</option>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${tenNganhNghe == 'C'}">
                                        <option value="C" selected>C - TRUNG TÂM THƯƠNG MẠI, SIÊU THỊ (bao gồm cửa hàng, tạp hóa mini, siêu thị nội thất…)</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="C">C - TRUNG TÂM THƯƠNG MẠI, SIÊU THỊ (bao gồm cửa hàng, tạp hóa mini, siêu thị nội thất…)</option>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${tenNganhNghe == 'D'}">
                                        <option value="D" selected>D - KHÁCH SẠN ( bao gồm nhà nghỉ, Motel, khách sạn, resort, kinh doanh nhà trọ bất động sản…)</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="D">D - KHÁCH SẠN ( bao gồm nhà nghỉ, Motel, khách sạn, resort, kinh doanh nhà trọ bất động sản…)</option>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${tenNganhNghe == 'E'}">
                                        <option value="E" selected>E - DU LỊCH ( bao gồm dịch vụ liên quan đến du lịch như cty du lịch, bán vé máy bay...)</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="E">E - DU LỊCH ( bao gồm dịch vụ liên quan đến du lịch như cty du lịch, bán vé máy bay...)</option>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${tenNganhNghe == 'F'}">
                                        <option value="F" selected>F - KHÁC</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="F">F - KHÁC</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">Ghi chú</td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${_ghiChu != ''}">
                                    <input name="ghichu" onblur="caps(this.id)" value="${_ghiChu}" id="ghichu" size="80" maxlength="200"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="ghichu" onblur="caps(this.id)" value="" id="ghichu" size="80" maxlength="200"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <th colspan="4">
                        ĐĂNG KÝ GIAO DỊCH ĐẶC BIỆT
                    </th>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb1 == 1}">
                                    <input name="gddb1" value="1" checked="checked" type="checkbox" />
                                    <label for="khongxuattrinhMoto1"><span></span>Giao dịch không xuất trình thẻ (MOTO) (**)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb1" value="1" type="checkbox" />
                                    <label for="khongxuattrinhMoto2"><span></span>Giao dịch không xuất trình thẻ (MOTO) (**)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb2 == 1}">
                                    <input name="gddb2" value="1" checked="checked" onclick="giaodichdatphong()" type="checkbox" id="giaodichdatphong1"/>
                                    <label for="giaodichdatphong1" onclick="giaodichdatphong()"><span></span>Giao dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb2" value="1" onclick="giaodichdatphong()" type="checkbox" id="giaodichdatphong2"/>
                                    <label for="giaodichdatphong2" onclick="giaodichdatphong()"><span></span>Giao dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb3 == 1}">
                                    <input name="gddb3" checked="checked" value="1" type="checkbox" id="gd3"/>
                                    <label for="gd3"><span></span>Giao dịch Điều chỉnh (Adjust) (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb3" value="1" type="checkbox" id="gd3"/>
                                    <label for="gd3"><span></span>Giao dịch Điều chỉnh (Adjust) (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb4 == 1}">
                                    <input name="gddb4"  checked="checked" value="1" type="checkbox" id="gd4"/>
                                    <label for="gd4"><span></span>Giao dịch Ngoại tuyến (OFFLINE) (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb4" value="1" type="checkbox" id="gd4"/>
                                    <label for="gd4"><span></span>Giao dịch Ngoại tuyến (OFFLINE) (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb5 == 1}">
                                    <input checked="checked" name="gddb5" value="1" type="checkbox" id="gd5"/>
                                    <label for="gd5"><span></span>Chức năng nhập tiền TIP</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb5" value="1" type="checkbox" id="gd5"/>
                                    <label for="gd5"><span></span>Chức năng nhập tiền TIP</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb6 == 1}">
                                    <input name="gddb6" checked="checked" value="1" type="checkbox" id="gd6"/>
                                    <label for="gd6"><span></span>Giao dịch thanh toán nhập tay số thẻ (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb6" value="1" type="checkbox" id="gd6"/>
                                    <label for="gd6"><span></span>Giao dịch thanh toán nhập tay số thẻ (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb7 == 1}">
                                    <input name="gddb7" checked="checked" onclick="khongnhapCVC()" value="1" type="checkbox" id="khongnhapCVC1"/>
                                    <label for="khongnhapCVC1" onclick="khongnhapCVC()"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb7" value="1" type="checkbox" id="khongnhapCVC2"/>
                                    <label for="khongnhapCVC2" onclick="khongnhapCVC()"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</label>

                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb8 == 1}">
                                    <input name="gddb8" onclick="nhapTaySoThe()" checked="checked" value="1" type="checkbox" id="nhapTaySoThe1"/>
                                    <label for="nhapTaySoThe1" onclick="nhapTaySoThe()"><span></span>Thực hiện nhập tay số thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb8" onclick="nhapTaySoThe()" value="1" type="checkbox" id="nhapTaySoThe2"/>
                                    <label for="nhapTaySoThe2" onclick="nhapTaySoThe()"><span></span>Thực hiện nhập tay số thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb9 == 1}">
                                    <input name="gddb9" checked="checked" value="1" type="checkbox" id="gd9"/>
                                    <label for="gd9"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb9" value="1" type="checkbox" id="boQuaBuocNhapCVCPreAuth"/>
                                    <label for="boQuaBuocNhapCVCPreAuth" onclick="boQuaBuocNhapCVCPreAuth()"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${tienkyquyMoto != 0}">
                                    <span>Số tiền ký quỹ khi sử dụng dịch vụ MOTO(VNĐ): </span>
                                    <input name="_tienkyquyMoto" onChange="format_curency(this);" value="<fmt:formatNumber pattern="#,##0" value="${tienkyquyMoto}" />" onkeypress="return keyPressWord(event);" id="tienkyquyMoto"/>
                                </c:when>
                                <c:otherwise>
                                    <span>Số tiền ký quỹ khi sử dụng dịch vụ MOTO(VNĐ): </span>
                                    <input name="_tienkyquyMoto"  onChange="format_curency(this);" value="" onkeypress="return keyPressWord(event);" id="tienkyquyMoto"/>
                                </c:otherwise>
                            </c:choose>

                        </td>
                    </tr>                    
                    <tr>
                        <td colspan="2">Hạn mức VND: 
                            <c:choose>
                                <c:when test="${hanMucVND != 0}">
                                    <input name="_hanmucVnd" onChange="format_curency(this);" value="<fmt:formatNumber pattern="#,##0" value="${hanMucVND}" />" onkeypress="return keyPressWord(event);" id="hanmucVnd"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="_hanmucVnd"  onChange="format_curency(this);" value="" onkeypress="return keyPressWord(event);" id="hanmucVnd"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td colspan="2">Hạn mức USD: 
                            <c:choose>
                                <c:when test="${hanMucUSD != 0}">
                                    <input name="_hanmucUsd" onChange="format_curency(this);" value="<fmt:formatNumber pattern="#,##0" value="${hanMucUSD}" />" onkeypress="return keyPressWord(event);" id="hanmucUsd"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="_hanmucUsd" onChange="format_curency(this);" value="" onkeypress="return keyPressWord(event);" id="hanmucUsd"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <c:choose>
                        <c:when test="${error != null}">
                            <tr>
                                <td colspan="4">
                            <center>
                                <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                            </center>
                            </td>
                            </tr>
                        </c:when>
                    </c:choose>

                    <tr>
                        <td colspan="2">
                            <br/>
                            <input type="submit" value="CẬP NHẬT" class="submit-pos"/>
                            <a href="trove_themttlapdat.html" class="submit-pos-cancel">TRỞ VỀ</a>
                            <br/>
                        </td>
                    </tr>
                </table>
            </div>
        </center>              
    </form>
    <footer style="bottom: 0px;">
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
    </script>                        
    <script src="<%=request.getContextPath()%>/resources/js/themmoipos.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
</body>
</html>
