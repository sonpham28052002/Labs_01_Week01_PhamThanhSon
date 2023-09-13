<%@ page import="vn.edu.iuh.fit.entities.Log" %>
<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %><%--
  Created by IntelliJ IDEA.
  User: Leon
  Date: 9/11/2023
  Time: 1:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    Account account = (Account) request.getSession().getAttribute("user");
    List<Role> ds = (List<Role>) request.getAttribute("list_gant");
    request.setAttribute("Log", request.getAttribute("Log"));
%>
<div class="container">
    <H1>
        <%= account.getFullName() %>
    </H1>
    <H1>
        <%= account.getEmail() %>
    </H1>
    <H1>
        <%= account.getPhone() %>
    </H1>
    <h3>Quyền</h3>
    <select class="custom-select w-25" multiple>
        <%
            for (Role role:ds) {%>
        <option><%=role.getRoleName()%></option>
        <%}%>

    </select>
    <form action="controller" method="post">
        <input type="submit" value="logout" name="logout">
        <div>
            <%--        <%=log.toString()%>--%>
        </div>
    </form>
</div>
</body>
</html>
