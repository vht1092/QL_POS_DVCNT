<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: white">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>XEM THÔNG TIN DUYỆT</title>
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
                <li>Lịch sử duyệt</li>
            </ul>
            <center>
                <h2>THÔNG TIN CBNV XỬ LÝ HỒ SƠ ĐVCNT ${_id}
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> &nbsp;/&nbsp; ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
        <div id="docx" class="content" style="height: 5000px">
            <div class="WordSection1">
                <center>
                    <table style="width: 90%; height: auto; margin: 0; font-size: 18px">
                        <tr>
                            <th>Thời gian</th>
                            <th>Username</th>
                            <!--<th>Cấp user</th>-->
                            <th>Thao tác</th>
                        </tr>
                        <c:forEach items="${list}" var="p">
                            <tr>
                                <td>
                            <center>
                                ${fn:substring(p.logTime, 6, 8)}/${fn:substring(p.logTime, 4, 6)}/${fn:substring(p.logTime, 0, 4)}
                                ${fn:substring(p.logTime, 8, 10)}:${fn:substring(p.logTime, 10, 12)}
                            </center>
                            </td>
                            <td>${p.logUser}</td>
<!--                                <td>${p.logLevel}</td>-->
                            <td>${p.logContent}</td>
                            </tr>    
                        </c:forEach>
                    </table>
                </center>
            </div>
        </div>
    </center>
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
