-- Language: SQL



CREATE TABLE payment (
  payment_id SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id SMALLINT(5) UNSIGNED NOT NULL,
  rental_id INT(11) DEFAULT NULL,
  amount DECIMAL(5,2) NOT NULL,
  payment_date DATETIME NOT NULL,
  cost_per_film VARCHAR(10) NOT NULL DEFAULT ('0.4');
  PRIMARY KEY  (payment_id),
  CONSTRAINT fk_payment_rental FOREIGN KEY (rental_id) REFERENCES rental (rental_id) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_payment_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE
 );




CREATE TABLE employee(
employee_id SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
first_name VARCHAR(45) NOT NULL,
last_name VARCHAR(45) NOT NULL,
email VARCHAR(50) DEFAULT NULL,
address_id SMALLINT(5) UNSIGNED NOT NULL,
PRIMARY KEY (employee_id),
CONSTRAINT fk_employee_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE administrator(
admin_id SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
first_name VARCHAR(45) NOT NULL,
last_name VARCHAR(45) NOT NULL,
email VARCHAR(50) DEFAULT NULL,
PRIMARY KEY (admin_id)
);


CREATE TABLE series(
  series_id SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(128) NOT NULL,
  description TEXT DEFAULT NULL,
  release_year YEAR(4) DEFAULT NULL,
  language_id TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  original_language_id TINYINT(3) UNSIGNED DEFAULT NULL,
  rating ENUM('G','PG','PG-13','R','NC-17') DEFAULT 'PG-13',
  special_features SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes', 'All Included') DEFAULT 'All Included',
  PRIMARY KEY  (series_id),
  CONSTRAINT fk_series_language FOREIGN KEY (language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_series_language_original FOREIGN KEY (original_language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE seasons(
seasons_id SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
series_id SMALLINT(5) UNSIGNED NOT NULL,
number_of_seasons SMALLINT(5) UNSIGNED NOT NULL,
PRIMARY KEY(seasons_id),
CONSTRAINT fk_series_id FOREIGN KEY (series_id) REFERENCES series (series_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE episodes(
episodes_id SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
series_id SMALLINT(5) UNSIGNED NOT NULL,
number_of_episodes SMALLINT(5) UNSIGNED NOT NULL,
length SMALLINT(5) UNSIGNED DEFAULT NULL,
PRIMARY KEY(episodes_id),
CONSTRAINT fk_serepisodes_id FOREIGN KEY (series_id) REFERENCES series (series_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE series_category(
series_id SMALLINT(5) UNSIGNED NOT NULL,
category_id TINYINT(3) UNSIGNED NOT NULL,
PRIMARY KEY (series_id, category_id),
CONSTRAINT fk_series_category_film FOREIGN KEY (series_id) REFERENCES series (series_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_series_category_category FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE series_actor(
 actor_id SMALLINT(5) UNSIGNED NOT NULL,
 series_id SMALLINT(5) UNSIGNED NOT NULL,
 PRIMARY KEY  (actor_id,series_id),
 CONSTRAINT fk_series_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_series_actor_series FOREIGN KEY (series_id) REFERENCES series (series_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE series_inventory (
series_inventory_id MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
series_id SMALLINT(5) UNSIGNED NOT NULL,
PRIMARY KEY  (series_inventory_id),
CONSTRAINT fk_inventory_series FOREIGN KEY (series_id) REFERENCES series (series_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE series_rental (
  series_rental_id INT(11) NOT NULL AUTO_INCREMENT,
  rental_date DATETIME NOT NULL,
  series_inventory_id MEDIUMINT(8) UNSIGNED NOT NULL,
  customer_id SMALLINT(5) UNSIGNED NOT NULL,
  PRIMARY KEY (series_rental_id),
  UNIQUE KEY  (rental_date,series_inventory_id,customer_id),
  CONSTRAINT fk_series_rental_inventory FOREIGN KEY (series_inventory_id) REFERENCES series_inventory (series_inventory_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_series_rental_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE
);



CREATE TABLE series_payment (
  series_payment_id SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id SMALLINT(5) UNSIGNED NOT NULL,
  series_rental_id INT(11) DEFAULT NULL,
  series_amount DECIMAL(5,2) NOT NULL,
  series_payment_date DATETIME NOT NULL,
  cost_per_series VARCHAR(10) NOT NULL DEFAULT '0.2',
  PRIMARY KEY  (series_payment_id),
  CONSTRAINT fk_series_payment_rental FOREIGN KEY (series_rental_id) REFERENCES series_rental (series_rental_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_series_payment_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE
 );

