<%@page import="java.text.DecimalFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PREVIEW & EXPORT</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/export.css"/>

        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
        <script type="text/javascript">
            $("#btnPrint").live("click", function () {
                var divContents = $("#dvContainer").html();
                var printWindow = window.open('', '', 'height=3508,width=2480');
                printWindow.document.write('</head><body>');
                printWindow.document.write(divContents);
                printWindow.document.write('</body></html>');
                printWindow.document.close();
                printWindow.print();
            });
        </script>
    </head>
    <body>
    <center>
        <input type="button" value="IN THÔNG TIN" id="btnPrint" class="btnPrint" style="position: fixed"/>
    </center>
    <form id="form1" style="font-size: 14px">
        <center>
            <div class="content" id="dvContainer">
                <table class="table1">
                    <tr class="boldtext">
                        <td class="title-export">
                            <p class="scb"><b>NGÂN HÀNG TMCP SÀI GÒN <br/><span style="margin-left: 10px; font-size: 14px; text-decoration: underline">ĐƠN VỊ: ${macn} - CN ${tencn}</b></span></p></br></br>
                            <p></p>
                            <p></p>
                        </td>
                        <td colspan="2">
                            <!--floatRight title-export chxhcnvn--> 
                            <p class="" style="font-size: 15px; margin-left: 55px"><b>CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM</b></p>
                            <p style="margin-left: 110px; text-decoration: underline"><b>Độc lập – Tự do – Hạnh phúc</b></p>
                            <p class="ngaythangnam" style="margin-left: 65px;"><i>TP. Hồ Chí Minh, ngày ${day} tháng ${month} năm ${year}</i></p>
                        </td>
                    </tr>
                    <tr>
                    <center><th colspan="3" style="padding-top: 4%; margin-left: 5%"><center><h2> &nbsp;&nbsp;&nbsp; BẢN MÔ TẢ THÔNG TIN ĐƠN VỊ CHẤP NHẬN THẺ</h2></center></th></center>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top: 2%"><h3 style="float: left; text-decoration: underline">A. THÔNG TIN ĐVCNT</h3></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="floatLeft">Tên đơn vị đăng ký kinh doanh: <b>${tendonviVn}</b></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="floatLeft">Tên tiếng Anh: <b>${tendonviEn}</b></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="floatLeft">Địa chỉ: <b>${diachi}</b></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="floatLeft">Điện thoại: <b>${sdtdvcnt}</b></td>
                    </tr>
                    <tr>
                        <td class="floatLeft" colspan="3">
                            Giấy chứng nhận đăng ký kinh doanh số: <b>${soGpdkkd}</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="float: left">Ngày cấp: <b>${GpdkkdNgaycap}</b></span>
                        </td>
                        <td>
                            Nơi cấp: <b>${noiCapGpkd}</b>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="floatLeft">Mã số thuế: <b>${masothue}</b></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            Người đại diện theo pháp luật trên GPĐKKD: <b>${tenNguoidaidien}</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            Chức vụ: <b>${GpdkkdChucvu}</b>
                        </td>
                    </tr>
                    <tr>
                        <td class="floatLeft">
                            CMT/CCCD/Hộ chiếu: <b>${GpdkkdCmnd}</b>
                        </td>
                        <td>
                            <span style="float: left">Ngày cấp: <b>${GpdkkdNgaycapCmnd}</b></span>
                        </td>
                        <td>
                            Nơi cấp: <b>${GpdkkdNoicap}</b>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="3" class="floatLeft">Người đại diện ký kết hợp đồng ĐVCNT: <b>${nguoidaidienkyhopdong}</b></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            Chức vụ: <b>${ChucVuNguoiyhopdong}</b>
                        </td>
                    </tr>
                    <tr>
                        <td class="floatLeft">
                            CMT/CCCD/Hộ chiếu: <b>${CmndNguoiyhopdong}</b>
                        </td>
                        <td>
                            <span style="float: left">Ngày cấp: <b>${NgaycapCmndHopdong}</b></span>
                        </td>
                        <td>
                            Nơi cấp: <b>${NoiCapCmndNguoiyhopdong}</b>
                        </td>
                    </tr>
                    <tr>
                        <td class="floatLeft">
                            Theo ủy quyền số (nếu có):  <b>${souyquyen}</b>
                        </td>
                        <td>
                            <span style="float: left">Ngày ủy quyền: <b>${ngayuyquyen}</b></span>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            Đang hợp tác với ngân hàng khác: <b>${nganhanghoptac}</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top: 2%"><h3 style="float: left; text-decoration: underline">B. KẾT QUẢ KHẢO SÁT</h3></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            Ngành nghề kinh doanh: <b>${nganhnghekinhdoanh}</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            Doanh số thanh toán thẻ dự kiến theo tháng: <b>${doanhsodukien} VNĐ/máy</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            Xếp loại theo kết quả khảo sát: <b>${xeploai}</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            Đăng ký lắp POS: <b>Lần ${landk}</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            Số lượng POS cần lắp đặt : <b>${soluongdk}</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top: 2%"><h3 style="float: left; text-decoration: underline">NHÂN VIÊN QUẢN LÝ ĐVCNT:</h3></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            Direct: <b>${get_direct_employee}</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text">
                            InDirect: <b>${get_inDirect_employee}</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top: 2%"><h3 style="float: left; text-decoration: underline">C. THÔNG TIN POS LẮP ĐẶT</h3></td>
                    </tr>
                    <%
                        int index = 1;
                    %>
                    <c:forEach items="${lstPosTemp}" var="p1">
                        <c:choose>
                            <c:when test="${p1.ismapping != 1 && p1.ismapping != 3}">
                                <tr>
                                    <td class="text" colspan="3">
                                                <p><b><%out.println(String.format("%d", index));%>. Máy POS <%out.println(String.format("%d", index));
                                                    index++;%></b></p>
                                        <p>Tên in trên hóa đơn: <b>${p1.teninhoadon}</b></p>
                                        <p>Địa chỉ lắp đặt: <b>${p1.diachiLapdat}</b></p>
                                        <p>Số TK TGTT báo có: <b>${p1.soTktgtt}</b></p>
                                        <p>Tên chủ TK: <b>${p1.tenchutk}</b></p>
                                        <p>Loại máy: <b>${p1.dongmay}</b></p>
                                        <p>Số tiền ký quỹ khi sử dụng dịch vụ MOTO(VNĐ): <b>
                                                <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                                                <fmt:formatNumber pattern="#,##0" value="${p1.phimo}" />
                                            </b></p>
                                        <p>Hạn mức VND: <b>
                                                <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                                                <fmt:formatNumber pattern="#,##0" value="${p1.hanmucVnd}" />
                                            </b></p>
                                        <p>Hạn mức USD: <b>
                                                <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                                                <fmt:formatNumber pattern="#,##0" value="${p1.hanmucUsd}" />
                                            </b></p>
                                        <p>Ngành nghề:
                                            <c:choose>
                                                <c:when test="${p1.tenNganhNghe == 'A'}">
                                                    A - ĂN UỐNG (bao gồm quán ăn nhà hàng, quán nước , cafe trà sữa..)
                                                </c:when>                                                
                                                <c:when test="${p1.tenNganhNghe == 'B'}">
                                                    B - THỜI TRANG (bao gồm kinh doanh quần áo, giày dép, phụ kiện hóa mỹ phẩm….)
                                                </c:when>                                                
                                                <c:when test="${p1.tenNganhNghe == 'C'}">
                                                    C - TRUNG TÂM THƯƠNG MẠI, SIÊU THỊ (bao gồm cửa hàng, tạp hóa mini, siêu thị nội thất…)
                                                </c:when>                                                
                                                <c:when test="${p1.tenNganhNghe == 'D'}">
                                                    D - KHÁCH SẠN ( bao gồm nhà nghỉ, Motel, khách sạn, resort, kinh doanh nhà trọ bất động sản…)
                                                </c:when>
                                                <c:when test="${p1.tenNganhNghe == 'E'}">
                                                    E - DU LỊCH ( bao gồm dịch vụ liên quan đến du lịch như cty du lịch, bán vé máy bay...)
                                                </c:when>
                                                <c:when test="${p1.tenNganhNghe == 'F'}">
                                                    F - KHÁC
                                                </c:when>
                                            </c:choose></p>
                                        <p><i>GIAO DỊCH ĐẶC BIỆT</i></p>
                                        <p>
                                            <c:choose>
                                                <c:when test="${p1.gddb1 == 1}">
                                                    <input name="gddb1" value="1" checked="checked" type="checkbox" id="gd1"/>
                                                    <label for="gd1"><span></span>Giao dịch không xuất trình thẻ (MOTO) (**)</label>
                                                        </c:when>

                                            </c:choose>
                                        </p>    
                                        <p>
                                            <c:choose>
                                                <c:when test="${p1.gddb2 == 1}">
                                                    <input name="gddb2" value="1" checked="checked" type="checkbox" id="gd2"/>
                                                    <label for="gd2"><span></span>Giao dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</label>
                                                        </c:when>

                                            </c:choose>
                                        </p>
                                        <p>
                                            <c:choose>
                                                <c:when test="${p1.gddb3 == 1}">
                                                    <input name="gddb3" checked="checked" value="1" type="checkbox" id="gd3"/>
                                                    <label for="gd3"><span></span>Giao dịch Điều chỉnh (Adjust) (***)</label>
                                                        </c:when>

                                            </c:choose>
                                        </p>
                                        <p>
                                            <c:choose>
                                                <c:when test="${p1.gddb4 == 1}">
                                                    <input name="gddb4"  checked="checked" value="1" type="checkbox" id="gd4"/>
                                                    <label for="gd4"><span></span>Giao dịch Ngoại tuyến (OFFLINE) (***)</label>
                                                        </c:when>

                                            </c:choose>
                                        </p>
                                        <p>
                                            <c:choose>
                                                <c:when test="${p1.gddb5 == 1}">
                                                    <input checked="checked" name="gddb5" value="1" type="checkbox" id="gd5"/>
                                                    <label for="gd5"><span></span>Chức năng nhập tiền TIP</label>
                                                        </c:when>

                                            </c:choose>
                                        </p>
                                        <p>
                                            <c:choose>
                                                <c:when test="${p1.gddb6 == 1}">
                                                    <input name="gddb6" checked="checked" value="1" type="checkbox" id="gd6"/>
                                                    <label for="gd6"><span></span>Giao dịch thanh toán nhập tay số thẻ (***)</label>
                                                        </c:when>

                                            </c:choose>
                                        </p>
                                        <p>
                                            <c:choose>
                                                <c:when test="${p1.gddb7 == 1}">
                                                    <input name="gddb7" checked="checked" value="1" type="checkbox" id="gd7"/>
                                                    <label for="gd7"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</label>
                                                        </c:when>

                                            </c:choose>
                                        </p>
                                        <p>
                                            <c:choose>
                                                <c:when test="${p1.gddb8 == 1}">
                                                    <input name="gddb8" checked="checked" value="1" type="checkbox" id="gd8"/>
                                                    <label for="gd8"><span></span>Nhập tay số thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                                        </c:when>

                                            </c:choose>
                                        </p>
                                        <p>
                                            <c:choose>
                                                <c:when test="${p1.gddb9 == 1}">
                                                    <input name="gddb9" checked="checked" value="1" type="checkbox" id="gd9"/>
                                                    <label for="gd9"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                                        </c:when>

                                            </c:choose>
                                        </p>
                                        <p>&nbsp;</p>
                                        <span>------------------------------------------------------------------------------------------</span></br>
                                    </td>
                                </tr>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                    <tr>
                        <td colspan="3" style="padding-top: 2%"><h3 style="float: left; text-decoration: underline">D.LOẠI THẺ CHẤP NHẬN THANH TOÁN VÀ PHÍ THU ĐVCNT</h3></td>
                    </tr>
                </table>
                <center>
                    <table id="table-loaithe" border="1" style="border-collapse: collapse">
                        <tr>
                            <th>Loại thẻ</th>
                            <th>Chấp nhận</th>
                            <th>Mức phí(% / gồm VAT)</th>
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
                                    <c:when test="${tenthekhac != ''}">
                                <center>${tenthekhac}</center>
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
                    </table>
                    <table class="table1" style="height: 500px">
                        <tr>
                            <td colspan="3" style="padding-top: 2%"><h3 style="float: left; text-decoration: underline">E. LOẠI TIỀN THANH TOÁN</h3></td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <c:choose>
                                    <c:when test="${loaitien == 'VND'}">
                                        <p>Việt Nam Đồng</p>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${loaitien == 'USD'}">
                                        <p>Đô La Mỹ</p>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${loaitien == 'VND/USD'}">
                                        <p>Việt Nam Đồng & Đô La Mỹ</p>
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3"><center>____________________________________________________________________________________________________</center></td>
                        </tr>
                        </br></br></br>
                        <tr style="height: 80px">
                            <td style="padding-top: 1%"><h3><center>TRƯỞNG ĐƠN VỊ</center></h3></td>
                            <td colspan="3" style="padding-top: 1%"><h3><center>LẬP BẢNG</center></h3></td>
                        </tr>
                        <tr style="height: 200px; background-color: red">
                            <td style="padding-top: 0%"><h3><center>${userDuyetDonVi}</center></h3></td>
                            <td colspan="3" style="padding-top: 0%"><h3><center>${userNhapDonVi}</center></h3></td>
                        </tr>
                        <tr>
                            <td colspan="3"><center>____________________________________________________________________________________________________</center>
                        </br>
                        <p><h3 style="float: left">Phần dành cho P.QLKD KHDN/P.QLKD SPTD:</h3></p>  
                        </br><p style="float: right; margin-right: 8%">Ngày........tháng........năm........</p>
                        </br></br><p>..........................................................................................................................................................................................................................</p>
                        </br><p>..........................................................................................................................................................................................................................</p>                        
                        </br><p>..........................................................................................................................................................................................................................</p>
                        </br><p>..........................................................................................................................................................................................................................</p>
                        </td>
                        </tr>
                        <tr style="height: 200px">
                            <td style="padding-top: 1%"><h3><center>TRƯỞNG ĐƠN VỊ</center></h3></td>
                            <td colspan="3" style="padding-top: 1%"><h3><center>LẬP BẢNG</center></h3></td>
                        </tr>
                        <tr>
                            <td colspan="3"><center>____________________________________________________________________________________________________</center>
                        </br>
                        <p><h3 style="float: left">Phần dành cho P.KT & VH Thẻ & NHS:</h3></p>  
                        </br><p style="float: right; margin-right: 8%">Ngày........tháng........năm........</p>
                        </br><p>..........................................................................................................................................................................................................................</p>
                        </br><p>..........................................................................................................................................................................................................................</p>                        
                        </br><p>..........................................................................................................................................................................................................................</p>
                        </br><p>..........................................................................................................................................................................................................................</p>
                        </td>
                        </tr>
                        <tr style="height: 80px">
                            <td style="padding-top: 2%"><h3><center>TRƯỞNG ĐƠN VỊ</center></h3></td>
                            <td colspan="3" style="padding-top: 2%"><h3><center>LẬP BẢNG</center></h3></td>
                        </tr>                        
                    </table>
                </center>
            </div>
        </center>
        <!--        <center>
                    <input type="button" value="PRINT THIS FILE" id="btnPrint" class="btnPrint"/>
                </center>-->
    </form>

    <script src="<%=request.getContextPath()%>/resources/js/jquery-1.8.3.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
</body>
</html>
