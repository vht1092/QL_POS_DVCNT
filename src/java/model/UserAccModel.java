package model;

import entity.UserAcc;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.criterion.Example;

public class UserAccModel {

    // Get an User by Id
    public UserAcc getUserByUsername(String maUser) {        
        UserAcc p = new UserAcc();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {            
            //UserAcc p = new UserAcc();
            try {
                s.beginTransaction();
                p = (UserAcc) s.get(UserAcc.class, maUser);
                s.getTransaction().commit();
            } catch (Exception e) {
                e.printStackTrace();
                s.getTransaction().rollback();
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return p;

    }

    // Get an User by Id
    public String _getEmail(String maUser) {
        Session s;
        UserAcc p = new UserAcc();
        try {
            s = HibernateUtil.getSessionFactory().getCurrentSession();
            //UserAcc p = new UserAcc();
            try {
                s.beginTransaction();
                p = (UserAcc) s.get(UserAcc.class, maUser);
                s.getTransaction().commit();
            } catch (Exception e) {
                e.printStackTrace();
                s.getTransaction().rollback();
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return String.valueOf(p.getEmail());
    }

    // Update User
    public void update(UserAcc p) {
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

    // Create USER
    public void create(UserAcc p) {
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
    
    public List<UserAcc> getUser_byBranch_byRole(String branch, String role) {
        List<UserAcc> lst = new ArrayList<UserAcc>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            UserAcc p = new UserAcc();            
            p.setMaCn(branch);
            p.setGroupUser(Byte.parseByte(role));
            s.beginTransaction();
            lst = s.createCriteria(UserAcc.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
}
