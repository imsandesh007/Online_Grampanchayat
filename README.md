# Gram Panchayat Management System

## Tech Stack
- Java (J2EE) — Servlets, JSP, JSTL
- MySQL — Database
- JDBC — DB connectivity
- Bootstrap 5 + Font Awesome — UI
- Apache Tomcat 10+ — Server
- Maven — Build tool

---

## Setup Instructions

### Step 1: Database Setup
1. Open MySQL Workbench or phpMyAdmin
2. Run the file: `database/gram_panchayat.sql`
3. This creates the database, all tables, and inserts sample data

### Step 2: Configure DB Password
Open `src/main/java/com/gp/util/DBConnection.java` and update:
```java
private static final String PASSWORD = "root"; // ← your MySQL password
```

### Step 3: Open in NetBeans
1. File → Open Project → Select `GramPanchayat` folder
2. NetBeans will detect it as a Maven project
3. Right-click project → Build (or `mvn clean install`)

### Step 4: Run
1. Right-click project → Run
2. Select Apache Tomcat 10+ as server
3. App opens at: `http://localhost:8080/GramPanchayat/`

---

## Login Credentials

| Role   | Email               | Password  |
|--------|---------------------|-----------|
| Admin  | admin@gp.gov.in     | admin123  |
| Citizen| Register yourself   | your password |

---

## Project Structure

```
GramPanchayat/
├── pom.xml
├── database/
│   └── gram_panchayat.sql
└── src/main/
    ├── java/com/gp/
    │   ├── model/         ← POJOs (User, BirthCertificate, etc.)
    │   ├── dao/           ← Database access (JDBC)
    │   ├── servlet/
    │   │   ├── admin/     ← Admin servlets
    │   │   └── citizen/   ← Citizen servlets
    │   ├── filter/        ← AuthFilter (session check)
    │   └── util/          ← DBConnection
    └── webapp/
        ├── css/style.css
        ├── js/script.js
        ├── login.jsp
        ├── register.jsp
        ├── index.jsp
        └── WEB-INF/
            ├── web.xml
            └── views/
                ├── admin/     ← Admin JSP pages
                ├── citizen/   ← Citizen JSP pages
                └── common/    ← Shared header/footer
```

---

## Features
- **Admin:** Dashboard stats, approve/reject certificates & schemes, manage complaints, manage users
- **Citizen:** Apply for birth/death certificates, register for government schemes, file complaints, track status
- **Security:** Session-based auth, role-based access control via filter
