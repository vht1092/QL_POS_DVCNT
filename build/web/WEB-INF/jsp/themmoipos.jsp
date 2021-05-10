<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: white">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>NHẬP KHO MÁY POS</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/themmoi.css"/>
    </head>
    <body>
    <center>
        <header class="header-pos">
            <ul class="breadcrumb">
                <li><a href="index.html">Trang chủ</a></li>
                <li>
                    <div class="dropdown">
                        <button class="dropbtn">Quản lý POS</button>
                        <div class="dropdown-content">
                            <c:choose>
                                <c:when test="${groupuser == 1}">
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
                <h2>NHẬP KHO MÁY POS
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> / ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <form action="${pageContext.request.contextPath}/xulythemmoipos" method="get">
        <center>
            <div class="content-pos">
                <table style="width: 100%; height: auto;">
                    <tr>
                        <td>Dòng máy</td>
                        <td>Số seri</td>
                        <td>Mã tài sản</td>
                        <td>Số tờ trình mua sắm</td>
                    </tr>                    
                    <tr>
                        <td>
                            <select name="dongmay">
                                <option value="PAX_S90">PAX S90</option>
                                <option value="PAX_S78">PAX S78</option>
                                <option value="PAX_P70S">PAX P70-S</option>
                                <option value="PAX_P80">PAX P80</option>
                                <option value="PAX_78">PAX 78</option>
                                <option value="VX520">VX520</option>
                            </select>
                        </td>
                        <td>
                            <input name="soseri"  type="text" id="text" onblur="caps(this.id)" required/>
                        </td>
                    <script>

                        function caps(id) {
                            document.getElementById(id).value = document.getElementById(id).value.toUpperCase();
                        }
                    </script>

                    <td>
                        <input name="mataisan" maxlength="20" onkeypress="return keyPressWord(event);"/>
                    </td>
                    <td>
                        <input name="sototrinh" maxlength="10" onkeypress="return keyPressWord(event);"/>
                    </td>
                    </tr>
                    <tr>
                        <td>Ngày nhập kho</td>
                        <td colspan="3">Ghi chú</td>
                    </tr>
                    <tr>
                        <td>                            
                            <select name="ngay_nhapkho" value="" id="ngay_nhapkho"></select>
                            <select name="thang_nhapkho" value="" id="thang_nhapkho"></select>
                            <select name="nam_nhapkho" value="" id="nam_nhapkho"></select>
                        </td>
                        <td colspan="3">
                            <input name="ghichu" id="text2" onblur="caps(this.id)" size="70"/>
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
                <c:choose>
                    <c:when test="${successAddPos != null}">
                        <center>
                            <marquee style="font-weight: bold; float: left; color: red; background-color: yellow" behavior="alternate" width="45%%">${successAddPos}</marquee>
                        </center>
                    </c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${trungsoseri != null}">
                        <center>
                            <marquee style="font-weight: bold; float: left; color: red; background-color: yellow" behavior="alternate" width="45%%">${trungsoseri}</marquee>
                        </center>
                    </c:when>
                </c:choose>
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
    <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
</body>
</html>
