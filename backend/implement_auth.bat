@echo off
echo ========================================
echo    IMPLEMENTARE AUTENTIFICARE GRM 2.0
echo ========================================
echo.

REM Oprește aplicația backend dacă rulează
echo 🛑 Te rog să oprești aplicația backend cu Ctrl+C dacă rulează...
pause

REM Navighează la backend
cd backend

echo 📦 Creez structura pentru autentificare...

REM Creez directoarele necesare
mkdir src\main\java\ro\ctp\grm\entity 2>nul
mkdir src\main\java\ro\ctp\grm\dto\request 2>nul
mkdir src\main\java\ro\ctp\grm\dto\response 2>nul
mkdir src\main\java\ro\ctp\grm\repository 2>nul
mkdir src\main\java\ro\ctp\grm\service 2>nul
mkdir src\main\java\ro\ctp\grm\security 2>nul
mkdir src\main\java\ro\ctp\grm\config 2>nul
mkdir src\main\java\ro\ctp\grm\controller 2>nul
mkdir src\main\resources\db\migration 2>nul

echo ✓ Structura creată!

REM Creez entitatea User
echo 🔐 Creez entitățile...
(
echo package ro.ctp.grm.entity;
echo.
echo import jakarta.persistence.*;
echo import jakarta.validation.constraints.Email;
echo import jakarta.validation.constraints.NotBlank;
echo import jakarta.validation.constraints.Size;
echo import lombok.AllArgsConstructor;
echo import lombok.Data;
echo import lombok.NoArgsConstructor;
echo import org.springframework.data.annotation.CreatedDate;
echo import org.springframework.data.annotation.LastModifiedDate;
echo import org.springframework.data.jpa.domain.support.AuditingEntityListener;
echo.
echo import java.time.LocalDateTime;
echo import java.util.HashSet;
echo import java.util.Set;
echo.
echo @Entity
echo @Table^(name = "users"^)
echo @Data
echo @NoArgsConstructor
echo @AllArgsConstructor
echo @EntityListeners^(AuditingEntityListener.class^)
echo public class User {
echo     
echo     @Id
echo     @GeneratedValue^(strategy = GenerationType.IDENTITY^)
echo     private Long id;
echo     
echo     @NotBlank
echo     @Size^(max = 50^)
echo     @Column^(unique = true^)
echo     private String username;
echo     
echo     @NotBlank
echo     @Size^(max = 100^)
echo     @Email
echo     @Column^(unique = true^)
echo     private String email;
echo     
echo     @NotBlank
echo     @Size^(max = 255^)
echo     private String password;
echo     
echo     @NotBlank
echo     @Size^(max = 100^)
echo     private String firstName;
echo     
echo     @NotBlank
echo     @Size^(max = 100^)
echo     private String lastName;
echo     
echo     @Column^(nullable = false^)
echo     private Boolean isActive = true;
echo     
echo     @Column^(nullable = false^)
echo     private Boolean emailVerified = false;
echo     
echo     private String phone;
echo     private String position;
echo     
echo     @ManyToMany^(fetch = FetchType.LAZY^)
echo     @JoinTable^(
echo         name = "user_roles",
echo         joinColumns = @JoinColumn^(name = "user_id"^),
echo         inverseJoinColumns = @JoinColumn^(name = "role_id"^)
echo     ^)
echo     private Set^<Role^> roles = new HashSet^<^>^(^);
echo     
echo     @CreatedDate
echo     @Column^(updatable = false^)
echo     private LocalDateTime createdAt;
echo     
echo     @LastModifiedDate
echo     private LocalDateTime updatedAt;
echo     
echo     private LocalDateTime lastLoginAt;
echo     
echo     public String getFullName^(^) {
echo         return firstName + " " + lastName;
echo     }
echo     
echo     public boolean hasRole^(String roleName^) {
echo         return roles.stream^(^)
echo                 .anyMatch^(role -^> role.getName^(^).equals^(roleName^)^);
echo     }
echo }
) > src\main\java\ro\ctp\grm\entity\User.java

