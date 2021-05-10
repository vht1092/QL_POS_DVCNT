<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>KHÓA POS</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/themmoi.css"/>

        <style>
            *{font-size: 13px}
        </style>
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
                <li>Khóa ĐVCNT</li>
            </ul>
            <center>
                <h2>KHÓA ĐƠN VỊ CHẤP NHẬN THẺ "${_maDvcnt}"
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> &nbsp;/&nbsp; ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <form action="${pageContext.request.contextPath}/luuthongtinkhoa" method="get" name="frm">
        <center>
            <div class="content">

                <table style="width: 100%; height: auto">
                    <form action="${pageContext.request.contextPath}/luuthongtinkhoa" method="post" name="frm">
                        <center>
                            <tr>
                                <th colspan="4">THÔNG TIN ĐVCNT</th>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    Mã ĐVCNT: 
                                    <input readonly="readonly" name="maDvcnt" value="${maDvcnt}" readonly="readonly" size="10"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">Đơn vị đăng ký kinh doanh</td>
                                <td colspan="2">Tên tiếng Anh</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input readonly="readonly" name="tenDvcntVn" id="text1" onblur="caps(this.id)" value="${tenDvcntVn}" autofocus="" size="60" required=""/>
                                </td>
                                <td colspan="2">
                                    <input readonly="readonly" name="tenDvcntEn" id="text2" onblur="caps(this.id)" value="${tenDvcntEn}" size="60"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">Địa chỉ</td>
                                <td colspan="2">Điện thoại</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input readonly="readonly" readonly="readonly" name="diaChiDvcnt" id="text3" onblur="caps(this.id)" value="${diachiDvcnt}" size="60"/>
                                </td>
                                <td colspan="2">
                                    <input readonly="readonly" name="sdtDvcnt" value="${sdtDvcnt}" onkeypress="return keyPressWord(event);"/>
                                </td>
                            </tr>

                            <tr>
                                <td>Giấy phép ĐKKD số</td>
                                <td>Ngày cấp(dd/mm/yyyy)</td>
                                <td>Nơi cấp</td>
                                <td>Mã số thuế</td>
                            </tr>
                            <tr>
                                <td>
                                    <input readonly="readonly" name="gpdkkdso" value="${gpdkkdso}"/>
                                </td>
                                <td>
                                    ${_GpdkkdNgaycap}
                                </td>
                                <td>
                                    <input readonly="readonly" name="gpdkkdNoicap" id="text4" onblur="caps(this.id)" value="${gpdkkdNoicap}"/>
                                </td>
                                <td>
                                    <input readonly="readonly" name="masothue" value="${masothue}" onkeypress="return keyPressWord(event);"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <c:choose>
                                        <c:when test="${errorPagekhoa != null}">
                                    <center>
                                        <br/>
                                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${errorPagekhoa}</marquee>
                                    </center>
                                </c:when>
                                <c:otherwise>
                                    <br/>
                                    <span style="color: darkgreen; font-weight: bold">${uploadsuccess}</span>
                                </c:otherwise>
                            </c:choose>
                            <span style="ont-weight: bold; background-color: lime">${luuthanhcong}</span>
                            </td>
                            </tr>
                            <tr>
                                <th colspan="12">CHECK CHỌN POS BÊN DƯỚI ĐỂ TIẾN HÀNH THU HỒI</th></br>
                            </tr>
                            <tr>
                                <th>Loại máy</th>                   
                                <th>Seri</th>
                                <th>Địa chỉ lắp đặt: </th>
                                <th>Tên in trên hóa đơn: </th> 
                            </tr>
                            <c:forEach items="${lst}" var="p">
                                <tr>
                                    <c:choose>
                                        <c:when test="${p.tinhtrangPos == 'Sử dụng'}">
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.tinhtrang == 1}">
                                                        <input type="checkbox" name="${p.soseri}" value="1" checked style="font-size: 40px"/>${p.dongmay}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="checkbox" name="${p.soseri}" value="1" style="font-size: 40px"/>${p.dongmay}
                                                    </c:otherwise>
                                                </c:choose>                                                
                                            </td>
                                            <td><span id="${p.soseri}">${p.soseri}</span></td>    
                                            <td>${p.diachiLapdat}</td>
                                            <td>${p.teninhoadon}</td>
                                        </c:when>
                                    </c:choose>
                                </tr>
                            </c:forEach>
                            <tr>
                                <th colspan="12">NƠI LƯU POS SAU KHI THU HỒI</th></br>
                            </tr>
                            <tr>
                                <td colspan="4">
                            <center>
                                <select name="noiLuuPos">
                                    <option value="DON VI">Lưu POS tại đơn vị</option>                                    
                                </select>
                            </center>
                            </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <br/>
                                    <input type="submit" value="LƯU THÔNG TIN" class="submit-pos" style="font-size: 12px"/>
                                    <br/>
                                </td>
                                <td colspan="2">
                                    <br/>
                                    <a href="bienbanthuhoipos.html?id=${_maDvcnt}" onclick="checkUpload()" class="hoantat" target="_blank"><center>XEM & IN THÔNG TIN</center></a>
                                    <br/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="12">
                                </td>
                            </tr>
                        </center>
                    </form>
                </table>
                <table>
                    <tr>
                        <td colspan="12">
                    <center>
                        <form method="post" action="${pageContext.request.contextPath}/fileUploadKhoa.do" enctype="multipart/form-data">
                            <input type="file" required  name="fileUploaded" class="xformUpload"/>
                            <input type="submit" value="UPLOAD FILE" class="xformUpload" style="padding: 2px"/>  
                        </form></br>
                        <a href="guiduyetkhoa.html?id=${_id}" class="guiduyet2"><center>GỬI DUYỆT</center></a>
                    </center>
                    </td>
                    </tr>
                </table>
            </div>
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
                    if (charCode == 46)
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
