<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EXPORT PYC EDIT ĐVCNT</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/export.css"/>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <style>
            p{
                margin-bottom: 5px;
            }
        </style>
    </head>
    <body>
        <a id="export" target="_blank" class="btnPrint">Export to Word</a>
        <div id="docx">
            <div class="WordSection1">
                <center>
                    <table style="width: 90%; font-size: 14px; border: none">
                        <tr>
                            <td style="width: 25%">
                        <center>
                            <p><b>NGÂN HÀNG TMCP SÀI GÒN</b></p>
                            <p style="font-size: 12px">Số: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /ĐN-SCB-TGĐ.19</p>
                        </center>
                        </td>
                        <td style="width: 80px;"></td>
                        <td style="">
                        <center>
                            <p style="font-size: 13px; margin-left: -25px"><b>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</b></p>
                            <p><b>Độc lập – Tự do – Hạnh phúc</b></p>
                            <p class="ngaythangnam"  style="font-size: 13px"><i>TP. Hồ Chí Minh, ngày ${day} tháng ${month} năm ${year}</i></p>
                        </center>
                        </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                        <center>
                            <p> &nbsp; </p>
                            <h3>GIẤY ĐỀ NGHỊ THAY ĐỔI THÔNG TIN CHO ĐVCNT VÀ CÁC DỊCH VỤ KHÁC (NẾU CÓ)</h3>
                            <p><h3>Kính gửi: NH TMCP CÔNG THƯƠNG VN</h3>
                        </center>
                        </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                        <center><p>Căn cứ đề nghị của ĐVCNT, Ngân hàng TMCP Sài Gòn kính đề nghị Vietinbank thay đổi thông tin cho ĐVCNT như sau:</p></center>
                        <p> &nbsp; </p>
                        </td>
                        </tr>

                        <tr class="abc" style="background-color: #D4D0C8;">
                            <td></td>
                            <td><center><b>THÔNG TIN CŨ</b></center></td>
                        <td><center><b>THÔNG TIN MỚI</b></center></td>
                        </tr>
                        <tr>
                            <c:choose>
                                <c:when test="${check == true}">
                                    <th colspan="3" style=" font-weight: bold; background-color: #D4D0C8;">THÔNG TIN ĐVCNT</th>
                                    </c:when>
                                </c:choose>
                        </tr>
                        <c:choose>
                            <c:when test="${tenDvcnt != null}">
                                <tr>
                                    <td>Tên GPĐKKD</td>
                                    <td>${tenDvcnt}</td>
                                    <c:choose>
                                        <c:when test="${tenDvcnt != _tenDvcnt}">
                                            <td><b><u>${_tenDvcnt}</u></b></td>
                                                    </c:when>
                                                    <c:otherwise>
                                            <td>${_tenDvcnt}</td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${tenNguoiDaiDienGPKD != null}">
                                <tr>
                                    <td>Tên người đại diện</td>
                                    <td>${tenNguoiDaiDienGPKD}</td>
                                    <c:choose>
                                        <c:when test="${tenNguoiDaiDienGPKD != _tenNguoiDaiDienGPKD}">
                                            <td><b><u>${_tenNguoiDaiDienGPKD}</u></b></td>
                                                    </c:when>
                                                    <c:otherwise>
                                            <td>${_tenNguoiDaiDienGPKD}</td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${CMNDnguoiDaiDienGPKD != null}">
                                <tr>
                                    <td>CMND/ Thẻ căn cước / Hộ Chiếu</td>
                                    <td>${CMNDnguoiDaiDienGPKD}</td>
                                    <c:choose>
                                        <c:when test="${CMNDnguoiDaiDienGPKD != _CMNDnguoiDaiDienGPKD}">
                                            <td><b><u>${_CMNDnguoiDaiDienGPKD}</u></b></td>
                                                    </c:when>
                                                    <c:otherwise>
                                            <td>${_CMNDnguoiDaiDienGPKD}</td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${diachiDvcnt != null}">
                                <tr>
                                    <td>Địa chỉ đăng ký kinh doanh</td>
                                    <td>${diachiDvcnt}</td>
                                    <c:choose>
                                        <c:when test="${diachiDvcnt != _diachiDvcnt}">
                                            <td><b><u>${_diachiDvcnt}</u></b></td>
                                                    </c:when>
                                                    <c:otherwise>
                                            <td>${_diachiDvcnt}</td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:when>
                        </c:choose>
                        <tr>
                            <c:choose>
                                <c:when test="${size > 0}">
                                    <th colspan="3" style=" font-weight: bold; background-color: #D4D0C8;">THÔNG TIN POS</th>
                                    </c:when>
                                </c:choose>
                        </tr>
                        <%
                            int index = 1;
                        %>
                        <c:forEach items="${lst}" var="p">
                            <tr>
                                <td style="width: 20%">
                                    POS <%out.println(String.format("%d", index));
                                        index++;%>
                                </td>

                                <td style="width: 40%">
                                    <p>Tên in trên hóa đơn: 
                                        <b>
                                            <c:choose>
                                                <c:when test="${p.edit1 == null}">
                                                    ${p.teninhoadon}
                                                </c:when>
                                                <c:otherwise>
                                                    ${p.edit1}
                                                </c:otherwise>
                                            </c:choose>
                                        </b></p>
                                    <p>Địa chỉ lắp đặt: 
                                        <b>
                                            <c:choose>
                                                <c:when test="${p.edit2 == null}">
                                                    ${p.diachiLapdat}
                                                </c:when>
                                                <c:otherwise>
                                                    ${p.edit2}
                                                </c:otherwise>
                                            </c:choose>
                                        </b></p>
                                    <p>MCC: 
                                        <b>
                                            <c:choose>
                                                <c:when test="${p.edit3 == null}">
                                                    ${p.mcc}
                                                </c:when>
                                                <c:otherwise>
                                                    ${p.edit3}
                                                </c:otherwise>
                                            </c:choose>
                                        </b></p>
                                    <p>Dòng  máy: 
                                        <b>
                                            <c:choose>
                                                <c:when test="${p.edit4 == null}">
                                                    ${p.dongmay}
                                                </c:when>
                                                <c:otherwise>
                                                    ${p.edit4}
                                                </c:otherwise>
                                            </c:choose>
                                        </b></p>
                                    <p>GIAO DỊCH ĐẶC BIỆT</p>
                                    <c:choose>
                                        <c:when test="${p.editGddb1 == 1}">
                                            <input name="gddb1" value="1" checked="checked" type="checkbox" id="gd1"/>
                                            <label for="gd1"><span></span>1</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.editGddb2 == 1}">
                                            <input name="gddb2" value="1" checked="checked" type="checkbox" id="gd2"/>
                                            <label for="gd2"><span></span>2</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.editGddb3 == 1}">
                                            <input name="gddb3" checked="checked" value="1" type="checkbox" id="gd3"/>
                                            <label for="gd3"><span></span>3</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.editGddb4 == 1}">
                                            <input name="gddb4"  checked="checked" value="1" type="checkbox" id="gd4"/>
                                            <label for="gd4"><span></span>4</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.editGddb5 == 1}">
                                            <input checked="checked" name="gddb5" value="1" type="checkbox" id="gd5"/>
                                            <label for="gd5"><span></span>5</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.editGddb6 == 1}">
                                            <input name="gddb6" checked="checked" value="1" type="checkbox" id="gd6"/>
                                            <label for="gd6"><span></span>6</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.editGddb7 == 1}">
                                            <input name="gddb7" checked="checked" value="1" type="checkbox" id="gd7"/>
                                            <label for="gd7"><span></span>7</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.editGddb8 == 1}">
                                            <input name="gddb8" checked="checked" value="1" type="checkbox" id="gd8"/>
                                            <label for="gd8"><span></span>8</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.editGddb9 == 1}">
                                            <input name="gddb9" checked="checked" value="1" type="checkbox" id="gd9"/>
                                            <label for="gd9"><span></span>9</label>
                                                </c:when>

                                    </c:choose>

                                    <p>--------------------------------------------------------</p>
                                </td>
                                <td style="width: 40%">
                                    <c:choose>
                                        <c:when test="${p.edit1 != p.teninhoadon && p.edit1 != null}">
                                            <p>Tên in trên hóa đơn: <b><u>${p.teninhoadon}</u></b></p>
                                                    </c:when>
                                                    <c:otherwise>
                                            <p>Tên in trên hóa đơn: ${p.teninhoadon}</p>    
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.edit2 != p.diachiLapdat && p.edit2 != null}">
                                            <p>Địa chỉ lắp đặt: <b><u>${p.diachiLapdat}</u></b></p>
                                                    </c:when>
                                                    <c:otherwise>
                                            <p>Địa chỉ lắp đặt: <b>${p.diachiLapdat}</b></p>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:choose>
                                        <c:when test="${p.edit3 != p.mcc && p.edit3 != null}">
                                            <p>MCC: <b><u>${p.mcc}</u></b></p>
                                                    </c:when>
                                                    <c:otherwise>
                                            <p>MCC: <b>${p.mcc}</b></p>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:choose>
                                        <c:when test="${p.edit4 != p.dongmay && p.edit4 != null}">
                                            <p>Dòng  máy: <b><u>${p.dongmay}</u></b></p>
                                                    </c:when>
                                                    <c:otherwise>
                                            <p>Dòng  máy: <b>${p.dongmay}</b></p>
                                        </c:otherwise>
                                    </c:choose>



                                    <p><i>GIAO DỊCH ĐẶC BIỆT</i></p>
                                    <c:choose>
                                        <c:when test="${p.gddb1 == 1}">
                                            <input name="gddb1" value="1" checked="checked" type="checkbox" id="gd1"/>
                                            <label for="gd1"><span></span>1</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.gddb2 == 1}">
                                            <input name="gddb2" value="1" checked="checked" type="checkbox" id="gd2"/>
                                            <label for="gd2"><span></span>2</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.gddb3 == 1}">
                                            <input name="gddb3" checked="checked" value="1" type="checkbox" id="gd3"/>
                                            <label for="gd3"><span></span>3</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.gddb4 == 1}">
                                            <input name="gddb4"  checked="checked" value="1" type="checkbox" id="gd4"/>
                                            <label for="gd4"><span></span>4</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.gddb5 == 1}">
                                            <input checked="checked" name="gddb5" value="1" type="checkbox" id="gd5"/>
                                            <label for="gd5"><span></span>5</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.gddb6 == 1}">
                                            <input name="gddb6" checked="checked" value="1" type="checkbox" id="gd6"/>
                                            <label for="gd6"><span></span>6</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.gddb7 == 1}">
                                            <input name="gddb7" checked="checked" value="1" type="checkbox" id="gd7"/>
                                            <label for="gd7"><span></span>7</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.gddb8 == 1}">
                                            <input name="gddb8" checked="checked" value="1" type="checkbox" id="gd8"/>
                                            <label for="gd8"><span></span>8</label>
                                                </c:when>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.gddb9 == 1}">
                                            <input name="gddb9" checked="checked" value="1" type="checkbox" id="gd9"/>
                                            <label for="gd9"><span></span>9</label>
                                                </c:when>

                                    </c:choose>
                                    <p>--------------------------------------------------------</p>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr style="font-style: italic">
                            <c:choose>
                                <c:when test="${size != 0}">
                                    <td>Ghi chú:</td>
                                    <td colspan="2">
                                        <p> &nbsp; </p>
                                        <p>1. Giao dịch không xuất trình thẻ (MOTO) (**)</p>
                                        <p>2. Giao dịch Đặt phòng / Hoàn tất Đặt phòng (Pre-Auth / Complete Pre-Auth) (**)</p>
                                        <p>3. Giao dịch Điều chỉnh (Adjust) (***)</p>
                                        <p>4. Giao dịch Ngoại tuyến (OFFLINE) (***)</p>
                                        <p>5. Chức năng nhập tiền TIP</p>
                                        <p>6. Giao dịch thanh toán nhập tay số thẻ (***)</p>
                                        <p>7. Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch MOTO (**)</p>
                                        <p>8. Nhập tay số thẻ khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</p>
                                        <p>9. Bỏ qua bước nhập CVC2/CVV2/CID khi thực hiện giao dịch Pre-Auth / Complete Pre-Auth (***)</p>
                                    </td>                            
                                </c:when>
                            </c:choose>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p> &nbsp; </p>
                                <p>
                                    Chúng tôi cam kết sẽ tuân thủ đầy đủ các điều kiện và điều khoản trong Hợp đồng chấp nhận thanh toán thẻ với Vietinbank. Nếu có bất kỳ sai sót nào, chúng tôi sẽ chịu hoàn toàn trách nhiệm.														
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                        <center><b>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p>LẬP BẢNG</p></b>
                            <p>(Ký & ghi rõ họ tên)</p>
                        </center>
                        </td>
                        <td>
                        <center><b>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p>KIỂM SOÁT</p></b>
                            <p>(Ký & ghi rõ họ tên)</p>
                        </center>
                        </td>
                        <td><center><b>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p>TRƯỞNG ĐƠN VỊ</p></b>
                            <p>TUQ. TỔNG GIÁM ĐỐC</p>
                            <p>(Ký & đóng dấu)</p>
                        </center>
                        </td>
                        <tr>
                            <td colspan="3">
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                            </td> 
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p><b><i><u>Nơi nhận:</u></i></b></p>
                                <p>- Như trên;</p>
                                <p>- Tổng Giám Đốc "để báo cáo";</p>   
                                <p>- Lưu VT, P.KTT&NHS.</p>   
                            </td>
                        </tr>
                    </table>
                </center>
            </div>
        </div>
    </body>

    <script>
        /* HTML to Microsoft Word Export Demo 
         * This code demonstrates how to export an html element to Microsoft Word
         * with CSS styles to set page orientation and paper size.
         * Tested with Word 2010, 2013 and FireFox, Chrome, Opera, IE10-11
         * Fails in legacy browsers (IE<10) that lack window.Blob object
         */
        window.export.onclick = function () {

            if (!window.Blob) {
                alert('Your legacy browser does not support this action.');
                return;
            }

            var html, link, blob, url, css;

            // EU A4 use: size: 841.95pt 595.35pt;
            // US Letter use: size:11.0in 8.5in;

            css = (
                    '<style>' +
                    '@page WordSection1{size: 841.95pt 595.35pt;mso-page-orientation: landscape;}' +
                    'div.WordSection1 {page: WordSection1;}' +
                    'table{border:none}td{border:none;width:5em;padding:2px;}' +
                    '.abc{background-color:red;}' +
                    '</style>'
                    );

            html = window.docx.innerHTML;
            blob = new Blob(['\ufeff', css + html], {
                type: 'application/msword'
            });
            url = URL.createObjectURL(blob);
            link = document.createElement('A');
            link.href = url;
            // Set default file name. 
            // Word will append file extension - do not add an extension here.
            link.download = 'EDIT_DVCNT';
            document.body.appendChild(link);
            if (navigator.msSaveOrOpenBlob)
                navigator.msSaveOrOpenBlob(blob, 'EDIT_DVCNT.doc'); // IE10-11
            else
                link.click();  // other browsers
            document.body.removeChild(link);
        };

    </script>
</html>
