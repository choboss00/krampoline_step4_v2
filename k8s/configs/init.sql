CREATE SCHEMA IF NOT EXISTS `krampoline` DEFAULT CHARACTER SET utf8mb4;

GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION;
GRANT ALL ON krampoline.* TO 'root'@'localhost';
FLUSH PRIVILEGES;

USE `krampoline`;

DROP TABLE IF EXISTS `interests`;
CREATE TABLE interests (
   id int auto_increment,
   created_at timestamp not null,
   deleted_at timestamp,
   is_deleted boolean default false not null,
   updated_at timestamp,
   category varchar(255),
   primary key (id)
);

INSERT INTO `interests` (created_at, category) VALUES
  (NOW(), 'IDOL'),
  (NOW(), 'Game'),
  (NOW(), 'K-POP'),
  (NOW(), 'Sports'),
  (NOW(), 'Movie'),
  (NOW(), 'Drama');
