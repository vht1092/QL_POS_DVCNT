package controller;

import entity.UserAcc;
import java.io.IOException;
import java.rmi.ServerException;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserAccModel;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import java.io.UnsupportedEncodingException;
import java.util.Hashtable;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.FilterChain;
import java.util.Hashtable;

import javax.naming.*;
import javax.naming.directory.*;

//import org.springframework.security.core.Authentication;
@Controller
public class LoginController {

    private Session session;
    private HttpSession _session;
    private static String _ten;
    public static String ldapUri = "ldap://ad.scb.com.vn:389";
    public static String usersContainer = "OU=OU_Synced_Users,DC=scb,DC=local";

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginform(HttpServletRequest request) {
        _session = request.getSession();
        // Check login???
        if ((String) _session.getAttribute("hoten") == null) {
            return "login";
        }
        String user = (String) _session.getAttribute("hoten");
        if (user != null || !user.equals("")) {
            return "redirect:index.html";
        }
        return "login";
    }

    @RequestMapping(value = "/password", method = RequestMethod.GET)
    public String password(HttpServletRequest request) {
        _session = request.getSession();
        return "password";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(SessionStatus status, HttpServletRequest request) {
        _session = request.getSession();
//        status.setComplete();
        // Check login???
//        String fullName = (String) _session.getAttribute("hoten");
//        if (fullName.isEmpty()) {
//            return "login";
//        }
        _session.removeAttribute("hoten");
        _session.removeAttribute("mauser");
        _session.removeAttribute("success");
        _session.removeAttribute("error");
        _session.removeAttribute("doipassthanhcong");
        _session.removeAttribute("confirm");
        _session.removeAttribute("luthongsothanhcong");
        _session.removeAttribute("luthanhcongtamkhoa");
        return "redirect:login.html";
    }

    // LOGIN LIVE: LDAP
    @RequestMapping(value = "/checkloginZZZZ", method = RequestMethod.POST)
    public String processRequestLDAP(HttpServletRequest request, HttpServletResponse respones, Model m)
            throws ServerException, IOException, ServletException, Exception {
        _session = request.getSession();

        String frm_username = request.getParameter("username").toLowerCase();
        String _frm_password = request.getParameter("password");
        int lenght_username = frm_username.length();
        int number = 20 - lenght_username;

        for (int i = 1; i <= number; i++) {
            frm_username += " "; // Vì username dưới DB luôn là 20 kí tự nên phải thêm bước này
        }

        UserAccModel model = new UserAccModel();
        UserAcc user = new UserAcc();
        user = model.getUserByUsername(frm_username);

        if (user == null) {
            String str = "Tên đăng nhập hoặc mật khẩu không đúng...";
            _session.setAttribute("error", str);
            return "redirect:login.html";
        }

        String userName = "scb\\" + request.getParameter("username").toLowerCase();
        boolean checkLDAP = checkLDAP(userName, _frm_password);
        if (checkLDAP == true) {
            String hoten = user.getHoten();
            String macn = user.getMaCn();
            String tencn = user.getTenCn();
            String mauser = user.getMaUser();
            Byte groupuser = user.getGroupUser();
            _session.setAttribute("hoten", hoten);
            _session.setAttribute("macn", macn);
            _session.setAttribute("tencn", tencn);
            _session.setAttribute("mauser", mauser);
            _session.setAttribute("groupuser", groupuser);
            _session.removeAttribute("error");
            return "redirect:index.html";
        } else {
            String str = "Tên đăng nhập hoặc mật khẩu không đúng...";
            _session.setAttribute("error", str);
            return "redirect:login.html";
        }
    }

    public boolean checkLDAP(String username, String password) {

        boolean checkLogin = true;
        Hashtable<String, String> env = new Hashtable<String, String>();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, ldapUri);
        env.put(Context.SECURITY_PRINCIPAL, username);
        env.put(Context.SECURITY_CREDENTIALS, password);

        try {
            DirContext ctx = new InitialDirContext(env);
            SearchControls ctls = new SearchControls();
            String[] attrIDs = {"cn"};
            ctls.setReturningAttributes(attrIDs);
            ctls.setSearchScope(SearchControls.ONELEVEL_SCOPE);

            NamingEnumeration answer = ctx.search(usersContainer,
                    "(objectclass=group)", ctls);
            while (answer.hasMore()) {
                SearchResult rslt = (SearchResult) answer.next();
                Attributes attrs = rslt.getAttributes();
                System.out.println(attrs.get("cn"));
            }
            ctx.close();
            return checkLogin;
        } catch (NamingException e) {
            System.out.println("ERROR LOGIN: " + e.toString());

        }
        System.out.println("checkLogin = " + checkLogin);
        return false;
    }

