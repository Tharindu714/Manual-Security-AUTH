<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%
    // Force an HTTP 401 status so it shows up if someone inspects the network
    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    int status = response.getStatus();

    // Simple, matching message
    String msg = "An unauthorized request was made. Please retry logging in.";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error <%= status %></title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- GSAP for animations -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>

    <style>
        /* Glass-morphism backdrop filter */
        #error-card {
            backdrop-filter: blur(8px);
        }
    </style>
</head>
<body
        class="min-h-screen flex items-center justify-center px-4"
        style="background: linear-gradient(135deg, #2d2d2d 0%, #c54040 80%);"
>
<div id="error-card"
     class="bg-white/20 rounded-2xl shadow-2xl max-w-lg w-full p-8 text-center">
    <h1 id="error-title"
        class="text-5xl font-extrabold text-orange-500 mb-4">
        Code&nbsp;<%= status %>
    </h1>
    <p id="error-msg"
       class="text-xl text-white mb-6">
        <%= msg %>
    </p>
    <button
            id="retry-btn"
            class="px-6 py-3 bg-white text-red-600 font-semibold rounded-full shadow-lg opacity-100 transform transition duration-300 hover:scale-105">
        Retry Login
    </button>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Card pop-in
        gsap.fromTo("#error-card",
            { opacity: 0, scale: 0.9 },
            { opacity: 1, scale: 1, duration: 0.8, ease: "back.out(1.7)" }
        );

        // Title drop + subtle pulse
        gsap.fromTo("#error-title",
            { opacity: 0, y: -50 },
            { opacity: 1, y: 0, duration: 1, ease: "power4.out", delay: 0.3 }
        );
        gsap.fromTo("#error-title",
            { scale: 1 },
            { scale: 1.04, duration: 0.6, ease: "power1.inOut", yoyo: true, repeat: -1, delay: 1.5 }
        );

        // Message fade-in
        gsap.from("#error-msg", {
            opacity: 0, y: 20, duration: 0.8, ease: "power2.out", delay: 0.6
        });

        // Retry button pop
        gsap.fromTo("#retry-btn",
            { opacity: 0, scale: 0.8 },
            { opacity: 1, scale: 1, duration: 0.8, ease: "elastic.out(1, 0.5)", delay: 0.9 }
        );

        // Button hover pulse
        const btn = document.getElementById("retry-btn");
        btn.addEventListener("mouseenter", () =>
            gsap.to(btn, { scale: 1.05, duration: 0.2, ease: "power1.out" })
        );
        btn.addEventListener("mouseleave", () =>
            gsap.to(btn, { scale: 1, duration: 0.2, ease: "power1.out" })
        );

        // Retry behavior
        btn.addEventListener("click", () => {
            window.location.href = `${pageContext.request.contextPath}/login.jsp`;
        });
    });
</script>
</body>
</html>
