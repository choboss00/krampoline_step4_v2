CREATE SCHEMA IF NOT EXISTS `krampoline` DEFAULT CHARACTER SET utf8mb4;

GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION;
GRANT ALL ON krampoline.* TO 'root'@'localhost';
FLUSH PRIVILEGES;

USE `krampoline`;

SET foreign_key_checks = 0;    # 외래키 체크 설정 해제
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS interests;
DROP TABLE IF EXISTS mentor_posts;
DROP TABLE IF EXISTS connected_users;
DROP TABLE IF EXISTS not_connected_register_users;
DROP TABLE IF EXISTS user_interests;
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS subtitles;
DROP TABLE IF EXISTS video_interests;
DROP TABLE IF EXISTS refresh_tokens;
DROP TABLE IF EXISTS video_histories;
SET foreign_key_checks = 1;    # 외래키 체크 설정

CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        deleted_at TIMESTAMP NULL DEFAULT NULL,
                        is_deleted BOOLEAN DEFAULT FALSE NOT NULL,
                        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                       birth_date DATE NOT NULL,
                       country VARCHAR(255) NOT NULL,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       first_name VARCHAR(255) NOT NULL,
                       introduction VARCHAR(255),
                       last_name VARCHAR(255) NOT NULL,
                       PASSWORD VARCHAR(256) NOT NULL,
                       phone VARCHAR(255) NOT NULL,
                       profile_image VARCHAR(255) DEFAULT NULL,
                       role VARCHAR(255) NOT NULL
);

CREATE TABLE interests (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        deleted_at TIMESTAMP NULL DEFAULT NULL,
                        is_deleted BOOLEAN DEFAULT FALSE NOT NULL,
                        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                           category VARCHAR(255)
);

