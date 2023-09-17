package vn.edu.iuh.fit.entities;

import jakarta.persistence.*;

import java.util.Collection;

@Entity
@Table(name = "account")
public class Account{
    @Id
    @Column(name = "account_id")
    private String accountId;
    @Column(name = "full_name" , columnDefinition = "nvarchar(255)")
    private String fullName;
    private String password;
    private String email;
    private String phone;
    private boolean status;

    public Account() {
    }

    public Account(String accountId, String fullName, String password, String email, String phone, boolean status) {
        this.accountId = accountId;
        this.fullName = fullName;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.status = status;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
//        "{'roleId':'"+roleId+"','roleName':'"+roleName+"','description':'"+description+"','status':'"+status+"'}";
        return "{'accountId':'" + accountId +"','fullName':'" + fullName + "', 'password':'" + password + "','email':'" + email + "','phone':'" + phone + "', 'status':'" + status +"'}";
    }

    @OneToMany(mappedBy = "account")
    private Collection<GantAccess> gantAccess;

    public Collection<GantAccess> getGantAccess() {
        return gantAccess;
    }

    public void setGantAccess(Collection<GantAccess> gantAccess) {
        this.gantAccess = gantAccess;
    }
}
