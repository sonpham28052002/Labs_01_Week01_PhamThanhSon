package vn.edu.iuh.fit.reponsitory;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.edu.iuh.fit.conectionDB.ConecttionDB;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.GantAccess;

import java.util.List;

public class AccountReponsitory {
    private EntityManager entityManager;

    public AccountReponsitory() {
        entityManager = ConecttionDB.getConecttionDB().getManagerFactory().createEntityManager();
    }
    public Account getOne(String id){
        return  entityManager.find(Account.class,id);
    }
    public Account getAccountByEmailAndPassword(String email, String password){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            String sql = "SELECT a FROM account WHERE email ='" + email + "' and password = '" + password + "'";
            System.out.println(sql);
            Account a = (Account) entityManager.createNativeQuery("SELECT * FROM `account` WHERE email ='"+email+"' and password = '"+password+"'", Account.class).getSingleResult();
            transaction.commit();
            return  a;
        }catch (Exception ex){
            ex.printStackTrace();
            transaction.rollback();
        }
        return null;
    }

    public List<Account> getAll(){
        return entityManager.createQuery("select a from Account a where status = +"+1, Account.class).getResultList();
    }
    public boolean addGantAccess(GantAccess gantAccess){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            entityManager.persist(gantAccess);
            transaction.commit();
            return true;
        }catch (Exception ex){
            transaction.rollback();
        }
        return false;
    }
    public String getAccountFinal(){
        return entityManager.createQuery("select ac from Account ac order by ac.accountId desc ",Account.class).getResultList().get(0).getAccountId();
    }
    public boolean insertAccount(Account account){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            entityManager.persist(account);
            transaction.commit();
            return true;
        }catch (Exception ex){
            ex.printStackTrace();
            transaction.rollback();
        }
        return false;
    }
    public boolean deleteAccount(Account account){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            entityManager.remove(account);
            transaction.commit();
            return true;
        }
        catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return false;
    }
    public boolean updateAccount(Account account){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {
            entityManager.merge(account);
            transaction.commit();
            return true;
        }catch (Exception exception){
            exception.printStackTrace();
             transaction.rollback();
        }
        return false;
    }
}