CREATE TABLE videos (
    id INT AUTO_INCREMENT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    video_end_time VARCHAR(255),
    video_start_time VARCHAR(255),
    video_thumbnail_url VARCHAR(255),
    video_title_eng VARCHAR(255),
    video_title_korean VARCHAR(255),
    video_url VARCHAR(255),
    views BIGINT NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

CREATE TABLE mentor_posts (
                              id INT AUTO_INCREMENT PRIMARY KEY,
                              created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        deleted_at TIMESTAMP NULL DEFAULT NULL,
                        is_deleted BOOLEAN DEFAULT FALSE NOT NULL,
                        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                              content VARCHAR(300),
                              state VARCHAR(255) NOT NULL,
                              title VARCHAR(255) NOT NULL,
                              writer_id INT,
                              FOREIGN KEY (writer_id) REFERENCES users(id)
);

CREATE TABLE connected_users (
                                 id INT AUTO_INCREMENT PRIMARY KEY,
                                 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        deleted_at TIMESTAMP NULL DEFAULT NULL,
                        is_deleted BOOLEAN DEFAULT FALSE NOT NULL,
                        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                                 mentee_user_id INT,
                                 mentor_post_id INT,
                                 FOREIGN KEY (mentee_user_id) REFERENCES users(id),
                                 FOREIGN KEY (mentor_post_id) REFERENCES mentor_posts(id)
);

CREATE TABLE not_connected_register_users (
                                              id INT AUTO_INCREMENT PRIMARY KEY,
                                              created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        deleted_at TIMESTAMP NULL DEFAULT NULL,
                        is_deleted BOOLEAN DEFAULT FALSE NOT NULL,
                        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                                              state VARCHAR(255) NOT NULL,
                                              mentee_user_id INT,
                                              mentor_post_id INT,
                                              FOREIGN KEY (mentee_user_id) REFERENCES users(id),
                                              FOREIGN KEY (mentor_post_id) REFERENCES mentor_posts(id)
);

CREATE TABLE user_interests (
                                id INT AUTO_INCREMENT PRIMARY KEY,
                                created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        deleted_at TIMESTAMP NULL DEFAULT NULL,
                        is_deleted BOOLEAN DEFAULT FALSE NOT NULL,
                        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                                interest_id INT,
                                user_id INT,
                                FOREIGN KEY (interest_id) REFERENCES interests(id),
                                FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE video_interests (
                                 id INT AUTO_INCREMENT PRIMARY KEY,
                                 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        deleted_at TIMESTAMP NULL DEFAULT NULL,
                        is_deleted BOOLEAN DEFAULT FALSE NOT NULL,
                        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                                 interest_id INT,
                                 video_id INT,
                                 FOREIGN KEY (interest_id) REFERENCES interests(id),
                                 FOREIGN KEY (video_id) REFERENCES videos(id)
);

CREATE TABLE subtitles (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        deleted_at TIMESTAMP NULL DEFAULT NULL,
                        is_deleted BOOLEAN DEFAULT FALSE NOT NULL,
                        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                           eng_end_time VARCHAR(255),
                           eng_start_time VARCHAR(255),
                           eng_subtitle_content VARCHAR(255),
                           kor_end_time VARCHAR(255),
                           kor_start_time VARCHAR(255),
                           kor_subtitle_content VARCHAR(255),
                           video_id INT,
                           FOREIGN KEY (video_id) REFERENCES videos(id)
);

CREATE TABLE refresh_tokens (
    id INT NOT NULL AUTO_INCREMENT,
    refresh_token VARCHAR(500),
    user_id INT,
    PRIMARY KEY (id)
);

CREATE TABLE video_histories (
    id INT NOT NULL AUTO_INCREMENT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        deleted_at TIMESTAMP NULL DEFAULT NULL,
                        is_deleted BOOLEAN DEFAULT FALSE NOT NULL,
                        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    user_id INT,
    video_id INT,
    PRIMARY KEY (id)
);


INSERT INTO `interests` (created_at, category) VALUES
                                                   (NOW(), 'IDOL'),
                                                   (NOW(), 'Game'),
                                                   (NOW(), 'K-POP'),
                                                   (NOW(), 'Sports'),
                                                   (NOW(), 'Movie'),
                                                   (NOW(), 'Drama');

-- user Table
INSERT INTO users (created_at, first_name, last_name, email, password, country, introduction, birth_date, profile_image, role, phone) VALUES
 (NOW(), 'John', 'Doe', 'test1@example.com', '{bcrypt}$2a$10$8H0OT8wgtALJkig6fmypi.Y7jzI5Y7W9PGgRKqnVeS2cLWGifwHF2', 'USA', 'Hello, I am John.', '1998-01-01', 'profile.jpg', 'MENTOR', '010-0000-0000'),
 (NOW(), 'Alice', 'Smith', 'test2@example.com', '{bcrypt}$2a$10$8H0OT8wgtALJkig6fmypi.Y7jzI5Y7W9PGgRKqnVeS2cLWGifwHF2', 'Canada', 'I love painting.', '1998-01-01', 'image2.jpg', 'MENTOR', '010-0000-0000'),
 (NOW(), 'Admin', 'Admin', 'test3@example.com', '{bcrypt}$2a$10$8H0OT8wgtALJkig6fmypi.Y7jzI5Y7W9PGgRKqnVeS2cLWGifwHF2', 'USA', 'I am an admin user.', '1988-01-01', 'admin.jpg', 'MENTEE', '010-0000-0000'),
 (NOW(), 'Jane', 'Smith', 'test4@example.com', '{bcrypt}$2a$10$8H0OT8wgtALJkig6fmypi.Y7jzI5Y7W9PGgRKqnVeS2cLWGifwHF2', 'Canada', 'I love coding.', '1993-01-01', 'profile.jpg', 'MENTEE', '010-0000-0000'),
 (NOW(), 'Adccczczmin', 'qwdasd', 'test5@example.com', '{bcrypt}$2a$10$8H0OT8wgtALJkig6fmypi.Y7jzI5Y7W9PGgRKqnVeS2cLWGifwHF2', 'USA', 'I am the qwdad.', '1988-01-01', 'admin.jpg', 'MENTEE', '010-0000-0000'),
 (NOW(), 'adadad', 'adaddddd', 'test6@example.com', '{bcrypt}$2a$10$8H0OT8wgtALJkig6fmypi.Y7jzI5Y7W9PGgRKqnVeS2cLWGifwHF2', 'USA', 'I am the adadad.', '1988-01-01', 'admin.jpg', 'MENTEE', '010-0000-0000'),
(NOW(), 'admin', 'admin', 'admin@example.com', '{bcrypt}$2a$10$8H0OT8wgtALJkig6fmypi.Y7jzI5Y7W9PGgRKqnVeS2cLWGifwHF2', 'USA', 'I am the admin.', '1988-01-01', 'admin.jpg', 'ADMIN', '010-0000-0000');

-- mentorPost Table
INSERT INTO mentor_posts (created_at, writer_id, title, content, state) VALUES
      (NOW(), 1, 'Teaching Programming', 'I can teach you how to code.', 'ACTIVE'),
      (NOW(), 1, 'Art Workshop', 'Let''s create beautiful art together.', 'DONE'),
      (NOW(), 2, 'Software Development Mentorship', 'I can mentor you in software development.', 'ACTIVE'),
      (NOW(), 2, 'Art and Painting Mentorship', 'Learn the art of painting with me.', 'ACTIVE'),
      (NOW(), 1, 'Web Development Mentorship', 'I can teach you web development from scratch.', 'ACTIVE'),
      (NOW(), 2, 'Fitness and Health Mentorship', 'Get in shape and stay healthy with my guidance.', 'ACTIVE'),
      (NOW(), 1, 'Data Science Mentorship', 'Learn data science and machine learning with me.', 'ACTIVE'),
      (NOW(), 2, 'Music Production Mentorship', 'Produce your own music with professional tips.', 'ACTIVE'),
      (NOW(), 2, 'Cooking and Culinary Arts Mentorship', 'Master the art of cooking and culinary skills.', 'ACTIVE'),
      (NOW(), 2, 'Entrepreneurship Mentorship', 'Start and grow your own business.', 'ACTIVE'),
      (NOW(), 1, 'Graphic Design Mentorship', 'Create stunning graphics and designs.', 'ACTIVE'),
      (NOW(), 1, 'Yoga and Mindfulness Mentorship', 'Find inner peace and balance through yoga.', 'ACTIVE'),
      (NOW(), 1, 'Photography Mentorship', 'Capture amazing moments with your camera.', 'ACTIVE'),
      (NOW(), 2, 'Mathematics Tutoring', 'I can help you understand and excel in math.', 'ACTIVE');


-- notConnectedRegisterUser Table
INSERT INTO not_connected_register_users (created_at, mentor_post_id, mentee_user_id, state) VALUES
      (NOW(), 1, 3, 'AWAIT'),
      (NOW(), 3, 3, 'AWAIT'),
      (NOW(), 1, 4, 'ACCEPT'),
      (NOW(), 3, 5, 'AWAIT');

-- connectedUser Table
INSERT INTO connected_users (created_at, mentor_post_id, mentee_user_id) VALUES
    (NOW(), 2, 3),
    (NOW(), 3, 3),
    (NOW(), 2, 5),
    (NOW(), 2, 6);

-- userInterest Table
INSERT INTO user_interests (created_at, user_id, interest_id) VALUES
   (NOW(), 1, 1),
   (NOW(), 1, 2),
   (NOW(), 2, 1),
   (NOW(), 2, 3),
   (NOW(), 3, 3),
   (NOW(), 3, 4),
   (NOW(), 4, 1),
   (NOW(), 4, 3),
   (NOW(), 5, 3),
   (NOW(), 5, 4),
   (NOW(), 5, 3),
   (NOW(), 5, 4),
   (NOW(), 6, 3),
   (NOW(), 6, 4);