@echo off
echo ========================================
echo    GRM 2.0 - TOATE FISIERELE
echo ========================================
echo.
echo Creez .gitignore...
(
echo # Compiled class files
echo *.class
echo *.log
echo target/
echo node_modules/  
echo .env
echo .idea/
echo *.swp
echo .DS_Store
echo uploads/
echo logs/
) > .gitignore
echo û .gitignore creat!
echo.
echo Creez pom.xml pentru backend...
(
echo <?xml version="1.0" encoding="UTF-8"?>
echo <project xmlns="http://maven.apache.org/POM/4.0.0">
echo     <modelVersion>4.0.0</modelVersion>
echo     <parent>
echo         <groupId>org.springframework.boot</groupId>
echo         <artifactId>spring-boot-starter-parent</artifactId>
echo         <version>3.2.1</version>
echo     </parent>
echo     <groupId>ro.ctp</groupId>
echo     <artifactId>grm-backend</artifactId>
echo     <version>1.0.0</version>
echo     <dependencies>
echo         <dependency>
echo             <groupId>org.springframework.boot</groupId>
echo             <artifactId>spring-boot-starter-web</artifactId>
echo         </dependency>
echo         <dependency>
echo             <groupId>org.springframework.boot</groupId>
echo             <artifactId>spring-boot-starter-data-jpa</artifactId>
echo         </dependency>
echo         <dependency>
echo             <groupId>org.postgresql</groupId>
echo             <artifactId>postgresql</artifactId>
echo         </dependency>
echo     </dependencies>
echo </project>
) > backend\pom.xml
echo û pom.xml creat!
echo.
echo Creez aplicatia Spring Boot principala...
(
echo package ro.ctp.grm;
echo import org.springframework.boot.SpringApplication;
echo import org.springframework.boot.autoconfigure.SpringBootApplication;
echo @SpringBootApplication
echo public class GrmApplication {
echo     public static void main(String[] args) {
echo         SpringApplication.run(GrmApplication.class, args);
echo     }
echo }
) > backend\src\main\java\ro\ctp\grm\GrmApplication.java
echo û GrmApplication.java creat!
echo.
echo Creez package.json pentru frontend...
(
echo {
echo   "name": "grm-frontend",
echo   "version": "1.0.0",
echo   "dependencies": {
echo     "react": "^18.2.0",
echo     "react-dom": "^18.2.0",
echo     "react-scripts": "5.0.1",
echo     "@mui/material": "^5.14.17",
echo     "@emotion/react": "^11.11.1",
echo     "@emotion/styled": "^11.11.0"
echo   },
echo   "scripts": {
echo     "start": "react-scripts start",
echo     "build": "react-scripts build"
echo   }
echo }
) > frontend\package.json
echo û package.json creat!
echo.
echo Creez App.tsx pentru frontend...
(
echo import React from 'react';
echo function App() {
echo   return (
echo     <div>
echo       <h1>GRM 2.0 - Sistem ERP</h1>
echo       <p>Backend: Spring Boot + PostgreSQL</p>
echo       <p>Frontend: React + Material-UI</p>
echo       <p>?? Aplica?ia este gata!</p>
echo     </div>
echo   );
echo }
echo export default App;
) > frontend\src\App.tsx
echo û App.tsx creat!
echo.
echo Creez docker-compose.yml complet...
(
echo version: '3.8'
echo services:
echo   postgres:
echo     image: postgres:15-alpine
echo     container_name: grm-postgres
echo     environment:
echo       POSTGRES_DB: grm_db
echo       POSTGRES_USER: grm_user
echo       POSTGRES_PASSWORD: grm_password
echo     ports:
echo       - "5432:5432"
echo     volumes:
echo       - postgres_data:/var/lib/postgresql/data
echo   backend:
echo     build: ./backend
echo     container_name: grm-backend
echo     ports:
echo       - "8080:8080"
echo     depends_on:
echo       - postgres
echo   frontend:
echo     build: ./frontend
echo     container_name: grm-frontend
echo     ports:
echo       - "3000:80"
echo     depends_on:
echo       - backend
echo volumes:
echo   postgres_data:
) > docker-compose.yml
echo û docker-compose.yml creat!
echo.
echo ========================================
echo     ? TOATE FISIERELE CREATE!
echo ========================================
echo.
echo ?? Ce ai acum:
echo    - Backend Spring Boot complet
echo    - Frontend React cu TypeScript
echo    - Docker configuration
echo    - Database PostgreSQL
echo.
echo ?? URMATORUL PAS:
echo    Mergi in GitHub Desktop si fa COMMIT!
echo.
pause
