<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>ĐVCNT LẮP THÊM POS</title>
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
                            <a href="#">Edit ĐVCNT</a><br/>
                            <a href="#">Tạm khóa, đóng</a><br/>
                        </div>
                    </div>
                </li>
                <li>Thông tin ĐVCNT</li>
            </ul>
            <center>
                <h2>THÔNG TIN ĐƠN VỊ CHẤP NHẬN THẺ
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout">ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>

    <center>
        <div class="content" style="height: auto">
            <table style="width: 100%; height: auto">
                <tr>
                    <th colspan="4">THÔNG TIN ĐVCNT</th>
                </tr>
                <tr>
                    <td colspan="4">Tên đơn vị đăng ký kinh doanh: <b>${tenDvcntVn}</td>
                </tr>                    
                <tr>
                    <td colspan="4">Tên tiếng Anh: <b>${tenDvcntEn}</b></td>
                </tr>                    
                <tr>
                    <td colspan="4">Địa chỉ: <b>${diachiDvcnt}</td>
                </tr>
                <tr>
                    <td colspan="4">Điện thoại: <b>${sdtDvcnt}</td>
                </tr>
                <tr>
                    <td colspan="1">GPĐKKD số: <b>${gpdkkdso}</td>
                    <td colspan="1">Ngày cấp: <b>${_GpdkkdNgaycap}</td>
                    <td colspan="2">Nơi cấp: <b>${gpdkkdNoicap}</td>
                </tr>
                <tr>
                    <td>Người đại diện theo pháp luật trên GPĐKKD: <b>${gpdkkdTennguoidaidien}</td>
                </tr>
                <tr>
                    <td colspan="4">Chức vụ: <b>${gpdkkdChucvu}</td>
                </tr>
                <tr>
                    <td colspan="1">CMT/CCCD/Hộ chiếu: <b>${gpdkkdCmnd}</td>
                    <td colspan="1">Ngày cấp: <b>${_GpdkkdNgaycapCmnd}</td>
                    <td colspan="2">Nơi cấp: <b>${gpdkkdNoicapCmnd}</td>
                </tr>
                <tr>
                    <td colspan="4">Mã số thuế: <b>${masothue}</td>
                </tr>
                <tr>
                    <td colspan="4">Người đại diện ký kết hợp đồng ĐVCNT: <b>${tennguoiKyhopdong}</td>
                </tr>
                <tr>
                    <td colspan="4">Chức vụ: <b>${chucvuHopdong}</td>
                </tr>
                <tr>
                    <td colspan="1">CMT/CCCD/Hộ chiếu: <b>${cmndHopdong}</td>
                    <td colspan="1">Ngày cấp: <b>${_NgaycapCmndHopdong}</td>
                    <td colspan="2">Nơi cấp: <b>${noicapCmndHopdong}</td>
                </tr>
                <tr>
                    <td colspan="2">Theo ủy quyền số (nếu có): <b>${soUyquyen}</td>
                    <td colspan="2">Ngày ủy quyền: <b>${_NgayUyquyen}</td>
                </tr>
                <tr>
                    <td colspan="4">Đang hợp tác với ngân hàng khác: <b>${nganhangHoptac}</td>
                </tr>
                <tr>
                    <td colspan="4">Loại hình ĐVCNT: 
                        <c:choose>
                            <c:when test="${loaihinhDvcnt == 1}">
                                <b>Hộ kinh doanh</b>
                            </c:when>
                            <c:otherwise>
                                <b>Tổ chức</b>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th colspan="4">KẾT QUẢ KHẢO SÁT</th>
                </tr>
                <tr>
                    <td colspan="4">Ngành nghề kinh doanh: <b>${nganhnghekd}</td>
                </tr>
                <tr>
                    <td colspan="4">Doanh số thanh toán thẻ dự kiến theo tháng: <b>${doanhsothanhtoandukien}</td>
                </tr>
                <tr>
                    <td colspan="4">Xếp loại theo kết quả khảo sát: <b>${xeploai}</td>
                </tr>
                <tr>
                    <td colspan="4">Lần đăng ký lắp POS: <b>${landk}</td>
                </tr>
                <tr>
                    <td colspan="4">Loại tiền thanh toán: <b>${loaitien}</td>
                </tr>
                <tr>
                    <th colspan="4">
                        ĐĂNG KÝ GIAO DỊCH ĐẶC BIỆT
                    </th>
                </tr>
                <tr>
                    <td colspan="4">
                        <c:choose>
                            <c:when test="${gddb1 == 1}">
                                </br><p>Giao dịch không xuất trình thẻ (MOTO) (**)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb2 == 1}">
                                <p>Giao dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb3 == 1}">
                                <p>Giao dịch Điều chỉnh (Adjust) (***)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb4 == 1}">
                                <p>Giao dịch Ngoại tuyến (OFFLINE) (***)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb5 == 1}">
                                <p>Chức năng nhập tiền TIP</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb6 == 1}">
                                <p>Giao dịch thanh toán nhập tay số thẻ (***)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb7 == 1}">
                                <p>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb8 == 1}">
                                <p>Thực hiện nhập tay số thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</p></br>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${gddb9 == 1}">
                                <p>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</p></br>
                            </c:when>
                        </c:choose>

                        <c:choose>
                            <c:when test="${tienkyquyMoto != ''}">
                                <p>Số tiền ký quỹ khi sử dụng dịch vụ MOTO: <b>${tienkyquyMoto}</p></br>
                            </c:when>
                            <c:otherwise>

                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="luuy">
                        <div>
                            <p>(*) Áp dụng với POS thanh toán xử lý qua hệ thống VTB</p>
                            <p>(**) Áp dụng ĐVCNT thuộc mô hình khách sạn, dịch vụ lưu trú ngắn ngày</p>
                            <p>(***) Áp dụng với ĐVCNT là khách sạn 3* trở lên.</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th colspan="4">
                        LOẠI THẺ CHẤP NHẬN THANH TOÁN & PHÍ CHIẾT KHẤU <i>(Đơn vị: % - Đã bao gồm VAT)</i>
                    </th>
                </tr>
            </table>
            <table id="table-loaithe">
                <tr>
                    <th>Loại thẻ</th>
                    <th>Chấp nhận</th>
                    <th>Mức phí(gồm VAT)</th>
                </tr>
                <tr>
                    <td>Thẻ ghi nợ nội địa SCB</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiGhinoscb != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiGhinoscb != ''}">
                        <center>${phiGhinoscb}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ ghi nợ nội địa liên minh</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiGhinoLienminh != ''}">
                        <center>X</center>
                        </c:when>
                        <c:otherwise></c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiGhinoLienminh != ''}">
                        <center>${phiGhinoLienminh}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ MC/VS phát hành trong nước</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiVisa != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiVisa != ''}">
                        <center>${phiVisa}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ MC/VS phát hành nước ngoài</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiMastercard != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiMastercard != ''}">
                        <center>${phiMastercard}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ JCB, JCB Class, JBC Grande, JBC Card</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiJcb != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiJcb != ''}">
                        <center>${phiJcb}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ CUP</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiCup != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiCup != ''}">
                        <center>${phiCup}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ DinnerClub, Discover</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiDiscover != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiDiscover != ''}">
                        <center>${phiDiscover}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ khác</td>
                    <td>
                        <c:choose>
                            <c:when test="${tenThekhac != ''}">
                        <center>${tenThekhac}</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiThekhac != ''}">
                        <center>${phiThekhac}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
            </table></br>
            <table class="thongtinlapdat">
                <tr>
                    <th colspan="12">THÔNG TIN LẮP ĐẶT POS</th></br>
                </tr>
                <tr>
                    <th>Tên in trên hóa đơn: </th> 
                    <th>Địa chỉ lắp đặt: </th>
                    <th>Số TK TGTT báo có: </th>
                    <th>Tên chủ TK</th>                    
                    <th>Loại máy</th>                   
                    <th>Seri</th>                   
                    <th>TID1</th>                   
                    <th>MID1</th>                   
                    <th>TID2</th>                   
                    <th>MID2</th>                   
                    <th>TID3</th>                   
                    <th>MID3</th>                   
                </tr>
                <c:forEach items="${lst}" var="p">
                    <tr>
                        <td>${p.teninhoadon}</td>
                        <td>${p.diachiLapdat}</td>
                        <td>${p.soTktgtt}</td>
                        <td>${p.tenchutk}</td>
                        <td>${p.dongmay}</td>
                        <td>${p.soseri}</td>    
                        <td class="number">${p.tid1}</td>
                        <td class="number">${p.mid1}</td>
                        <td class="number">${p.tid2}</td>
                        <td class="number">${p.mid2}</td>
                        <td class="number">${p.tid3}</td>
                        <td class="number">${p.mid3}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <c:choose>
            <c:when test="${groupuser == 1 && statusDuyet == 13 && statusDvcnt == 0}">
                </br>        
                <div class="_xacNhanBanGiao">
                    <a href="xacnhanbangiao.html" class="xacNhanBanGiao">XÁC NHẬN ĐÃ LẮP ĐẶT CHO ĐƠN VỊ</a>
                </div>
                </br>
            </c:when>
        </c:choose>
    </center>
</form>
</br>
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
