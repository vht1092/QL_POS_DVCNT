package model;

import entity.TtPosLive;
import entity.TtPosTempLive;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Restrictions;

public class TtPosTempModel {

    // SelectAll TtPos
    public List<TtPosTempLive> getAll() {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TT_POS_TEMP
    public List<TtPosTempLive> getAllById(String maDvcnt) {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Create TT_POS_TEMP
    public void create(TtPosTempLive p) {
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

    // Đếm số lượng POS_TEMP đã gán cho ĐVCNT
    public int countById(String maDvcnt) {
        int size = 0;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        size = lst.size();
        return size;
    }

    // Đếm số lượng POS đã map(ISMAPPING == 6)
    public int countByIsMapping_ChuaDuyet(String maDvcnt) {
        Byte ismapping = 6;
        int size = 0;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        size = lst.size();
        return size;
    }

    // Đếm số lượng POS đã map(ISMAPPING == 1)
    public int countByIsMapping(String maDvcnt) {
        Byte ismapping = 1;
        int size = 0;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        size = lst.size();
        return size;
    }

    // Đếm số lượng POS đã map co ISMAPPING == -1
    public int countByIsMappingBangTru1(String maDvcnt) {
        Byte ismapping = -1;
        int size = 0;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        size = lst.size();
        return size;
    }

    // Đếm số lượng POS đã map co ISMAPPING == 3: pos lap them da map, chua duyet
    public int countByIsMappingBang3(String maDvcnt) {
        Byte ismapping = 3;
        int size = 0;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        size = lst.size();
        return size;
    }

    public void capNhatPosLapThemQuaBangTT_POS(String maDvcnt, String userThucHien) {
        Byte ismapping = 3;
        int size = 0;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        size = lst.size();
        for (int i = 0; i < size; i++) {
            String seriPosTemp = lst.get(i).getSoseri();
            TtPosModel model = new TtPosModel();
            List<TtPosLive> lstPos = new ArrayList<TtPosLive>();
            lstPos = model.getPosBySeri(seriPosTemp);
            for (int j = 0; j <= lstPos.size(); j++) {
                TtPosLive pos = new TtPosLive();
                pos = lstPos.get(j);
                pos.setMid(lst.get(i).getMid());
                pos.setTinhtrangPos("Sử dụng");
                pos.setTeninhoadon(lst.get(i).getTeninhoadon());
                pos.setDiachiLapdat(lst.get(i).getDiachiLapdat());
                pos.setTenchutk(lst.get(i).getTenchutk());

                String mid3 = lst.get(i).getMid3();
                if (mid3 == null) {
                    pos.setNganhang("VTB");
                } else {
                    pos.setNganhang("EXB");
                }
                pos.setTid1(lst.get(i).getTid1());
                pos.setTid2(lst.get(i).getTid2());
                pos.setTid3(lst.get(i).getTid3());

                pos.setMid1(lst.get(i).getMid1());
                pos.setMid2(lst.get(i).getMid2());
                pos.setMid3(lst.get(i).getMid3());

                pos.setTenDvcnt(lst.get(i).getTenDvcnt());
                pos.setMcc(lst.get(i).getMcc());
                pos.setHanmucVnd(lst.get(i).getHanmucVnd());
                pos.setHanmucUsd(lst.get(i).getHanmucUsd());
                pos.setLoaitien(lst.get(i).getLoaitien());
                pos.setPhimo(lst.get(i).getPhimo());

                pos.setGddb1(lst.get(i).getGddb1());
                pos.setGddb2(lst.get(i).getGddb2());
                pos.setGddb3(lst.get(i).getGddb3());
                pos.setGddb4(lst.get(i).getGddb4());
                pos.setGddb5(lst.get(i).getGddb5());
                pos.setGddb6(lst.get(i).getGddb6());
                pos.setGddb7(lst.get(i).getGddb7());
                pos.setGddb8(lst.get(i).getGddb8());
                pos.setGddb9(lst.get(i).getGddb9());

                pos.setVungLapdat(lst.get(i).getVungLapdat());
                pos.setTenNganhNghe(lst.get(i).getTenNganhNghe());
                pos.setMccCode(lst.get(i).getMccCode());
                pos.setMerchantType(lst.get(i).getMerchantType());
                pos.setUserLapdat(userThucHien);

                pos.setTinhtrang(Byte.parseByte("3"));
                model.update(pos);
                break;
            }
        }
    }

    // Đếm số lượng POS đã map(ISMAPPING == 3)
    public int countByIsMappingPOSThemMoi(String maDvcnt) {
        Byte ismapping = 3;
        int size = 0;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        size = lst.size();
        return size;
    }

    // Count All POS_TEMP
    public long countAllPOSTemp() {
        long count = 0;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).list();
            count = lst.size();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Get a TT_POS_TEMP
    public TtPosTempLive getTtPosTemp(long id) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        TtPosTempLive p = new TtPosTempLive();
        try {
            s.beginTransaction();
            p = (TtPosTempLive) s.get(TtPosTempLive.class, id);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
        return p;
    }

    // Get a TT_POS_TEMP by seri
    // Lấy DSPOS theo SOSERI
    public List<TtPosTempLive> getTtPosTemp_bySeri(String seri) {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        TtPosTempLive p = new TtPosTempLive();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            p.setSoseri(seri);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Remove TT_POS_TEMP
    public void remove(TtPosTempLive p) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            s.delete(p);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
    }

    // Update TtDDvcnt
    public void update(TtPosTempLive p) {
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

    // GET STT POS_TEMP theo số Seri
    public long getPosBySeriNo(String soseri) {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setSoseri(soseri);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        long maPOS = 0;
        int n = lst.size();
        for (int i = 0; i < n; i++) {
            String str = lst.get(i).getSoseri();
            if (lst.get(i).getSoseri().equals(soseri)) {
                maPOS = lst.get(i).getStt();
                break;
            }
        }
        return maPOS;
    }

    // GET DS POS_TEMP được thêm mới: ISMAPPING = 2
    public List<TtPosTempLive> getDSPOSThemMoi(String Mid) {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(Mid);
            Byte ismapping = 2;
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // GET DS POS_TEMP được thêm mới: ISMAPPING = 3
    public List<TtPosTempLive> getDSPOSThemMoiDaMap(String Mid) { // Lấy để xuất biên bản bàn giao
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(Mid);
            Byte ismapping = 3;
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // GET DS POS_TEMP ismapping = 3 va ismapping = 1: tất cả POS đã thêm mới & thêm ban đầu(làm chức năng thu hồi)
//    public List<TtPosTemp> getDSPOSDeThuHoi(String Mid) {
//        List<TtPosTemp> lst = new ArrayList<TtPosTemp>();
//        List<TtPosTemp> lstResult = new ArrayList<TtPosTemp>();
//        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
//
//        try {
//            s.beginTransaction();
//            Criteria cr = s.createCriteria(TtPosTemp.class);
//            cr.add(Restrictions.or(Restrictions.eq("ismapping", 1), Restrictions.eq("ismapping", 3)));
//            lstResult = cr.list();
//            s.getTransaction().commit();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        int size = lstResult.size();
//        return lstResult;
//    }
    // GET DS POS_TEMP để Xuất giấy đề nghị: ISMAPPING = 2
    public List<TtPosTempLive> getDSPOSxuatPhieuYeuCau() {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            Byte ismapping = 2;
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Đếm số lượng POS thêm mới theo MADVCNT & ISMAPPING = 2
    public int countPosThemMoi(String Mid) {
        int count = 0;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(Mid);
            Byte ismapping = 2;
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        count = lst.size();
        return count;
    }

    public List<TtPosTempLive> getlistTheoNgay_XuatPhieuYeuCau(String dayfrom, String dayto) {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        List<TtPosTempLive> lstResult = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();

        dayfrom = dayfrom.replaceAll("-", "");
        dayto = dayto.replaceAll("-", "");

        long numberTuNgay = 0, numberDenNgay = 0;

        if (dayfrom != "") {
            numberTuNgay = Long.parseLong(dayfrom);
        }

        if (dayto != "") {
            numberDenNgay = Long.parseLong(dayto);
        }

        List<TtPosTempLive> playerList;
        TtPosTempModel model = new TtPosTempModel();

        try {
            s.beginTransaction();
            Criteria cr = s.createCriteria(TtPosTempLive.class);

            if (dayfrom != "" && dayto == "") {
                cr.add(Restrictions.gt("user1PtntDate", numberTuNgay - 1));
            }
            if (dayfrom == "" && dayto != "") {
                cr.add(Restrictions.gt("user1PtntDate", numberDenNgay - 1));
            }

            if (dayfrom != "" && dayto != "") {
                cr.add(Restrictions.between("user1PtntDate", numberTuNgay - 1, numberDenNgay - 1));
            } else {
                lstResult = model.getDSPOSxuatPhieuYeuCau();
            }

            lstResult = cr.list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        int size = lstResult.size();
        return lstResult;
    }

    //Cập nhật tình trạng đang chờ Xuất giấy đề nghị
    public List<TtPosTempLive> capNhatTinhTrangDangChoXuatPYC(String mid, long ngaythanghientai) {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(mid);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        int size = lst.size();
        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive temp = new TtPosTempLive();

        for (int i = 0; i < size; i++) {
            temp = lst.get(i);
            String _mid = temp.getMid();
            Byte _ismapping = 7;
//            if (temp.getIsmapping() == null) {
//                temp.getIsmapping() = _ismapping;
//            }
            if (_mid.equals(mid) && (temp.getIsmapping() != 1 || temp.getIsmapping().equals(null))) {
                temp.setUser1PtntDate(ngaythanghientai);

                Byte ismapping = 2; // (POS_TEMP đang chờ Xuất giấy đề nghị)
                temp.setIsmapping(ismapping);
                model.update(temp);
            }
        }
        return lst;
    }

    // GET DS POS_TEMP đang yêu cầu chỉnh sửa: ISMAPPING = 4 => Edit ĐVCNT cần P.KTT&NHS duyệt
    public List<TtPosTempLive> getDSPOSChinhSua1(String Mid) {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(Mid);
            Byte ismapping = 4; // Edit ĐVCNT cần P.KTT&NHS duyệt
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // GET DS POS_TEMP đang yêu cầu chỉnh sửa: ISMAPPING = 5 => Edit ĐVCNT không cần P.KTT&NHS duyệt
    public List<TtPosTempLive> getDSPOSChinhSua(String Mid) {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(Mid);
            Byte ismapping = 5; // Edit ĐVCNT không cần P.KTT&NHS duyệt
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Cap nhat ismapping =  1 khi USER 2 P.QLKDTD/KHDN duyệt EDIT không cần P.KTT&NHS duyệt
    public void capNhatIsmappingEditBasic(String mid) {
        List<TtPosTempLive> lst = getDSPOSChinhSua(mid);
        for (int i = 0; i < lst.size(); i++) {
            TtPosTempLive pos = new TtPosTempLive();
            pos = lst.get(i);

            Byte ismapping = 1;
            pos.setIsmapping(ismapping);

            TtPosTempModel model = new TtPosTempModel();
            model.update(pos);
        }
    }

    // Cập nhật các field EDIT về null
    public void capNhatEditAdvanceNull(String mid) {
        List<TtPosTempLive> lst = getDSPOSChinhSua1(mid);
        for (int i = 0; i < lst.size(); i++) {
            TtPosTempLive pos = new TtPosTempLive();
            pos = lst.get(i);

            Byte ismapping = 1;
            pos.setIsmapping(ismapping);
            pos.setedit1(null);
            pos.setedit2(null);
            pos.setedit3(null);
            pos.setedit4(null);
            pos.seteditGddb1(null);
            pos.seteditGddb2(null);
            pos.seteditGddb3(null);
            pos.seteditGddb4(null);
            pos.seteditGddb5(null);
            pos.seteditGddb6(null);
            pos.seteditGddb7(null);
            pos.seteditGddb8(null);
            pos.seteditGddb9(null);

            TtPosTempModel model = new TtPosTempModel();
            model.update(pos);
        }
    }

    // Lấy DS POS theo MID
    public List<TtPosTempLive> getListPosByMid(String Mid) {
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        TtPosTempLive p = new TtPosTempLive();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            p.setMid(Mid);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    public void update_thuhoiPosTemp(String maDvcnt, String soSeri) {

        // UPDATE DS TT_POS_TEMP THUOC DVCNT maDvcnt về null
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        lst = getListPosByMid(maDvcnt);
        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive p = new TtPosTempLive();

        for (int i = 0; i < lst.size(); i++) {
            p = lst.get(i);
            if (p.getSoseri() != null && p.getSoseri().equals(soSeri)) {
                String emty = null;
                //p.setMid(emty);
                p.setTeninhoadon(emty);
                p.setDiachiLapdat(emty);
                p.setSoTktgtt(emty);
                p.setTenchutk(emty);
                p.setTid1(emty);
                p.setMid1(emty);
                p.setTid2(emty);
                p.setMid2(emty);
                p.setTid3(emty);
                p.setMid3(emty);
                p.setGhichu(emty);
                p.setTenDvcnt(emty);
                Byte gddb = 0;
                p.setGddb1(gddb);
                p.setGddb2(gddb);
                p.setGddb3(gddb);
                p.setGddb4(gddb);
                p.setGddb5(gddb);
                p.setGddb6(gddb);
                p.setGddb7(gddb);
                p.setGddb8(gddb);
                p.setGddb9(gddb);
                p.setSoseri(emty);
                long number = 0;
                p.setHanmucUsd(number);
                p.setHanmucVnd(number);
                p.setSoseri(emty);
                p.setGpdkkdso(emty);
                p.setGpdkkdTennguoidaidien(emty);
                p.setGpdkkdCmnd(emty);
                p.setDiachiDvcnt(emty);
                p.setUser1PtntDate(number);
                p.setIsmapping(Byte.parseByte("8"));
                p.setMid(emty);//da thu hoi: M001005_
                model.update(p);
            }
        }
    }

    public void update_TamKhoaPosTemp(String maDvcnt, String soSeri) {

        // UPDATE DS TT_POS_TEMP THUOC DVCNT maDvcnt về null
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        lst = getListPosByMid(maDvcnt);
        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive p = new TtPosTempLive();

        for (int i = 0; i < lst.size(); i++) {
            p = lst.get(i);
            String soseriTemp = String.valueOf(p.getSoseri());
            if (!soseriTemp.equals("null")) {
                if (soseriTemp.equals(soSeri)) {
                    String emty = null;
                    //p.setMid(emty);
                    Byte ismapping = 6;
                    p.setIsmapping(ismapping);
                    model.update(p);
                }
            }
        }
    }

    // Cập nhật ismaping = -1 thành ismaping = 6: tức là (1)P.KTT&NHS đã mapping đủ POS, (2)P.KTT&NHS chua duyet
    public void updateIssMappingBang6(String maDvcnt) {
        Byte ismapping = -1;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        TtPosTempLive p = new TtPosTempLive();
        for (int i = 0; i < lst.size(); i++) {
            p = lst.get(i);
            String soseriTemp = String.valueOf(p.getSoseri());
            if (!soseriTemp.equals("null")) {
                //p.setMid(emty);
                Byte _ismapping = 6;
                p.setIsmapping(_ismapping);
                update(p);
            }
        }
    }

    // Cập nhật ismaping = 6 thành ismaping = -1: tức là (2)P.KTT&NHS trả hồ sơ (1)P.KTT&NHS để edit thông số
    public void updateIssMappingBangTru_1(String maDvcnt) {
        Byte ismapping = 6;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        TtPosTempLive p = new TtPosTempLive();
        for (int i = 0; i < lst.size(); i++) {
            p = lst.get(i);
            String soseriTemp = String.valueOf(p.getSoseri());
            if (!soseriTemp.equals("null")) {
                //p.setMid(emty);
                Byte _ismapping = -1;
                p.setIsmapping(_ismapping);
                update(p);
            }
        }
    }

    // Cập nhật ismaping = 6 thành ismaping = 1: tức là (2)P.KTT&NHS hoàn tất duyệt thông số
    public void updateIssMappingBang_1(String maDvcnt) {
        Byte ismapping = 6;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        TtPosTempLive p = new TtPosTempLive();
        for (int i = 0; i < lst.size(); i++) {
            p = lst.get(i);
            String soseriTemp = String.valueOf(p.getSoseri());
            if (!soseriTemp.equals("null")) {
                //p.setMid(emty);
                Byte _ismapping = 1;
                p.setIsmapping(_ismapping);
                update(p);
            }
        }
    }

    // Cập nhật ismaping = 4 thành ismaping = 1: tức là POS hoàn tất edit thông tin
    public void update_HoanTatEditPos(String maDvcnt) {
        Byte ismapping = 4;
        List<TtPosTempLive> lst = new ArrayList<TtPosTempLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtPosTempLive p = new TtPosTempLive();
            p.setMid(maDvcnt);
            p.setIsmapping(ismapping);
            s.beginTransaction();
            lst = s.createCriteria(TtPosTempLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        TtPosTempLive p = new TtPosTempLive();
        for (int i = 0; i < lst.size(); i++) {
            p = lst.get(i);
            String soseriTemp = String.valueOf(p.getSoseri());
            if (!soseriTemp.equals("null")) {
                //p.setMid(emty);
                Byte _ismapping = 1;
                p.setIsmapping(_ismapping);
                update(p);
            }
        }
    }
}
