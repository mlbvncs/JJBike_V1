CREATE SCHEMA Relational;

CREATE TABLE Relational.sellers(
  id_seller int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  seller_name Varchar(50) NOT NULL
);

CREATE TABLE Relational.products(
  id_product int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  product_name Varchar(100) NOT NULL,
  product_price Numeric(10,2) NOT NULL
);

CREATE TABLE Relational.customers(
  id_customer int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_name Varchar(50) NOT NULL,
  customer_state Varchar(2) NOT NULL,
  customer_gender Char(1) NOT NULL,
  customer_status Varchar(50) NOT NULL
);

CREATE TABLE Relational.sales(
  id_sale int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_seller int NOT NULL references Relational.sellers (id_seller),
  id_customer int NOT NULL references Relational.customers (id_customer),
  sale_date Date NOT NULL,
  total Numeric(10,2) NOT NULL
);

CREATE TABLE Relational.sale_items (
    id_product int NOT NULL REFERENCES Relational.products ON DELETE RESTRICT,
    id_sale int NOT NULL REFERENCES Relational.sales ON DELETE CASCADE,
    quantity int NOT NULL,
    unit_price decimal(10,2) NOT NULL,
    total_price decimal(10,2) NOT NULL,
    discount decimal(10,2) NOT NULL,
    PRIMARY KEY (id_product, id_sale)
);
