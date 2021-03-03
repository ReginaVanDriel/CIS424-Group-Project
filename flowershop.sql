/********************************************************
* This script creates the database named flower_shop
*********************************************************/

DROP DATABASE IF EXISTS flower_shop;
CREATE DATABASE flower_shop;
USE flower_shop;

-- create the tables for the database
CREATE TABLE categories (
  category_id        INT            PRIMARY KEY   AUTO_INCREMENT,
  category_name      VARCHAR(255)   NOT NULL      UNIQUE
);

CREATE TABLE products (
  product_id         INT            PRIMARY KEY   AUTO_INCREMENT,
  category_id        INT            NOT NULL,
  product_code       VARCHAR(10)    NOT NULL      UNIQUE,
  product_name       VARCHAR(255)   NOT NULL,
  description        TEXT           NOT NULL,
  list_price         DECIMAL(10,2)  NOT NULL,
  discount_percent   DECIMAL(10,2)  NOT NULL      DEFAULT 0.00,
  date_added         DATETIME                     DEFAULT NULL,
  CONSTRAINT products_fk_categories
    FOREIGN KEY (category_id)
    REFERENCES categories (category_id)
);

CREATE TABLE customers (
  customer_id           INT            PRIMARY KEY   AUTO_INCREMENT,
  email_address         VARCHAR(255)   NOT NULL      UNIQUE,
  password              VARCHAR(60)    NOT NULL,
  first_name            VARCHAR(60)    NOT NULL,
  last_name             VARCHAR(60)    NOT NULL,
  shipping_address_id   INT                          DEFAULT NULL,
  billing_address_id    INT                          DEFAULT NULL,
  rewards_points        INT
);

CREATE TABLE addresses (
  address_id         INT            PRIMARY KEY   AUTO_INCREMENT,
  customer_id        INT            NOT NULL,
  line1              VARCHAR(60)    NOT NULL,
  line2              VARCHAR(60)                  DEFAULT NULL,
  city               VARCHAR(40)    NOT NULL,
  state              VARCHAR(2)     NOT NULL,
  zip_code           VARCHAR(10)    NOT NULL,
  phone              VARCHAR(12)    NOT NULL,
  disabled           TINYINT(1)     NOT NULL      DEFAULT 0,
  CONSTRAINT addresses_fk_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id)
);

CREATE TABLE orders (
  order_id           INT            PRIMARY KEY  AUTO_INCREMENT,
  customer_id        INT            NOT NULL,
  order_date         DATETIME       NOT NULL,
  ship_amount        DECIMAL(10,2)  NOT NULL,
  tax_amount         DECIMAL(10,2)  NOT NULL,
  ship_date          DATETIME                    DEFAULT NULL,
  ship_address_id    INT            NOT NULL,
  card_type          VARCHAR(50)    NOT NULL,
  card_number        CHAR(16)       NOT NULL,
  card_expires       CHAR(7)        NOT NULL,
  billing_address_id  INT           NOT NULL,
  CONSTRAINT orders_fk_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id)
);

CREATE TABLE order_items (
  item_id            INT            PRIMARY KEY  AUTO_INCREMENT,
  order_id           INT            NOT NULL,
  product_id         INT            NOT NULL,
  item_price         DECIMAL(10,2)  NOT NULL,
  discount_amount    DECIMAL(10,2)  NOT NULL,
  quantity           INT            NOT NULL,
  CONSTRAINT items_fk_orders
    FOREIGN KEY (order_id)
    REFERENCES orders (order_id), 
  CONSTRAINT items_fk_products
    FOREIGN KEY (product_id)
    REFERENCES products (product_id)
);

CREATE TABLE administrators (
  admin_id           INT            PRIMARY KEY   AUTO_INCREMENT,
  email_address      VARCHAR(255)   NOT NULL,
  password           VARCHAR(255)   NOT NULL,
  first_name         VARCHAR(255)   NOT NULL,
  last_name          VARCHAR(255)   NOT NULL
);

CREATE TABLE inventory (
  inventory_id       INT            PRIMARY KEY   AUTO_INCREMENT,
  product_id         INT            NOT NULL,
  count              INT            NOT NULL,
  CONSTRAINT inventory_fk_products
    FOREIGN KEY (product_id)
    REFERENCES products (product_id)
);

