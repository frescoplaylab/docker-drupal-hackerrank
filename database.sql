CREATE DATABASE drupal;
CREATE USER drupal@localhost IDENTIFIED BY 'drupal';
GRANT ALL ON drupal.* TO drupal@localhost;
FLUSH PRIVILEGES;
