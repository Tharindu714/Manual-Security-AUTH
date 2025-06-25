<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home</title>

    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- GSAP for animations -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"
            integrity="sha512-..." crossorigin="anonymous"></script>

    <style>
        /* A little extra custom styling */
        body {
            background: linear-gradient(135deg, #2d2d2d 0%, #e53e3e 100%);
        }
        #card {
            backdrop-filter: blur(10px);
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4">
<div id="card" class="bg-white/30 rounded-2xl shadow-2xl p-8 max-w-md text-center">
    <h1 id="title" class="text-5xl font-bold text-white mb-4">Welcome Home!</h1>
    <p id="subtitle" class="text-lg text-gray-100 mb-6">This is your awesome homepage.</p>
    <button id="cta"
            class="px-6 py-3 bg-white text-red-700 font-semibold rounded-full shadow-lg transform hover:scale-105 transition">
        Get Started
    </button>
</div>

<script>
    // Animate in the title and subtitle with a stagger
    document.addEventListener('DOMContentLoaded', () => {
        gsap.from("#title", {
            duration: 1,
            y: -50,
            opacity: 0,
            ease: "power4.out"
        });
        gsap.from("#subtitle", {
            duration: 1,
            y: 50,
            opacity: 0,
            ease: "power4.out",
            delay: 0.5
        });

        // Pulse the button on hover
        const btn = document.getElementById("cta");
        btn.addEventListener("mouseenter", () => {
            gsap.to(btn, { scale: 1.1, duration: 0.2, ease: "power1.out" });
        });
        btn.addEventListener("mouseleave", () => {
            gsap.to(btn, { scale: 1, duration: 0.2, ease: "power1.out" });
        });
    });
</script>
</body>
</html>