REM Creez entitatea Role
(
echo package ro.ctp.grm.entity;
echo.
echo import jakarta.persistence.*;
echo import jakarta.validation.constraints.NotBlank;
echo import jakarta.validation.constraints.Size;
echo import lombok.AllArgsConstructor;
echo import lombok.Data;
echo import lombok.NoArgsConstructor;
echo.
echo import java.util.HashSet;
echo import java.util.Set;
echo.
echo @Entity
echo @Table^(name = "roles"^)
echo @Data
echo @NoArgsConstructor
echo @AllArgsConstructor
echo public class Role {
echo     
echo     @Id
echo     @GeneratedValue^(strategy = GenerationType.IDENTITY^)
echo     private Long id;
echo     
echo     @NotBlank
echo     @Size^(max = 50^)
echo     @Column^(unique = true^)
echo     private String name;
echo     
echo     @Size^(max = 255^)
echo     private String description;
echo     
echo     @ManyToMany^(fetch = FetchType.LAZY^)
echo     @JoinTable^(
echo         name = "role_permissions",
echo         joinColumns = @JoinColumn^(name = "role_id"^),
echo         inverseJoinColumns = @JoinColumn^(name = "permission_id"^)
echo     ^)
echo     private Set^<Permission^> permissions = new HashSet^<^>^(^);
echo     
echo     @Column^(nullable = false^)
echo     private Boolean isActive = true;
echo     
echo     public Role^(String name, String description^) {
echo         this.name = name;
echo         this.description = description;
echo     }
echo }
) > src\main\java\ro\ctp\grm\entity\Role.java

REM Creez entitatea Permission
(
echo package ro.ctp.grm.entity;
echo.
echo import jakarta.persistence.*;
echo import jakarta.validation.constraints.NotBlank;
echo import jakarta.validation.constraints.Size;
echo import lombok.AllArgsConstructor;
echo import lombok.Data;
echo import lombok.NoArgsConstructor;
echo.
echo @Entity
echo @Table^(name = "permissions"^)
echo @Data
echo @NoArgsConstructor
echo @AllArgsConstructor
echo public class Permission {
echo     
echo     @Id
echo     @GeneratedValue^(strategy = GenerationType.IDENTITY^)
echo     private Long id;
echo     
echo     @NotBlank
echo     @Size^(max = 100^)
echo     @Column^(unique = true^)
echo     private String name;
echo     
echo     @Size^(max = 255^)
echo     private String description;
echo     
echo     @NotBlank
echo     @Size^(max = 50^)
echo     private String resource;
echo     
echo     @NotBlank
echo     @Size^(max = 50^)
echo     private String action;
echo     
echo     public Permission^(String name, String description, String resource, String action^) {
echo         this.name = name;
echo         this.description = description;
echo         this.resource = resource;
echo         this.action = action;
echo     }
echo }
) > src\main\java\ro\ctp\grm\entity\Permission.java

echo ✓ Entități create!

REM Creez DTOs
echo 📋 Creez DTOs...

REM LoginRequest
(
echo package ro.ctp.grm.dto.request;
echo.
echo import jakarta.validation.constraints.NotBlank;
echo import lombok.Data;
echo.
echo @Data
echo public class LoginRequest {
echo     
echo     @NotBlank^(message = "Username is required"^)
echo     private String username;
echo     
echo     @NotBlank^(message = "Password is required"^)
echo     private String password;
echo     
echo     private Boolean rememberMe = false;
echo }
) > src\main\java\ro\ctp\grm\dto\request\LoginRequest.java

