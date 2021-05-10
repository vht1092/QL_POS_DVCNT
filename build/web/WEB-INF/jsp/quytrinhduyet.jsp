<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>DUYỆT ĐVCNT ${id}</title>
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
                <li>Thông tin duyệt</li>
            </ul>
            <center>
                <h2>THEO DÕI QUÁ TRÌNH DUYỆT ĐVCNT "${id}"
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout">ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten} / &nbsp;</span>
                </h2>
            </center>
        </header>
    </center>

    <center>
        <div class="quytrinhduyet">
            <table class="table-quytrinhduyet" style="font-size: 13px">
                <!--(1)CN/PGD-->
                <tr style="background-color: #E3F2E1">
                    <td colspan="3"><center><b>(1)CN/PGD</b></center></td>
                </tr>
                <tr>
                    <td>
                        <c:choose>
                            <c:when test="${statusDuyet >= 3 && statusDvcnt != 2&& statusDvcnt != 3 && statusDvcnt != 4 && statusDvcnt != 5 && statusDvcnt != 8 && statusDvcnt != 9}">
                                <span class="chuyentiep">Đã thêm mới</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet >= 3 && statusDvcnt == 2}">
                                <span class="trave">YÊU CẦU EDIT THÔNG TIN ĐVCNT</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet >= 3 && statusDvcnt == 3}">
                                <span class="trave">YÊU CẦU EDIT 'THÔNG TIN' ĐVCNT</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet >= 3 && statusDvcnt == 4}">
                                <span class="trave">YÊU CẦU KHÓA POS</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet >= 3 && statusDvcnt == 5}">
                                <span class="trave">YÊU CẦU TẠM KHÓA POS</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet >= 3 && statusDvcnt == 8 || statusDvcnt == 9}">
                                <span class="trave">YÊU CẦU LẮP THÊM POS CHO ĐVCNT</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet == 0}">
                                <span class="trave">Đang tiếp nhận...</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td></td>
                    <td>
                <center>
                    <p>Ngày thêm ${_user1Donvi_NgayNhap}</p>
                    <p>User thực hiện: ${user1Donvi}</p>
                </center>
                </td>
                </tr>
                <!--(2)CN/PGD-->
                <tr style="background-color: #E3F2E1">
                    <td colspan="3"><center><b>(2)CN/PGD</b></center></td>
                </tr>
                <tr>
                    <td>
                        <c:choose>
                            <c:when test="${statusDuyet >= 4}">
                                <span class="chuyentiep">Chuyển tiếp</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet == 0}">
                                <span class="trave">Trả về</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet < 4 && statusDuyet > 0}">
                                <span class="dangcho">Đang chờ...</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${ghichu_user2Donvi != ''}">
                                <u><i>Ghi chú:</i></u> ${ghichu_user2Donvi}
                                </c:when>
                            </c:choose>
                    </td>
                    <td>
                <center>
                    <p>
                        <c:choose>
                            <c:when test="${_str_user2Donvi_NgayDuyet != ''}">
                                Ngày duyệt ${_str_user2Donvi_NgayDuyet}
                            </c:when>
                        </c:choose>
                    </p>
                    <p>
                        <c:choose>
                            <c:when test="${user2Donvi != ''}">
                                User thực hiện: ${user2Donvi}
                            </c:when>
                        </c:choose>
                    </p>
                </center>
                </td>
                </tr>
                <!--(1)P.QLKDTD-->
                <c:choose>
                    <c:when test="${loaiHinhDvcnt == 1}">
                        <tr style="background-color: #E3F2E1">
                            <td colspan="3"><center><b>(1)P.QLKDTD</b></center></td>
                        </tr>
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${statusDuyet == 15}">
                                        <span class="danhan">Đã nhận</span>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${statusDuyet >= 16 || (statusDuyet >= 7 && statusDuyet <= 13)}">
                                        <span class="chuyentiep">Chuyển tiếp</span>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${statusDuyet == 0}">
                                        <span class="trave">Trả về</span>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${(statusDuyet <= 14 && statusDuyet > 13) || (statusDuyet <= 5 && statusDuyet > 0)}">
                                        <span class="dangcho">Đang chờ...</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${ghichu_user1KHCN != ''}">
                                        <u><i>Ghi chú:</i></u> ${ghichu_user1KHCN}
                                        </c:when>
                                    </c:choose>
                            </td>
                            <td>
                        <center>
                            <p>
                                <c:choose>
                                    <c:when test="${_str_user1KHCN_NgayDuyet != ''}">
                                        Ngày duyệt: ${_str_user1KHCN_NgayDuyet}
                                    </c:when>
                                </c:choose>
                            </p>
                            <p>
                                <c:choose>
                                    <c:when test="${user1KHCN != ''}">
                                        User thực hiện: ${user1KHCN}
                                    </c:when>
                                </c:choose>
                            </p>
                        </center>
                        </td>
                        </tr>
                        <!--(2)P.QLKDTD-->
                        <tr style="background-color: #E3F2E1">
                            <td colspan="3"><center><b>(2)P.QLKDTD</b></center></td>
                        </tr>
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${statusDuyet == 7 || statusDuyet == 17 || (statusDuyet > 7 && statusDuyet <= 13)}">
                                        <span class="chuyentiep">Chuyển tiếp</span>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${statusDuyet == 0}">
                                        <span class="trave">Trả về</span>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${(statusDuyet > 13 && statusDuyet <= 16) || (statusDuyet < 7 && statusDuyet > 0)}">
                                        <span class="dangcho">Đang chờ...</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${ghichu_user2KHCN != ''}">
                                        <u><i>Ghi chú:</i></u> ${ghichu_user2KHCN}
                                        </c:when>
                                    </c:choose>
                            </td>
                            <td>
                        <center>
                            <p>
                                <c:choose>
                                    <c:when test="${_str_user2KHCN_NgayDuyet != ''}">
                                        Ngày duyệt ${_str_user2KHCN_NgayDuyet}
                                    </c:when>
                                </c:choose>
                            </p>
                            <p>
                                <c:choose>
                                    <c:when test="${user2KHCN != ''}">
                                        User thực hiện: ${user2KHCN}
                                    </c:when>
                                </c:choose>
                            </p>
                        </center>
                        </td>
                        </tr>
                    </c:when>
                </c:choose>
                <!--(1)P.SP&CS KHDN-->
                <c:choose>
                    <c:when test="${loaiHinhDvcnt == 2}">
                        <tr style="background-color: #E3F2E1">
                            <td colspan="3"><center><b>(1)P.SP&CS KHDN</b></center></td>
                        </tr>
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${statusDuyet == 5}">
                                        <span class="danhan">Đã nhận</span>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${statusDuyet >= 6}">
                                        <span class="chuyentiep">Chuyển tiếp</span>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${statusDuyet == 0}">
                                        <span class="trave">Trả về</span>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${statusDuyet < 5 && statusDuyet > 0}">
                                        <span class="dangcho">Đang chờ...</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${ghichu_user1KHDN != ''}">
                                        <u><i>Ghi chú:</i></u> ${ghichu_user1KHDN}
                                        </c:when>
                                    </c:choose>
                            </td>
                            <td>
                        <center>
                            <p>
                                <c:choose>
                                    <c:when test="${_str_user1KHDN_NgayDuyet != ''}">
                                        Ngày duyệt: ${_str_user1KHDN_NgayDuyet}
                                    </c:when>
                                </c:choose>
                            </p>
                            <p>
                                <c:choose>
                                    <c:when test="${user1KHDN != ''}">
                                        User thực hiện: ${user1KHDN}
                                    </c:when>
                                </c:choose>
                            </p>
                        </center>
                        </td>
                        </tr>
                        <!--(2)P.SP&CS KHDN-->
                        <tr style="background-color: #E3F2E1">
                            <td colspan="3"><center><b>(2)P.SP&CS KHDN</b></center></td>
                        </tr>
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${statusDuyet >= 7}">
                                        <span class="chuyentiep">Chuyển tiếp</span>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${statusDuyet == 0}">
                                        <span class="trave">Trả về</span>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${statusDuyet < 7 && statusDuyet > 0}">
                                        <span class="dangcho">Đang chờ...</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${ghichu_user2KHDN != ''}">
                                        <u><i>Ghi chú:</i></u> ${ghichu_user2KHDN}
                                        </c:when>
                                    </c:choose>
                            </td>
                            <td>
                        <center>
                            <p>
                                <c:choose>
                                    <c:when test="${_str_user2KHDN_NgayDuyet != ''}">
                                        Ngày duyệt ${_str_user2KHDN_NgayDuyet}
                                    </c:when>
                                </c:choose>
                            </p>
                            <p>
                                <c:choose>
                                    <c:when test="${user2KHDN != ''}">
                                        User thực hiện: ${user2KHDN}
                                    </c:when>
                                </c:choose>
                            </p>
                        </center>
                        </td>
                        </tr>
                    </c:when>
                </c:choose>
                <!--(1)P.KTT&NHS-->
                <tr style="background-color: #E3F2E1">
                    <td colspan="3"><center><b>(1)P.KTT&NHS</b></center></td>
                </tr>
                <tr>
                    <td>
                        <c:choose>
                            <c:when test="${statusDuyet > 9 && loaiHinhDvcnt == 2}"><!--KH DOANH NGHIEP-->
                                <span class="chuyentiep">Chuyển tiếp</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet > 17 && loaiHinhDvcnt == 1}"><!--HO KINH DOANH-->
                                <span class="chuyentiep">Chuyển tiếp</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${(statusDuyet == 12 || statusDuyet == 13) && loaiHinhDvcnt == 1}"><!--HO KINH DOANH-->
                                <span class="chuyentiep">Chuyển tiếp</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet == 8}">
                                <span class="danhan">Đã nhận</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet == 9}">
                                <span class="chuyentiep">Duyệt -> Gửi phiếu yêu cầu sang VTB...</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet == 10}">
                                <span class="chuyentiep">Đang map thông số...</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet == 11}">
                                <span class="chuyentiep">Đã map thông số...</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet == 12}">
                                <!--                                <span class="chuyentiep">Đã gửi duyệt</span>-->
                            </c:when>
                        </c:choose>

                        <c:choose>
                            <c:when test="${statusDuyet == 0}">
                                <span class="trave">Trả về</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet < 8 && statusDuyet > 0}">
                                <span class="dangcho">Đang chờ...</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet > 13 && statusDuyet <= 17}">
                                <span class="dangcho">Đang chờ...</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${ghichu_user1TNT != ''}">
                                <u><i>Ghi chú:</i></u> ${ghichu_user1TNT}
                                </c:when>
                            </c:choose>
                    </td>
                    <td>
                <center>
                    <p>
                        <c:choose>
                            <c:when test="${_str_user1TNT_NgayDuyet != ''}">
                                Ngày duyệt: ${_str_user1TNT_NgayDuyet}
                            </c:when>
                        </c:choose>
                    </p>
                    <p>
                        <c:choose>
                            <c:when test="${user1TNT != ''}">
                                User thực hiện: ${user1TNT}
                            </c:when>
                        </c:choose>
                    </p>
                </center>
                </td>
                </tr>
                <!--(2)P.KTT&NHS-->
                <tr style="background-color: #E3F2E1">
                    <td colspan="3"><center><b>(2)P.KTT&NHS</b></center></td>
                </tr>
                <tr>
                    <td>
                        <c:choose>                        
                            <c:when test="${statusDuyet == 0}">
                                <span class="trave">Trả về</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet < 13 && statusDuyet > 0}">
                                <span class="dangcho">Đang chờ...</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet > 13}">
                                <span class="dangcho">Đang chờ...</span>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet == 13}">
                                <span class="chuyentiep">Hoàn tất tạo thông số</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${ghichu_user2TNT != ''}">
                                <u><i>Ghi chú:</i></u> ${ghichu_user2TNT}
                                </c:when>
                            </c:choose>
                    </td>
                    <td>
                <center>
                    <p>
                        <c:choose>
                            <c:when test="${_str_user2TNT_NgayDuyet != ''}">
                                Ngày duyệt: ${_str_user2TNT_NgayDuyet}
                            </c:when>
                        </c:choose>
                    </p>
                    <p>
                        <c:choose>
                            <c:when test="${user2TNT != ''}">
                                User thực hiện: ${user2TNT}
                            </c:when>
                        </c:choose>
                    </p>
                </center>
                </td>
                </tr>
            </table>
        </div>
    </center>

    <footer>
        <center>

            <h4><a href="index.html"><i class="fa fa-home"></i>Trở về trang chủ</a></h5>
                <span>-------------------------------------------------</span>
                <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
        </center>
    </footer>

    <script src="<%=request.getContextPath()%>/resources/js/dangkydvcnt.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>   
</body>
</html>
