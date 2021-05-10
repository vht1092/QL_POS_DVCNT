<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>EDIT POS</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/dsdvcnt.css"/>
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
                <li>Chỉnh sửa thông tin POS </li>
            </ul>
            <center>
                <h2>EDIT POS THUỘC ĐVCNT "${maDvcnt}"
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout">ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten} / </span>
                </h2>
            </center>
        </header>
    </center>
    <table class="thongtinlapdat" style="font-size: 15px">
        <tr>
            <th>Tên in trên hóa đơn </th> 
            <th>Địa chỉ lắp đặt </th>
            <th>Số TK TGTT báo có </th>
            <th>Tên chủ TK</th>                    
            <th>Loại máy</th>                   
            <th>Seri</th>                   
            <!--            <th>TID1</th>                   
                        <th>MID1</th>                   
                        <th>TID2</th>                   
                        <th>MID2</th>                   
                        <th>TID3</th>                   
                        <th>MID3</th>                   -->
            <th>Thao tác</th>
        </tr>
        <c:forEach items="${lst}" var="p">
            <tr>
                <td>${p.teninhoadon}</td>
                <td>${p.diachiLapdat}</td>
                <td>${p.soTktgtt}</td>
                <td>${p.tenchutk}</td>
                <td>${p.dongmay}</td>
                <td>${p.soseri}</td>    
<!--                <td class="number">${p.tid1}</td>
                <td class="number">${p.mid1}</td>
                <td class="number">${p.tid2}</td>
                <td class="number">${p.mid2}</td>
                <td class="number">${p.tid3}</td>
                <td class="number">${p.mid3}</td>-->
                <td><a href="editpos.html?id=${p.soseri}" class="edit"/>Edit</td>
            </tr>
        </c:forEach>

    </table>

    <table style="border: none; width: 100%">
        <tr style="border: none">
            <td style="border: none; visibility: hidden">
                <a href="exporteditinformation.html?id=${maDvcnt}" class="hoantat" target="_blank"><center>Xuất PYC</center></a>
            </td>
            <td>
                <form method="post" action="${pageContext.request.contextPath}/fileUploadEdit.do" enctype="multipart/form-data">
                    <input type="file" required  name="fileUploaded" class="xformUpload"/>  
                    <input type="submit" value="UPLOAD FILE" class="xformUpload" style="height: 20px"/>  
                    <span style="color: darkgreen; font-weight: bold">${uploadsuccess}</span>
                    <span style="color: red; font-weight: bold">${error}</span>
                </form>
            </td>
            <td style="border: none;">
                <a href="guiduyetchinhsuapos.html?id=${maDvcnt}" class="guiduyet2"><center>GỬI DUYỆT</center></a>
            </td>
        </tr>
        <tr style="border: none">
            <td colspan="3" style="border: none">
                <c:choose>
                    <c:when test="${error != null}">
                <center>
                    <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${noUseerror}</marquee>
                </center>
            </c:when>
        </c:choose>
    </td>
</tr>
</table>

<footer>
    <center>
        <h4><a href="index.html">Trở về trang chủ</a></h5>
            <span>-------------------------------------------------</span>
            <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
    </center>
</footer>
</body>
</html>
