<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: white">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>Gán thông số POS</title>
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
                <li>Chỉnh sửa thông số POS</li>
            </ul>
            <center>
                <h2>Chỉnh sửa thông số POS
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> &nbsp;/&nbsp; ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>

    <center>
        <div class="content-pos" style="height: 850px">
            <form action="${pageContext.request.contextPath}/checkserinumber" method="get">
                <table style="width: 100%; height: auto;">
                    <tr>
                        <td colspan="2">
                            <a href="danhsachpos.html" class="seri" target="_blank">Serial No</a><br/>
                        </td>
                        <td colspan="2">Mã tài sản</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${soseri != ''}">
                                    <input id="soseri" readonly="readonly" name="soseri" value="${soseri}" size="17" placeholder="Serial" required="required"/>
                                </c:when>
                                <c:otherwise>
                                    <input id="soseri" readonly="readonly" name="soseri" value="" size="17" placeholder="Serial" required="required"/>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${error != null}">
                                    <span class="warning">${error}</span>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${dongmayhople != null}">
                                    <span class="warning">${dongmayhople}</span>
                                </c:when>
                            </c:choose>
                        </td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${mataisan != ''}">
                                    <input name="mataisan" readonly="readonly" value="${mataisan}"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="mataisan" readonly="readonly" value=""/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </form>
            <form action="${pageContext.request.contextPath}/xulychinhsuathongsopos" method="post">
                <table style="width: 100%; height: auto;">
                    <tr>
                        <td colspan="2">Dòng máy</td>
                        <td colspan="2">MCC</td>                        
                    </tr>
                    <tr>
                        <td colspan="1">                    
                            <select name="dongmay" readonly="readonly">
                                <c:choose>
                                    <c:when test="${_dongmay == 'PAX_S90'}">
                                        <option value="PAX_S90" selected="selected" readonly="readonly">PAX S90</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_S90" readonly="readonly">PAX S90</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${_dongmay == 'PAX_S78'}">
                                        <option value="PAX_S78" selected="selected" readonly="readonly">PAX S78</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_S78" readonly="readonly">PAX S78</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${_dongmay == 'PAX_P70S'}">
                                        <option value="PAX_P70S" selected="selected" readonly="readonly">PAX P70-S</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_P70S" readonly="readonly">PAX P70-S</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${_dongmay == 'PAX_P80'}">
                                        <option value="PAX_P80" selected="selected" readonly="readonly">PAX P80</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_P80" readonly="readonly">PAX P80</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${_dongmay == 'PAX_78'}">
                                        <option value="PAX_78" selected="selected" readonly="readonly">PAX 78</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_78" readonly="readonly">PAX 78</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${_dongmay == 'VX520'}">
                                        <option value="VX520" selected="selected" readonly="readonly">VX520</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="VX520" readonly="readonly">VX520</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </td>
                        <td colspan="2">
                            <input name="mcc" required="required" value="${mcc}" maxlength="4" onkeypress="return keyPressWord(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">Ngân hàng thanh toán: &nbsp; &nbsp; &nbsp;
                            <c:choose>
                                <c:when test="${nganhang == 'EXB'}">
                                    <input name="nganhang" value="EXB" id="exb" type="radio" checked="checked" onclick="change1()" required="required"/>
                                    <label for="exb"><span></span>Eximbank</label> &nbsp; &nbsp;
                                    <input name="nganhang" value="VTB" id="vtb" type="radio" onclick="change2()" required="required"/>
                                    <label for="vtb"><span></span>Viettinbank</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="nganhang" value="EXB" id="exb" type="radio" onclick="change1()" required="required"/>
                                    <label for="exb"><span></span>Eximbank</label> &nbsp; &nbsp;
                                    <input name="nganhang" value="VTB" id="vtb" type="radio" checked="checked" onclick="change2()" required="required"/>
                                    <label for="vtb"><span></span>Viettinbank</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Hạn mức VNĐ</td>
                        <td colspan="2">Hạn mức USD</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${hanmucVND != ''}">
                                    <input name="hanmucVnd" id="hanmucVnd" value="${hanmucVND}" onkeypress="return keyPressWord(event);"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="hanmucVnd" id="hanmucVnd" value="" onkeypress="return keyPressWord(event);"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${hanmucUsd != ''}">
                                    <input name="hanmucUsd" value="${hanmucUsd}" id="hanmucUsd" onkeypress="return keyPressWord(event);" disabled/>
                                </c:when>
                                <c:otherwise>
                                    <input name="hanmucUsd" value="" id="hanmucUsd" onkeypress="return keyPressWord(event); disabled"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">TID</td>
                        <td colspan="2">MID</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${tid1 != ''}">
                                    <input name="tid1" value="${tid1}" required="required"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="tid1" value="" required="required"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${mid1 != ''}">
                                    <input name="mid1" value="${mid1}" required="required" />
                                </c:when>
                                <c:otherwise>
                                    <input name="mid1" value="" required="required" />
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>                    
                    <tr>
                        <td colspan="4">
                    <marquee style="font-weight: bold; color: red"
                             behavior="alternate" width="50%">${uploadsuccess}</marquee>
                    </td>
                    </tr>
                    <tr>
                        <th colspan="4">
                            GIAO DỊCH ĐẶC BIỆT
                        </th>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${_gddb1 == 1}">
                                    <input name="gddb1" value="1" checked="checked" type="checkbox" id="gd1"/>
                                    <label for="gd1"><span></span>Giao dịch không xuất trình thẻ (MOTO) (**)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb1" value="1" type="checkbox" id="gd1"/>
                                    <label for="gd1"><span></span>Giao dịch không xuất trình thẻ (MOTO) (**)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${_gddb2 == 1}">
                                    <input name="gddb2" value="1" checked="checked" type="checkbox" id="gd2"/>
                                    <label for="gd2"><span></span>Giao dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb2" value="1" type="checkbox" id="gd2"/>
                                    <label for="gd2"><span></span>Giao dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${_gddb3 == 1}">
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
                                <c:when test="${_gddb4 == 1}">
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
                                <c:when test="${_gddb5 == 1}">
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
                                <c:when test="${_gddb6 == 1}">
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
                                <c:when test="${_gddb7 == 1}">
                                    <input name="gddb7" checked="checked" value="1" type="checkbox" id="gd7"/>
                                    <label for="gd7"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb7" value="1" type="checkbox" id="gd7"/>
                                    <label for="gd7"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${_gddb8 == 1}">
                                    <input name="gddb8" checked="checked" value="1" type="checkbox" id="gd8"/>
                                    <label for="gd8"><span></span>Thực hiện nhập tay số thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb8" value="1" type="checkbox" id="gd8"/>
                                    <label for="gd8"><span></span>Thực hiện nhập tay số thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${_gddb9 == 1}">
                                    <input name="gddb9" checked="checked" value="1" type="checkbox" id="gd9"/>
                                    <label for="gd9"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb9" value="1" type="checkbox" id="gd9"/>
                                    <label for="gd9"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Hạn mức VND: 
                            <input class="disabled" onChange="format_curency(this);" name="" required="required" readonly="readonly" value="${_hanmucVnd}" onkeypress="return keyPressWord(event);" id="hanmucVnd"/>
                        </td>
                        <td colspan="2">Hạn mức USD: 
                            <input class="disabled" onChange="format_curency(this);" name="" required="readonly" disabled="readonly" value="${_hanmucUsd}" onkeypress="return keyPressWord(event);" id="hanmucUsd"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="label">
                            Tên ĐVCNT
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <input  class="disabled" name="tenDvcnt" value="${tendvcnt}" readonly="readonly"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="label">Mã ĐVCNT</td>
                        <td colspan="2" class="label">Tên in trên hóa đơn</td>
                    </tr>                    
                    <tr>
                        <td colspan="2">
                            <input class="disabled" name="maDvcnt" value="${_id}" size="10" readonly="readonly"/>
                            <input style="border: 0x white; color: white;" name="id_edit" value="${_idedit}" size="5" hidden="hidden"/>
                        </td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${_teninhoadon != ''}">
                                    <input  class="disabled" name="teninhoadon" value="${_teninhoadon}" id="teninhoadon" maxlength="21" readonly="readonly"/>
                                </c:when>
                                <c:otherwise>
                                    <input class="disabled" name="teninhoadon" value="" id="teninhoadon" maxlength="21" readonly="readonly"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="label">Số TK TGTT báo có:</td>
                        <td colspan="2" class="label">Tên chủ TK</td>
                    </tr>
                    <tr>
                        <td colspan="2"> 
                            <c:choose>
                                <c:when test="${_soTktgtt != ''}">
                                    <input class="disabled" name="soTktgtt" value="${_soTktgtt}" id="soTktgtt" readonly="readonly"/>
                                </c:when>
                                <c:otherwise>
                                    <input class="disabled" name="soTktgtt" id="soTktgtt" readonly="readonly"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${_tenchutk != ''}">
                                    <input class="disabled" name="tenchutk" value="${_tenchutk}" id="tenchutk" readonly="readonly"/>
                                </c:when>
                                <c:otherwise>
                                    <input class="disabled" name="tenchutk" id="tenchutk" readonly="readonly"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="label">Địa chỉ lắp đặt</td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${_diachiLapdat != ''}">
                                    <input class="disabled" name="diachiLapdat" value="${_diachiLapdat}" id="diachiLapdat" maxlength="44" size="40" readonly="readonly"/>
                                </c:when>
                                <c:otherwise>
                                    <input class="disabled" name="diachiLapdat" id="diachiLapdat" value="" maxlength="44" size="40" readonly="readonly"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="label">Ghi chú</td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${_ghiChu != ''}">
                                    <input class="disabled" name="ghichu" value="${_ghiChu}" id="ghichu" size="80" readonly="readonly"/>
                                </c:when>
                                <c:otherwise>
                                    <input class="disabled" name="ghichu" value="" id="ghichu" size="80" readonly="readonly"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <br/>
                            <input type="submit" value="CẬP NHẬT" class="submit-pos" readonly="readonly"/>
                            <a href="trove_taothongso.html" class="submit-pos-cancel">TRỞ VỀ</a>
                            <br/>
                        </td>
                    </tr>
                </table>
            </form>
            <form method="post"
                  action="${pageContext.request.contextPath}/editFileUploadMapping.do"
                  enctype="multipart/form-data">
                <b>Upload file thông số</b>
                <input type="file" required name="fileUploaded"
                       class="xformUpload" /> <input type="submit" value="UPLOAD FILE"
                       class="xformUpload" style="background-color: darkred; color: white; padding: 1%; padding-bottom: 2%"/>                
            </form>
        </div>
    </center>


    <footer style="bottom: 0px; margin-top: 25%">
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
