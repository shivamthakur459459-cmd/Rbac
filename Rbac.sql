-- Step 1: Create Database and Table
CREATE DATABASE company_db;
USE company_db;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Step 2: Create Roles
CREATE ROLE 'admin_role';
CREATE ROLE 'editor_role';
CREATE ROLE 'viewer_role';

-- Step 3: Grant Privileges to Roles
-- Admin: Full Access
GRANT ALL PRIVILEGES ON company_db.* TO 'admin_role';

-- Editor: CRUD (no user management)
GRANT SELECT, INSERT, UPDATE, DELETE ON company_db.* TO 'editor_role';

-- Viewer: Read-only
GRANT SELECT ON company_db.* TO 'viewer_role';

-- Step 4: Create Users
CREATE USER 'admin_user'@'%' IDENTIFIED BY 'AdminPass123';
CREATE USER 'editor_user'@'%' IDENTIFIED BY 'EditorPass123';
CREATE USER 'viewer_user'@'%' IDENTIFIED BY 'ViewerPass123';

-- Step 5: Assign Roles to Users
GRANT 'admin_role' TO 'admin_user'@'%';
GRANT 'editor_role' TO 'editor_user'@'%';
GRANT 'viewer_role' TO 'viewer_user'@'%';

-- Step 6: Set Default Roles
SET DEFAULT ROLE ALL TO 'admin_user'@'%', 'editor_user'@'%', 'viewer_user'@'%';