x<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: white">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>LẮP ĐẶT THÊM POS</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/themmoi.css"/>
    </head>
    <body>
    <center>
        <header class="header-lapdatpos">
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
                <li>Lắp thêm POS</li>
            </ul>
            <center>
                <h2>LẮP THÊM POS CHO ĐVCNT "${_id}"
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout">ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten} / </span>
                </h2>
            </center>
        </header>
    </center>
    <form action="${pageContext.request.contextPath}/xulylapthempos" method="get">
        <center>
            <div class="content-pos" style="height: auto">
                <table style="width: 100%; height: auto;">
                    <tr>
                        <td colspan="2">Mã ĐVCNT</td>
                        <td colspan="2">
                            Tên ĐVCNT
                            <p id="clear" onclick="reset()" class="rerset-form">Reset</p>
                        </td>
                    </tr>                            
                    <tr>
                        <td colspan="2">
                            <input name="maDvcnt" value="${_id}" size="10" readonly="readonly"/>
                        </td>
                        <td colspan="2">
                            <input name="tenDvcnt" value="${tendvcnt}" readonly="readonly"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">Số lượng POS của SCB đã lắp đặt: ${soluongdalap}</td>
                    </tr>
                    <tr style="color: red">
                        <c:choose>
                            <c:when test="${soluonglapthem == 0}">
                                <td colspan="4">Số lượng POS cần lắp thêm(chỉ nhập 1 lần): 
                                    <input name="soluonglapthem" value="" size="5" maxlength="5" onkeypress="return keyPressWord(event);" required="required"/>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td colspan="4">Số lượng POS cần lắp thêm(chỉ nhập 1 lần): 
                                    <input name="soluonglapthem" value="${soluonglapthem}" size="5" maxlength="5" onkeypress="return keyPressWord(event);" readonly="readonly" style="background-color: red; color: white"/>
                                </td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                    <tr>
                        <td colspan="4">Đồng tiền thanh toán</td>
                    </tr>
                    <tr>
                        <td> 
                            <c:choose>
                                <c:when test="${loaitien == 'VND'}">
                                    <input name="loaitien" checked="checked" onclick="check_soluongposlapthem()" value="VND" type="radio" id="vnd"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="loaitien" checked="checked" value="VND" type="radio" id="vnd"/>
                                </c:otherwise>
                            </c:choose>
                            <label for="vnd" onclick="check_soluongposlapthem()"><span></span>Đồng Việt Nam(VNĐ)</label>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${loaitien == 'USD'}">
                                    <input name="loaitien" onclick="check_soluongposlapthem()" value="USD" type="radio" id="usd" checked="checked"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="loaitien" value="USD" type="radio" id="usd"/>
                                </c:otherwise>
                            </c:choose>
                            <label for="usd" onclick="check_soluongposlapthem()"><span></span>Đô la Mỹ(USD)</label>
                        </td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${loaitien == 'VND/USD'}">
                                    <input name="loaitien" onclick="check_soluongposlapthem()" value="VND/USD" type="radio" id="vndusd" checked="checked"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="loaitien" value="VND/USD" type="radio" id="vndusd"/>
                                </c:otherwise>
                            </c:choose>
                            <label for="vndusd" onclick="check_soluongposlapthem()"><span></span>VNĐ và USD</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Loại máy</td>
                        <td colspan="2">Tên in trên hóa đơn</td>
                    </tr>                    
                    <tr>
                        <td colspan="2">                    
                            <select name="dongmay">
                                <c:choose>
                                    <c:when test="${dongmay == 'PAX_S90'}">
                                        <option value="PAX_S90" selected="selected" readonly="readonly">PAX S90</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_S90" readonly="readonly">PAX S90</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${dongmay == 'PAX_S78'}">
                                        <option value="PAX_S78" selected="selected" readonly="readonly">PAX S78</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_S78" readonly="readonly">PAX S78</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${dongmay == 'PAX_P70S'}">
                                        <option value="PAX_P70S" selected="selected" readonly="readonly">PAX P70-S</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_P70S" readonly="readonly">PAX P70-S</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${dongmay == 'PAX_P80'}">
                                        <option value="PAX_P80" selected="selected" readonly="readonly">PAX P80</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_P80" readonly="readonly">PAX P80</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${dongmay == 'PAX_78'}">
                                        <option value="PAX_78" selected="selected" readonly="readonly">PAX 78</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="PAX_78" readonly="readonly">PAX 78</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${dongmay == 'VX520'}">
                                        <option value="VX520" selected="selected" readonly="readonly">VX520</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="VX520" readonly="readonly">VX520</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${teninhoadon != ''}">
                                    <input name="teninhoadon" onblur="caps(this.id)" size="45" required="required" value="${teninhoadon}" id="teninhoadon" maxlength="22"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="teninhoadon" onblur="caps(this.id)" size="45" required="required" value="" id="teninhoadon" maxlength="22"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Số TK TGTT báo có:</td>
                        <td colspan="2">Tên chủ TK</td>
                    </tr>
                    <tr>
                        <td colspan="2"> 
                            <c:choose>
                                <c:when test="${soTktgtt != ''}">
                                    <input name="soTktgtt" required="required" size="45" value="${soTktgtt}" id="soTktgtt" maxlength="16" onkeypress="return keyPressWord(event);"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="soTktgtt" required="required" size="45" value="" id="soTktgtt" maxlength="16" onkeypress="return keyPressWord(event);"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${tenChuTaiKhoan != ''}">
                                    <input name="tenchutk" size="45" onblur="caps(this.id)" maxlength="50" id="tenchutk" value="${tenChuTaiKhoan}"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="tenchutk" size="45" onblur="caps(this.id)"  maxlength="50" id="tenchutk" value=""/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">Địa chỉ lắp đặt</td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${diaChiLapDat != ''}">
                                    <input name="diachiLapdat" onblur="caps(this.id)" required="required" id="diachiLapdat" value="${diaChiLapDat}" maxlength="44" size="45"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="diachiLapdat" onblur="caps(this.id)" required="required" id="diachiLapdat" value="" maxlength="44" size="45"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="4">
                            ĐĂNG KÝ GIAO DỊCH ĐẶC BIỆT
                        </th>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb1 != 0 && gddb1 != null}">
                                    <input name="gddb1" value="1" onclick="changeMotoLapThemPos()" checked="checked" type="checkbox" id="khongxuattrinhMoto1"/>
                                    <label for="khongxuattrinhMoto1"><span></span>Giao dịch không xuất trình thẻ (MOTO) (**)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb1" value="1" onclick="changeMotoLapThemPos()" type="checkbox" id="khongxuattrinhMoto2"/>
                                    <label for="khongxuattrinhMoto2"><span></span>Giao dịch không xuất trình thẻ (MOTO) (**)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb2 != 0 && gddb2 != null}">
                                    <input name="gddb2" value="1" checked="checked" onclick="giaodichdatphong()" type="checkbox" id="giaodichdatphong1"/>
                                    <label for="giaodichdatphong1" onclick="giaodichdatphong()"><span></span>Giao dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb2" value="1" onclick="giaodichdatphong()" type="checkbox" id="giaodichdatphong2"/>
                                    <label for="giaodichdatphong2" onclick="giaodichdatphong()"><span></span>Giao dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb3 != 0 && gddb3 != null}">
                                    <input name="gddb3" checked="checked" value="1" type="checkbox" id="gd3"/>
                                    <label for="gd3"><span></span>Giao dịch Điều chỉnh (Adjust) (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb3" value="1" type="checkbox" id="gd3"/>
                                    <label for="gd3"><span></span>Giao dịch Điều chỉnh (Adjust) (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb4 != 0 && gddb4 != null}">
                                    <input name="gddb4"  checked="checked" value="1" type="checkbox" id="gd4"/>
                                    <label for="gd4"><span></span>Giao dịch Ngoại tuyến (OFFLINE) (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb4" value="1" type="checkbox" id="gd4"/>
                                    <label for="gd4"><span></span>Giao dịch Ngoại tuyến (OFFLINE) (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb5 != 0 && gddb5 != null}">
                                    <input checked="checked" name="gddb5" value="1" type="checkbox" id="gd5"/>
                                    <label for="gd5"><span></span>Chức năng nhập tiền TIP</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb5" value="1" type="checkbox" id="gd5"/>
                                    <label for="gd5"><span></span>Chức năng nhập tiền TIP</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb6 != 0 && gddb6 != null}">
                                    <input name="gddb6" checked="checked" value="1" type="checkbox" id="gd6"/>
                                    <label for="gd6"><span></span>Giao dịch thanh toán nhập tay số thẻ (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb6" value="1" type="checkbox" id="gd6"/>
                                    <label for="gd6"><span></span>Giao dịch thanh toán nhập tay số thẻ (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb7 != 0 && gddb7 != null}">
                                    <input name="gddb7" checked="checked" onclick="khongnhapCVC()" value="1" type="checkbox" id="khongnhapCVC1"/>
                                    <label for="khongnhapCVC1" onclick="khongnhapCVC()"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb7" value="1" type="checkbox" id="khongnhapCVC2"/>
                                    <label for="khongnhapCVC2" onclick="khongnhapCVC()"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</label>

                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb8 != 0 && gddb8 != null}">
                                    <input name="gddb8" onclick="nhapTaySoThe()" checked="checked" value="1" type="checkbox" id="nhapTaySoThe1"/>
                                    <label for="nhapTaySoThe1" onclick="nhapTaySoThe()"><span></span>Thực hiện nhập tay số thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb8" onclick="nhapTaySoThe()" value="1" type="checkbox" id="nhapTaySoThe2"/>
                                    <label for="nhapTaySoThe2" onclick="nhapTaySoThe()"><span></span>Thực hiện nhập tay số thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${gddb9 != 0 && gddb9 != null}">
                                    <input name="gddb9" checked="checked" value="1" type="checkbox" id="gd9"/>
                                    <label for="gd9"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:when>
                                        <c:otherwise>
                                    <input name="gddb9" value="1" type="checkbox" id="boQuaBuocNhapCVCPreAuth"/>
                                    <label for="boQuaBuocNhapCVCPreAuth" onclick="boQuaBuocNhapCVCPreAuth()"><span></span>Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</label>
                                        </c:otherwise>
                                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <span>Số tiền ký quỹ khi sử dụng dịch vụ MOTO: </span>
                            <c:choose>
                                <c:when test="${phiMoto != ''}">
                                    <input name="tienkyquyMoto" value="${phiMoto}" onkeypress="return keyPressWord(event);" id="tienkyquyMoto"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="tienkyquyMoto" value="0" onkeypress="return keyPressWord(event);" id="xtienkyquyMoto"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">Giao dịch MO: </td>
                    </tr>
                    <tr>
                        <td colspan="2">Hạn mức VND: 
                            <c:choose>
                                <c:when test="${hanmucvnd != ''}">
                                    <input name="hanmucVnd" value="${hanmucvnd}" onkeypress="return keyPressWord(event);" id="hanmucUsd"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="hanmucVnd" value="0" onkeypress="return keyPressWord(event);" id="hanmucUsd"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td colspan="2">Hạn mức USD: 
                            <c:choose>
                                <c:when test="${hanmucusd != ''}">
                                    <input name="hanmucUsd" value="${hanmucusd}" onkeypress="return keyPressWord(event);" id="hanmucusd"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="hanmucUsd" value="0" onkeypress="return keyPressWord(event);" id="hanmucusd"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">Ghi chú</td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${ghichu != ''}">
                                    <input name="ghichu" onblur="caps(this.id)" value="${ghichu}" id="ghichu" size="80"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="ghichu" onblur="caps(this.id)" value="" id="ghichu" size="80"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br/>
                            <input type="submit" value="LƯU THÔNG TIN" class="submit-pos"/>
                            <br/>
                        </td>
                        <td colspan="2">
                            <br/>
                            <a href="exportlapthempos.html?id=${_id}" class="exportthempos" target="_blank">XEM & IN THÔNG TIN</a>
                            <br/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <c:choose>
                                <c:when test="${error != 0}">
                            <center>
                                <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                            </center>
                        </c:when>
                    </c:choose>
                    </td>
                    </tr>
                </table>
            </div>
        </center>
    </form>

    <center>
        <table class="lapdatpos">
            <tr>
                <th colspan="9"><h3>THÔNG TIN POS THÊM MỚI</h3></th>
            </tr>
            <tr>                                
                <th>Loại máy</th>                    
                <th>Tên in trên hóa đơn</th>                    
                <th>Số TK TGTT</th>                    
                <th>Tên chủ TK</th>                    
                <th>Địa chỉ lắp đặt</th>                                    
                <th>Thao tác</th>                    
            </tr>
            <c:forEach items="${listPosThemMoi}" var="p1">
                <tr>                                        
                    <td>${p1.dongmay}</td>
                    <td>${p1.teninhoadon}</td>
                    <td>${p1.soTktgtt}</td>
                    <td>${p1.tenchutk}</td>
                    <td>${p1.diachiLapdat}</td>                    
                    <td>
                <center><a href="xoathongtinlapdatposmoi.html?id=${p1.stt}" class="delete">DELETE</a></center>
                </td>
                </td>
                </tr>
            </c:forEach>
        </table>
    </center>

    <center>
        <table class="lapdatpos">
            <tr>
                <th colspan="9"><h3>DANH SÁCH POS ĐÃ LẮP</h3></th>
            </tr>
            <tr>                                
                <th>Loại máy</th>                    
                <th>Tên in trên hóa đơn</th>                    
                <th>Số TK TGTT</th>                    
                <th>Tên chủ TK</th>                    
                <th>Địa chỉ lắp đặt</th>                                    
                <th>Thao tác</th>                    
            </tr>
            <c:forEach items="${listPosDaLap}" var="p1">
                <c:choose>
                    <c:when test="${p1.tinhtrangPos == 'Sử dụng'}">
                        <tr>                                                        
                            <td>${p1.dongmay}</td>
                            <td>${p1.teninhoadon}</td>
                            <td>${p1.soTktgtt}</td>
                            <td>${p1.tenchutk}</td>
                            <td>${p1.diachiLapdat}</td>                            
                            <td>
                        <center><a href="same.html?id=${p1.soseri}" class="detail">SAME</a></center>
                        </td>
                        </td>
                        </tr>
                    </c:when>
                </c:choose>
            </c:forEach>
        </table>

        <c:choose>
            <c:when test="${groupuser == 1}">
                <table style="width: 100%; margin-top: 2%; margin-left: 4%">
                    <tr>
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/fileUploadLapThemPos.do" enctype="multipart/form-data">
                                <input type="file" required  name="fileUploaded"/>  
                                <input type="submit" value="UPLOAD FILE"/>  
                                <marquee style="font-weight: bold; color: darkgreen" behavior="alternate" width="45%">${uploadsuccess}</marquee>
                            </form>
                            </br>
                            <a href="guiduyetlapthempos.html?id=${_id}" class="guiduyet2"><center>GỬI DUYỆT</center></a>
                        </td>
                    </tr>
                </table>
            </c:when>
        </c:choose>
    </center>

    <footer style="bottom: 0px;">
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
    <script src="<%=request.getContextPath()%>/resources/js/themmoipos.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
</body>
</html>
