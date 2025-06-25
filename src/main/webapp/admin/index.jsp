<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = "Secured Admin Panel";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin | Home</title>

    <!-- React & ReactDOM -->
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <!-- Babel for JSX only -->
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>

    <style>
        body { font-family: sans-serif; background: linear-gradient(135deg, #2d2d2d 0%, #e53e3e 100%); display: flex; height: 100vh; align-items: center; justify-content: center; }
        #root { background: #000000; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 12px rgba(255, 255, 255, 0.73); }
        a { color: #e53e3e; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
<div id="root"><h1>Loading…</h1></div>

<script type="text/babel" data-presets="react">
    // no TS types here, just JS + JSX
    function App(props) {
        return (
            <>
                <h2 style={{ color: '#f31d5e' }}>Welcome, {props.name}!</h2>
                <p style={{color:'#fff'}}>This page shows Java (JSP), HTML, and JSX all together.</p>
                <a href="<%= request.getContextPath() %>/logout">Logout</a>
            </>
        );
    }

    ReactDOM.createRoot(document.getElementById('root'))
        .render(<App name="<%= user %>" />);
</script>
</body>
</html>
