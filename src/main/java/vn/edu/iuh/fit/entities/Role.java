package vn.edu.iuh.fit.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity(name = "role")
public class Role {
    @Id
    @Column(name = "role_id")
    private String roleId;
    @Column(name = "role_name",columnDefinition = "nvarchar(255)")
    private  String roleName;
    private  String description;
    private boolean status;

    public Role() {
    }

    public Role(String roleId, String roleName, String description, boolean status) {
        this.roleId = roleId;
        this.roleName = roleName;
        this.description = description;
        this.status = status;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "{'roleId':'"+roleId+"','roleName':'"+roleName+"','description':'"+description+"','status':'"+status+"'}";
    }

    public static void main(String[] args) {

    }
}
