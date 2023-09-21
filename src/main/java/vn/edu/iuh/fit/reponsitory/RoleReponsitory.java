package vn.edu.iuh.fit.reponsitory;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import vn.edu.iuh.fit.conectionDB.ConecttionDB;
import vn.edu.iuh.fit.entities.GantAccess;
import vn.edu.iuh.fit.entities.Role;

import java.util.ArrayList;
import java.util.List;

public class RoleReponsitory {
    private EntityManager entityManager;

    public RoleReponsitory() {
        entityManager = ConecttionDB.getConecttionDB().getManagerFactory().createEntityManager();
    }

    public List<Role> getRole(String id){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            String sql ="SELECT * FROM grant_access WHERE account_id = '" + id + "'";
            List<GantAccess> dsGant = entityManager.createNativeQuery(sql, GantAccess.class).getResultList();
            List<Role> dsRole = new ArrayList<>();
            for (GantAccess a:dsGant) {
                dsRole.add(a.getRole());
                System.out.println(a.getRole());
            }
            return dsRole;
        }catch (Exception ex){
            ex.printStackTrace();
            transaction.rollback();
        }
        return null;
    }

    public Role getOne(String id){
        return entityManager.find(Role.class,id);
    }
    public List<Role> getAll(){
        return entityManager.createQuery("select rl from role rl",Role.class).getResultList();
    }

    public List<Role> getRoleNoBelongAccount(String id){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            String sql = "SELECT * from role WHERE role_id not in (SELECT role_id FROM grant_access WHERE account_id = '"+id+"')";
            List<Role> ds = entityManager.createNativeQuery(sql,Role.class).getResultList();
            transaction.commit();
            return ds;
        }catch (Exception ex){
            ex.printStackTrace();
            transaction.rollback();
        }

        return null;
    }
    public List<Role> getRoleofAccount(String id){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            List<GantAccess> dsGrant =entityManager.createNativeQuery("SELECT * FROM grant_access WHERE account_id = '"+id+"'",GantAccess.class).getResultList();
            List<Role> dsRole = new ArrayList<>();
            for (GantAccess gantAccess:dsGrant) {
                dsRole.add(gantAccess.getRole());
            }
            transaction.commit();
            return  dsRole;
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return null;
    }
    public boolean checkAdmin(String id){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            Query a = entityManager.createNativeQuery("SELECT * FROM grant_access WHERE account_id = '"+id+"' AND role_id ='role5'",GantAccess.class);
            transaction.commit();
            if (a.getResultList().size() > 0){
                return true;
            }
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return false;
    }

    public GantAccess getOneGrantAccess(String roleID, String accountId){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            GantAccess gantAccess = (GantAccess) entityManager.createNativeQuery("SELECT * FROM grant_access WHERE role_id ='"+roleID+"' and account_id ='"+accountId+"'",GantAccess.class).getSingleResult();
            transaction.commit();
            return gantAccess;
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return null;
    }
    public boolean deleteGrantAccess(GantAccess gantAccess){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            entityManager.remove(gantAccess);
            transaction.commit();
            return true;
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return false;
    }public boolean insertRole(Role role){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            entityManager.persist(role);
            transaction.commit();
            return true;
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return false;
    }
    public String getRoleLast(){
       EntityTransaction transaction = entityManager.getTransaction();
       transaction.begin();
       try {
           String role=entityManager.createQuery("select rl from role rl order by rl.roleId desc",Role.class).getResultList().get(0).getRoleId();
           transaction.commit();
           return role;
       }catch (Exception exception){
           exception.printStackTrace();
           transaction.rollback();
       }
       return null;
    }
}