-- Insert data into the tables
INSERT INTO categories (category_id, category_name) VALUES
(1, 'Fertilizers'),
(2, 'Flowers'),
(3, 'Pots');

INSERT INTO products (product_id, category_id, product_code, product_name, description, list_price, discount_percent, date_added) VALUES
(1, 1, 'micgro', 'Miracle-Gro Water Soluble Bloom Booster Flower Food', 'Promotes more blooms for greater color versus unfed plants', '6.99', '36.00', CURDATE()),
(2, 1, 'bayerAIO', 'Bayer Advanced 701110A All in One Rose and Flower Care Granules', '3 systemic products in one: insect control, disease control and fertilizer', '16.99', '0.00', CURDATE()),
(3, 1, 'jobeorg', 'Jobes Organics 09627 Organic Fertilizer', 'Fertilizer Analysis: 3-5-4. Guaranteed results. No synthetic chemicals.', '8.49', '19.00', CURDATE()),
(4, 1, 'fxfarm', 'Fox Farm FX14049 Liquid Nutrient Trio Soil Formula: Big Bloom, Grow Big, Tiger Bloom (Pack of 3 - 32 oz. bottles)', 'A three-pack of favorite liquid fertilizers from FoxFarm', '49.90', '0.00', CURDATE()),
(5, 2, 'lilies', 'Lilies', 'Lilies are one of the most popular and versatile flowers in the world.', '10.99', '0.00', CURDATE()),
(6, 2, 'roses', 'Roses', 'A decorative touch to one’s home', '12.99', '10.00', CURDATE()),
(7, 3, 'smpot', 'Small Pot',  'A small pot for growing 1-2 flowers', '3.99', '0.00', CURDATE()),
(8, 3, 'mdpot', 'Medium Pot', 'A medium pot for growing larger flowers', '7.99', '5.00', CURDATE()),
(9, 3, 'lgpot', 'Large Pot',  'A large pot for growing small bushes', '13.99', '10.00', CURDATE());

INSERT INTO customers (customer_id, email_address, password, first_name, last_name, shipping_address_id, billing_address_id) VALUES
(1, 'allan.sherwood@yahoo.com', '650215acec746f0e32bdfff387439eefc1358737', 'Allan', 'Sherwood', 1, 2),
(2, 'barryz@gmail.com', '3f563468d42a448cb1e56924529f6e7bbe529cc7', 'Barry', 'Zimmer', 3, 3),
(3, 'christineb@solarone.com', 'ed19f5c0833094026a2f1e9e6f08a35d26037066', 'Christine', 'Brown', 4, 4),
(4, 'david.goldstein@hotmail.com', 'b444ac06613fc8d63795be9ad0beaf55011936ac', 'David', 'Goldstein', 5, 6),
(5, 'erinv@gmail.com', '109f4b3c50d7b0df729d299bc6f8e9ef9066971f', 'Erin', 'Valentino', 7, 7),
(6, 'frankwilson@sbcglobal.net', '3ebfa301dc59196f18593c45e519287a23297589', 'Frank Lee', 'Wilson', 8, 8),
(7, 'gary_hernandez@yahoo.com', '1ff2b3704aede04eecb51e50ca698efd50a1379b', 'Gary', 'Hernandez', 9, 10),
(8, 'heatheresway@mac.com', '911ddc3b8f9a13b5499b6bc4638a2b4f3f68bf23', 'Heather', 'Esway', 11, 12);

INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(1, 1, '100 East Ridgewood Ave.', '', 'Paramus', 'NJ', '07652', '201-653-4472', 0),
(2, 1, '21 Rosewood Rd.', '', 'Woodcliff Lake', 'NJ', '07677', '201-653-4472', 0),
(3, 2, '16285 Wendell St.', '', 'Omaha', 'NE', '68135', '402-896-2576', 0),
(4, 3, '19270 NW Cornell Rd.', '', 'Beaverton', 'OR', '97006', '503-654-1291', 0),
(5, 4, '186 Vermont St.', 'Apt. 2', 'San Francisco', 'CA', '94110', '415-292-6651', 0),
(6, 4, '1374 46th Ave.', '', 'San Francisco', 'CA', '94129', '415-292-6651', 0),
(7, 5, '6982 Palm Ave.', '', 'Fresno', 'CA', '93711', '559-431-2398', 0),
(8, 6, '23 Mountain View St.', '', 'Denver', 'CO', '80208', '303-912-3852', 0),
(9, 7, '7361 N. 41st St.', 'Apt. B', 'New York', 'NY', '10012', '212-335-2093', 0),
(10, 7, '3829 Broadway Ave.', 'Suite 2', 'New York', 'NY', '10012', '212-239-1208', 0),
(11, 8, '2381 Buena Vista St.', '', 'Los Angeles', 'CA', '90023', '213-772-5033', 0),
(12, 8, '291 W. Hollywood Blvd.', '', 'Los Angeles', 'CA', '90024', '213-391-2938', 0);

