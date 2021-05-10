<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>CHI TIẾT THÔNG TIN LẮP ĐẶT</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/dsdvcnt.css"/>
    </head>
    <body>
    <center>
        <header>
            <ul class="breadcrumb">
                <li><a href="index.html">Trang chủ</a></li>
                <li><a href="#">Quản lý ĐVCNT</a></li>
                <li>Xem thông tin lắp đặt POS</li>
            </ul>
            <center>
                <h2>XEM THÔNG TIN LẮP ĐẶT POS
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout">ĐĂNG XUẤT</a>
                    <span class="tennguoidung">${tennguoidung}</span>
                </h2>
            </center>
        </header>
    </center>
    <center>
        <div class="content">
            <table class="dvcnt-pendding">                
                <tr>
                    <th>Mã ĐVCNT</th>
                    <th>Tên in trên hóa đơn</th>
                    <th>Dòng máy</th>
                    <th>Địa chỉ lắp đặt</th>
                    <th>Số TK TGTT</th>
                    <th>Tên chủ TK</th>
                    <th>TID 1</th>
                    <th>MID 1</th>
                    <th>TID 2</th>
                    <th>MID 2</th>
                    <th>TID 3</th>
                    <th>MID 4</th>
                </tr>

                <c:forEach items="${lst}" var="p">
                    <tr class="row">
                        <td>${p.mid}</td>
                        <td>${p.teninhoadon}</td>
                        <td><a>${p.dongmay}</a></td>
                        <td>${p.diachiLapdat}</td>
                        <td>${p.soTktgtt}</td>
                        <td>${p.tenchutk}</td>
                        <td>${tid1}</td>
                        <td>${p.mid1}</td>
                        <td>${p.tid2}</td>
                        <td>${p.mid2}</td>
                        <td>${p.tid3}</td>
                        <td>${p.mid3}</td>
                    </tr>

                </c:forEach>
            </table>
            <a href="themthongtinlapdatpos.html?id=${mid}" class="hoantat"><center>LẮP THÊM POS</center></a>
        </div>
        <center>
                <table style="margin-top: 10%; width: 80%; ">
                    <c:forEach items="${lstsoluong}" var="p1">
                        <tr>
                            <th>PAX_S90</th>                    
                            <th>PAX_S78</th>                    
                            <th>PAX_P70S</th>                    
                            <th>PAX_P80</th>                    
                            <th>PAX_78</th>                    
                            <th>VX520</th>                    
                        </tr>
                        <tr>
                            <td>${p1.paxS90}</td>
                            <td>${p1.paxS78}</td>
                            <td>${p1.paxP70s}</td>
                            <td>${p1.paxP80}</td>
                            <td>${p1.pax78}</td>
                            <td>${p1.vx520}</td>
                        </tr>
                    </c:forEach>
                </table>
            </center>
    </center>

    <footer>
        <center>
            <h4><a href="index.html">Trở về trang chủ</a></h5>
                <span>-------------------------------------------------</span>
                <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
        </center>
    </footer>
</center>
</body>
</html>
