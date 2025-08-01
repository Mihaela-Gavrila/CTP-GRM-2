-- V2__create_users_table.sql
-- Create users table for authentication

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_active ON users(is_active);

-- Insert demo user (password: Admin123!)
INSERT INTO users (username, email, password, first_name, last_name) VALUES
('admin', 'admin@grm.ro', '$2a$10$rM8jBgI5vKjdVsKnZdKqJeC1qGZzG2QdQrHYvBcKVWL2FHg8qJwfO', 'Administrator', 'Sistem');

INSERT INTO users (username, email, password, first_name, last_name) VALUES
('demo', 'demo@grm.ro', '$2a$10$rM8jBgI5vKjdVsKnZdKqJeC1qGZzG2QdQrHYvBcKVWL2FHg8qJwfO', 'Demo', 'User');