INSERT INTO orders (order_id, customer_id, order_date, ship_amount, tax_amount, ship_date, ship_address_id, card_type, card_number, card_expires, billing_address_id) VALUES
(1, 1, '2018-03-28 09:40:28', '5.00', '32.32',  '2018-03-30 15:32:51', 1, 'Visa', '4111111111111111', '04/2020', 2),
(2, 2, '2018-03-28 11:23:20', '5.00', '0.00',   '2018-03-29 12:52:14', 3, 'Visa', '4012888888881881', '08/2019', 3),
(3, 1, '2018-03-29 09:44:58', '10.00', '89.92', '2018-03-31 9:11:41',  1, 'Visa', '4111111111111111', '04/2017', 2),
(4, 3, '2018-03-30 15:22:31', '5.00', '0.00',   '2018-04-03 16:32:21', 4, 'American Express', '378282246310005', '04/2016', 4),
(5, 4, '2018-03-31 05:43:11', '5.00', '0.00',   '2018-04-02 14:21:12', 5, 'Visa', '4111111111111111', '04/2019', 6),
(6, 5, '2018-03-31 18:37:22', '5.00', '0.00',    NULL,                 7, 'Discover', '6011111111111117', '04/2019', 7),
(7, 6, '2018-04-01 23:11:12', '15.00', '0.00',  '2018-04-03 10:21:35', 8, 'MasterCard', '5555555555554444', '04/2019', 8),
(8, 7, '2018-04-02 11:26:38', '5.00', '0.00',    NULL,                 9, 'Visa', '4012888888881881', '04/2019', 10),
(9, 4, '2018-04-03 12:22:31', '5.00', '0.00',    NULL,                 5, 'Visa', '4111111111111111', '04/2019', 6);

INSERT INTO order_items (item_id, order_id, product_id, item_price, discount_amount, quantity) VALUES
(1,  1, 2, '16.99', '0.00', 1),
(2,  2, 4, '49.90', '0.00', 1),
(3,  3, 3, '8.49',  '1.61', 1),
(4,  3, 4, '49.90', '0.00', 1),
(5,  4, 2, '16.99', '0.00', 2),
(6,  5, 4, '49.90', '0.00', 1),
(7,  6, 4, '49.90', '0.00', 1),
(8,  7, 1, '6.99',  '2.50', 1),
(9,  7, 4, '49.90', '0.00', 1),
(10, 7, 4, '49.90', '0.00', 1),
(11, 8, 4, '49.90', '0.00', 1),
(12, 9, 1, '6.99',  '2.50', 1);

INSERT INTO administrators (admin_id, email_address, password, first_name, last_name) VALUES
(1, 'jacob@banghart.com', '971e95957d3b74d70d79c20c94e9cd91b85f7aae', 'Jacob', 'Banghart');

insert into inventory (product_id, count) values
(1,30),
(2,30),
(3,30),
(4,30),
(5,40),
(6,50),
(7,20),
(8,20),
(9,20);

-- Create a user named mgs_user
CREATE USER IF NOT EXISTS cis_user@localhost
IDENTIFIED BY 'pa55word';

-- Grant privileges to that user
GRANT SELECT, INSERT, UPDATE, DELETE
ON cis.*
TO cis_user@localhost;
 
 -- Add views
create view customer_info as
	select cust.customer_id, first_name, last_name, email_address, 
    line1,line2, city, state, zip_code, phone,
    rewards_points
	from customers as cust
		inner join addresses
			on cust.shipping_address_id = addresses.address_id;
