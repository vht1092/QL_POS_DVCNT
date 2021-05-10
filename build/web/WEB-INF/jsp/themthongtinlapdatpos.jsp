<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<meta charset="utf-8" />
<%
    response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="background-color: white">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>THÔNG TIN MÁY POS LẮP ĐẶT</title>
        <link rel="SHORTCUT ICON"
              href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico"/>
        <link rel="stylesheet"
              href="<%=request.getContextPath()%>/resources/css/themmoi.css"/>


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
                                        <a href="themmoidvcnt.html">Thêm ĐVCNT mới</a>
                                        <br />
                                    </c:when>
                                </c:choose>
                                <a href="dvcntdangxuly.html">ĐVCNT đang xử lý</a><br />
                                <c:choose>
                                    <c:when test="${groupuser == 1 || groupuser == 2}">
                                        <a href="danhsachdvcnt1.html">ĐVCNT đã lắp đặt</a>
                                        <br />
                                    </c:when>
                                    <c:when test="${groupuser == 3 || groupuser == 4}">
                                        <a href="danhsachdvcnt2.html">ĐVCNT đã lắp đặt</a>
                                        <br />
                                    </c:when>
                                    <c:when test="${groupuser == 5 || groupuser == 6}">
                                        <a href="danhsachdvcnt3.html">ĐVCNT đã lắp đặt</a>
                                        <br />
                                    </c:when>
                                    <c:otherwise>
                                        <a href="danhsachdvcnt.html">ĐVCNT đã lắp đặt</a>
                                        <br />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </li>
                    <li>Thông tin lắp POS</li>
                </ul>
                <center>
                    <h2>
                        THÔNG TIN MÁY POS LẮP ĐẶT <a class="dangxuat"
                                                     href="${pageContext.request.contextPath}/logout"> &nbsp; /
                            &nbsp; ĐĂNG XUẤT</a> <span class="tennguoidung">CN: ${macn} /
                            ${hoten}</span>
                    </h2>
                </center>
            </header>
        </center>
        <center>
            <form
                action="${pageContext.request.contextPath}/xulythemthongtinlapdat"
                method="post">

                <div class="content-pos" style="height: 1250px">
                    <c:choose>
                        <c:when test="${status > 2}">
                            <table style="width: 100%;">
                                <tr>
                                    <td colspan="2">ID</td>
                                    <td colspan="2">Tên ĐVCNT
                                        <p id="clear" onclick="reset()" class="reset"
                                           style="float: right; font-size: 12px; border-radius: 4px; cursor: pointer; font-weight: bold; background-color: #F5F5F5; padding: 4px; color: gray">Reset</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"><input name="maDvcnt" value="${_id}"
                                                           size="10" readonly="readonly" /></td>
                                    <td colspan="2"><input name="tenDvcnt" size="45"
                                                           value="${tendvcnt}" readonly="readonly" /></td>
                                </tr>

                                <tr>
                                    <td colspan="2">Loại máy</td>
                                    <td colspan="2">Tên in trên hóa đơn</td>
                                </tr>
                                <tr>
                                    <td colspan="2"><select name="dongmay" disabled="disabled">
                                            <option value="PAX_S90">PAX S90</option>
                                            <option value="PAX_S78">PAX S78</option>
                                            <option value="PAX_P70S">PAX P70-S</option>
                                            <option value="PAX_P80">PAX P80</option>
                                            <option value="PAX_78">PAX 78</option>
                                            <option value="VX520">VX520</option>
                                        </select></td>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${_teninhoadon != ''}">
                                                <input name="teninhoadon"
                                                       onkeypress="return blockSpecialChar(event)"
                                                       disabled="disabled" value="${_teninhoadon}" id="teninhoadon"
                                                       maxlength="22" size="65" />
                                            </c:when>
                                            <c:otherwise>
                                                <input name="teninhoadon"
                                                       onkeypress="return blockSpecialChar(event)"
                                                       disabled="disabled" value="" id="teninhoadon" maxlength="22"
                                                       size="65" />
                                            </c:otherwise>
                                        </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="2">Số TK TGTT báo có:</td>
                                    <td colspan="2">Tên chủ TK</td>
                                </tr>
                                <tr>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${_soTktgtt != ''}">
                                                <input name="soTktgtt" maxlength="16" disabled="disabled"
                                                       value="${_soTktgtt}" id="soTktgtt" pattern=".{0}|.{16,}"
                                                       required title="Either 0 OR (8 chars minimum)" />
                                            </c:when>
                                            <c:otherwise>
                                                <input name="soTktgtt" maxlength="16" disabled="disabled"
                                                       id="soTktgtt" pattern=".{0}|.{16,}" required
                                                       title="Either 0 OR (8 chars minimum)" />
                                            </c:otherwise>
                                        </c:choose></td>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${_tenchutk != ''}">
                                                <input name="tenchutk" maxlength="50"
                                                       onkeypress="return blockSpecialChar(event)"
                                                       disabled="disabled" size="45" value="${_tenchutk}"
                                                       id="tenchutk" />
                                            </c:when>
                                            <c:otherwise>
                                                <input name="tenchutk" maxlength="50"
                                                       onkeypress="return blockSpecialChar(event)"
                                                       disabled="disabled" size="45" id="tenchutk" />
                                            </c:otherwise>
                                        </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="2">Địa chỉ lắp đặt</td>
                                    <td colspan="2">Seri máy POS dự kiến lắp đặt</td>
                                </tr>
                                <tr>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${_diachiLapdat != ''}">
                                                <input name="diachiLapdat" id="text3" onblur="caps(this.id)"
                                                       disabled="disabled" value="${_diachiLapdat}"
                                                       id="diachiLapdat" maxlength="44" size="45" />
                                            </c:when>
                                            <c:otherwise>
                                                <input name="diachiLapdat" id="text4" onblur="caps(this.id)"
                                                       disabled="disabled" id="diachiLapdat" value=""
                                                       maxlength="44" size="45" />
                                            </c:otherwise>
                                        </c:choose></td>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${seridexuat != ''}">
                                                <input name="seridexuat"
                                                       onkeypress="return blockSpecialChar(event)" id="text3"
                                                       onblur="caps(this.id)" disabled="disabled"
                                                       value="${_diachiLapdat}" id="diachiLapdat" maxlength="20"
                                                       size="45" />
                                            </c:when>
                                            <c:otherwise>
                                                <input name="seridexuat"
                                                       onkeypress="return blockSpecialChar(event)" id="text4"
                                                       onblur="caps(this.id)" disabled="disabled" id="diachiLapdat"
                                                       value="" maxlength="20" size="45" />
                                            </c:otherwise>
                                        </c:choose></td>
                                </tr>
                                <tr>
                                    <th colspan="4">ĐĂNG KÝ GIAO DỊCH ĐẶC BIỆT</th>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb1 == 1}">
                                                <input name="gddb1" disabled="disabled" value="1"
                                                       checked="checked" type="checkbox" id="gd1" />
                                                <label for="gd1"><span></span>Giao dịch không xuất
                                                    trình thẻ (MOTO) (**)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb1" disabled="disabled" value="1"
                                                       type="checkbox" id="gd1" />
                                                <label for="gd1"><span></span>Giao dịch không xuất
                                                    trình thẻ (MOTO) (**)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb2 == 1}">
                                                <input name="gddb2" disabled="disabled" value="1"
                                                       checked="checked" type="checkbox" id="gd2" />
                                                <label for="gd2"><span></span>Giao dịch Đặt phòng /
                                                    Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb2" disabled="disabled" value="1"
                                                       type="checkbox" id="gd2" />
                                                <label for="gd2"><span></span>Giao dịch Đặt phòng /
                                                    Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb3 == 1}">
                                                <input name="gddb3" disabled="disabled" checked="checked"
                                                       value="1" type="checkbox" id="gd3" />
                                                <label for="gd3"><span></span>Giao dịch Điều chỉnh
                                                    (Adjust) (***)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb3" disabled="disabled" value="1"
                                                       type="checkbox" id="gd3" />
                                                <label for="gd3"><span></span>Giao dịch Điều chỉnh
                                                    (Adjust) (***)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb4 == 1}">
                                                <input name="gddb4" disabled="disabled" checked="checked"
                                                       value="1" type="checkbox" id="gd4" />
                                                <label for="gd4"><span></span>Giao dịch Ngoại tuyến
                                                    (OFFLINE) (***)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb4" disabled="disabled" value="1"
                                                       type="checkbox" id="gd4" />
                                                <label for="gd4"><span></span>Giao dịch Ngoại tuyến
                                                    (OFFLINE) (***)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb5 == 1}">
                                                <input checked="checked" disabled="disabled" name="gddb5"
                                                       value="1" type="checkbox" id="gd5" />
                                                <label for="gd5"><span></span>Chức năng nhập tiền TIP</label>
                                                    </c:when>
                                                    <c:otherwise>
                                                <input name="gddb5" disabled="disabled" value="1"
                                                       type="checkbox" id="gd5" />
                                                <label for="gd5"><span></span>Chức năng nhập tiền TIP</label>
                                                    </c:otherwise>
                                                </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb6 == 1}">
                                                <input name="gddb6" disabled="disabled" checked="checked"
                                                       value="1" type="checkbox" id="gd6" />
                                                <label for="gd6"><span></span>Giao dịch thanh toán
                                                    nhập tay số thẻ (***)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb6" disabled="disabled" value="1"
                                                       type="checkbox" id="gd6" />
                                                <label for="gd6"><span></span>Giao dịch thanh toán
                                                    nhập tay số thẻ (***)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb7 == 1}">
                                                <input name="gddb7" disabled="disabled" checked="checked"
                                                       value="1" type="checkbox" id="gd7" />
                                                <label for="gd7"><span></span>Bỏ qua bước nhập
                                                    CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb7" disabled="disabled" value="1"
                                                       type="checkbox" id="gd7" />
                                                <label for="gd7"><span></span>Bỏ qua bước nhập
                                                    CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb8 == 1}">
                                                <input name="gddb8" disabled="disabled" checked="checked"
                                                       value="1" type="checkbox" id="gd8" />
                                                <label for="gd8"><span></span>Thực hiện nhập tay số
                                                    thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth
                                                    (***)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb8" disabled="disabled" value="1"
                                                       type="checkbox" id="gd8" />
                                                <label for="gd8"><span></span>Thực hiện nhập tay số
                                                    thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth
                                                    (***)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb9 == 1}">
                                                <input name="gddb9" disabled="disabled" checked="checked"
                                                       value="1" type="checkbox" id="gd9" />
                                                <label for="gd9"><span></span>Bỏ qua bước nhập
                                                    CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete
                                                    Pre-Auth (***)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb9" disabled="disabled" value="1"
                                                       type="checkbox" id="gd9" />
                                                <label for="gd9"><span></span>Bỏ qua bước nhập
                                                    CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete
                                                    Pre-Auth (***)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><span>Số tiền ký quỹ khi sử dụng
                                            dịch vụ MOTO(VNĐ): </span> <input onChange="format_curency(this);"
                                                                          name="tienkyquyMoto" required="required" value=""
                                                                          onkeypress="return keyPressWord(event);" id="_tienkyquyMoto" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">Giao dịch MO:</td>
                                </tr>
                                <tr>
                                    <td colspan="2">Hạn mức VND: <input
                                            onChange="format_curency(this);" name="hanmucVnd"
                                            required="required" value=""
                                            onkeypress="return keyPressWord(event);" id="_hanmucVnd" />
                                    </td>
                                    <td colspan="2">Hạn mức USD: <input
                                            onChange="format_curency(this);" name="hanmucUsd"
                                            required="required" value=""
                                            onkeypress="return keyPressWord(event);" id="_hanmucUsd" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">Ghi chú</td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${_ghiChu != ''}">
                                                <input name="ghichu" maxlength="200" disabled="disabled"
                                                       value="${_ghiChu}" id="ghichu" size="80" />
                                            </c:when>
                                            <c:otherwise>
                                                <input name="ghichu" maxlength="200" disabled="disabled"
                                                       value="" id="ghichu" size="80" />
                                            </c:otherwise>
                                        </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><br /> <br /></td>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${status >= 3}">

                                            </c:when>
                                            <c:otherwise>
                                                <br />
                                                <a href="hoantat_themttlapdatpos.html?id=${_id}"
                                                   class="hoantat"><center>HOÀN TẤT</center></a>
                                                <br />
                                            </c:otherwise>
                                        </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${error != null}">
                                                <center>
                                                    <marquee style="font-weight: bold; float: left; color: red"
                                                             behavior="alternate" width="38%">${error}</marquee>
                                                </center>
                                            </c:when>
                                        </c:choose></td>
                                </tr>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <table style="width: 100%; height: auto;">
                                <tr>
                                    <td colspan="2">ID</td>
                                    <td colspan="2">Tên ĐVCNT
                                        <p id="clear" onclick="reset()" class="reset"
                                           style="float: right; font-size: 12px; border-radius: 4px; cursor: pointer; font-weight: bold; background-color: #F5F5F5; padding: 4px; color: gray">Reset</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"><input name="maDvcnt" value="${_id}"
                                                           size="10" readonly="readonly" /></td>
                                    <td colspan="2"><input name="tenDvcnt" value="${tendvcnt}"
                                                           readonly="readonly" /></td>
                                </tr>
                                <tr>
                                    <th colspan="4">
                                        NHÂN VIÊN QUẢN LÝ ĐVCNT
                                    </th>
                                </tr>
                                <tr>
                                    <td colspan="2">Direct</td>
                                    <td colspan="2">InDirect</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <c:choose>
                                            <c:when test="${get_direct_employee != ''}">
                                                <input name="direct_employee" list="brow" placeholder="Direct ID" 
                                                       style="width: 281px;"
                                                       required value="${get_direct_employee}"
                                                       minlength="8"/> 
                                        <datalist id="brow"> 
                                            <c:forEach items="${list_employee}" var="p">
                                                <option value="${p.empCode} - ${p.empName}"></option>
                                            </c:forEach> 
                                        </datalist>
                                    </c:when>
                                    <c:otherwise>
                                        <input name="direct_employee" list="brow" placeholder="Direct ID" 
                                               style="width: 281px;"
                                               required value="" 
                                               minlength="8"/> 
                                        <datalist id="brow"> 
                                            <c:forEach items="${list_employee}" var="p">
                                                <option value="${p.empCode} ${p.empName}">${p.empCode} - ${p.empName}</option>
                                            </c:forEach> 
                                        </datalist>
                                    </c:otherwise>
                                </c:choose>
                                </td>
                                <td colspan="2">
                                    <c:choose>
                                        <c:when test="${get_inDirect_employee != ''}">
                                            <input name="inDirect_employee" list="brow"
                                                   placeholder="InDirect ID" style="width: 281px" value="${get_inDirect_employee}" /> 
                                        <datalist
                                            id="brow"> 
                                            <c:forEach items="${list_jobTitleCode}"
                                                       var="p">
                                                <option value="${p.indirectEmployee}">${p.indirectEmployee}</option>
                                            </c:forEach> 
                                        </datalist>
                                    </c:when>
                                    <c:otherwise>
                                        <input name="inDirect_employee" list="brow"
                                               placeholder="InDirect ID" style="width: 281px" value="" /> 
                                        <datalist
                                            id="brow"> 
                                            <c:forEach items="${list_jobTitleCode}"
                                                       var="p">
                                                <option value="${p.indirectEmployee}">${p.indirectEmployee}</option>
                                            </c:forEach> 
                                        </datalist>
                                    </c:otherwise>
                                </c:choose>
                                </td>
                                </tr>
                                <tr>
                                    <th colspan="4">
                                        THÔNG TIN POS
                                    </th>
                                </tr>
                                <tr>
                                    <td colspan="2">Loại máy</td>
                                    <td colspan="2">Tên in trên hóa đơn</td>
                                </tr>

                                <tr>
                                    <td colspan="2"><select name="dongmay">
                                            <option value="PAX_S90">PAX S90</option>
                                            <option value="PAX_S78">PAX S78</option>
                                            <option value="PAX_P70S">PAX P70-S</option>
                                            <option value="PAX_P80">PAX P80</option>
                                            <option value="PAX_78">PAX 78</option>
                                            <option value="VX520">VX520</option>
                                        </select></td>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${_teninhoadon != ''}">
                                                <input style="width: 312px" name="teninhoadon"
                                                       onblur="caps(this.id)" required="required"
                                                       value="${_teninhoadon}" id="teninhoadon" maxlength="22"
                                                       width="145" />
                                            </c:when>
                                            <c:otherwise>
                                                <input style="width: 312px" name="teninhoadon"
                                                       onblur="caps(this.id)" required="required" value=""
                                                       id="teninhoadon" maxlength="22" width="145" />
                                            </c:otherwise>
                                        </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="2">Số TK TGTT báo có:</td>
                                    <td colspan="2">Tên chủ TK</td>
                                </tr>
                                <tr>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${_soTktgtt != ''}">
                                                <input style="width: 312px" name="soTktgtt"
                                                       required="required" value="${_soTktgtt}" maxlength="16"
                                                       id="soTktgtt" onkeypress="return keyPressWord(event);" />
                                            </c:when>
                                            <c:otherwise>
                                                <input style="width: 312px" name="soTktgtt"
                                                       required="required" id="soTktgtt" maxlength="16"
                                                       onkeypress="return keyPressWord(event);" />
                                            </c:otherwise>
                                        </c:choose></td>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${_tenchutk != ''}">
                                                <input style="width: 312px" name="tenchutk"
                                                       onblur="caps(this.id)" required="required"
                                                       value="${_tenchutk}" id="tenchutk" maxlength="50" />
                                            </c:when>
                                            <c:otherwise>
                                                <input style="width: 312px" name="tenchutk"
                                                       onblur="caps(this.id)" required="required" id="tenchutk"
                                                       maxlength="50" />
                                            </c:otherwise>
                                        </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="2">Địa chỉ lắp đặt</td>
                                    <td colspan="2">Seri máy POS dự kiến lắp đặt<i>(Áp dụng đối với POS từ nguồn máy Đơn vị)</i></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${_diachiLapdat != ''}">
                                                <input name="diachiLapdat" onblur="caps(this.id)"
                                                       required="required" value="${_diachiLapdat}"
                                                       id="diachiLapdat" maxlength="44" size="40" />
                                            </c:when>
                                            <c:otherwise>
                                                <input name="diachiLapdat" onblur="caps(this.id)"
                                                       required="required" id="diachiLapdat" value=""
                                                       maxlength="44" size="40" />
                                            </c:otherwise>
                                        </c:choose></td>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${soseridukienlapthem != ''}">
                                                <input name="soseridukienlapthem" onblur="caps(this.id)"
                                                       value="${_soseridukienlapthem}" id="diachiLapdat"
                                                       maxlength="20" size="20" />
                                            </c:when>
                                            <c:otherwise>
                                                <input name="soseridukienlapthem" onblur="caps(this.id)"
                                                       id="diachiLapdat" value="" maxlength="20" size="20" />
                                            </c:otherwise>
                                        </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="2">Ngành nghề(Chia theo nhóm A, B, C,...)</td>
                                    <td colspan="2">Vùng</td>
                                </tr>
                                <tr>
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
                                    <td colspan="2">
                                        <select name="vungLapdat">                                            
                                            <option>KV DONG NAM BO</option>             
                                            <option>KV HA NOI</option>                  
                                            <option>KV HO CHI MINH</option>             
                                            <option>KV MIEN TAY</option>                
                                            <option>KV MIEN TRUNG VA TAY NGUYEN</option>
                                            <option>KV DUYEN HAI BAC BO</option>             
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">Ngành nghề(MCC Code-Không bắt buộc)</td>                                    
                                </tr>
                                <tr>
                                    <td colspan="2"><select
                                            name="mccCode">
                                            <option value=""></option>
                                            <c:forEach items="${listMcc}" var="listMcc">
                                                <option value="${listMcc.mccCode}${listMcc.merchantType}">
                                                    ${listMcc.mccCode} - ${fn:substring(listMcc.merchantType, 0, 50)}</option>
                                                </c:forEach>
                                        </select></td>  
                                    <td><c:choose>
                                            <c:when test="${error != null}">
                                                <center>
                                                    <marquee style="font-weight: bold; float: left; color: red"
                                                             behavior="alternate" width="90%">LỖI: ${error}</marquee>
                                                </center>
                                            </c:when>
                                        </c:choose>
                                <marquee style="font-weight: bold; color: darkgreen"
                                         behavior="alternate" width="100%">${uploadsuccess}</marquee>
                                </td>
                                </tr>
                                <th colspan="4">ĐĂNG KÝ GIAO DỊCH ĐẶC BIỆT</th>                                

                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb11 == 1}">
                                                <input name="gddb1" value="1" onclick="change3()"
                                                       checked="checked" type="checkbox" id="khongxuattrinhMoto1" />
                                                <label for="khongxuattrinhMoto1"><span></span>Giao
                                                    dịch không xuất trình thẻ (MOTO) (**)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb1" value="1" onclick="change3()"
                                                       type="checkbox" id="khongxuattrinhMoto2" />
                                                <label for="khongxuattrinhMoto2"><span></span>Giao
                                                    dịch không xuất trình thẻ (MOTO) (**)</label>
                                                </c:otherwise>
                                            </c:choose></td>

                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb2 == 1}">
                                                <input name="gddb2" value="1" checked="checked"
                                                       onclick="giaodichdatphong()" type="checkbox"
                                                       id="giaodichdatphong1" />
                                                <label for="giaodichdatphong1" onclick="giaodichdatphong()"><span></span>Giao
                                                    dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete
                                                    Pre-Auth) (**)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb2" value="1" onclick="giaodichdatphong()"
                                                       type="checkbox" id="giaodichdatphong2" />
                                                <label for="giaodichdatphong2" onclick="giaodichdatphong()"><span></span>Giao
                                                    dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete
                                                    Pre-Auth) (**)</label>
                                                </c:otherwise>
                                            </c:choose></td>

                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb3 == 1}">
                                                <input name="gddb3" checked="checked" value="1"
                                                       type="checkbox" id="gd3" />
                                                <label for="gd3"><span></span>Giao dịch Điều chỉnh
                                                    (Adjust) (***)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb3" value="1" type="checkbox" id="gd3" />
                                                <label for="gd3"><span></span>Giao dịch Điều chỉnh
                                                    (Adjust) (***)</label>
                                                </c:otherwise>
                                            </c:choose></td>

                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb4 == 1}">
                                                <input name="gddb4" checked="checked" value="1"
                                                       type="checkbox" id="gd4" />
                                                <label for="gd4"><span></span>Giao dịch Ngoại tuyến
                                                    (OFFLINE) (***)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb4" value="1" type="checkbox" id="gd4" />
                                                <label for="gd4"><span></span>Giao dịch Ngoại tuyến
                                                    (OFFLINE) (***)</label>
                                                </c:otherwise>
                                            </c:choose></td>

                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb5 == 1}">
                                                <input checked="checked" name="gddb5" value="1"
                                                       type="checkbox" id="gd5" />
                                                <label for="gd5"><span></span>Chức năng nhập tiền TIP</label>
                                                    </c:when>
                                                    <c:otherwise>
                                                <input name="gddb5" value="1" type="checkbox" id="gd5" />
                                                <label for="gd5"><span></span>Chức năng nhập tiền TIP</label>
                                                    </c:otherwise>
                                                </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb6 == 1}">
                                                <input name="gddb6" checked="checked" value="1"
                                                       type="checkbox" id="gd6" />
                                                <label for="gd6"><span></span>Giao dịch thanh toán
                                                    nhập tay số thẻ (***)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb6" value="1" type="checkbox" id="gd6" />
                                                <label for="gd6"><span></span>Giao dịch thanh toán
                                                    nhập tay số thẻ (***)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb7 == 1}">
                                                <input name="gddb7" checked="checked"
                                                       onclick="khongnhapCVC()" value="1" type="checkbox"
                                                       id="khongnhapCVC1" />
                                                <label for="khongnhapCVC1" onclick="khongnhapCVC()"><span></span>Bỏ
                                                    qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO
                                                    (**)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb7" value="1" type="checkbox"
                                                       id="khongnhapCVC2" />
                                                <label for="khongnhapCVC2" onclick="khongnhapCVC()"><span></span>Bỏ
                                                    qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO
                                                    (**)</label>

                                            </c:otherwise>
                                        </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb8 == 1}">
                                                <input name="gddb8" onclick="nhapTaySoThe()"
                                                       checked="checked" value="1" type="checkbox"
                                                       id="nhapTaySoThe1" />
                                                <label for="nhapTaySoThe1" onclick="nhapTaySoThe()"><span></span>Thực
                                                    hiện nhập tay số thẻ khi thực hiện giao dịch Pre-Auth /
                                                    Complete Pre-Auth (***)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb8" onclick="nhapTaySoThe()" value="1"
                                                       type="checkbox" id="nhapTaySoThe2" />
                                                <label for="nhapTaySoThe2" onclick="nhapTaySoThe()"><span></span>Thực
                                                    hiện nhập tay số thẻ khi thực hiện giao dịch Pre-Auth /
                                                    Complete Pre-Auth (***)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="4"><c:choose>
                                            <c:when test="${gddb9 == 1}">
                                                <input name="gddb9" checked="checked" value="1"
                                                       type="checkbox" id="gd9" />
                                                <label for="gd9"><span></span>Bỏ qua bước nhập
                                                    CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete
                                                    Pre-Auth (***)</label>
                                                </c:when>
                                                <c:otherwise>
                                                <input name="gddb9" value="1" type="checkbox"
                                                       id="boQuaBuocNhapCVCPreAuth" />
                                                <label for="boQuaBuocNhapCVCPreAuth"
                                                       onclick="boQuaBuocNhapCVCPreAuth()"><span></span>Bỏ
                                                    qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth
                                                    / Complete Pre-Auth (***)</label>
                                                </c:otherwise>
                                            </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><span>Số tiền ký quỹ khi sử dụng
                                            dịch vụ MOTO(VNĐ): </span> <input name="_tienkyquyMoto"
                                                                          onChange="format_curency(this);" value=""
                                                                          onkeypress="return keyPressWord(event);" id="tienkyquyMoto_" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">Giao dịch MO:</td>
                                </tr>
                                <tr>
                                    <td colspan="1">Hạn mức VND: <input name="_hanmucVnd"
                                                                        onChange="format_curency(this);" value=""
                                                                        onkeypress="return keyPressWord(event);" id="hanmucVnd_" />
                                    </td>
                                    <td colspan="1">Hạn mức USD: <input name="_hanmucUsd"
                                                                        onChange="format_curency(this);" value=""
                                                                        onkeypress="return keyPressWord(event);" id="hanmucUsd_" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">Ghi chú</td>
                                </tr>
                                <tr>
                                    <td colspan="2"><c:choose>
                                            <c:when test="${_ghiChu != ''}">
                                                <input name="ghichu" maxlength="200" onblur="caps(this.id)"
                                                       value="${_ghiChu}" id="ghichu" size="80" />
                                            </c:when>
                                            <c:otherwise>
                                                <input name="ghichu" maxlength="200" onblur="caps(this.id)"
                                                       value="" id="ghichu" size="80" />
                                            </c:otherwise>
                                        </c:choose></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><br /> <input type="submit"
                                                                  value="LƯU THÔNG TIN" class="submit-pos"
                                                                  style="font-size: 12px" /> <br /></td>
                                    <td colspan="2"><br /> <a href="export.html?id=${_id}"
                                                              onclick="checkUpload()" class="hoantat" target="_blank"><center>XEM
                                                & IN THÔNG TIN</center></a> <br /></td>
                                </tr>

                                <tr>
                                    <td colspan="4"></td>
                                </tr>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
            </form>
            <table class="soluong">
                <tr>
                    <td>Số lượng POS đã đăng ký: ${soluongPos}</td>
                    <td><c:choose>
                            <c:when test="${groupuser == 1}">
                                Số POS đã gán: ${soluongdagan}
                            </c:when>
                        </c:choose></td>
                    <td></td>
                </tr>
            </table>

            <table class="lapdatpos">
                <tr>
                    <th>ID</th>
                    <th>Tên ĐVCNT</th>
                    <th>Loại máy</th>
                    <th>Tên in trên hóa đơn</th>
                    <th>Số TK TGTT</th>
                    <th>Tên chủ TK</th>
                    <th>Địa chỉ lắp đặt</th>
                    <th>Thao tác</th>
                </tr>
                <c:forEach items="${lstPosTemp}" var="p1">
                    <c:choose>
                        <c:when test="${p1.ismapping != 1 && p1.ismapping != 3}">
                            <tr>
                                <td>${p1.mid}</td>
                                <td>${p1.tenDvcnt}</td>
                                <td>${p1.dongmay}</td>
                                <td>${p1.teninhoadon}</td>
                                <td>${p1.soTktgtt}</td>
                                <td>${p1.tenchutk}</td>
                                <td>${p1.diachiLapdat}</td>
                                <td>
                                    <center>
                                        <c:choose>
                                            <c:when test="${groupuser == 1}">
                                                <a href="chinhsuathongtinlapdat.html?id_edit=${p1.stt}"
                                                   class="edit">Edit</a>
                                                <a href="xoathongtinlapdat.html?id=${p1.stt}" class="delete">Delete</a>
                                            </c:when>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${groupuser == 7}">
                                                <a href="themthongsopos.html?id_edit=${p1.stt}" class="map">Mapping</a>
                                            </c:when>
                                        </c:choose>
                                    </center>
                                </td>
                            </tr>
                        </c:when>
                    </c:choose>
                </c:forEach>
            </table>
        </center>
    </form>
    <c:choose>
        <c:when test="${groupuser == 1}">
            <table style="width: 100%; margin-top: 2%; margin-left: 4%;">
                <tr>
                    <td>
                        <p>
                            <b>Upload file: </b>
                            <c:choose>
                                <c:when test="${path_themmoi != null}">
                                    <a href="downloadfile.html?id=${path_themmoi}">Download file</a></br></br>
                                </c:when>
                            </c:choose>
                        </p>
                        <form method="post"
                              action="${pageContext.request.contextPath}/fileUpload.do"
                              enctype="multipart/form-data">
                            <input type="file" required name="fileUploaded"
                                   class="xformUpload" /> <input type="submit" value="UPLOAD FILE"
                                   class="xformUpload" style="background-color: darkgreen; color: white; padding-bottom: 1%"/>

                        </form> </br> <a href="hoantat_themttlapdatpos.html?id=${_id}"
                                         class="guiduyet2"><center>GỬI DUYỆT</center></a>
                    </td>
                </tr>
            </table>
        </c:when>
    </c:choose>

<footer style="bottom: 0px;">
    <center>

        <h4>
            <a href="index.html"><i class="fa fa-home"></i>Trở về trang chủ</a>
            </h5>
            <span>-------------------------------------------------</span>
            <h5>&copy; 2018 - Bản quyền P.KTT & NHS - Ngân Hàng TMCP Sài
                Gòn(SCB)</h5>
    </center>
</footer>

<script>
    function caps(id) {
        document.getElementById(id).value = document.getElementById(id).value
                .toUpperCase();
    }

    function id_Direct() {
        var element = document.getElementById("id_Direct");
        var id_Direct = element.options[element.selectedIndex].value;
        //alert(department);
        $
                .ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/getNameDirectBy_idDirect",
                    data: {
                        "id_Direct": id_Direct
                    },
                    dataType: "application/json",
                    success: function (response) {
                        alert("json : "); // here i need to bind the response list to doctor combobox item.
                    },
                    error: function (error) {
                        alert('Failed to get details: ' + error);
                    }
                });
    }
</script>

<script src="<%=request.getContextPath()%>/resources/js/themmoipos.js"></script>
<script
src="<%=request.getContextPath()%>/resources/js/jquery-1.8.3.js"></script>
<script
src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
</body>
</html>
