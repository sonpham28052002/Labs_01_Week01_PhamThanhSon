package vn.edu.iuh.fit.reponsitory;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
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
}
