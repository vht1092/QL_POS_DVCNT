<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="30">
        <title>ĐĂNG NHẬP: CHƯƠNG TRÌNH QUẢN ĐVCNT, POS</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/trangchu.css"/>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/dangnhap.css"/>
    </head>
    <body>
        <header>
            <div class="logo">
                <a href="https://scb.com.vn/" target="_blank">
                    <img src="<%=request.getContextPath()%>/resources/img/logo/logo.png" title="SCB logo" alt="SCB logo"/>
                </a>
            </div>
            <div class="title">
                <h2>CHƯƠNG TRÌNH QUẢN LÝ ĐƠN VỊ CHẤP NHẬN THẺ, POS</h2>
            </div>
        </header>

    <center>
        <form action="${pageContext.request.contextPath}/checklogin" method="post">
            <div class="imgcontainer">
                <img src="<%=request.getContextPath()%>/resources/img/logo/scb.jpg" alt="Avatar" class="avatar">
            </div>

            <div class="container">
                <label><b>Tên đăng nhập</b></label>
                <input type="text" name="username" required><br/>

                <label style="margin-left: 3%"><b>Mật khẩu</b></label>
                <input type="password" name="password" required><br/>

                <input type="submit" value="ĐĂNG NHẬP" class="button"/></br>

            </div>
        </form>
        <c:choose>
            <c:when test="${error != ''}">
                <p style="color: #BF0000; font-weight: bold; margin-left: 196px">${error}</p></br>
            </c:when>
        </c:choose>

    </center>

    <div class="footer">
        <h6><center>BẢN QUYỀN P.KTT & NHS - NGÂN HÀNG TMCP SÀI GÒN (SCB &copy2018)</center></h6>
    </div>
</body>
</html>