REM RegisterRequest
(
echo package ro.ctp.grm.dto.request;
echo.
echo import jakarta.validation.constraints.Email;
echo import jakarta.validation.constraints.NotBlank;
echo import jakarta.validation.constraints.Size;
echo import lombok.Data;
echo.
echo @Data
echo public class RegisterRequest {
echo     
echo     @NotBlank^(message = "Username is required"^)
echo     @Size^(min = 3, max = 50, message = "Username must be between 3 and 50 characters"^)
echo     private String username;
echo     
echo     @NotBlank^(message = "Email is required"^)
echo     @Email^(message = "Email should be valid"^)
echo     @Size^(max = 100, message = "Email must not exceed 100 characters"^)
echo     private String email;
echo     
echo     @NotBlank^(message = "Password is required"^)
echo     @Size^(min = 6, max = 100, message = "Password must be between 6 and 100 characters"^)
echo     private String password;
echo     
echo     @NotBlank^(message = "Confirm password is required"^)
echo     private String confirmPassword;
echo     
echo     @NotBlank^(message = "First name is required"^)
echo     @Size^(max = 100, message = "First name must not exceed 100 characters"^)
echo     private String firstName;
echo     
echo     @NotBlank^(message = "Last name is required"^)
echo     @Size^(max = 100, message = "Last name must not exceed 100 characters"^)
echo     private String lastName;
echo     
echo     private String phone;
echo     private String position;
echo }
) > src\main\java\ro\ctp\grm\dto\request\RegisterRequest.java

REM AuthResponse
(
echo package ro.ctp.grm.dto.response;
echo.
echo import lombok.AllArgsConstructor;
echo import lombok.Data;
echo import java.time.LocalDateTime;
echo.
echo @Data
echo @AllArgsConstructor
echo public class AuthResponse {
echo     
echo     private String token;
echo     private String type = "Bearer";
echo     private String refreshToken;
echo     private UserInfoResponse user;
echo     private LocalDateTime expiresAt;
echo     
echo     public AuthResponse^(String token, String refreshToken, UserInfoResponse user, LocalDateTime expiresAt^) {
echo         this.token = token;
echo         this.refreshToken = refreshToken;
echo         this.user = user;
echo         this.expiresAt = expiresAt;
echo     }
echo }
) > src\main\java\ro\ctp\grm\dto\response\AuthResponse.java

REM UserInfoResponse
(
echo package ro.ctp.grm.dto.response;
echo.
echo import lombok.Data;
echo import ro.ctp.grm.entity.User;
echo import java.time.LocalDateTime;
echo import java.util.Set;
echo import java.util.stream.Collectors;
echo.
echo @Data
echo public class UserInfoResponse {
echo     
echo     private Long id;
echo     private String username;
echo     private String email;
echo     private String firstName;
echo     private String lastName;
echo     private String fullName;
echo     private String phone;
echo     private String position;
echo     private Boolean isActive;
echo     private Boolean emailVerified;
echo     private Set^<String^> roles;
echo     private Set^<String^> permissions;
echo     private LocalDateTime createdAt;
echo     private LocalDateTime lastLoginAt;
echo     
echo     public static UserInfoResponse from^(User user^) {
echo         UserInfoResponse response = new UserInfoResponse^(^);
echo         response.setId^(user.getId^(^)^);
echo         response.setUsername^(user.getUsername^(^)^);
echo         response.setEmail^(user.getEmail^(^)^);
echo         response.setFirstName^(user.getFirstName^(^)^);
echo         response.setLastName^(user.getLastName^(^)^);
echo         response.setFullName^(user.getFullName^(^)^);
echo         response.setPhone^(user.getPhone^(^)^);
echo         response.setPosition^(user.getPosition^(^)^);
echo         response.setIsActive^(user.getIsActive^(^)^);
echo         response.setEmailVerified^(user.getEmailVerified^(^)^);
echo         response.setCreatedAt^(user.getCreatedAt^(^)^);
echo         response.setLastLoginAt^(user.getLastLoginAt^(^)^);
echo         
echo         response.setRoles^(user.getRoles^(^).stream^(^)
echo                 .map^(role -^> role.getName^(^)^)
echo                 .collect^(Collectors.toSet^(^)^)^);
echo         
echo         response.setPermissions^(user.getRoles^(^).stream^(^)
echo                 .flatMap^(role -^> role.getPermissions^(^).stream^(^)^)
echo                 .map^(permission -^> permission.getName^(^)^)
echo                 .collect^(Collectors.toSet^(^)^)^);
echo         
echo         return response;
echo     }
echo }
) > src\main\java\ro\ctp\grm\dto\response\UserInfoResponse.java

