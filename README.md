# 🔐 Manual Security AUTH Demo

> A Jakarta EE application showcasing manual authentication and authorization using `HttpAuthenticationMechanism`, `IdentityStore`, EJB security annotations, and servlet-based access controls.

---

## 📑 Table of Contents

1. [✨ Project Overview](#-project-overview)
2. [📂 Project Structure](#-project-structure)
3. [🛡️ Security Components & Theories](#-security-components--theories)

   * [HttpAuthenticationMechanism](#httpauthenticationmechanism)
   * [IdentityStore](#identitystore)
   * [Servlet Security Annotations](#servlet-security-annotations)
   * [EJB Method-Level Annotations](#ejb-method-level-annotations)
4. [🛠️ Configuration (web.xml)](#-configuration-webxml)
5. [🚀 Deploy & Run](#-deploy--run)
6. [👥 Default Users & Roles](#-default-users--roles)
7. [📂 Servlet Endpoints & JSP Views](#-servlet-endpoints--jsp-views)
8. [🤝 Contributing](#-contributing)

---

## ✨ Project Overview

This demo illustrates **manual security** in a Jakarta EE web app without relying on container auto-configuration. Key aspects:

* **Custom `HttpAuthenticationMechanism`** for handling credential validation and session management.
* **In-memory `IdentityStore`** as a user store with roles.
* **Servlet-level security** using `@ServletSecurity` and `@DeclareRoles`.
* **EJB security** annotations (`@RolesAllowed`, `@PermitAll`, `@DenyAll`).

---

## 📂 Project Structure

```
Manual-Security-AUTH/
├── src/main/java/com/tharindu/manual_AUTH/
│   ├── security/
│   │   ├── AuthMechanism.java    # Implements HttpAuthenticationMechanism
│   │   └── AppIdentifyStore.java # In-memory IdentityStore
│   ├── ejb/
│   │   └── UserSessionBean.java  # EJB with security annotations
│   └── servlet/
│       ├── Login.java            # POST /login redirects on success
│       ├── Logout.java           # GET /logout invalidates session
│       ├── Admin.java            # @ServletSecurity protected profile page
│       └── User.java             # Servlet for /user/* area
├── src/main/webapp/
│   ├── login.jsp                 # Login form page
│   ├── index.jsp                 # Public home page
│   ├── error.jsp                 # Generic error page
│   └── admin/
│       └── index.jsp             # Admin panel UI
└── src/main/webapp/WEB-INF/
    └── web.xml                   # Security constraints & role definitions
```

---

## 🛡️ Security Components & Theories

### HttpAuthenticationMechanism

`AuthMechanism.java` implements `HttpAuthenticationMechanism` to intercept every HTTP request.

* **validateRequest(...)**: Core method that:

  1. **Extracts Credentials** from request parameters (`j_username`, `j_password`).
  2. **Validates** via `IdentityStore`.
  3. **Manages Session**: On `AuthenticationStatus.SUCCESS`, calls `context.notifyContainerAboutLogin()`.
  4. **Redirects** unauthenticated protected requests to `/login.jsp`.

> Theory: Custom authentication mechanisms allow fine-grained control over login flow and session propagation.

### IdentityStore

`AppIdentifyStore.java` provides an in-memory map of `User` objects and validates credentials:

* **`validate(Credential)`**: Checks `UsernamePasswordCredential` against stored users, returning a `CredentialValidationResult` with caller name and roles.

> Theory: IdentityStores decouple credential storage from authentication logic, enabling pluggable stores (JPA, LDAP).

### Servlet Security Annotations

`Admin.java` uses `@DeclareRoles({"ADMIN","USER"})` and `@ServletSecurity(@HttpConstraint(rolesAllowed="ADMIN"))`:

* **Protected URLs**: `/admin/*` only accessible by ADMIN.
* **`web.xml`** also defines constraints for `/user/*` accessible by ADMIN and USER.

> Theory: Declarative security via annotations and `web.xml` leverages container-managed authorization.

### EJB Method-Level Annotations

`UserSessionBean.java` illustrates:

* `@DenyAll` on `method1()` to block all calls.
* `@PermitAll` on `method2()` to allow any authenticated caller.
* `@RolesAllowed("ADMIN")` on `method3()` to restrict to ADMIN.
* `@RolesAllowed({"ADMIN","USER"})` on `method4()` for both.
* No annotation on `method5()`, inherits class-level default.

> Theory: EJB security annotations secure business methods independent of the web layer.

---

## 🛠️ Configuration (web.xml)

```xml
<security-constraint>
  <web-resource-collection>
    <url-pattern>/admin/*</url-pattern>
  </web-resource-collection>
  <auth-constraint><role-name>ADMIN</role-name></auth-constraint>
</security-constraint>
<security-constraint>
  <web-resource-collection>
    <url-pattern>/user/*</url-pattern>
  </web-resource-collection>
  <auth-constraint><role-name>ADMIN</role-name><role-name>USER</role-name></auth-constraint>
</security-constraint>
<security-role><role-name>ADMIN</role-name></security-role>
<security-role><role-name>USER</role-name></security-role>
```

---

## 🚀 Deploy & Run

1. `mvn clean package`
2. Deploy WAR to a Jakarta EE container (WildFly, Payara).
3. Access:

   * Home: `/index.jsp`
   * Login: `/login.jsp`
   * Admin: `/admin/index.jsp`

---

## 👥 Default Users & Roles

| Username | Password     | Roles       |
| -------- | ------------ | ----------- |
| Stephani | Stephani8754 | ADMIN       |
| Shane    | Shane\@23    | ADMIN, USER |
| Alberto  | Alberto234   | USER        |

---

## 📂 Servlet Endpoints & JSP Views

* **/login (POST)** → `Login.java`
* **/logout (GET)** → `Logout.java`
* **/admin/profile** → `Admin.java`
* **/user/profile** → `User.java`

Views:

```
login.jsp
index.jsp
error.jsp
admin/index.jsp
```

---

## 🤝 Contributing

Fork → branch → PR.

