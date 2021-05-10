<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>DANH SÁCH DÒNG MÁY (${size})</h1>
        <table class="table-dspos">                
            <tr>
                <th>Mã</th>
                <th>Dòng máy</th>
            </tr>

            <c:forEach items="${lst}" var="p">
                <tr class="row">
                    <td>${p.maPos}</td>
                    <td>${p.dongmay}</td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
