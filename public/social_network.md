# Social Network Data Architecture

## Overview

This document outlines the data architecture for a social networking application where users can create posts and follow other users.

### Entities

1. **User**:
   - Represents a registered user of the platform.
   - Attributes:
     - `user_id` (Primary key)
     - `username`
     - `email`
     - `password_hash`
     - Other profile information (e.g., full name, bio, avatar)

2. **Post**:
   - Represents a post made by a user.
   - Attributes:
     - `post_id` (Primary key)
     - `user_id` (Foreign key referencing `User`)
     - `content`
     - `timestamp`

3. **Follow**:
   - Represents a follow relationship between users.
   - Attributes:
     - `follow_id` (Primary key)
     - `follower_id` (Foreign key referencing `User` who is following)
     - `followed_id` (Foreign key referencing `User` who is being followed)
     - `timestamp` (When the follow relationship was established)

## Database Schema

The following schema defines the structure of the database using SQL syntax:

```sql
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    -- other fields (full name, bio, avatar)
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE follows (
    follow_id INT AUTO_INCREMENT PRIMARY KEY,
    follower_id INT,
    followed_id INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (follower_id) REFERENCES users(user_id),
    FOREIGN KEY (followed_id) REFERENCES users(user_id),
    UNIQUE(follower_id, followed_id)  -- Ensure a user can only follow another once
);

# Relationships in Database

## User-Post Relationship

### Description
- Each User can have many Posts.
- Posts are linked to users via the `user_id` foreign key in the `posts` table.

### Database Schema

- **Table Name:** `users`
  - **Columns:** `id` (primary key), `username`, `email`, ...

- **Table Name:** `posts`
  - **Columns:** `id` (primary key), `user_id` (foreign key referencing `users.id`), `content`, `created_at`, ...

### Example

- User with `id = 1` (John Doe) has multiple posts in the `posts` table where `user_id = 1`.

## User-Follow Relationship

### Description
- A User can follow many other Users.
- Follow relationships are stored in the `follows` table, linking `follower_id` to `followed_id`.

### Database Schema

- **Table Name:** `follows`
  - **Columns:** `id` (primary key), `follower_id` (foreign key referencing `users.id`), `followed_id` (foreign key referencing `users.id`), `created_at`, ...

### Example

- User with `id = 1` (John Doe) follows users with `id = 2` (Jane Smith) and `id = 3` (Mike Johnson) as recorded in the `follows` table.
