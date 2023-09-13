package vn.edu.iuh.fit.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "grant_access")
public class GantAccess {
    @Id
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;
    @Id
    @ManyToOne
    @JoinColumn(name = "account_id")
    private  Account account;
    @Column(name = "is_gant")
    private boolean isGant;
    private String note;

    public GantAccess() {
    }

    public GantAccess(Role role, Account account, boolean isGant, String note) {
        this.role = role;
        this.account = account;
        this.isGant = isGant;
        this.note = note;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public boolean isGant() {
        return isGant;
    }

    public void setGant(boolean gant) {
        isGant = gant;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "GantAccess{" +
                "role=" + role +
                ", account=" + account +
                ", isGant=" + isGant +
                ", note='" + note + '\'' +
                '}';
    }
}
