<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: white">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>THÔNG TIN LẮP ĐẶT POS</title>
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
                <li>Chi tiết POS lắp thêm mới</li>
            </ul>
            <center>
                <h2>CHI TIẾT POS LẮP THÊM MỚI "${maDvcnt}"
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> / ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <center>
        <div class="content-pos" style="height: auto">
            <table style="width: 100%; height: auto;">
                <tr>
                    <td colspan="2">Mã ĐVCNT</td>
                    <td colspan="2">
                        Tên ĐVCNT
                        <p id="clear" onclick="reset()" class="rerset-form">Reset</p>
                    </td>
                </tr>                            
                <tr>
                    <td colspan="2">
                        <input name="maDvcnt" value="${maDvcnt}" size="10" readonly="readonly"/>
                    </td>
                    <td colspan="2">
                        <input name="tenDvcnt" value="${tenDvcnt}" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Đồng tiền thanh toán</td>
                    <td colspan="2">Ngành nghề POS</td>
                </tr>
                <tr>
                    <td colspan="2"> 
                        <select name="loaitien" disabled="disabled">
                            <c:choose>
                                <c:when test="${loaitien == 'VND'}">
                                    <option value="VND" selected="selected">Đồng Việt Nam(VNĐ)</option>
                                    <option value="USD">Đô la Mỹ(USD)</option>
                                    <option value="VND/USD">VNĐ và USD</option>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${loaitien == 'USD'}">
                                    <option value="VND">Đồng Việt Nam(VNĐ)</option>
                                    <option value="USD" selected="selected">Đô la Mỹ(USD)</option>
                                    <option value="VND/USD">VNĐ và USD</option>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${loaitien == 'VND/USD'}">
                                    <option value="VND">Đồng Việt Nam(VNĐ)</option>
                                    <option value="USD">Đô la Mỹ(USD)</option>
                                    <option value="VND/USD" selected="selected">VNĐ và USD</option>
                                </c:when>
                            </c:choose>
                        </select>
                    </td>
                    <td colspan="2">
                        <b>
                            <c:choose>
                                <c:when test="${tenNganhNghe == 'A'}">
                                    A - ĂN UỐNG
                                </c:when>                                                
                                <c:when test="${tenNganhNghe == 'B'}">
                                    B - THỜI TRANG
                                </c:when>                                                
                                <c:when test="${tenNganhNghe == 'C'}">
                                    C - TRUNG TÂM THƯƠNG MẠI, SIÊU THỊ
                                </c:when>                                                
                                <c:when test="${tenNganhNghe == 'D'}">
                                    D - KHÁCH SẠN
                                </c:when>
                                <c:when test="${tenNganhNghe == 'E'}">
                                    E - DU LỊCH
                                </c:when>
                                <c:when test="${tenNganhNghe == 'F'}">
                                    F - KHÁC
                                </c:when>
                            </c:choose>
                        </b>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Loại máy</td>
                    <td colspan="2">Tên in trên hóa đơn</td>
                </tr>                    
                <tr>
                    <td colspan="2">                    
                        <select name="dongmay" disabled="disabled">
                            <c:choose>
                                <c:when test="${dongmay == 'PAX_S90'}">
                                    <option value="PAX_S90" selected="selected" readonly="readonly">PAX S90</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="PAX_S90" readonly="readonly">PAX S90</option>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${dongmay == 'PAX_S78'}">
                                    <option value="PAX_S78" selected="selected" readonly="readonly">PAX S78</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="PAX_S78" readonly="readonly">PAX S78</option>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${dongmay == 'PAX_P70S'}">
                                    <option value="PAX_P70S" selected="selected" readonly="readonly" disabled="disabled">PAX P70-S</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="PAX_P70S" readonly="readonly">PAX P70-S</option>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${dongmay == 'PAX_P80'}">
                                    <option value="PAX_P80" selected="selected" readonly="readonly">PAX P80</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="PAX_P80" readonly="readonly">PAX P80</option>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${dongmay == 'PAX_78'}">
                                    <option value="PAX_78" selected="selected" readonly="readonly">PAX 78</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="PAX_78" readonly="readonly">PAX 78</option>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${dongmay == 'VX520'}">
                                    <option value="VX520" selected="selected" readonly="readonly">VX520</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="VX520" readonly="readonly">VX520</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </td>
                    <td colspan="2">
                        <input name="teninhoadon" required="required" value="${teninhoadon}" id="teninhoadon" maxlength="22" disabled="disabled"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Số TK TGTT báo có:</td>
                    <td colspan="2">Tên chủ TK</td>
                </tr>
                <tr>
                    <td colspan="2"> 
                        <input name="soTktgtt" required="required" value="${soTktgtt}" id="soTktgtt" maxlength="16" disabled="disabled" onkeypress="return keyPressWord(event);"/>
                    </td>
                    <td colspan="2">
                        <input name="tenchutk" value="${tenchutk}" id="tenchutk" disabled="disabled"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">Địa chỉ lắp đặt</td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input name="diachiLapdat" required="required" id="diachiLapdat" value="${diachiLapdat}" disabled="disabled" maxlength="44" size="40"/>
                    </td>
                </tr>
                <tr>
                    <th colspan="4">
                        ĐĂNG KÝ GIAO DỊCH ĐẶC BIỆT
                    </th>
                </tr>
                <tr>
                    <td colspan="4">
                        <c:choose>
                            <c:when test="${gddb1 == 1}">
                                </br><p>Giao dịch không xuất trình thẻ (MOTO) (**)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb2 == 1}">
                                <p>Giao dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb3 == 1}">
                                <p>Giao dịch Điều chỉnh (Adjust) (***)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb4 == 1}">
                                <p>Giao dịch Ngoại tuyến (OFFLINE) (***)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb5 == 1}">
                                <p>Chức năng nhập tiền TIP</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb6 == 1}">
                                <p>Giao dịch thanh toán nhập tay số thẻ (***)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb7 == 1}">
                                <p>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb8 == 1}">
                                <p>Thực hiện nhập tay số thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb9 == 1}">
                                <p>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</p></br>
                            </c:when>
                        </c:choose>

                        <c:choose>
                            <c:when test="${tienkyquyMoto != ''}">
                                <p>Số tiền ký quỹ khi sử dụng dịch vụ MOTO(VNĐ): <b><input name="hanmucUsd" value="<fmt:formatNumber pattern="#,##0" value="${tienkyquyMoto}" />" required="required" disabled="disabled" onkeypress="return keyPressWord(event);"/></b></br>
                                    </c:when>
                                    <c:otherwise></c:otherwise>
                                </c:choose>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Hạn mức VND: 
                        <input name="hanmucVnd" value="<fmt:formatNumber pattern="#,##0" value="${hanmucVnd}" />" required="required" disabled="disabled" onkeypress="return keyPressWord(event);"/>
                    </td>
                    <td colspan="2">Hạn mức USD: 
                        <input name="hanmucUsd" value="<fmt:formatNumber pattern="#,##0" value="${hanmucUsd}" />" required="required" disabled="disabled" onkeypress="return keyPressWord(event);"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">Ghi chú</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input name="ghichu" value="${ghichu}" id="ghichu" size="80" disabled="disabled"/>
                    </td>
                    <td colspan="2">
                        <a href="trove_duyet.html" class="submit-pos-cancel" style="background-color: yellow; padding-top: 5px">TRỞ VỀ</a>
                    </td>
                </tr>
            </table>
        </div>
    </center>

    <footer style="bottom: 0px;">
        <center>

            <h4><a href="index.html"><i class="fa fa-home"></i>Trở về trang chủ</a></h5>
                <span>-------------------------------------------------</span>
                <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
        </center>
    </footer>

    <script src="<%=request.getContextPath()%>/resources/js/themmoipos.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
</body>
</html>
