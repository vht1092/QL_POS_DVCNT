package model;

import entity.TtPosLive;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;

public class TtPosModel {

    // SelectAll TtPos
    public List<TtPosLive> getAll() {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).addOrder(Order.desc("tinhtrangPos")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Count All POS
    public long countAll() {
        long count = 0;
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).list();
            count = lst.size();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Trả về số lượng ĐVCNT đang xử lý
    public long countPOSDangXuLy() {
        long size = 0;
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setTinhtrangPos("Đang xử lý");
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            size = lst.size();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return size;
    }

    // Trả về số lượng ĐVCNT đang xử lý
    public long countPOSByDongMay_MaDvcnt(String maDvcnt, String dongmay) {
        long size = 0;
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setMid(maDvcnt);
            p.setDongmay(dongmay);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            size = lst.size();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return size;
    }

    // Create TtPOS
    public void create(TtPosLive p) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            s.save(p);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
    }

    // Get a TT_POS
    public TtPosLive getTtPos(String id) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        TtPosLive p = new TtPosLive();
        try {
            s.beginTransaction();
            p = (TtPosLive) s.get(TtPosLive.class, id);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
        return p;
    }

    // Update TtDDvcnt
    public void update(TtPosLive p) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            s.update(p);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
    }

    // Lấy DS thông tin lắp đặt POS theo MA_DVCNT
    public TtPosLive getPosById(String id) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        TtPosLive p = new TtPosLive();
        try {
            s.beginTransaction();
            p = (TtPosLive) s.get(TtPosLive.class, id);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
        return p;
    }

    // Lấy DSPOS theo SOSERI
    public List<TtPosLive> getPosBySeri(String seri) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        TtPosLive p = new TtPosLive();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            p.setSoseri(seri);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Lấy DS POS theo mid
    public List<TtPosLive> getListPosById(String id) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setMid(id);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Lấy DS POS theo mã ĐVCNT(Mid)
    public List<TtPosLive> getListPosByIdDVCNT(String maDvcnt) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setMid(maDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Lấy DS POS theo tên dòng máy
    public List<TtPosLive> getListPosByDongMay(String dongMay) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setDongmay(dongMay);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Lấy DS POS theo số Seri của POS
    public List<TtPosLive> getListPosBySeriNo(String soseri) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setSoseri(soseri);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Lấy DS POS theo tình trạng: Ton kho/Sử dụng/Đang xử lý
    public List<TtPosLive> getListPosByTinhTrang(String tinhtrang) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setTinhtrangPos(tinhtrang);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    public List<TtPosLive> getAllDistinctByDongMay() {
        List<TtPosLive> _lst = new ArrayList<TtPosLive>();
//        List<TtPos> lst= new ArrayList<TtPos>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();

        Criteria criteria = s.createCriteria(TtPosLive.class).setProjection(Projections.distinct(Projections.property("dongmay")));
        List<TtPosLive> lst = criteria.list();

        return lst;
    }

    // Check trùng serialNo?
    public boolean checkSerialNo(String serial) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        int n = lst.size();
        for (int i = 0; i < n; i++) {
            String str = String.valueOf(lst.get(i).getSoseri());
            if (str.equals(serial)) {
                return false;
            }
        }
        return true;
    }

    // Đếm số lượng POS theo mã ĐVCNT
    public int countPOSByMid(String Mid) {
        int count = 0;
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setMid(Mid);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
            count = lst.size();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Lấy DS POS theo MID
    public List<TtPosLive> getListPosByMid(String Mid) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        TtPosLive p = new TtPosLive();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            p.setMid(Mid);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // GET POS theo số Seri
    public String getPosBySeriNo(String soseri) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setSoseri(soseri);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String maPOS = "";
        int n = lst.size();
        for (int i = 0; i < n; i++) {
            String str = lst.get(i).getSoseri();
            if (lst.get(i).getSoseri().equals(soseri)) {
                maPOS = lst.get(i).getMaPos();
                break;
            }
        }
        return maPOS;
    }

    // GET ngan hang thanh toan theo số Seri
    public String getNganHangThanhToanBySeriNumber(String soseri) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setSoseri(soseri);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String nganhangthanhtoan = "";
        int n = lst.size();
        for (int i = 0; i < n; i++) {
            String str = lst.get(i).getSoseri();
            if (lst.get(i).getSoseri().equals(soseri)) {
                nganhangthanhtoan = lst.get(i).getNganhang();
                break;
            }
        }
        return nganhangthanhtoan;
    }

    // GET MA TAI SAN theo số Seri
    public String getMaTaiSanBySeriNumber(String soseri) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setSoseri(soseri);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String mataisan = "";
        int n = lst.size();
        for (int i = 0; i < n; i++) {
            String str = lst.get(i).getSoseri();
            if (lst.get(i).getSoseri().equals(soseri)) {
                mataisan = lst.get(i).getMataisan();
                break;
            }
        }
        return mataisan;
    }

    public void update_thuhoiPos(String maDvcnt, int ngayThuHoi) {

        // UPDATE DS TT_POS THUOC DVCNT maDvcnt về tình trạng Ton kho
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        lst = getListPosByMid(maDvcnt);
        TtPosModel model = new TtPosModel();
        TtPosLive p = new TtPosLive();

        for (int i = 0; i < lst.size(); i++) {
            p = lst.get(i);
            String STATUS = String.valueOf(p.getTinhtrang());

            if (STATUS.equals("1")) {

                // Xóa TT_POS_TEMP
                String soSeri = p.getSoseri();
                TtPosTempModel modelTemp = new TtPosTempModel();
                modelTemp.update_thuhoiPosTemp(maDvcnt, soSeri);

                // Xóa TT_POS
                String emty = null;
                // p.setMid(emty);
                p.setTeninhoadon(emty);
                p.setDiachiLapdat(emty);
                p.setSoTktgtt(emty);
                p.setTenchutk(emty);
                p.setNganhang(emty);
                p.setMid(emty);
                p.setTid1(emty);
                p.setMid1(emty);
                p.setTid2(emty);
                p.setMid2(emty);
                p.setTid3(emty);
                p.setMid3(emty);
                p.setGhichu(emty);
                p.setTenDvcnt(emty);
                p.setngayXacnhanThuhoi(ngayThuHoi);

                p.setTinhtrang(null);// Tình trạng POS = null, tức là đã xóa POS thuộc maDvcnt -> POS trở về Ton kho

                p.setTinhtrangPos("Ton kho");
                model.update(p);
            }
        }
    }

    public void update_TamKhoa_Pos(String maDvcnt) { //Tức là cập nhật tình trạng POS về tạm khóa, có thể mở khóa lại

        // UPDATE DS TT_POS THUOC DVCNT maDvcnt về tình trạng Ton kho
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        lst = getListPosByMid(maDvcnt);
        TtPosModel model = new TtPosModel();
        TtPosLive p = new TtPosLive();
        int size = lst.size();

        for (int i = 0; i < lst.size(); i++) {
            p = lst.get(i);
            String STATUS = String.valueOf(p.getTinhtrang());

            if (STATUS.equals("2")) {

                // Tạm khóa TT_POS_TEMP, cập nhật ismapping = 6
                String soSeri = p.getSoseri();
                TtPosTempModel modelTemp = new TtPosTempModel();
                modelTemp.update_TamKhoaPosTemp(maDvcnt, soSeri);

                Byte tinh_trang = -2; // Tình trạng POS = -2, tức là đã POS đã được bật tạm khóa
                p.setTinhtrang(tinh_trang);

                //p.setTinhtrangPos("Ton kho");
                model.update(p);
            }
        }
    }

    // GET DS POS đang được xử lý lắp mới
    public List<TtPosLive> getDSPOSDangXuLyThemMoi(String Mid) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setMid(Mid);
            Byte tinhtrang = 0; // POS đang xử lý thêm mới
            p.setTinhtrang(tinhtrang);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // GET DS POS đang được xử lý tạm khóa
    public List<TtPosLive> getDSPOSDangXuLyTamKhoa(String Mid) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setMid(Mid);
            Byte tinhtrang = 2; // POS đang xử lý tạm khóa
            p.setTinhtrang(tinhtrang);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // GET DS POS đang được xử lý khóa
    public List<TtPosLive> getDSPOSDangXuLKhoa(String Mid) {
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosLive p = new TtPosLive();
            p.setMid(Mid);
            Byte tinhtrang = 1; // POS đang xử lý khóa
            p.setTinhtrang(tinhtrang);
            s.beginTransaction();
            lst = s.createCriteria(TtPosLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
}
