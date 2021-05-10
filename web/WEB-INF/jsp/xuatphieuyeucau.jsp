<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
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
        <div class="timkiem" style=" margin-left: 8%; margin-bottom: 6%">                
            <form action="${pageContext.request.contextPath}/thoigianxuatpyc" method="get">
                Từ ngày
                <input type="date" name="dayfrom" style="border: 1px solid; border-radius: 2px">
                Đến ngày
                <input type="date" name="dayto" style="border: 1px solid; border-radius: 2px">
                <input type="submit" value="Search" style="background-color: green; color: white; padding: 3px; font-weight: bold"/>
                <span style="color: red;">
                    <c:choose>
                        <c:when test="${dayfrom != '' && dayto == ''}">
                            Kết quả tìm kiếm từ ngày ${dayfrom}
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${dayfrom == '' && dayto != ''}">
                            Kết quả tìm kiếm từ ngày ${dayto}
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${dayfrom != '' && dayto != ''}">
                            Kết quả tìm kiếm từ ngày ${dayfrom} đến ngày ${dayto}
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${dayfrom == '' && dayto == ''}">
                        </c:when>
                    </c:choose>
                </span>
            </form>
        </div>
        <div id="docx">
            <div class="WordSection1">
                <center>
                    <table style="width: 100%; font-size: 16px; border: none; background-color: white; border-collapse: collapse">
                        <tr>
                            <td colspan="5">
                        <center>
                            <p><b>NGÂN HÀNG TMCP SÀI GÒN</b></p>
                            <p>Số: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /ĐN-SCB-TGĐ.19</p>
                        </center>
                        </td>
                        <td colspan="13">
                        <center>
                            <p style="font-size: 14px"><b>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</b></p>
                            <p><b>Độc lập – Tự do – Hạnh phúc</b></p>
                            <p class="ngaythangnam"><i>TP. Hồ Chí Minh, ngày ${day} tháng ${month} năm ${year}</i></p>
                        </center>
                        </td>
                        </tr>
                        <tr>
                            <td colspan="18">
                        <center>
                            <p> &nbsp; </p>
                            <h3>GIẤY ĐỀ NGHỊ THIẾT LẬP THÔNG SỐ CHO ĐVCNT VÀ CÁC DỊCH VỤ KHÁC (NẾU CÓ)</h3>
                            <p><h3>Kính gửi: NH TMCP CÔNG THƯƠNG VN</h4></h3>
                        </center>
                        </td>
                        </tr>
                        <tr>
                            <td colspan="18">
                        <center><p>Căn cứ đề nghị của ĐVCNT, Ngân hàng TMCP Sài Gòn kính đề nghị Vietinbank tạo thông số cho các ĐVCNT sau:</p></center>
                        <p> &nbsp; </p>
                        </td>
                        </tr>

                        <tr  style="border: 1px solid; border-collapse: collapse; height: 30px; font-size: 12px">
                            <th style="border: 1px solid; border-collapse: collapse">Tên ĐK KD</th>
                            <th style="border: 1px solid; border-collapse: collapse">Số GPĐKKD</th>
                            <th style="border: 1px solid; border-collapse: collapse">Người đại diện</th>
                            <th style="border: 1px solid; border-collapse: collapse">CMT/Passport</th>
                            <th style="border: 1px solid; border-collapse: collapse">Địa chỉ ĐKKD</th>
                            <th style="border: 1px solid; border-collapse: collapse">Tên in HĐ</th>
                            <th style="border: 1px solid; border-collapse: collapse">Địa chỉ lắp</th>
                            <th style="border: 1px solid; border-collapse: collapse">Nhóm nghề</th>
                            <th style="border: 1px solid; border-collapse: collapse">Dòng máy</th>
                            <th style="border: 1px solid; border-collapse: collapse">MO</th>
                            <th style="border: 1px solid; border-collapse: collapse">Pre-Authorized</th>
                            <th style="border: 1px solid; border-collapse: collapse">Offline</th>
                            <th style="border: 1px solid; border-collapse: collapse">TIP</th>
                            <th style="border: 1px solid; border-collapse: collapse">Adj</th>
                            <th style="border: 1px solid; border-collapse: collapse">Refund</th>
                            <th style="border: 1px solid; border-collapse: collapse">1</th>
                            <th style="border: 1px solid; border-collapse: collapse">2</th>
                            <th style="border: 1px solid; border-collapse: collapse">3</th>
                            <th style="border: 1px solid; border-collapse: collapse">4</th>
                        </tr>
                        <c:forEach items="${lst}" var="p">
                            <c:choose>
                                <c:when test="${p.ismapping == 2}">
                                    <tr  style="border: 1px solid; border-collapse: collapse; height: 30px">
                                        <td style="border: 1px solid; border-collapse: collapse; font-size: 11px">${p.tenDvcnt}</td>
                                        <td style="border: 1px solid; border-collapse: collapse; font-size: 11px">${p.gpdkkdso}</td>
                                        <td style="border: 1px solid; border-collapse: collapse; font-size: 11px">${p.gpdkkdTennguoidaidien}</td>
                                        <td style="border: 1px solid; border-collapse: collapse; font-size: 11px">${p.gpdkkdCmnd}</td>
                                        <td style="border: 1px solid; border-collapse: collapse; font-size: 11px">${p.diachiDvcnt}</td>
                                        <td style="border: 1px solid; border-collapse: collapse; font-size: 11px">${p.teninhoadon}</td>
                                        <td style="border: 1px solid; border-collapse: collapse; font-size: 11px">${p.diachiLapdat}</td>
                                        <td style="border: 1px solid; border-collapse: collapse; font-size: 11px">${p.nganhnghekd}</td>
                                        <td style="border: 1px solid; border-collapse: collapse; font-size: 11px">${p.dongmay}</td>
                                        <td style="border: 1px solid; border-collapse: collapse; font-size: 11px"></td>
                                        <td style="border: 1px solid; border-collapse: collapse">
                                            <c:choose>
                                                <c:when test="${p.gddb2 == 1}">
                                            <center>x</center>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="border: 1px solid; border-collapse: collapse">
                                        <c:choose>
                                            <c:when test="${p.gddb4 == 1}">
                                            <center>x</center>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="border: 1px solid; border-collapse: collapse"></td>
                                    <td style="border: 1px solid; border-collapse: collapse">
                                        <c:choose>
                                            <c:when test="${p.gddb3 == 1}">
                                            <center>x</center>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="border: 1px solid; border-collapse: collapse">
                                        <c:choose>
                                            <c:when test="${p.gddb6 == 1}">
                                            <center>x</center>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="border: 1px solid; border-collapse: collapse">
                                        <c:choose>
                                            <c:when test="${p.gddb8 == 1}">
                                            <center>x</center>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="border: 1px solid; border-collapse: collapse">
                                        <c:choose>
                                            <c:when test="${p.gddb9 == 1}">
                                            <center>x</center>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="border: 1px solid; border-collapse: collapse">
                                        <c:choose>
                                            <c:when test="${p.gddb7 == 1}">
                                            <center>x</center>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="border: 1px solid; border-collapse: collapse">
                                        <c:choose>
                                            <c:when test="${p.gddb1 == 1}">
                                            <center>x</center>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        <tr>
                            <td colspan="18">
                                </br><p>- Corp. ID: <b>1883958</b>.</p>
                                <p>- (1): Chức năng nhập tay giao dịch đặt phòng / hoàn tất đặt phòng</p>
                                <p>- (2): Chức năng bỏ qua bước nhập CVC2/ CVV2/ CAV2/ CID cho dịch vụ đặt phòng/ hoàn tất đặt phòng</p>
                                <p>- (3): Chức năng bỏ qua bước nhập CVC2/ CVV2/ CAV2/ CID cho giao dịch MOTO</p>
                                <p>- (4): Chức năng Hủy giao dịch MOTO.</p></br></br>
                                <p>- Mức phí (đã bao gồm VAT):	</p>												
                            </td>
                        </tr>
                        <tr>
                            <td colspan="18">
                                <table class="phi" style="width: 300px; border: 1px solid;border-collapse: collapse">
                                    <tr style="border-collapse: collapse; border: 1px solid">
                                        <th style="border-collapse: collapse; border: 1px solid">Loại thẻ</th>
                                        <th style="border-collapse: collapse; border: 1px solid">SALE</th>
                                        <th style="border-collapse: collapse; border: 1px solid">Ứng tiền mặt</th>
                                    </tr>
                                    <tr style="border-collapse: collapse; border: 1px solid">
                                        <td style="border-collapse: collapse; border: 1px solid">- Visa / MC</td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>1.54%</center></td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>1.1%</td>
                                    </tr>
                                    <tr style="border-collapse: collapse; border: 1px solid">
                                        <td style="border-collapse: collapse; border: 1px solid">- JCB</td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>1.98%</center></td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>1.1%</center></td>
                                    </tr>
                                    <tr style="border-collapse: collapse; border: 1px solid">
                                        <td style="border-collapse: collapse; border: 1px solid">- CUP</td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>1.98%</center></td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>1.1%</center></td>
                                    </tr>
                                    <tr style="border-collapse: collapse; border: 1px solid">
                                        <td style="border-collapse: collapse; border: 1px solid">- DCI</td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>3.3%</center></td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>1.1%</center></td>
                                    </tr>
                                    <tr style="border-collapse: collapse; border: 1px solid">
                                        <td style="border-collapse: collapse; border: 1px solid">- E. VTB</td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>0.297%</center></td>
                                        <td style="border-collapse: collapse; border: 1px solid"></td>
                                    </tr>
                                    <tr style="border-collapse: collapse; border: 1px solid">
                                        <td style="border-collapse: collapse; border: 1px solid">- SCB ATM</td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>0.11%</center></td>
                                        <td style="border-collapse: collapse; border: 1px solid"></td>
                                    </tr>
                                    <tr style="border-collapse: collapse; border: 1px solid">
                                        <td style="border-collapse: collapse; border: 1px solid">- ATM </td>
                                        <td style="border-collapse: collapse; border: 1px solid"><center>0.693%</center></td>
                                        <td style="border-collapse: collapse; border: 1px solid"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="18">
                                <p> &nbsp; </p>
                                <p>
                                    Chúng tôi cam kết sẽ tuân thủ đầy đủ các điều kiện và điều khoản trong Hợp đồng chấp nhận thanh toán thẻ với Vietinbank. Nếu có bất kỳ sai sót nào, chúng tôi sẽ chịu hoàn toàn trách nhiệm.
                                </p>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="4">
                        <center><b>
                                <p>LẬP BẢNG</p></b>
                            <p style="font-size: 13px">(Ký & ghi rõ họ tên)</p>
                        </center>
                        </td>
                        <td colspan="6">
                        <center><b>
                                <p>KIỂM SOÁT</p></b>
                            <p style="font-size: 13px">(Ký & ghi rõ họ tên)</p>
                        </center>
                        </td>
                        <td colspan="8"><center><b>
                                <p> &nbsp; </p>
                                <p>TRƯỞNG ĐƠN VỊ</p></b>
                            <p>TUQ. TỔNG GIÁM ĐỐC</p>
                            <p style="font-size: 13px">(Ký & đóng dấu)</p>
                        </center>
                        </td>
                        <tr>
                            <td colspan="3">
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                                <p> &nbsp; </p>
                            </td> 
                        </tr>
                        <tr>
                            <td colspan="3" style="font-size: 13px">
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
            link.download = 'PYC_CAP_THONG_SO_DVCNT';
            document.body.appendChild(link);
            if (navigator.msSaveOrOpenBlob)
                navigator.msSaveOrOpenBlob(blob, 'PYC_CAP_THONG_SO_DVCNT.doc'); // IE10-11
            else
                link.click();  // other browsers
            document.body.removeChild(link);
        };

    </script>
</html>
