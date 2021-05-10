<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.io.*" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>CHI TIẾT ĐVCNT</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/themmoi.css">
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
                <li>Chi tiết ĐVCNT</li>
            </ul>
            <center>
                <h2>CẬP NHẬT THÔNG TIN ĐVCNT
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> / ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <form action="${pageContext.request.contextPath}/updatedvcnt" method="post">
        <center>
            <div class="content" style="height: 1100px">
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
                        <td colspan="2">Tên đơn vị đăng ký kinh doanh (*)</td>
                        <td colspan="2">Tên tiếng Anh</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input name="tenDvcntVn" required="required" id="text1" onblur="caps(this.id)" value="${tenDvcntVn}" autofocus="" size="60" required=""/>
                        </td>
                        <td colspan="2">
                            <input name="tenDvcntEn" id="text2" onblur="caps(this.id)" value="${tenDvcntEn}" size="60"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Địa chỉ (*)</td>
                        <td colspan="2">Điện thoại</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input name="diaChiDvcnt" required="required" id="text3" onblur="caps(this.id)" value="${diachiDvcnt}" size="60"/>
                        </td>
                        <td colspan="2">
                            <input name="sdtDvcnt" value="${sdtDvcnt}" onkeypress="return keyPressWord(event);"/>
                        </td>
                    </tr>

                    <tr>
                        <td>Giấy phép ĐKKD số (*)</td>
                        <td>Ngày cấp(dd/mm/yyyy)</td>
                        <td>Nơi cấp (*)</td>
                        <td>Mã số thuế (*)</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="gpdkkdso" required="required" value="${gpdkkdso}"/>
                        </td>
                        <td>
                            ${_GpdkkdNgaycap}
                        </td>
                        <td>
                            <input name="gpdkkdNoicap" required="required" id="text4" onblur="caps(this.id)" value="${gpdkkdNoicap}"/>
                        </td>
                        <td>
                            <input name="masothue" required="required" value="${masothue}" onkeypress="return keyPressWord(event);"/>
                        </td>
                    </tr>

                    <tr>
                        <td>Người đại diện theo pháp luật trên GPĐKKD (*)</td>
                        <td colspan="3">Chức vụ (*)</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="gpdkkdTennguoidaidien" required="required" id="text5" onblur="caps(this.id)" value="${gpdkkdTennguoidaidien}"/>
                        </td>
                        <td colspan="3">
                            <input name="gpdkkdChucvu" required="required" id="text6" onblur="caps(this.id)" value="${gpdkkdChucvu}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>CMND/ Thẻ căn cước / Hộ Chiếu (*)</td>
                        <td>Ngày cấp(dd/mm/yyyy)</td>
                        <td colspan="2">Nơi cấp (*)</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="gpdkkdCmnd" required="required" value="${gpdkkdCmnd}" onkeypress="return keyPressWord(event);"/>
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
                            <input name="tennguoiKyhopdong" required="required" id="text8" onblur="caps(this.id)" value="${tennguoiKyhopdong}"/>
                        </td>
                        <td colspan="3">
                            <input name="chucvuHopdong" required="required" id="text9" onblur="caps(this.id)" value="${chucvuHopdong}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>CMND/ Thẻ căn cước / Hộ Chiếu</td>
                        <td>Ngày cấp(dd/mm/yyyy)</td>
                        <td>Nơi cấp</td>
                    </tr>
                    <tr>
                        <td>
                            <input name="cmndHopdong" required="required" value="${cmndHopdong}" onkeypress="return keyPressWord(event);"/>
                        </td>
                        <td>
                            ${_NgaycapCmndHopdong}
                        </td>
                        <td>
                            <input name="noicapCmndHopdong" required="required" id="text10" onblur="caps(this.id)" value="${noicapCmndHopdong}"/>
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
                        <td>Ngành nghề kinh doanh (*)</td>
                        <td colspan="3">Doanh số thanh toán thẻ dự kiến theo tháng(VNĐ/máy)</td>
                    </tr>
                    <tr>
                        <td>                            
                            <select name="nganhnghekd" maxlength="50" onkeypress="return blockSpecialChar(event)" onblur="caps(this.id)" required="required">
                                <c:choose>
                                    <c:when test="${nganhnghekd == ''}">
                                        <option value="" selected></option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value=""></option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Ailines'}">
                                        <option value="Ailines" selected>Hàng không</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Ailines">Hàng không</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Amusement and Entertainment'}">
                                        <option value="Amusement and Entertainment" selected>Giải trí</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Amusement and Entertainment">Giải trí</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Automobiles and Vehicles'}">
                                        <option value="Automobiles and Vehicles" selected>Ô tô và phương tiện</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Automobiles and Vehicles">Ô tô và phương tiện</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Business Services'}">
                                        <option value="Business Services" selected>Dịch vụ kinh doanh</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Business Services">Dịch vụ kinh doanh</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Clothing Stores'}">
                                        <option value="Clothing Stores" selected>Cửa hàng quần áo</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Clothing Stores">Cửa hàng quần áo</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Contracted Services'}">
                                        <option value="Contracted Services" selected>Dịch vụ ký hợp đồng</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Contracted Services">Dịch vụ ký hợp đồng</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Government Services'}">
                                        <option value="Government Services" selected>Dịch vụ chính phủ</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Government Services">Dịch vụ chính phủ</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Hotels and Motels'}">
                                        <option value="Hotels and Motels" selected>Khách sạn và nhà nghỉ</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Hotels and Motels">Khách sạn và nhà nghỉ</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Mail Order/Telephone Order Providers'}">
                                        <option value="Mail Order/Telephone Order Providers" selected>Khách sạn và nhà nghỉ</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Mail Order/Telephone Order Providers">Đặt hàng qua thư/NCC đặt hàng qua ĐT</option>
                                    </c:otherwise>
                                </c:choose>    

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Miscellaneous Stores'}">
                                        <option value="Miscellaneous Stores" selected>Cửa hàng linh tinh</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Miscellaneous Stores">Cửa hàng linh tinh</option>
                                    </c:otherwise>
                                </c:choose>  

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Personal Service Providers'}">
                                        <option value="Personal Service Providers" selected>Nhà cung cấp dịch vụ cá nhân</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Personal Service Providers">Nhà cung cấp dịch vụ cá nhân</option>
                                    </c:otherwise>
                                </c:choose>  

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Professional Services and Membership Organizations'}">
                                        <option value="Professional Services and Membership Organizations" selected>Dịch vụ chuyên nghiệp và tổ chức thành viên</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Professional Services and Membership Organizations">Dịch vụ chuyên nghiệp và tổ chức thành viên</option>
                                    </c:otherwise>
                                </c:choose> 

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Professional Services and Membership Organizations'}">
                                        <option value="Repair Services" selected>Dịch vụ sửa chữa</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Repair Services">Dịch vụ sửa chữa</option>
                                    </c:otherwise>
                                </c:choose> 

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Professional Services and Membership Organizations'}">
                                        <option value="Retail Stores" selected>Cửa hàng bán lẻ</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Retail Stores">Cửa hàng bán lẻ</option>
                                    </c:otherwise>
                                </c:choose> 

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Service Providers'}">
                                        <option value="Service Providers" selected>Nhà cung cấp dịch vụ</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Service Providers">Nhà cung cấp dịch vụ</option>
                                    </c:otherwise>
                                </c:choose> 

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Transportation'}">
                                        <option value="Transportation" selected>Giao thông vận tải</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Transportation">Giao thông vận tải</option>
                                    </c:otherwise>
                                </c:choose> 

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Utilities'}">
                                        <option value="Utilities" selected>Tiện ích</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Utilities">Tiện ích</option>
                                    </c:otherwise>
                                </c:choose> 

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Utilities'}">
                                        <option value="Wholesale Distributors and Manufacturers" selected>Nhà phân phối và nhà sản xuất</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Wholesale Distributors and Manufacturers">Nhà phân phối và nhà sản xuất</option>
                                    </c:otherwise>
                                </c:choose>      

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Restaurant-Food Service'}">
                                        <option value="Restaurant-Food Service" selected>Nhà hàng-Dịch vụ ăn uống</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Restaurant-Food Service">Nhà hàng-Dịch vụ ăn uống</option>
                                    </c:otherwise>
                                </c:choose> 

                                <c:choose>
                                    <c:when test="${nganhnghekd == 'Other'}">
                                        <option value="Other" selected>Khác</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Other">Khác</option>
                                    </c:otherwise>
                                </c:choose> 
                            </select>
                        </td>
                        <td  colspan="3">
                            <input onChange="format_curency(this);" onkeypress="return keyPressWord(event);" name="_doanhsothanhtoandukien" id="doanhsothanhtoandukien" required="required" value="${doanhsothanhtoandukien}" size="30"/>
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
                            SỐ LƯỢNG & DÒNG MÁY LẮP ĐẶT
                        </th>
                    </tr>
                    <tr>
                        <td colspan="4">
                            Số lượng máy POS cần lắp thêm (*): 
                            <input name="slpos" required="required" value="${slpos}" size="5" onkeypress="return keyPressWord(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="4">
                            LOẠI THẺ CHẤP NHẬN THANH TOÁN & PHÍ CHIẾT KHẤU <i>(Đơn vị: % - Đã bao gồm VAT)</i>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <label for="t8"><span></span>Thẻ khác(nếu có)</label>
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
                        <td>
                            <label for="t1"><span></span>Thẻ ghi nợ nội địa SCB (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t1"><span></span>Phí: </label>
                            <input name="phiGhinoscb" required="required" value="${phiGhinoscb}" placeholder="Phí ghi nợ nội địa SCB"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t2"><span></span>Thẻ ghi nợ nội địa liên minh (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t2"><span></span>Phí: </label>
                            <input name="phiGhinoLienminh" required="required" value="${phiGhinoLienminh}" placeholder="Phí ghi nợ nội địa liên minh"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t3"><span></span>Thẻ MC/VS phát hành trong nước (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t3"><span></span>Phí: </label>
                            <input name="phiVisa" required="required" value="${phiVisa}" placeholder="Phí VISA"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t4"><span></span>Thẻ MC/VS phát hành nước ngoài (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t4"><span></span>Phí: </label>
                            <input name="phiMastercard" required="required" value="${phiMastercard}" placeholder="Phí Mastercard"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t5"><span></span>Thẻ JBC (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t5"><span></span>Phí: </label>
                            <input name="phiJcb" required="required" value="${phiJcb}" placeholder="Phí JCB"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t6"><span></span>Thẻ CUP (*)</label>
                        </td>
                        <td colspan="3">
                            <label for="t6"><span></span>Phí: </label>
                            <input name="phiCup" required="required" value="${phiCup}" placeholder="Phí CUP"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="t7"><span></span>Thẻ Discover</label>
                        </td>
                        <td colspan="3">
                            <label for="t7"><span></span>Phí: </label>
                            <input name="phiDiscover" required="required" value="${phiDiscover}" placeholder="Phí Discover"/>
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
                    </tr>  

                    <tr>                        
                        <td colspan="2">
                            <a href="quayvepagedvcntdangxuly.html?id=${maDvcnt}" class="xacNhanBanGiao">Quay về trước</a>
                        </td>
                        <td colspan="1">
                            <input type="submit" value="CẬP NHẬT THÔNG TIN" class="submit"/>
                        </td>
                        <td colspan="1">
                            <c:choose>
                                <c:when test="${groupuser == 1}">
                                    <a href="hoantat_themttlapdatpos.html?id=${_id}"
                                       class="guiduyet2" style="background-color: darkgreen"><center>GỬI DUYỆT</center></a>
                                        </c:when>
                                    </c:choose>
                        </td>
                    </tr>
                </table>
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
    <script>

        function caps(id) {
            document.getElementById(id).value = document.getElementById(id).value.toUpperCase();
        }
    </script>                        
    <script src="<%=request.getContextPath()%>/resources/js/dangkydvcnt.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
</body>
</html>
