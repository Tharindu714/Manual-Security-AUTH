package com.tharindu.manual_AUTH.servlet;

import jakarta.annotation.security.DeclareRoles;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
@DeclareRoles({"ADMIN","USER"})
@ServletSecurity(@HttpConstraint(rolesAllowed = "ADMIN"))
@WebServlet("/admin/profile")
public class Admin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang=\"en\">");
            out.println("<head>");
            out.println("  <meta charset=\"UTF-8\" />");
            out.println("  <title>Admin Profile</title>");
            // Tailwind CDN
            out.println("  <script src=\"https://cdn.tailwindcss.com\"></script>");
            // GSAP CDN
            out.println("  <script src=\"https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js\"></script>");
            out.println("</head>");
            out.println(  // ← updated gradient here
                    "<body class=\"min-h-screen flex items-center justify-center " +
                            "bg-gradient-to-br from-black to-blue-600 p-4\">"
            );
            out.println("  <div id=\"card\" class=\"bg-white/20 backdrop-blur-md rounded-2xl shadow-xl p-8 text-center max-w-md opacity-0\">");
            out.println("    <h1 id=\"title\" class=\"text-4xl font-bold text-white mb-4\">Admin Profile</h1>");
            out.println("    <p id=\"message\" class=\"text-lg text-gray-100\">Welcome to your dashboard, <strong>Admin</strong>!</p>");
            out.println("  </div>");
            out.println("  <script>");
            out.println("    document.addEventListener('DOMContentLoaded', () => {");
            out.println("      gsap.to('#card', {");
            out.println("        opacity: 1,");
            out.println("        duration: 1,");
            out.println("        ease: 'power2.out'");
            out.println("      });");
            out.println("      gsap.from('#title', {");
            out.println("        y: -30,");
            out.println("        opacity: 0,");
            out.println("        duration: 0.8,");
            out.println("        ease: 'bounce.out',");
            out.println("        delay: 0.5");
            out.println("      });");
            out.println("    });");
            out.println("  </script>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}

