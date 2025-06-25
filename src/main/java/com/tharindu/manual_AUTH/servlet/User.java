package com.tharindu.manual_AUTH.servlet;

import jakarta.annotation.security.DeclareRoles;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.tharindu.manual_AUTH.ejb.UserSessionBean;

import java.io.IOException;
@DeclareRoles({"USER"})
@ServletSecurity(@HttpConstraint(rolesAllowed = "USER"))
@WebServlet("/user")
public class User extends HttpServlet {
    @EJB
    private UserSessionBean userSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        userSessionBean.method4();
    }
}
