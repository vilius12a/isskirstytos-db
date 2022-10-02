#@(#) script.ddl

DROP TABLE IF EXISTS shipment_details;
DROP TABLE IF EXISTS work;
DROP TABLE IF EXISTS shipment;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS partner;
DROP TABLE IF EXISTS manufacturer;
DROP TABLE IF EXISTS courier;
DROP TABLE IF EXISTS client_purchases;
DROP TABLE IF EXISTS client_personal;

CREATE TABLE client_personal
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name varchar (255),
    surname varchar (255),
    birthdate date,
    email varchar (255),
    phone varchar (255),
    city varchar (255),
    PRIMARY KEY(id)
);

CREATE TABLE client_purchases
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date date,
    products_per_year int,
    last_purchase_date date,
    money_spent_per_year decimal,
    PRIMARY KEY(id)
);

CREATE TABLE courier
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name varchar (255),
    surname varchar (255),
    rating varchar (255),
    PRIMARY KEY(id)
);

CREATE TABLE manufacturer
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_name varchar (255),
    address varchar (255),
    country varchar (255),
    PRIMARY KEY(id)
);

CREATE TABLE partner
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_name varchar (255),
    company_code varchar (255),
    PRIMARY KEY(id)
);

CREATE TABLE store
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    address varchar (255),
    PRIMARY KEY(id)
);

CREATE TABLE product
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name varchar (255),
    description TEXT,
    price decimal,
    manufacturer_id integer NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT produce FOREIGN KEY(manufacturer_id) REFERENCES manufacturer (id)
);

CREATE TABLE shipment
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    total_price decimal,
    purchase_date date,
    client_purchase_id integer NOT NULL,
    store_id integer NOT NULL,
    courier_id integer NOT NULL,
    client_personal_id integer NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT buy FOREIGN KEY(client_purchase_id) REFERENCES client_purchases (id),
    CONSTRAINT arrive FOREIGN KEY(store_id) REFERENCES store (id),
    CONSTRAINT ship FOREIGN KEY(courier_id) REFERENCES courier (id),
    CONSTRAINT client_personal FOREIGN KEY(client_personal_id) REFERENCES client_personal (id)
);

CREATE TABLE work
(
    partner_id integer,
    courier_id integer,
    PRIMARY KEY(partner_id, courier_id),
    CONSTRAINT work FOREIGN KEY(partner_id) REFERENCES partner (id)
);

CREATE TABLE shipment_details
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity decimal,
    product_id integer,
    shipment_id integer NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT consist FOREIGN KEY(product_id) REFERENCES product (id),
    FOREIGN KEY(shipment_id) REFERENCES shipment (id)
);