REM ApiResponse
(
echo package ro.ctp.grm.dto.response;
echo.
echo import lombok.AllArgsConstructor;
echo import lombok.Data;
echo.
echo @Data
echo @AllArgsConstructor
echo public class ApiResponse {
echo     
echo     private Boolean success;
echo     private String message;
echo     private Object data;
echo     
echo     public static ApiResponse success^(String message^) {
echo         return new ApiResponse^(true, message, null^);
echo     }
echo     
echo     public static ApiResponse success^(String message, Object data^) {
echo         return new ApiResponse^(true, message, data^);
echo     }
echo     
echo     public static ApiResponse error^(String message^) {
echo         return new ApiResponse^(false, message, null^);
echo     }
echo }
) > src\main\java\ro\ctp\grm\dto\response\ApiResponse.java

echo ✓ DTOs create!

REM Creez Repository-urile
echo 🗄️ Creez repository-urile...

(
echo package ro.ctp.grm.repository;
echo.
echo import org.springframework.data.jpa.repository.JpaRepository;
echo import org.springframework.stereotype.Repository;
echo import ro.ctp.grm.entity.User;
echo import java.util.Optional;
echo.
echo @Repository
echo public interface UserRepository extends JpaRepository^<User, Long^> {
echo     
echo     Optional^<User^> findByUsername^(String username^);
echo     Optional^<User^> findByEmail^(String email^);
echo     Boolean existsByUsername^(String username^);
echo     Boolean existsByEmail^(String email^);
echo }
) > src\main\java\ro\ctp\grm\repository\UserRepository.java

(
echo package ro.ctp.grm.repository;
echo.
echo import org.springframework.data.jpa.repository.JpaRepository;
echo import org.springframework.stereotype.Repository;
echo import ro.ctp.grm.entity.Role;
echo import java.util.Optional;
echo.
echo @Repository
echo public interface RoleRepository extends JpaRepository^<Role, Long^> {
echo     
echo     Optional^<Role^> findByName^(String name^);
echo     Boolean existsByName^(String name^);
echo }
) > src\main\java\ro\ctp\grm\repository\RoleRepository.java

(
echo package ro.ctp.grm.repository;
echo.
echo import org.springframework.data.jpa.repository.JpaRepository;
echo import org.springframework.stereotype.Repository;
echo import ro.ctp.grm.entity.Permission;
echo import java.util.Optional;
echo.
echo @Repository
echo public interface PermissionRepository extends JpaRepository^<Permission, Long^> {
echo     
echo     Optional^<Permission^> findByName^(String name^);
echo     Boolean existsByName^(String name^);
echo }
) > src\main\java\ro\ctp\grm\repository\PermissionRepository.java

echo ✓ Repository-uri create!

REM Creez migrarea Flyway
echo 🗃️ Creez migrarea pentru baza de date...