    //PASSWORD DB
    @RequestMapping(value = "/checklogin", method = RequestMethod.POST)
    public String processRequest(HttpServletRequest request, HttpServletResponse respones, Model m)
            throws ServerException, IOException, ServletException, Exception {
        _session = request.getSession();
        
        String frm_username = request.getParameter("username").toLowerCase();
        String _frm_password = request.getParameter("password");
        String frm_password = maHoaPassword(_frm_password);
        
        int lenght_username = frm_username.length();
        int number = 20 - lenght_username;
        
        for (int i = 1; i <= number; i++) {
            frm_username += " "; // Vì username dưới DB luôn là 20 kí tự nên phải thêm bước này
        }
        
        UserAccModel model = new UserAccModel();
        UserAcc user = new UserAcc();
        user = model.getUserByUsername(frm_username);
        
        if (user == null) {
            String str = "Tên đăng nhập hoặc mật khẩu không đúng...";
            _session.setAttribute("error", str);
            return "redirect:login.html";
        }
        
        Byte lanDangNhap = user.getLanDangNhap();
        String password = user.getPassword();
        Byte lanDangNhapSai = user.getLanDangNhapSai();
        Byte tinhTrang = user.getTinhTrang();
        
        if (String.valueOf(lanDangNhap) == null || password == null || frm_password == null) {
            String str = "Tên đăng nhập hoặc mật khẩu không đúng...";
            _session.setAttribute("error", str);
            return "redirect:login.html";
        }
        
        if (lanDangNhap == 0 && !frm_password.equals(password)) {
            String str = "Tên đăng nhập hoặc mật khẩu không đúng...";
            _session.setAttribute("error", str);
            return "redirect:login.html";
        }
        if (lanDangNhap == 0 && frm_password.equals(password)) {
            String mauser = user.getMaUser();
            _session.setAttribute("mauser", mauser);
            _session.removeAttribute("error");
            return "redirect:password.html";
        }
        if (lanDangNhap != 0 && !frm_password.equals(password)) {
            String str = "Tên đăng nhập hoặc mật khẩu không đúng...";
            _session.setAttribute("error", str);
            return "redirect:login.html";
        } else {
            String hoten = user.getHoten();
            String macn = user.getMaCn();
            String tencn = user.getTenCn();
            String mauser = user.getMaUser();
            Byte groupuser = user.getGroupUser();
            _session.setAttribute("hoten", hoten);
            _session.setAttribute("macn", macn);
            _session.setAttribute("tencn", tencn);
            _session.setAttribute("mauser", mauser);
            _session.setAttribute("groupuser", groupuser);
            _session.removeAttribute("error");
            return "redirect:index.html";
        }
    }
    @RequestMapping(value = "/changepass", method = RequestMethod.POST)
    public String changepass(HttpServletRequest request, HttpServletResponse respones, Model m) throws ServerException, IOException, ServletException {
        _session = request.getSession();

        String frm_password1 = request.getParameter("password1");
        frm_password1 = maHoaPassword(frm_password1);
        String frm_password2 = request.getParameter("password2");
        frm_password2 = maHoaPassword(frm_password2);

        UserAccModel model = new UserAccModel();
        UserAcc user = new UserAcc();
        String username = String.valueOf(_session.getAttribute("mauser"));
        user = model.getUserByUsername(username);

        if (!frm_password1.equals(frm_password2)) {
            String error = "Mật khẩu xác nhận không khớp!";
            _session.setAttribute("error", error);
            return "redirect:password.html";
        } else {
            user.setPassword(frm_password1);
            Byte n = 1;
            user.setLanDangNhap(n);
            model.update(user);

            String doipassthanhcong = "Đổi mật khẩu thành công. Anh/chị vui lòng đăng nhập lại bằng mật khẩu mới !";
            _session.setAttribute("doipassthanhcong", doipassthanhcong);
            _session.removeAttribute("error");
            return "redirect:login.html";
        }
    }

    // Thêm mới ĐVCNT
    @RequestMapping(value = "/search_create_user", method = RequestMethod.POST)
    public String themDVCNT(Model m, @ModelAttribute(value = "_UserAcc") UserAcc p,
            HttpServletRequest request) {
        _session = request.getSession();
        String txt_user = request.getParameter("txt_user");
        String txt_role = request.getParameter("txt_role");
        String txt_option = request.getParameter("txt_option");
        String txt_branch = request.getParameter("txt_branch");

        UserAccModel model = new UserAccModel();
        UserAcc user = new UserAcc();
        //user = model.getUserByUsername(txt_user);

        if (txt_option.equals("KIỂM TRA")) {

        } else if (txt_option.equals("TẠO MỚI")) {
            if (model.getUserByUsername(txt_user) == null) {
                _session.setAttribute("alert_create_user", "User đã tồn tại !");
                return "redirect:tao_user.html";
            }
            UserAcc userNew = new UserAcc();
            userNew.setHoten(txt_user);
            userNew.setMaUser(txt_user.toLowerCase());
            userNew.setLanDangNhap(Byte.parseByte("0"));
            userNew.setPassword("U2NiQDEyMzQ="); // Scb@1234
            userNew.setGroupUser(Byte.parseByte(txt_role));
            userNew.setMaCn(txt_branch);
            userNew.setTenCn("");
            userNew.setLanDangNhapSai(Byte.parseByte("0"));
            userNew.setTinhTrang(Byte.parseByte("0"));
            model.create(userNew);
            _session.setAttribute("alert_create_user", "Đã tạo mới user: " + txt_user.toUpperCase());
        } else if (txt_option.equals("CẬP NHẬT")) {

        }
        //String txt_role_db = String.valueOf(user.getGroupUser());

        return "redirect:tao_user.html";
    }

    public static String maHoaPassword(String str) {
        String result = null;
        try {
            result = Base64.getEncoder().encodeToString(str.getBytes("utf-8"));
        } catch (UnsupportedEncodingException e) {
            System.out.println("Error :" + e.getMessage());
        }
        return result;
    }

    public static String giaiMaPassword(String str) {
        try {
            byte[] base64decodedBytes = Base64.getDecoder().decode(str);
            str = new String(base64decodedBytes, "utf-8");
        } catch (UnsupportedEncodingException e) {
            System.out.println("Error :" + e.getMessage());
        }
        return str;
    }
}
