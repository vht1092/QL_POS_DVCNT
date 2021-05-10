<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>DANH SÁCH POS</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/dsdvcnt.css"/>
    </head>
    <body>
    <center>
        <header class="header-dspos">
            <ul class="breadcrumb">
                <li><a href="index.html">Trang chủ</a></li>
                <li>
                    <div class="dropdown">
                        <button class="dropbtn">Quản lý POS</button>
                        <div class="dropdown-content">
                            <c:choose>
                                <c:when test="${groupuser == 7}">
                                    <a href="themmoipos.html">Nhập kho</a><br/>
                                </c:when>
                            </c:choose>
                            <a href="danhsachpos.html">Danh sách POS</a><br/>
                        </div>
                    </div>
                </li>
                <li>Danh sách POS</li>
            </ul>
            <center>
                <h2>DANH SÁCH POS
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> / ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <center>
        <div class="content">
            <div class="timkiem">
                <form action="${pageContext.request.contextPath}/search-pos-by-keyword" method="get" class="timkiembasic">
                    <p>Tìm kiếm theo: </p>
                    <select name="key-search">
                        <c:choose>
                            <c:when test="${keysearchbasic == '1'}">
                                <option value="1" selected="selected">MÃ ĐVCNT</option>
                            </c:when>
                            <c:otherwise>
                                <option value="1">MÃ ĐVCNT</option>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${keysearchbasic == '2'}">
                                <option value="2" selected="selected">DÒNG MÁY</option>
                            </c:when>
                            <c:otherwise>
                                <option value="2">DÒNG MÁY</option>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${keysearchbasic == '3'}">
                                <option value="3" selected="selected">SỐ SERI</option>
                            </c:when>
                            <c:otherwise>
                                <option value="3">SỐ SERI</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                    <c:choose>
                        <c:when test="${txtsearchbasic != ''}">
                            <input name="txtsearch" placeholder="Tìm kiếm..." class="txtTimKiem" value="${txtsearchbasic}"/>
                        </c:when>
                        <c:otherwise>
                            <input name="txtsearch" placeholder="Tìm kiếm..." class="txtTimKiem"/>        
                        </c:otherwise>
                    </c:choose>

                    <input type="submit" value="TÌM KIẾM" class="submit"/>
                </form>

                <form action="${pageContext.request.contextPath}/search-pos-by-status" method="get" class="timkiemstatus">                    
                    <span>Lọc theo tình trạng POS: </span>
                    <select name="key-search-status">
                        <c:choose>
                            <c:when test="${keysearch == '1'}">
                                <option value="1" selected="selected">----TẤT CẢ----</option>
                            </c:when>
                            <c:otherwise>
                                <option value="1">----TẤT CẢ----</option>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${keysearch == '2'}">
                                <option value="2" selected="selected">SỬ DỤNG</option>
                            </c:when>
                            <c:otherwise>
                                <option value="2">SỬ DỤNG</option>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${keysearch == '3'}">
                                <option value="3" selected="selected">Ton kho</option>
                            </c:when>
                            <c:otherwise>
                                <option value="3">Ton kho</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                    <input type="submit" value="TRA CỨU"/>
                </form>
                <input style="height: 30px; width: 100px; background-color: darkorange; margin-top: 8%; border-radius: 5px; font-weight: bold; cursor: pointer"
                       class="btn btn-danger" type="button"
                       onclick="tableToExcel('testTable', 'QLDVCNT-P.KTT&NHDT')"
                       value="Export">
            </div>
            <table rules="groups" frame="hsides" id="testTable"
                   class="table-dspos scroll"
                   style="width: 200%; table-layout: fixed; height: 50px;">
                <thead valign="top">                         
                    <tr>
                        <th>Dòng máy</th>
                        <th>Số seri</th>
                        <th>Tình trạng</th>
                        <th>Mã tài sản</th>
                        <th>Mã ĐVCNT</th>
                        <th>Tên ĐVCNT</th>
                        <th>Tên in HĐ</th>
                        <th>Địa chỉ lắp đặt</th>
                        <th>Số TKTGTT</th>
                        <th>Bank</th>
                        <th>TID</th>
                        <th>MID</th>                        
                        <th>LƯU POS</th>
                        <th>Ghi chú</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${lst}" var="p">
                        <c:choose>
                            <c:when test="${groupuser == 7 || groupuser == 9 }">                            
                                <tr class="row">
                                    <td>${p.dongmay}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.tinhtrangPos == 'Sử dụng'}">
                                                <span class="sudung">${p.soseri}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="tonkho">${p.soseri}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.tinhtrangPos == 'Sử dụng'}">
                                                <span class="sudung">${p.tinhtrangPos}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="tonkho">${p.tinhtrangPos}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${p.mataisan}</td>
                                    <td>${p.mid}</td>
                                    <td>${p.tenDvcnt}</td>
                                    <td>${p.teninhoadon}</td>
                                    <td>${p.diachiLapdat}</td>
                                    <td>${p.soTktgtt}</td>
                                    <td>${p.nganhang}</td>
                                    <td>${p.tid1}</td>
                                    <td>${p.mid1}</td>                                    
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.noiLuuPos != 'HO'}">
                                                <span class="sudung">${p.noiLuuPos}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="sudung">HO</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${p.ghichu}</td>
                                </tr>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${groupuser == 1 }">
                                <c:choose>
                                    <c:when test="${fn:substring(p.mid, 1, 4) == macn}">
                                        <tr class="row">
                                            <td>${p.dongmay}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.tinhtrangPos == 'Sử dụng'}">
                                                        <span class="sudung">${p.soseri}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="tonkho">${p.soseri}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.tinhtrangPos == 'Sử dụng'}">
                                                        <span class="sudung">${p.tinhtrangPos}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="tonkho">${p.tinhtrangPos}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${p.mataisan}</td>
                                            <td>${p.mid}</td>
                                            <td>${p.tenDvcnt}</td>
                                            <td>${p.teninhoadon}</td>
                                            <td>${p.diachiLapdat}</td>
                                            <td>${p.soTktgtt}</td>
                                            <td>${p.nganhang}</td>
                                            <td>${p.tid1}</td>
                                            <td>${p.mid1}</td>
                                            <td>${p.tid2}</td>
                                            <td>${p.mid2}</td>
                                            <td>${p.tid3}</td>
                                            <td>${p.mid3}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.noiLuuPos != 'HO'}">
                                                        <span class="sudung">${p.noiLuuPos}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="sudung">HO</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${p.ghichu}</td>
                                        </tr>
                                    </c:when>
                                </c:choose>                            
                            </c:when>
                        </c:choose>
                    </c:forEach>
                </tbody>
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
    <script>
        $(document).ready(
                function () {
                $("#testTable").children("tbody").children("tr").children(
                        "td").click(function () {
                $(this.parentNode).toggleClass("active");
                });
                });
    </script>
                <script>
    var tableToExcel = (function () {
var uri = 'data:application/vnd.ms-excel;base64,', template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>', base64 = function (
            s) {
    return window.btoa(unescape(encodeURIComponent(s)))
    }, format = function (s, c) {
return s.replace(/{(\w+)}/g, function (m, p) {
        return c[p];
    })
}
return function (table, name) {
    if (!table.nodeType)
        table = document.getElementById(table)
    var ctx = {
        worksheet: name || 'Worksheet',
        table: table.innerHTML
    }
    window.location.href = uri + base64(format(template, ctx))
}
})()
    </script>
</body>
</html>