(
echo -- V2__create_auth_tables.sql
echo -- Create authentication tables for GRM 2.0
echo.
echo -- Create permissions table
echo CREATE TABLE permissions ^(
echo     id BIGSERIAL PRIMARY KEY,
echo     name VARCHAR^(100^) NOT NULL UNIQUE,
echo     description VARCHAR^(255^),
echo     resource VARCHAR^(50^) NOT NULL,
echo     action VARCHAR^(50^) NOT NULL
echo ^);
echo.
echo -- Create roles table
echo CREATE TABLE roles ^(
echo     id BIGSERIAL PRIMARY KEY,
echo     name VARCHAR^(50^) NOT NULL UNIQUE,
echo     description VARCHAR^(255^),
echo     is_active BOOLEAN NOT NULL DEFAULT true
echo ^);
echo.
echo -- Create users table
echo CREATE TABLE users ^(
echo     id BIGSERIAL PRIMARY KEY,
echo     username VARCHAR^(50^) NOT NULL UNIQUE,
echo     email VARCHAR^(100^) NOT NULL UNIQUE,
echo     password VARCHAR^(255^) NOT NULL,
echo     first_name VARCHAR^(100^) NOT NULL,
echo     last_name VARCHAR^(100^) NOT NULL,
echo     is_active BOOLEAN NOT NULL DEFAULT true,
echo     email_verified BOOLEAN NOT NULL DEFAULT false,
echo     phone VARCHAR^(20^),
echo     position VARCHAR^(100^),
echo     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
echo     updated_at TIMESTAMP,
echo     last_login_at TIMESTAMP
echo ^);
echo.
echo -- Create role_permissions junction table
echo CREATE TABLE role_permissions ^(
echo     role_id BIGINT NOT NULL REFERENCES roles^(id^) ON DELETE CASCADE,
echo     permission_id BIGINT NOT NULL REFERENCES permissions^(id^) ON DELETE CASCADE,
echo     PRIMARY KEY ^(role_id, permission_id^)
echo ^);
echo.
echo -- Create user_roles junction table
echo CREATE TABLE user_roles ^(
echo     user_id BIGINT NOT NULL REFERENCES users^(id^) ON DELETE CASCADE,
echo     role_id BIGINT NOT NULL REFERENCES roles^(id^) ON DELETE CASCADE,
echo     PRIMARY KEY ^(user_id, role_id^)
echo ^);
echo.
echo -- Insert default permissions
echo INSERT INTO permissions ^(name, description, resource, action^) VALUES
echo ^('USER_CREATE', 'Create users', 'USER', 'CREATE'^),
echo ^('USER_READ', 'View users', 'USER', 'READ'^),
echo ^('USER_UPDATE', 'Update users', 'USER', 'UPDATE'^),
echo ^('USER_DELETE', 'Delete users', 'USER', 'DELETE'^),
echo ^('ROLE_MANAGE', 'Manage roles', 'ROLE', 'ALL'^),
echo ^('PROJECT_CREATE', 'Create projects', 'PROJECT', 'CREATE'^),
echo ^('PROJECT_READ', 'View projects', 'PROJECT', 'READ'^),
echo ^('PROJECT_UPDATE', 'Update projects', 'PROJECT', 'UPDATE'^),
echo ^('PROJECT_DELETE', 'Delete projects', 'PROJECT', 'DELETE'^),
echo ^('DOCUMENT_CREATE', 'Create documents', 'DOCUMENT', 'CREATE'^),
echo ^('DOCUMENT_READ', 'View documents', 'DOCUMENT', 'READ'^),
echo ^('DOCUMENT_UPDATE', 'Update documents', 'DOCUMENT', 'UPDATE'^),
echo ^('DOCUMENT_DELETE', 'Delete documents', 'DOCUMENT', 'DELETE'^),
echo ^('REPORT_VIEW', 'View reports', 'REPORT', 'READ'^),
echo ^('SYSTEM_ADMIN', 'System administration', 'SYSTEM', 'ALL'^);
echo.
echo -- Insert default roles
echo INSERT INTO roles ^(name, description^) VALUES
echo ^('ADMIN', 'System Administrator'^),
echo ^('HR_MANAGER', 'Human Resources Manager'^),
echo ^('PROJECT_MANAGER', 'Project Manager'^),
echo ^('EMPLOYEE', 'Regular Employee'^);
echo.
echo -- Assign permissions to roles
echo -- ADMIN role gets all permissions
echo INSERT INTO role_permissions ^(role_id, permission_id^)
echo SELECT r.id, p.id FROM roles r, permissions p WHERE r.name = 'ADMIN';
echo.
echo -- HR_MANAGER role permissions
echo INSERT INTO role_permissions ^(role_id, permission_id^)
echo SELECT r.id, p.id FROM roles r, permissions p 
echo WHERE r.name = 'HR_MANAGER' AND p.name IN ^('USER_CREATE', 'USER_READ', 'USER_UPDATE', 'REPORT_VIEW'^);
echo.
echo -- PROJECT_MANAGER role permissions
echo INSERT INTO role_permissions ^(role_id, permission_id^)
echo SELECT r.id, p.id FROM roles r, permissions p 
echo WHERE r.name = 'PROJECT_MANAGER' AND p.name IN ^('PROJECT_CREATE', 'PROJECT_READ', 'PROJECT_UPDATE', 'PROJECT_DELETE', 'DOCUMENT_CREATE', 'DOCUMENT_READ', 'DOCUMENT_UPDATE', 'REPORT_VIEW'^);
echo.
echo -- EMPLOYEE role permissions
echo INSERT INTO role_permissions ^(role_id, permission_id^)
echo SELECT r.id, p.id FROM roles r, permissions p 
echo WHERE r.name = 'EMPLOYEE' AND p.name IN ^('PROJECT_READ', 'DOCUMENT_READ'^);
echo.
echo -- Insert admin user ^(password: Admin123!^)
echo INSERT INTO users ^(username, email, password, first_name, last_name, email_verified^) VALUES
echo ^('admin', 'admin@grm.ro', '$2a$10$rM8jBgI5vKjdVsKnZdKqJeC1qGZzG2QdQrHYvBcKVWL2FHg8qJwfO', 'Administrator', 'Sistem', true^);
echo.
echo -- Assign ADMIN role to admin user
echo INSERT INTO user_roles ^(user_id, role_id^)
echo SELECT u.id, r.id FROM users u, roles r WHERE u.username = 'admin' AND r.name = 'ADMIN';
echo.
echo -- Create indexes for performance
echo CREATE INDEX idx_users_username ON users^(username^);
echo CREATE INDEX idx_users_email ON users^(email^);
echo CREATE INDEX idx_users_active ON users^(is_active^);
echo CREATE INDEX idx_roles_name ON roles^(name^);
echo CREATE INDEX idx_permissions_name ON permissions^(name^);
echo CREATE INDEX idx_permissions_resource ON permissions^(resource^);
) > src\main\resources\db\migration\V2__create_auth_tables.sql

