<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: white">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>THÔNG TIN MÁY POS LẮP ĐẶT</title>
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
                <h2>THÔNG TIN MÁY POS LẮP ĐẶT
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> &nbsp; / &nbsp; ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <form action="${pageContext.request.contextPath}/xulythemthongtinlapdat" method="get">
        <center>
            <div class="content-pos" style="height: 200px">

            </div>
            <table class="soluong">
                <c:choose>
                    <c:when test="${luthongsothanhcong != null && luthongsothanhcong != ''}">
                        <tr>
                            <td colspan="">
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="70%">${luthongsothanhcong}</marquee>
                        </td>
                        </tr>
                    </c:when>
                </c:choose>
                <tr>
                    <td>Số lượng POS đã đăng ký: ${soluongPos}</td>
                    <td>
                        <c:choose>
                            <c:when test="${groupuser == 1}">
                                Số POS đã gán: ${soluongdagan}
                            </c:when>
                        </c:choose>
                    </td>
                    <td> </td>
                </tr>                
            </table>

            <table class="lapdatpos">
                <tr>                    
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
                        <c:when test="${p1.ismapping != 1}">
                            <tr>                                
                                <td>${p1.tenDvcnt}</td>
                                <td>${p1.dongmay}</td>
                                <td>${p1.teninhoadon}</td>
                                <td>${p1.soTktgtt}</td>
                                <td>${p1.tenchutk}</td>
                                <td>${p1.diachiLapdat}</td>
                                <td>
                            <center>
                                <c:choose>
                                    <c:when test="${groupuser == 7 && p1.ismapping != -1 && p1.ismapping != 3}">
                                        <a href="themthongsopos.html?id_edit=${p1.stt}" class="map">Gán</a>
                                    </c:when>
                                    <c:when test="${groupuser == 7 && (p1.ismapping == -1 || p1.ismapping == 3)}">
                                        <a href="chinhsuathongsodagan.html?id_edit=${p1.stt}" class="editmap">Edit</a>
                                    </c:when>
                                </c:choose>
                            </center>
                            </td>
                            </tr>
                        </c:when>
                    </c:choose>
                </c:forEach>
            </table>
            </br>
            <a href="chuyentiep.html?id=${_id}" class="duyetthongso">GỬI DUYỆT THÔNG SỐ</a>
            <a href="export2.html?id=${_id}" target="_blank" class="duyetthongso" style="float: right; margin-right: 9%; background-color: darkblue">XUẤT FILE MÔ TẢ</a>
            </br></br>
        </center>              
    </form>
    <c:choose>
        <c:when test="${groupuser == 1}">
            <table style="width: 100%; margin-top: 2%; margin-left: 4%;">
                <tr>
                    <td>
                        <p><b>Upload file scan: </b></p>
                        <form method="post" action="${pageContext.request.contextPath}/fileUpload.do" enctype="multipart/form-data">
                            <input type="file" required  name="fileUploaded" class="xformUpload"/>  
                            <input type="submit" value="UPLOAD FILE" class="xformUpload"/>  
                            <marquee style="font-weight: bold; color: darkgreen" behavior="alternate" width="45%">${uploadsuccess}</marquee>
                        </form>
                        </br>
                        <a href="hoantat_themttlapdatpos.html?id=${_id}" class="guiduyet2"><center>GỬI DUYỆT</center></a>
                    </td>
                </tr>
            </table>
        </c:when>
    </c:choose>

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
    <script src="<%=request.getContextPath()%>/resources/js/jquery-1.8.3.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
</body>
</html>
