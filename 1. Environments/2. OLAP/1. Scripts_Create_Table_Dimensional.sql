CREATE SCHEMA Dimensional;

CREATE TABLE Dimensional.dim_seller(
  seller_key int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_seller int NOT NULL,
  seller_name Varchar(50) NOT NULL,
  validity_start_date date NOT NULL,
  validity_end_date date
);

CREATE TABLE Dimensional.dim_customer(
  customer_key int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_customer int NOT NULL,
  customer_name Varchar(50) NOT NULL,
  customer_state Varchar(2) NOT NULL,
  customer_gender Char(1) NOT NULL,
  customer_status Varchar(50) NOT NULL,
  validity_start_date date NOT NULL,
  validity_end_date date
);

CREATE TABLE Dimensional.dim_product(
  product_key int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_product int NOT NULL,
  product_name Varchar(100) NOT NULL,
  validity_start_date date NOT NULL,
  validity_end_date date
);

CREATE TABLE Dimensional.dim_time(
  time_key int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  time_date Date NOT NULL,
  time_day int NOT NULL,
  time_month int NOT NULL,
  time_year int NOT NULL,
  time_weekday int NOT NULL,
  time_quarter int NOT NULL
);

CREATE TABLE Dimensional.fact_sales(
  sale_key int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  seller_key int NOT NULL references Dimensional.dim_seller (seller_key),
  customer_key int NOT NULL references Dimensional.dim_customer (customer_key),
  product_key int NOT NULL references Dimensional.dim_product (product_key),
  time_key int NOT NULL references Dimensional.dim_time (time_key),
  quantity int NOT NULL,
  unit_price Numeric(10,2) NOT NULL,
  total_price Numeric(10,2) NOT NULL,
  discount Numeric(10,2) NOT NULL
);
