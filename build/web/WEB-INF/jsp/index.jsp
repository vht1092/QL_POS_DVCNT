<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="60">
        <title>TRANG CHỦ: QUẢN LÝ ĐVCNT, POS</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/trangchu.css"/>
    </head>
    <body>
        <header>
            <div class="logo">
                <a href="home.html"><img src="<%=request.getContextPath()%>/resources/img/logo/logo.png" title="SCB logo" alt="SCB logo"/></a>
            </div>
            <div class="title">
                <h2>CHƯƠNG TRÌNH QUẢN LÝ ĐƠN VỊ CHẤP NHẬN THẺ, POS</h2>
            </div>
            <div class="login-info"> 
                <span>${hoten}</span></br>
                <span>${macn} -  ${tencn}</span></br>
                <a class="dangxuat" href="${pageContext.request.contextPath}/logout">ĐĂNG XUẤT</a>
            </div>
        </header>
        <div class="content">
            <center>
                <table> 
                    <tr>
                        <td>
                            <a href="#" id="menu1">
                                <img src="<%=request.getContextPath()%>/resources/img/orthers/house.png"/>
                                Quản lý ĐVCNT
                            </a> 
                        </td>
                        <td>
                            <a href="#" id="menu2">
                                <img src="<%=request.getContextPath()%>/resources/img/orthers/phone.png"/>
                                Quản lý thiết bị
                            </a> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="#" id="menu3">
                                <img src="<%=request.getContextPath()%>/resources/img/orthers/anphampos.png"/>
                                Quản lý ấn phẩm POS
                            </a> 
                        </td>
                        <td>
                            <a href="#">
                                <img src="<%=request.getContextPath()%>/resources/img/orthers/report.png"/>
                                &nbsp;Báo cáo
                            </a>
                        </td>
                    </tr>
                </table>
            </center>
        </div>
        <div class="footer">
            <h6><center>BẢN QUYỀN P.KTT & NHS - NGÂN HÀNG TMCP SÀI GÒN (SCB &copy2018)</center></h6>
        </div>

        <div id="menu1_modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="close">&times;</span>
                    <center><h2>QUẢN LÝ ĐƠN VỊ CHẤP NHẬN THẺ</h2></center> 
                </div>
                <div class="modal-body">
                    <c:choose>
                        <c:when test="${groupuser == 1}">
                            <a href="themmoidvcnt.html">Tạo hồ sơ ĐVCNT</a><br/>
                        </c:when>
                    </c:choose>
                    <a href="dvcntdangxuly.html">Danh sách hồ sơ xử lý</a><br/>
                    <c:choose>
                        <c:when test="${groupuser == 1 || groupuser == 2}">
                            <a href="danhsachdvcnt1.html">Danh sách ĐVCNT lắp đặt</a><br/>
                        </c:when>
                        <c:when test="${groupuser == 3 || groupuser == 4}">
                            <a href="danhsachdvcnt2.html">Danh sách ĐVCNT lắp đặt</a><br/>
                        </c:when>
                        <c:when test="${groupuser == 5 || groupuser == 6}">
                            <a href="danhsachdvcnt3.html">Danh sách ĐVCNT lắp đặt</a><br/>
                        </c:when>
                        <c:otherwise>
                            <a href="danhsachdvcnt.html">Danh sách ĐVCNT lắp đặt</a><br/>
                        </c:otherwise>
                    </c:choose>    
                </div>
            </div>
        </div>

        <div id="menu2_modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="close2">&times;</span>
                    <center><h2>QUẢN LÝ MÁY POS</h2></center>
                </div>
                <div class="modal-body">
                    <c:choose>
                        <c:when test="${groupuser == 7}">
                            <a href="themmoipos.html">Nhập kho</a><br/>                            
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${groupuser == 7 || groupuser == 1 || groupuser == 9 }">                            
                            <a href="danhsachpos.html">Danh sách POS</a><br/>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>

        <div id="menu3_modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="close3">&times;</span>
                    <center><h2>QUẢN LÝ ẤN PHẨM</h2></center>
                </div>
                <div class="modal-body">
                    <c:choose>
                        <c:when test="${groupuser == 1}">
                            <a href="themmoipos.html">Nhập kho</a><br/>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${groupuser == 1}">
                            <a href="themmoipos.html">Xuất kho</a><br/>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>

        <script src="<%=request.getContextPath()%>/resources/js/trangchu.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/resources/Snowstorm-master/unset_snowstorm.js"></script>
        <script type="text/javascript">
            snowStorm.snowColor = '#1FAAE6'; // màu của tuyết - ở đây là màu xanh xám
            snowStorm.flakesMaxActive = 800;  // số lượng tuyết rơi cùng 1 lúc
            snowStorm.useTwinkleEffect = false; // cho tuyết nhấp nháy
            snowStorm.fontSize = 55;
        </script>
    </body>
</html>