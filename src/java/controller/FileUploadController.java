package controller;

import static controller.DVCNTController._formatTime;
import entity.*;
import java.io.File;
import java.time.LocalDateTime;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.TtDvcntModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class FileUploadController {

    private HttpSession _session;
    private static final String destinationDir = "D:/DVCNT_APP/POS_MOTA_DVCNT/";
    private static final String destinationFileMapping = "D:/DVCNT_APP/POS_FILE_MAPPING/";
    private static final String tamkhoa_destinationDir = "D:/DVCNT_APP/POS_KHOA_DVCNT/";
    private static final String bienbanbangiao_destinationDir = "D:/DVCNT_APP/POS_BBBG/";

    @RequestMapping(value = "/fileUpload.do", method = RequestMethod.POST)
    protected String handleRequestInternal(Model m, HttpServletRequest req,
            HttpServletResponse res) throws Exception {
        _session = req.getSession();
        POSController posController = new POSController();
        String mid = (String) _session.getAttribute("_id");

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(destinationDir + mid + "_ThemMoi_" + ngay_gio_nhap + _fileNameOriginal);
        String filenameSaveDB = mid + "_ThemMoi_" + ngay_gio_nhap + _fileNameOriginal;

        String fileNameDisplay = mid + "_ThemMoi_" + ngay_gio_nhap + _fileNameOriginal;

        String str = "D:\\" + "SCAN_DVCNT_POS";
        if (String.valueOf(file.getOriginalFilename()).equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);
            String strPageThemThongTinLapDat = posController.themTtLapDatPOS(m, mid, req, res);

            return strPageThemThongTinLapDat;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        //String filename = file.getOriginalFilename();
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);

        Byte status = p.getStatusDvcnt();
        if (status == 2 || status == 3) { // Upload file edit DVCNT            
            p.setFileUpload3(fileNameDisplay);
            model.update(p);
            String uploadsuccess = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("uploadsuccess", uploadsuccess);

            DVCNTController dvcntController = new DVCNTController();
            String strPageEditDvcnt = dvcntController.editDvcnt(m, mid, req);
            String error = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("errorr", error);

            return strPageEditDvcnt;

        } else { // Upload file thêm mới DVCNT hoặc khi user 1 P.SP&CS KHDN/KHCN upload
            p.setFileUpload(filenameSaveDB);

        }
        model.update(p);

        //themTtLapDatPOS(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        String uploadsuccess = "Upload thành công: " + fileNameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageThemThongTinLapDat = posController.themTtLapDatPOS(m, mid, req, res);
        String error = "Upload thành công: " + fileNameDisplay;
        //m.addAttribute("error", error);

        return strPageThemThongTinLapDat;
    }

    @RequestMapping(value = "/fileUploadMapping.do", method = RequestMethod.POST)
    protected String fileUploadMapping(Model m, HttpServletRequest req,
            HttpServletResponse res) throws Exception {
        _session = req.getSession();
        POSController posController = new POSController();
        String mid = (String) _session.getAttribute("_id");

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(destinationFileMapping + mid + "_Mapping_" + ngay_gio_nhap + _fileNameOriginal);
        String filenameSaveDB = mid + "_Mapping_" + ngay_gio_nhap + _fileNameOriginal;

        String fileNameDisplay = mid + "_Mapping_" + ngay_gio_nhap + _fileNameOriginal;

        if (String.valueOf(file.getOriginalFilename()).equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);
            String strPageThemThongTinLapDat = posController.themTtLapDatPOS(m, mid, req, res);

            return strPageThemThongTinLapDat;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        //String filename = file.getOriginalFilename();
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);

        Byte status = p.getStatusDvcnt();
        if (status == 2 || status == 3) { // Upload file edit DVCNT            
            p.setFileUpload3(fileNameDisplay);
            model.update(p);
            String uploadsuccess = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("uploadsuccess", uploadsuccess);

            DVCNTController dvcntController = new DVCNTController();
            String strPageEditDvcnt = dvcntController.editDvcnt(m, mid, req);
            String error = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("errorr", error);

            return strPageEditDvcnt;

        } else { // Upload file thêm mới DVCNT hoặc khi user 1 P.SP&CS KHDN/KHCN upload
            p.setFileMapping(filenameSaveDB);
        }
        model.update(p);

        String uploadsuccess = "Upload thành công: " + fileNameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        long idPOS = Long.parseLong(String.valueOf(_session.getAttribute("id_edit")));
        String strPageThemThongTinLapDat = posController.themThongSoPos(m, idPOS, req);

        return strPageThemThongTinLapDat;
    }

    @RequestMapping(value = "/editFileUploadMapping.do", method = RequestMethod.POST)
    protected String editFileUploadMapping(Model m, HttpServletRequest req,
            HttpServletResponse res) throws Exception {
        _session = req.getSession();
        POSController posController = new POSController();
        String mid = (String) _session.getAttribute("_id");

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(destinationFileMapping + mid + "_Mapping_" + ngay_gio_nhap + _fileNameOriginal);
        String filenameSaveDB = mid + "_Mapping_" + ngay_gio_nhap + _fileNameOriginal;

        String fileNameDisplay = mid + "_Mapping_" + ngay_gio_nhap + _fileNameOriginal;

        if (String.valueOf(file.getOriginalFilename()).equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);

            long id_pos_temp = Long.parseLong(String.valueOf(_session.getAttribute("id_pos_temp")));
            String strPagechinhsuathongsodagan = posController.chinhsuathongsodagan(m, id_pos_temp, req);

            return strPagechinhsuathongsodagan;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        //String filename = file.getOriginalFilename();
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);

        Byte status = p.getStatusDvcnt();
        if (status == 2 || status == 3) { // Upload file edit DVCNT            
            p.setFileUpload3(fileNameDisplay);
            model.update(p);
            String uploadsuccess = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("uploadsuccess", uploadsuccess);

            DVCNTController dvcntController = new DVCNTController();
            String strPageEditDvcnt = dvcntController.editDvcnt(m, mid, req);
            String error = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("errorr", error);

            return strPageEditDvcnt;

        } else { // Upload file thêm mới DVCNT hoặc khi user 1 P.SP&CS KHDN/KHCN upload
            p.setFileMapping(filenameSaveDB);
        }
        model.update(p);

        String uploadsuccess = "Upload thành công: " + fileNameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);

        long id_pos_temp = Long.parseLong(String.valueOf(_session.getAttribute("id_pos_temp")));
        String strPagechinhsuathongsodagan = posController.chinhsuathongsodagan(m, id_pos_temp, req);

        return strPagechinhsuathongsodagan;
    }

    @RequestMapping(value = "/fileUploadEdit.do", method = RequestMethod.POST)// ở màn hình Edit thông tin POS
    protected String edit_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        POSController posController = new POSController();
        String mid = (String) _session.getAttribute("_id");

        DVCNTController dvcntController = new DVCNTController();

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(destinationDir + mid + "_ChinhSua_" + ngay_gio_nhap + _fileNameOriginal);
        String filenameSaveDB = mid + "_ChinhSua_" + ngay_gio_nhap + _fileNameOriginal;

        String fileNameDisplay = mid + "_ChinhSua_" + ngay_gio_nhap + _fileNameOriginal;

        String str = "D:\\" + "SCAN_DVCNT_POS";
        if (String.valueOf(file.getOriginalFilename()).equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);
            String strPageEditPos = dvcntController.dseditPOS(req, m, mid);

            return strPageEditPos;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filename = file.getOriginalFilename();
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);

        Byte status = p.getStatusDvcnt();
        if (status == 2 || status == 3) { // Upload file edit DVCNT
            p.setFileUpload3(fileNameDisplay);
            model.update(p);
            String uploadsuccess = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("uploadsuccess", uploadsuccess);

            String strPageEditPos = dvcntController.dseditPOS(req, m, mid);
            String error = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("errorr", error);

            return strPageEditPos;

        } else { // Upload file thêm mới DVCNT hoặc khi user 1 P.SP&CS KHDN/KHCN upload
            p.setFileUpload(filenameSaveDB);

        }
        model.update(p);

        //themTtLapDatPOS(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        String uploadsuccess = "Upload thành công: " + fileNameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageThemThongTinLapDat = posController.themTtLapDatPOS(m, mid, req, res);
        String error = "Upload thành công: " + fileNameDisplay;
        //m.addAttribute("error", error);

        return strPageThemThongTinLapDat;
    }

    @RequestMapping(value = "/_fileUploadEdit.do", method = RequestMethod.POST) // Ở màn hình edit thông tin ĐVCNT
    protected String editDVCNT_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        POSController posController = new POSController();
        String mid = (String) _session.getAttribute("_id");

        DVCNTController dvcntController = new DVCNTController();

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(destinationDir + mid + "_ChinhSua_" + ngay_gio_nhap + _fileNameOriginal);
        String filenameSaveDB = mid + "_ChinhSua_" + ngay_gio_nhap + _fileNameOriginal;

        String fileNameDisplay = mid + "_ChinhSua_" + ngay_gio_nhap + _fileNameOriginal;

        String str = "D:\\" + "SCAN_DVCNT_POS";
        if (String.valueOf(file.getOriginalFilename()).equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);
            String strPageEditDvcnt = dvcntController.editDvcnt(m, mid, req);

            return strPageEditDvcnt;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filename = file.getOriginalFilename();
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);

        Byte status = p.getStatusDvcnt();
        if (status == 2 || status == 3) { // Upload file edit DVCNT
            p.setFileUpload3(fileNameDisplay);
            model.update(p);
            String uploadsuccess = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("uploadsuccess", uploadsuccess);

            String strPageEditDvcnt = dvcntController.editDvcnt(m, mid, req);
            String error = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("errorr", error);

            return strPageEditDvcnt;

        } else { // Upload file thêm mới DVCNT hoặc khi user 1 P.SP&CS KHDN/KHCN upload
            p.setFileUpload(filenameSaveDB);

        }
        model.update(p);

        //themTtLapDatPOS(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        String uploadsuccess = "Upload thành công: " + fileNameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageEditDvcnt = dvcntController.editDvcnt(m, mid, req);
        String error = "Upload thành công: " + fileNameDisplay;
        //m.addAttribute("error", error);

        return strPageEditDvcnt;
    }

    @RequestMapping(value = "/_fileUploadEdit2.do", method = RequestMethod.POST) //user 1 P.SP&CS KHDN hoặc KHCN upload
    protected String editDVCNT2_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        POSController posController = new POSController();
        String mid = (String) _session.getAttribute("_id");

        DVCNTController dvcntController = new DVCNTController();

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(destinationDir + mid + "_ChinhSua(2)_" + ngay_gio_nhap + _fileNameOriginal);
        String filenameSaveDB = mid + "_ChinhSua(2)_" + ngay_gio_nhap + _fileNameOriginal;

        String fileNameDisplay = mid + "_ChinhSua(2)_" + ngay_gio_nhap + _fileNameOriginal;

        String str = "D:\\" + "SCAN_DVCNT_POS";
        if (String.valueOf(file.getOriginalFilename()).equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);

            String strPageDuyet = dvcntController.duyet(m, mid, req);
            return strPageDuyet;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filename = file.getOriginalFilename();
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);

        Byte status = p.getStatusDvcnt();
        if (status == 2 || status == 3) { // Upload file edit DVCNT
            p.setFileUpload3(fileNameDisplay);
            model.update(p);
            String uploadsuccess = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("uploadsuccess", uploadsuccess);

            String strPageDuyet = dvcntController.duyet(m, mid, req);
            String error = "Upload thành công: " + fileNameDisplay;
            m.addAttribute("uploadsuccess", error);

            return strPageDuyet;

        } else { // Upload file thêm mới DVCNT hoặc khi user 1 P.SP&CS KHDN/KHCN upload
            p.setFileUpload(filenameSaveDB);

        }
        model.update(p);

        //themTtLapDatPOS(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        String uploadsuccess = "Upload thành công: " + fileNameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageDuyet = dvcntController.duyet(m, mid, req);
        String error = "Upload thành công: " + fileNameDisplay;
        //m.addAttribute("error", error);

        return strPageDuyet;
    }

    // UPLOAD cua user 1 P.SP&CS KHDN hoac P.TDBH 
    @RequestMapping(value = "/_fileUpload.do", method = RequestMethod.POST)
    protected String _handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        DVCNTController dvcntController = new DVCNTController();
        String mid = (String) _session.getAttribute("_id");

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(destinationDir + mid + "_ThemMoi(2)_" + ngay_gio_nhap + _fileNameOriginal);

        String filenameDisplay = mid + "_ThemMoi(2)_" + ngay_gio_nhap + _fileNameOriginal;

        String str = "D:\\" + "SCAN_DVCNT_POS";
        if (fileNameOriginal.equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);
            String strPageDuyet = dvcntController.duyet(m, mid, req);
            return strPageDuyet;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filename = filenameDisplay;
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);

        Byte status = p.getStatusDvcnt();
        if (status == 2 || status == 3) { // Upload file edit DVCNT
            p.setFileUpload3(filename);

        } else { // Upload file thêm mới DVCNT hoặc khi user 1 P.SP&CS KHDN/KHCN upload
            p.setFileUpload(filename);

        }
        model.update(p);

        //themTtLapDatPOS(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        String uploadsuccess = "Success: " + filename;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageDuyet = dvcntController.duyet(m, mid, req);
        return strPageDuyet;
    }

    @RequestMapping(value = "/fileUploadTamKhoa.do", method = RequestMethod.POST)
    protected String TamKhoa_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        _session.removeAttribute("luthanhcongtamkhoa");
        String mid = (String) _session.getAttribute("_id");
        DVCNTController dvcntController = new DVCNTController();

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(tamkhoa_destinationDir + mid + "_TamKhoa_" + ngay_gio_nhap + _fileNameOriginal);
        String str = "D:\\" + "KHOA_DVCNT";
        if (fileNameOriginal.equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);
            String strTamKhoa = dvcntController.pagetamkhoa(m, req, mid);
            return strTamKhoa;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filenameDisplay = mid + "_TamKhoa_" + ngay_gio_nhap + _fileNameOriginal;
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);
        p.setFileuploadTamKhoa(filenameDisplay);
        model.update(p);
        String uploadsuccess = "Upload thành công: " + filenameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        return dvcntController.pagetamkhoa(m, req, mid);
    }

    @RequestMapping(value = "/_fileUploadTamKhoa.do", method = RequestMethod.POST)
    protected String _TamKhoa_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        String mid = (String) _session.getAttribute("_id");
        DVCNTController dvcntController = new DVCNTController();

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(tamkhoa_destinationDir + mid + "_TamKhoa_" + ngay_gio_nhap + _fileNameOriginal);
        String str = "D:\\" + "KHOA_DVCNT";
        if (fileNameOriginal.equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);
            String strPageDuyet = dvcntController.duyet(m, mid, req);
            return strPageDuyet;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filenameDisplay = mid + "_TamKhoa_" + ngay_gio_nhap + _fileNameOriginal;
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);
        p.setFileuploadTamKhoa(filenameDisplay);
        model.update(p);

        String uploadsuccess = "Upload thành công: " + filenameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageDuyet = dvcntController.duyet(m, mid, req);
        return strPageDuyet;
    }

    @RequestMapping(value = "/fileUploadKhoa.do", method = RequestMethod.POST)
    protected String Khoa_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        String mid = (String) _session.getAttribute("_id");
        DVCNTController dvcntController = new DVCNTController();

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(tamkhoa_destinationDir + mid + "_Khoa_" + ngay_gio_nhap + _fileNameOriginal);
        String str = "D:\\" + "KHOA_DVCNT";
        if (fileNameOriginal.equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);
            String strTamKhoa = dvcntController.khoa(m, req, mid);
            return strTamKhoa;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filenameDisplay = mid + "_Khoa_" + ngay_gio_nhap + _fileNameOriginal;
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);
        p.setFileuploadKhoa(filenameDisplay);
        model.update(p);
        String uploadsuccess = "Upload thành công: " + filenameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        return dvcntController.khoa(m, req, mid);
    }

    @RequestMapping(value = "/_fileUploadKhoa.do", method = RequestMethod.POST)
    protected String _Khoa_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        String mid = (String) _session.getAttribute("_id");
        DVCNTController dvcntController = new DVCNTController();

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(tamkhoa_destinationDir + mid + "_Khoa_" + ngay_gio_nhap + _fileNameOriginal);
        String str = "D:\\" + "KHOA_DVCNT";
        if (fileNameOriginal.equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);
            String strPageDuyet = dvcntController.duyet(m, mid, req);
            return strPageDuyet;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filenameDisplay = mid + "_Khoa_" + ngay_gio_nhap + _fileNameOriginal;
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);
        p.setFileuploadTamKhoa(filenameDisplay);
        model.update(p);

        String uploadsuccess = "Upload thành công: " + filenameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageDuyet = dvcntController.duyet(m, mid, req);
        return strPageDuyet;
    }

    @RequestMapping(value = "/fileUploadBBTHTamKhoa.do", method = RequestMethod.POST)
    protected String fileUploadBBTHTamKhoa(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        String mid = (String) _session.getAttribute("_id");
        DVCNTController dvcntController = new DVCNTController();

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(tamkhoa_destinationDir + mid + "_BBTH_TamKhoa_" + ngay_gio_nhap + _fileNameOriginal);
        String str = "D:\\" + "KHOA_DVCNT";
        if (fileNameOriginal.equals("")) {
            //res.getWriter().write("Chua chon file upload !");
            //res.flushBuffer();
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("uploadfail", uploadsuccess);
            String strPageDuyet = dvcntController.chiTietDvcntDaLap(m, mid, req);
            return strPageDuyet;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filenameDisplay = mid + "_BBTH_Khoa_" + ngay_gio_nhap + _fileNameOriginal;
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);
        p.setFileuploadKhoa(filenameDisplay);
        model.update(p);

        String uploadsuccess = "Upload thành công: " + filenameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageDuyet = dvcntController.chiTietDvcntDaLap(m, mid, req);
        return strPageDuyet;
    }

    @RequestMapping(value = "/fileUploadBienBanBanGiaoPOS.do", method = RequestMethod.POST)
    protected String bienbanbangiao_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        DVCNTController dvcntController = new DVCNTController();
        String mid = (String) _session.getAttribute("_id");
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(mid);

        // Lay thong tin user upload
        String userUpload = (String) _session.getAttribute("mauser");
        String macn = (String) _session.getAttribute("macn");

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        String tenBBBG = userUpload.toUpperCase().replaceAll(" ", "") + "_" + macn + "_" + mid + "_BBBG_"
                + ngay_gio_nhap + _fileNameOriginal;
        File destination = new File(bienbanbangiao_destinationDir + tenBBBG);

        String str = file.getOriginalFilename();
        if (str.equals("")) {
            String uploadfaile = "Chưa chọn file upload";
            m.addAttribute("uploadfail", uploadfaile);
            String strPageChitietdvcntdaplap = dvcntController.chiTietDvcntDaLap(m, mid, req);
            return strPageChitietdvcntdaplap;
        }
        file.transferTo(destination);

        Byte xacNhanDaUpLoad_BBBG_ThemMoi = 1;
        p.setBbbgThemmoi(xacNhanDaUpLoad_BBBG_ThemMoi);
        model.update(p);

        String uploadsuccess = "Success. File name: " + tenBBBG;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageChitietdvcntdaplap = dvcntController.chiTietDvcntDaLap(m, mid, req);
        return strPageChitietdvcntdaplap;
    }

    @RequestMapping(value = "/fileUploadBienBanBanGiaoPOSLapThem.do", method = RequestMethod.POST)
    protected String bienbanbangiaoLapThem_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        DVCNTController dvcntController = new DVCNTController();
        String mid = (String) _session.getAttribute("_id");

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(bienbanbangiao_destinationDir + mid + "_BBBGLapThem_" + ngay_gio_nhap + _fileNameOriginal);
        String fileNameDisplay = mid + "_BBBGLapThem_" + ngay_gio_nhap + _fileNameOriginal;

        String str = file.getOriginalFilename();
        if (str.equals("")) {
            String uploadfaile = "Chưa chọn file upload";
            m.addAttribute("uploadfail", uploadfaile);
            String strPageChitietdvcntdaplap = dvcntController.chiTietDvcntDaLap(m, mid, req);
            return strPageChitietdvcntdaplap;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filename = destination.getAbsolutePath();
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(mid);

        p.setFileuploadTamKhoa(filename);

        model.update(p);

        String uploadsuccess = "Success. File name: " + fileNameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageChitietdvcntdaplap = dvcntController.chiTietDvcntDaLap(m, mid, req);
        return strPageChitietdvcntdaplap;
    }

    @RequestMapping(value = "/fileUploadLapThemPos.do", method = RequestMethod.POST)
    protected String fileUploadLapThemPoso_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        DVCNTController dvcntController = new DVCNTController();
        String mid = (String) _session.getAttribute("_id");

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(destinationDir + mid + "_LapThem_" + ngay_gio_nhap + _fileNameOriginal);
        String filenameDisplay = mid + "_LapThem_" + ngay_gio_nhap + _fileNameOriginal;

        String str = "D:\\" + "SCAN_DVCNT_POS";
        if (fileNameOriginal.equals("")) {
            String uploadfaile = "Chưa chọn file upload";
            m.addAttribute("error", uploadfaile);
            String strPageLapThemPos = dvcntController.lapThemPos(req, m, mid);
            return strPageLapThemPos;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filename = file.getOriginalFilename();
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);

        p.setFileUpload2(filenameDisplay);

        model.update(p);
        String uploadsuccess = "Success. File name: " + filenameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageLapThemPos = dvcntController.lapThemPos(req, m, mid);
        _session.removeAttribute("listPosDaLap");
        return strPageLapThemPos;
    }

    @RequestMapping(value = "/_fileUploadLapThemPos.do", method = RequestMethod.POST)
    protected String _fileUploadLapThemPoso_handleRequestInternal(Model m, HttpServletRequest req, HttpServletResponse res) throws Exception {
        _session = req.getSession();
        DVCNTController dvcntController = new DVCNTController();
        String mid = (String) _session.getAttribute("_id");

        res.setContentType("text/plain");
        if (!(req instanceof MultipartHttpServletRequest)) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
        MultipartFile file = multipartRequest.getFile("fileUploaded");

        String fileNameOriginal = file.getOriginalFilename();
        String _fileNameOriginal = "";
        if (fileNameOriginal != "") {
            _fileNameOriginal = fileNameOriginal.substring((fileNameOriginal.length() - 4), fileNameOriginal.length());
        }

        File destination = new File(destinationDir + mid + "_LapThem_" + ngay_gio_nhap + _fileNameOriginal);
        String filenameDisplay = mid + "_LapThem_" + ngay_gio_nhap + _fileNameOriginal;

        String str = "D:\\" + "SCAN_DVCNT_POS";
        if (fileNameOriginal.equals("")) {
            String uploadsuccess = "Chưa chọn file upload !";
            m.addAttribute("error", uploadsuccess);
            String strPageDuyet = dvcntController.duyet(m, mid, req);
            return strPageDuyet;
        }

        file.transferTo(destination);
        //res.getWriter().write("Upload thanh cong, File name: " + file.getOriginalFilename() + ". Tro ve truoc de 'GUI DUYET'");
        //res.flushBuffer();

        String filename = file.getOriginalFilename();
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();

        p = model.getTtDvcnt(mid);

        p.setFileUpload2(filenameDisplay);

        model.update(p);

        String uploadsuccess = "Success, file name: " + filenameDisplay;
        m.addAttribute("uploadsuccess", uploadsuccess);
        String strPageDuyet = dvcntController.duyet(m, mid, req);
        return strPageDuyet;
    }
}
