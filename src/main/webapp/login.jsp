<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- GSAP (no integrity so it actually loads) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>

    <style>
        /* floating-label support */
        .group input:focus + label,
        .group input:not(:placeholder-shown) + label {
            transform: translateY(-1.75rem) scale(0.85);
            opacity: 1;
        }
        .group label {
            transition: all 0.2s ease-out;
            pointer-events: none;
        }
    </style>
</head>
<body
        class="min-h-screen flex items-center justify-center px-4"
        style="background: linear-gradient(135deg, #2d2d2d 0%, #e53e3e 100%);"
>

<!-- we no longer start this at opacity-0 or scale-90 in the HTML -->
<div id="login-card"
     class="bg-white/80 backdrop-blur-md rounded-2xl shadow-2xl max-w-sm w-full p-8">
    <h1 id="login-title"
        class="text-3xl font-extrabold text-gray-800 mb-6">
        Join With Us
    </h1>
    <form method="POST" action="login" class="space-y-6">
        <div class="relative group">
            <%--@declare id="j_username"--%><input name="username" type="text" placeholder=" " required
                   class="peer w-full px-4 py-3 bg-white border-2 border-gray-300 rounded-lg focus:outline-none transition"/>
            <label for="j_username"
                   class="absolute left-4 top-3 text-gray-500 opacity-75">Enter Username Here</label>
        </div>
        <div class="relative group">
            <%--@declare id="j_password"--%><input name="password" type="password" placeholder=" " required
                   class="peer w-full px-4 py-3 bg-white border-2 border-gray-300 rounded-lg focus:outline-none transition"/>
            <label for="j_password"
                   class="absolute left-4 top-3 text-gray-500 opacity-75">Enter Password Here</label>
        </div>
        <button type="submit" id="login-btn"
                class="w-full py-3 bg-red-600 text-white font-semibold rounded-lg shadow-lg transform transition">
            Log In
        </button>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Card pop-in
        gsap.fromTo("#login-card",
            { opacity: 0, scale: 0.9 },
            { opacity: 1, scale: 1, duration: 0.8, ease: "back.out(1.7)" }
        );

        // Title drop
        gsap.fromTo("#login-title",
            { opacity: 0, y: -30 },
            { opacity: 1, y: 0, duration: 1, ease: "power4.out", delay: 0.3 }
        );

        // Stagger the inputs + button
        gsap.fromTo("#login-card form > *",
            { opacity: 0, y: 20 },
            {
                opacity: 1,
                y: 0,
                duration: 0.8,
                ease: "power2.out",
                delay: 0.6,
                stagger: 0.15
            }
        );

        // Input focus border color
        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('focus', () => {
                gsap.to(input, { borderColor: "#7c3aed", duration: 0.3 });
            });
            input.addEventListener('blur', () => {
                gsap.to(input, { borderColor: "#d1d5db", duration: 0.3 });
            });
        });

        // Button hover pulse
        const btn = document.getElementById('login-btn');
        btn.addEventListener('mouseenter', () => {
            gsap.to(btn, { scale: 1.05, duration: 0.2, ease: "power1.out" });
        });
        btn.addEventListener('mouseleave', () => {
            gsap.to(btn, { scale: 1, duration: 0.2, ease: "power1.out" });
        });
    });
</script>
</body>
</html>
