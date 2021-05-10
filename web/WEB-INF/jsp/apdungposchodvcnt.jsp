<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ÁP DỤNG POS CHO ĐVCNT</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/themmoi.css"/>
    </head>
    <body>
    <center>
        <header class="header-pos">
            <ul class="breadcrumb">
                <li><a href="index.html">Trang chủ</a></li>
                <li><a href="#">Quản lý POS</a></li>
                <li>Áp dụng POS cho ĐVCNT</li>
            </ul>
            <center>
                <h2>ÁP DỤNG POS CHO ĐVCNT
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout">ĐĂNG XUẤT</a>
                    <span class="tennguoidung">${tennguoidung}</span>
                </h2>
            </center>
        </header>
    </center>
    <form action="${pageContext.request.contextPath}/xulythemmoipos" method="post">
        <center>
            <div class="content-pos">
                <table class="table-apdungpos">
                    <tr>
                        <th colspan="2"><center>Mã ĐVCNT</center></th>
                        <th colspan="2"><center>Dòng máy</center></th>                    
                    </tr>    
                    <tr>
                        <td colspan="2">
                            <center><input name="teninhoadon" value="${madvcnt}" size="10" disabled="disabled"/></center>
                        </td>
                        <td colspan="2">
                        <center><input name="diachilapdat" value="${dongnay}" size="10" disabled="disabled"/></center>
                        </td>
                    </tr> <br/> <br/>
                    <tr>
                        <td colspan="2"><center>Tên in trên hóa đơn</center></td>
                        <td colspan="2"><center>Địa chỉ lắp đặt</center></td>                    
                    </tr>    
                    <tr>
                        <td colspan="2">
                            <center><input name="teninhoadon" value="${teninhoadon}" size="30" disabled="disabled"/></center>
                        </td>
                        <td colspan="2">
                        <center><input name="diachilapdat" value="${diachilapdat}" size="30" disabled="disabled"/></center>
                        </td>
                    </tr>
                    <br/>
                    <tr>
                        <td colspan="2"><center>TID</center></td>
                        <td colspan="2"><center>MID</center></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <center>
                                 <input name="tid" value=""/>
                            </center>
                        </td>
                        <td colspan="2">
                            <center>
                                <input name="mid" value=""/>    
                            </center>
                        </td>
                    </tr>
                    <br/>
                    <tr>
                        <td colspan="4">
                            <center>SERI POS</center>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <center><input name="tid" value=""/></center>
                        </td>
                    </tr>
                    <tr>                    
                        <td colspan="4">
                    <center><br/>
                        <input type="submit" value="LƯU THÔNG TIN" class="submit-pos"/>
                    </center><br/>
                    </td>
                    </tr>
                </table>
                <h1>${error}</h1>
            </div>
        </center>
    </form>

    <footer>
        <center>

            <h4><a href="index.html"><i class="fa fa-home"></i>Trở về trang chủ</a></h5>
                <span>-------------------------------------------------</span>
                <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
        </center>
    </footer>

    <script src="<%=request.getContextPath()%>/resources/js/themmoipos.js"></script>
</body>
</html>
