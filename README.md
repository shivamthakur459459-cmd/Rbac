# Rbac
/* =======================================================
   ROLE BASED ACCESS CONTROL (RBAC) IN MYSQL
   Roles: Admin, Editor, Viewer
   Database: company_db
   ======================================================= */

/* Step 1: Create Database and Table */
CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

/* Step 2: Create Roles */
CREATE ROLE IF NOT EXISTS 'admin_role';
CREATE ROLE IF NOT EXISTS 'editor_role';
CREATE ROLE IF NOT EXISTS 'viewer_role';

/* Step 3: Grant Privileges to Roles */
-- Admin: Full access
GRANT ALL PRIVILEGES ON company_db.* TO 'admin_role';

-- Editor: CRUD (cannot manage users)
GRANT SELECT, INSERT, UPDATE, DELETE ON company_db.* TO 'editor_role';

-- Viewer: Read-only
GRANT SELECT ON company_db.* TO 'viewer_role';

/* Step 4: Create Users */
CREATE USER IF NOT EXISTS 'admin_user'@'%' IDENTIFIED BY 'AdminPass123';
CREATE USER IF NOT EXISTS 'editor_user'@'%' IDENTIFIED BY 'EditorPass123';
CREATE USER IF NOT EXISTS 'viewer_user'@'%' IDENTIFIED BY 'ViewerPass123';

/* Step 5: Assign Roles to Users */
GRANT 'admin_role' TO 'admin_user'@'%';
GRANT 'editor_role' TO 'editor_user'@'%';
GRANT 'viewer_role' TO 'viewer_user'@'%';

/* Step 6: Set Default Roles (so users don’t need SET ROLE manually) */
SET DEFAULT ROLE ALL TO 'admin_user'@'%', 'editor_user'@'%', 'viewer_user'@'%';

/* =======================================================
   ✅ TESTING GUIDE (Run these separately by logging in as different users)
   -------------------------------------------------------

   🔹 Login as Viewer
   > mysql -u viewer_user -p
   > SELECT * FROM company_db.employees;   -- ✅ Works
   > INSERT INTO company_db.employees(name, department, salary) VALUES ('Test', 'HR', 50000); -- ❌ Fails

   🔹 Login as Editor
   > mysql -u editor_user -p
   > INSERT INTO company_db.employees(name, department, salary) VALUES ('Alex', 'IT', 60000); -- ✅ Works
   > DELETE FROM company_db.employees WHERE emp_id=1; -- ✅ Works
   > CREATE USER test@'%' IDENTIFIED BY 'abc'; -- ❌ Fails

   🔹 Login as Admin
   > mysql -u admin_user -p
   > CREATE USER test_admin@'%' IDENTIFIED BY 'pass123'; -- ✅ Works
   > DROP TABLE company_db.employees; -- ✅ Works

   ======================================================= */
