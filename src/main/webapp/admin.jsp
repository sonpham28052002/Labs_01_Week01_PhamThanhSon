<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="vn.edu.iuh.fit.reponsitory.AccountReponsitory" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page import="vn.edu.iuh.fit.reponsitory.RoleReponsitory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
            crossorigin="anonymous">
    <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
            integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
            crossorigin="anonymous"></script>
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
            integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
            crossorigin="anonymous"></script>
</head>
<body style="display: flex;align-items: center;justify-content: center">
<%
    List<Account> dsUser = new AccountReponsitory().getAll();
    Account user = (Account) request.getSession().getAttribute("user");
    List<Role> roleList= new RoleReponsitory().getAll();
    String check = request.getAttribute("notifi")+"";
    check = check.equals("null") ? "":check;
%>
<div  class="container ">
    <form action="controller" method="post">
        <div class="form-row">
            <div class="form-group col-md-4">
                <label for="role">role:</label>
                <select id="role" name="role" class="form-control">
                    <%for (Role role:roleList) {
                    %>
                    <option value=<%=role.getRoleId()%>><%=role.getRoleName()%></option>
                    <%}%>
                </select>
            </div>
            <div class="form-group col-md-4">
                <label for="user">users:</label>
                <select id="user" name="user" class="form-control" >
                   <%for (Account account:dsUser) {
                        if (!account.getAccountId().equalsIgnoreCase(user.getAccountId())){
                   %>
                    <option value=<%=account.getAccountId()%>><%=account.getAccountId()%></option>
                    <%}}%>
                </select>
            </div>
            <div class="form-group col-md-4">
                <%=check%>
            </div>
            <div class="form-group col-md-4">
                <label for="inputZip">Notes</label>
                <input type="text" name="note" class="form-control" id="inputZip">
            </div>
        </div>
        <br>
        <div >
            <button type="submit" name="add" class="btn btn-primary">Add</button>
            <button type="submit" name="logout" class="btn btn-primary">Log Out</button>
        </div>
    </form>
</div>
</body>
</html>
