<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>QUẢN LÝ NGƯỜI DÙNG</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/dsdvcnt.css"/>
        <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>

        <style>
            table, table tr, table tr td {cursor: pointer;}
            table tr.active td {background-color: #ADFF2F;}

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
                            <c:choose>
                                <c:when test="${groupuser == 7}">
                                    <a href="xuatphieuyeucau.html" target="_blank">Xuất giấy đề nghị</a><br/>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${groupuser == 7}">
                                    <a href="tao_user.html" target="_blank">Tạo người dùng mới</a><br/>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </li>
                <li>Danh sách hồ sơ xử lý</li>
            </ul>
            <center>
                <h2>QUẢN LÝ NGƯỜI DÙNG
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> &nbsp; / &nbsp; ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <center>
        <div class="content">
            <center>
                <div class="timkiem">                    
                    <form action="${pageContext.request.contextPath}/search_create_user" method="post"
                          class="timkiembasic" style="width: 95%; height: 50px; margin-left: 2%">
                        <input name="txt_user" type="text" placeholder="User đăng nhập máy tính..." onkeypress="return blockSpecialChar(event)" onblur="caps(this.id)" id="username"
                               style="width: 20%; border: 1px solid; height: 25px; border-radius: 2px; line-height: 50px; float: left; margin-top: 1%;" required/>
                        <input name="txt_branch" type="text" placeholder="Mã đơn vị" onkeypress="return blockSpecialChar(event)" onblur="caps(this.id)" id="username"
                               style="width: 20%; border: 1px solid; height: 25px; border-radius: 2px; line-height: 50px; float: left; margin-top: 1%; margin-left: 5px"    />
                        <select name="txt_role" style="border-radius: 2px; float: left">
                            <option value="1">CN/PGD: User nhập</option>
                            <option value="2">CN/PGD: User duyệt</option>
                            <option value="3">P.PTSP&CSKHDN: User nhập</option>
                            <option value="4">P.PTSP&CSKHDN: User duyệt</option>
                            <option value="5">P.PTSPBL: User nhập</option>
                            <option value="6">P.PTSPBL: User duyệt</option>                            
                            <option value="7">P.TNT&NHS: User nhập</option>
                            <option value="8">P.TNT&NHS: User duyệt</option>
                        </select>
                        <input name="txt_option" type="submit" value="KIỂM TRA" class="submit"/>
                        <input name="txt_option" type="submit" value="TẠO MỚI" class="submit"/>
                        <input name="txt_option" type="submit" value="CẬP NHẬT" class="submit"/>
                        <span style="line-height: 50px; color: red; font-weight: bold; font-size: 18px">${alert_create_user}</span>
                    </form>
                </div>
            </center>

            <table class="dvcnt-pendding" id="testTable">   
                <c:choose>
                    <c:when test="${confirm != '' && confirm != 'null' && confirm != null}">
                        <tr style="padding: 10px;">
                            <td colspan="8" style="color: red; text-align: left; padding: 10px; font-weight: bold">
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="25%">${confirmCreateUser}</marquee>
                        </td>
                        </tr>
                    </c:when>
                </c:choose>
                <tr>
                    <th><a href="sortid.html" class="sort">ID</a></th>
                    <th>Số GPĐKKD</th>
                    <th><a href="sortname.html" class="sort">Tên Đơn vị chấp nhận thẻ</a></th>
                    <th><a href="sortstatus.html" class="sort">Trạng thái</a></th>
                    <th>Thao tác</th>
                    <th><a class="sort">Loại đăng ký</a></th>
                    <th>Ngày tạo yêu cầu</th>
                    <th>Mã đơn vị</th>
                    <th>User QL</th>
                        <c:choose>
                            <c:when test="${groupuser == 2}">
                            <td>Gán quyền quản lý</td>
                        </c:when>
                    </c:choose>
                </tr>
            </table>
        </div>
    </center>

    <footer>
        <center>
            <h4><a href="index.html">Trở về trang chủ</a></h5>
                <span>-------------------------------------------------</span>
                <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
        </center>
    </footer>
</center>

<script>

    function caps(id) {
        document.getElementById(id).value = document.getElementById(id).value.toUpperCase();
    }
</script>
<script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
<script>
    $(document).ready(function () {
        $("#testTable").children("tbody").children("tr").children("td").click(function () {
            $(this.parentNode).toggleClass("active");
        });
    });
</script>
</body>
</html>
