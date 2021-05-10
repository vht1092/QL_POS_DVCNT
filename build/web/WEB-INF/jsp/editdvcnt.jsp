<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>CẬP NHẬT THÔNG TIN ĐVCNT</title>
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
                <li>Cập nhật thông tin ĐVCNT</li>
            </ul>
            <center>
                <h2>CẬP NHẬT THÔNG TIN ĐƠN VỊ CHẤP NHẬN THẺ "${maDvcnt}"
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> / ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <form action="${pageContext.request.contextPath}/xulyeditdvcnt" method="get">
        <center>
            <div class="content" style="height: 1140px">
                <table style="width: 100%; height: auto">
                    <tr>
                        <th colspan="4">THÔNG TIN ĐVCNT</th>
                    </tr>
                    <tr>
                        <td colspan="4">
                            Mã ĐVCNT: 
                            <input name="maDvcnt" value="${maDvcnt}" readonly="readonly" size="10"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Đơn vị đăng ký kinh doanh</td>
                        <td colspan="2">Tên tiếng Anh</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input name="tenDvcntVn" id="text1" onblur="caps(this.id)" value="${tenDvcntVn}" autofocus="" size="60" required="" style="background-color: #F3EBC4"/>
                        </td>
                        <td colspan="2">
                            <input name="tenDvcntEn" id="text2" onblur="caps(this.id)" value="${tenDvcntEn}" size="60"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Địa chỉ</td>
                        <td colspan="2">Điện thoại</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input name="diaChiDvcnt" id="text3" onblur="caps(this.id)" value="${diachiDvcnt}" size="60" style="background-color: #F3EBC4"/>
                        </td>
                        <td colspan="2">
                            <input name="sdtDvcnt" value="${sdtDvcnt}" onkeypress="return keyPressWord(event);"/>
                        </td>
                    </tr>

                    <tr>
                        <td>Giấy phép ĐKKD số</td>
                        <td>Ngày cấp(dd/mm/yyyy)</td>
                        <td>Nơi cấp</td>
                        <td>Mã số thuế</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="gpdkkdso" value="${gpdkkdso}"/>
                        </td>
                        <td>
                            ${_GpdkkdNgaycap}
                        </td>
                        <td>
                            <input name="gpdkkdNoicap" id="text4" onblur="caps(this.id)" value="${gpdkkdNoicap}"/>
                        </td>
                        <td>
                            <input name="masothue" value="${masothue}" onkeypress="return keyPressWord(event);"/>
                        </td>
                    </tr>

                    <tr>
                        <td>Người đại diện theo pháp luật trên GPĐKKD</td>
                        <td colspan="3">Chức vụ</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="gpdkkdTennguoidaidien" id="text5" onblur="caps(this.id)" value="${gpdkkdTennguoidaidien}" style="background-color: #F3EBC4"/>
                        </td>
                        <td colspan="3">
                            <input name="gpdkkdChucvu" id="text6" onblur="caps(this.id)" value="${gpdkkdChucvu}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>CMND/ Thẻ căn cước / Hộ Chiếu</td>
                        <td>Ngày cấp(dd/mm/yyyy)</td>
                        <td colspan="2">Nơi cấp</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="gpdkkdCmnd" value="${gpdkkdCmnd}" onkeypress="return keyPressWord(event);" style="background-color: #F3EBC4"/>
                        </td>
                        <td>
                            ${_GpdkkdNgaycapCmnd}
                        </td>
                        <td colspan="2">
                            <input name="gpdkkdNoicapCmnd" id="text7" onblur="caps(this.id)" value="${gpdkkdNoicapCmnd}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Người đại diện ký kết hợp đồng ĐVCNT</td>
                        <td colspan="3">Chức vụ</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="tennguoiKyhopdong" id="text8" onblur="caps(this.id)" value="${tennguoiKyhopdong}"/>
                        </td>
                        <td colspan="3">
                            <input name="chucvuHopdong" id="text9" onblur="caps(this.id)" value="${chucvuHopdong}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>CMND/ Thẻ căn cước / Hộ Chiếu</td>
                        <td>Ngày cấp(dd/mm/yyyy)</td>
                        <td>Nơi cấp</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="cmndHopdong" value="${cmndHopdong}" onkeypress="return keyPressWord(event);"/>
                        </td>
                        <td>
                            ${_NgaycapCmndHopdong}
                        </td>
                        <td>
                            <input name="noicapCmndHopdong" id="text10" onblur="caps(this.id)" value="${noicapCmndHopdong}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Theo ủy quyền số(nếu có)</td>
                        <td colspan="3">Ngày ủy quyền(dd/mm/yyyy)</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="soUyquyen" value="${soUyquyen}"/>
                        </td>
                        <td colspan="3">
                            ${_NgayUyquyen}
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4">Đang hợp tác với ngân hàng: 
                            <input name="nganhangHoptac" id="text11" onblur="caps(this.id)" value="${nganhangHoptac}"/>
                        </td>
                    </tr>

                    <tr>
                        <td>Loại hình ĐVCNT: 
                            <c:choose>
                                <c:when test="${loaihinhDvcnt == 1}">
                                    <select name="loaihinhDvcnt">
                                        <option value="1">Hộ kinh doanh</option>
                                        <option value="2">Tổ chức</option>
                                    </select>
                                </c:when>
                                <c:otherwise>
                                    <select name="loaihinhDvcnt">
                                        <option value="1">Hộ kinh doanh</option>
                                        <option value="2" selected="selected">Tổ chức</option>
                                    </select>
                                </c:otherwise>
                            </c:choose>                           
                        </td>
                    </tr>

                    <tr>
                        <th colspan="4">
                            KẾT QUẢ KHẢO SÁT
                        </th>
                    </tr>

                    <tr>
                        <td>Ngành nghề kinh doanh</td>
                        <td colspan="3">Doanh số thanh toán thẻ dự kiến theo tháng(VNĐ/máy)</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="nganhnghekd" id="text12" onblur="caps(this.id)" value="${nganhnghekd}" size="30"/>
                        </td>
                        <td  colspan="3">
                            <input name="doanhsothanhtoandukien" value="${doanhsothanhtoandukien}" size="30" onkeypress="return keyPressWord(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Xếp loại theo kết quả khảo sát: ${xeploai}                            
                        </td>  
                        <td colspan="2">
                            Lần đăng ký: <input name="landk" value="${landk}"/>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="4">
                            LOẠI THẺ CHẤP NHẬN THANH TOÁN & PHÍ CHIẾT KHẤU <i>(Đơn vị: % - Đã bao gồm VAT)</i>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <label for="t1"><span></span>Thẻ ghi nợ nội địa SCB</label>
                        </td>
                        <td colspan="3">
                            <label for="t1"><span></span>Phí: </label>
                            <input name="phiGhinoscb" value="${phiGhinoscb}" placeholder="Phí ghi nợ nội địa SCB"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t2"><span></span>Thẻ ghi nợ nội địa liên minh</label>
                        </td>
                        <td colspan="3">
                            <label for="t2"><span></span>Phí: </label>
                            <input name="phiGhinoLienminh" value="${phiGhinoLienminh}" placeholder="Phí ghi nợ nội địa liên minh"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t3"><span></span>Thẻ MC/VS phát hành trong nước</label>
                        </td>
                        <td colspan="3">
                            <label for="t3"><span></span>Phí: </label>
                            <input name="phiVisa" value="${phiVisa}" placeholder="Phí VISA"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t4"><span></span>Thẻ MC/VS phát hành nước ngoài</label>
                        </td>
                        <td colspan="3">
                            <label for="t4"><span></span>Phí: </label>
                            <input name="phiMastercard" value="${phiMastercard}" placeholder="Phí Mastercard"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t5"><span></span>Thẻ JBC</label>
                        </td>
                        <td colspan="3">
                            <label for="t5"><span></span>Phí: </label>
                            <input name="phiJcb" value="${phiJcb}" placeholder="Phí JCB"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t6"><span></span>Thẻ CUP</label>
                        </td>
                        <td colspan="3">
                            <label for="t6"><span></span>Phí: </label>
                            <input name="phiCup" value="${phiCup}" placeholder="Phí CUP"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t7"><span></span>Thẻ Discover</label>
                        </td>
                        <td colspan="3">
                            <label for="t7"><span></span>Phí: </label>
                            <input name="phiDiscover" value="${phiDiscover}" placeholder="Phí Discover"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t8"><span></span>Thẻ khác</label>
                        </td>
                        <td>
                            <label for="t8"><span></span>Tên</label>
                            <input name="tenThekhac" id="text13" onblur="caps(this.id)" value="${tenThekhac}" placeholder="Nhập tên thẻ"/>
                        </td>
                        <td colspan="2">
                            <span>Phí: </span>
                            <input name="phiThekhac" value="${phiThekhac}" placeholder="Phí thẻ"/>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="4">
                            LOẠI TIỀN THANH TOÁN TRÊN POS
                        </th>
                    </tr>

                    <tr>
                        <td colspan="4">
                    <center>
                        <select name="loaitien">
                            <c:choose>
                                <c:when test="${loaitien == 'VND'}">
                                    <option value="VND" selected="selected">Đồng Việt Nam(VNĐ)</option>
                                    <option value="USD">Đô la Mỹ(USD)</option>
                                    <option value="VND/USD">VNĐ và USD</option>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${loaitien == 'USD'}">
                                    <option value="VND">Đồng Việt Nam(VNĐ)</option>
                                    <option value="USD" selected="selected">Đô la Mỹ(USD)</option>
                                    <option value="VND/USD">VNĐ và USD</option>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${loaitien == 'VND/USD'}">
                                    <option value="VND">Đồng Việt Nam(VNĐ)</option>
                                    <option value="USD">Đô la Mỹ(USD)</option>
                                    <option value="VND/USD" selected="selected">VNĐ và USD</option>
                                </c:when>
                            </c:choose>
                        </select>
                    </center>
                    </td>
                    </tr></br>  
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="LƯU THAY ĐỔI" class="submit" style="float: left"/>
                        </td>
                        <td colspan="2">
                            <a href="exporteditinformation.html?id=${maDvcnt}" class="hoantat" target="_blank"><center>XEM & IN THÔNG TIN</center></a>
                        </td>
                    </tr>
                </table>
            </div>
        </center>
    </form>
    <c:choose>
        <c:when test="${groupuser == 1}">
            <table style="width: 100%; margin-top: -2%; margin-left: 4%">
                <tr>
                    <td colspan="4">
                        <c:choose>
                            <c:when test="${error != null}">
                        <center>
                            <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                        </center>
                    </c:when>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td>
                <form method="post" action="${pageContext.request.contextPath}/_fileUploadEdit.do" enctype="multipart/form-data">
                    <input type="file" required  name="fileUploaded" class="xformUpload"/>  
                    <input type="submit" value="UPLOAD FILE" class="xformUpload"/>  
                    <marquee style="font-weight: bold; color: darkgreen" behavior="alternate" width="45%">${errorr}</marquee>
                </form>
                </br>
                <a href="guiduyetchinhsua.html?id=${maDvcnt}" class="guiduyet2"><center>GỬI DUYỆT</center></a>
            </td>
        </tr>
    </table>
</c:when>
</c:choose>
<footer>
    <center>

        <h4><a href="index.html"><i class="fa fa-home"></i>Trở về trang chủ</a></h5>
            <span>-------------------------------------------------</span>
            <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
    </center>
</footer>

<script>

    function caps(id) {
        document.getElementById(id).value = document.getElementById(id).value.toUpperCase();
    }
</script>
<script src="<%=request.getContextPath()%>/resources/js/dangkydvcnt.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
</body>
</html>