echo ✓ Migrare creată!

REM Actualizez application.yml
echo ⚙️ Actualizez configurația...

(
echo spring:
echo   application:
echo     name: grm-backend
echo   
echo   profiles:
echo     active: ${SPRING_PROFILES_ACTIVE:development}
echo   
echo   datasource:
echo     url: jdbc:postgresql://${DB_HOST:localhost}:${DB_PORT:5432}/${DB_NAME:grm_db}
echo     username: ${DB_USERNAME:grm_user}
echo     password: ${DB_PASSWORD:grm_password}
echo     driver-class-name: org.postgresql.Driver
echo   
echo   jpa:
echo     hibernate:
echo       ddl-auto: validate
echo     show-sql: false
echo     properties:
echo       hibernate:
echo         dialect: org.hibernate.dialect.PostgreSQLDialect
echo         format_sql: true
echo   
echo   flyway:
echo     enabled: true
echo     locations: classpath:db/migration
echo     baseline-on-migrate: true
echo.
echo # JWT Configuration
echo jwt:
echo   secret: ${JWT_SECRET:grm-super-secure-jwt-secret-production-2025-change-this-in-production}
echo   expiration: ${JWT_EXPIRATION:86400}
echo.
echo # Management endpoints
echo management:
echo   endpoints:
echo     web:
echo       exposure:
echo         include: health,info,metrics
echo   endpoint:
echo     health:
echo       show-details: always
echo.
echo # Logging
echo logging:
echo   level:
echo     root: INFO
echo     ro.ctp.grm: DEBUG
echo   file:
echo     name: logs/grm.log
) > src\main\resources\application.yml

echo ✓ Configurație actualizată!

echo.
echo ========================================
echo     ✅ AUTENTIFICARE IMPLEMENTATĂ!
echo ========================================
echo.
echo 📋 Ce a fost creat:
echo    - Entități: User, Role, Permission
echo    - DTOs: Login/Register requests și responses
echo    - Repository-uri pentru toate entitățile
echo    - Migrare Flyway cu date inițiale
echo    - Configurație JWT actualizată
echo.
echo 🚀 URMĂTORII PAȘI:
echo.
echo 1. Adaugă dependențele în pom.xml
echo 2. Creează serviciile și controller-ele
echo 3. Implementează security configuration
echo 4. Testează cu Postman
echo.
echo ========================================
echo        🎉 GATA PENTRU URMĂTOAREA FAZĂ!
echo ========================================

pause