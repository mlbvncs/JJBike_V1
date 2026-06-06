# JJBike PostgreSQL - Business Intelligence Analysis

A comprehensive **Business Intelligence (BI)** project demonstrating the complete development of a data warehouse using **PostgreSQL** (pgAdmin 4) and **Power BI**. This project transforms a transactional OLTP environment into an analytical OLAP environment using the **Star Schema** dimensional modeling approach.

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Technologies Used](#technologies-used)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Project Workflow](#project-workflow)
- [Database Structure](#database-structure)
- [Key Features](#key-features)
- [Power BI Artifacts](#power-bi-artifacts)
- [Project Structure](#project-structure)
- [Learning Outcomes](#learning-outcomes)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)

---

## 🎯 Project Overview

This project builds a **complete data warehouse solution** for the fictional company **JJBike** to enable data-driven business decisions. The solution implements:

- **OLTP Environment (Transactional):** Relational schema with 5 operational tables storing real business data
- **OLAP Environment (Analytical):** Star Schema with dimensional modeling and Slowly Changing Dimensions (SCD Type 2)
- **Visualization Layer:** Power BI dashboards and reports with hierarchical cubes
- **KPI Tracking:** Revenue targets vs. actual performance monitoring

**Business Context:** JJBike's administrators need to analyze customer behavior, seller performance, product sales, and revenue targets through multiple dimensions and time-based perspectives.

---

## 🏗️ Architecture

### Data Warehouse Structure (Star Schema)

```
                    ┌─────────────────┐
                    │   dim_product   │
                    │   (what?)       │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
┌───────▼─────┐      ┌──────▼──────┐     ┌──────▼──────┐
│ dim_seller  │      │ fact_sales  │     │ dim_customer│
│  (who?)     │◄─────┤  (core)     ├────►│  (who?)     │
└─────────────┘      └──────┬──────┘     └─────────────┘
                             │
                    ┌────────▼────────┐
                    │   dim_time      │
                    │  (when?)        │
                    └─────────────────┘
```

### Entity Details

**Dimensions (What, Who, When):**

| Dimension | Attributes | SCD Type | Purpose |
|-----------|-----------|----------|---------|
| **dim_product** | product_key, id_product, product_name, validity dates | Type 2 | Tracks what products are sold |
| **dim_seller** | seller_key, id_seller, seller_name, validity dates | Type 2 | Identifies who the sellers are |
| **dim_customer** | customer_key, id_customer, customer_name, customer_state, customer_gender, customer_status, validity dates | Type 2 | Segments customers by location, gender, and status |
| **dim_time** | time_key, time_date, time_day, time_month, time_year, time_weekday, time_quarter | N/A | Enables temporal analysis |

**Fact Table (Metrics):**

| Table | Granularity | Metrics | Aggregation |
|-------|-------------|---------|-------------|
| **fact_sales** | Product item per sale | quantity, unit_price, total_price, discount | Sum aggregation across all dimensions |

---

## 🛠 Technologies Used

| Technology | Purpose |
|-----------|---------|
| **PostgreSQL 12+** | Relational database for OLTP and OLAP environments |
| **pgAdmin 4** | GUI for PostgreSQL database administration |
| **SQL** | Data definition, manipulation, and transformation (Snake Case convention) |
| **Power BI Desktop** | Data visualization, reporting, and dashboard creation |
| **Git/GitHub** | Version control and project repository |

---

## 📦 Prerequisites

Before getting started, ensure you have the following installed:

- **PostgreSQL** (version 12.0 or higher)
  - Download: https://www.postgresql.org/download/
  - Includes `psql` command-line tool

- **pgAdmin 4** (optional but recommended for GUI management)
  - Download: https://www.pgadmin.org/download/
  - Included with PostgreSQL installer on most platforms

- **Power BI Desktop** (latest version)
  - Download: https://powerbi.microsoft.com/en-us/desktop/
  - Windows or macOS only

- **Git** (for cloning the repository)
  - Download: https://git-scm.com/

### System Requirements
- **OS:** Windows, macOS, or Linux
- **RAM:** Minimum 4GB (8GB recommended)
- **Disk Space:** At least 500MB free space
- **Port:** 5432 (default PostgreSQL port must be available)

---

## 💻 Installation & Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/mlbvncs/JJBike_PostgreSQL.git
cd JJBike_PostgreSQL
```

### Step 2: Create PostgreSQL Database

#### Option A: Using pgAdmin 4 (Recommended for Beginners)

1. Open **pgAdmin 4** and connect to your PostgreSQL server
2. Right-click on **Databases** → **Create** → **Database**
3. Enter database name: `JJBIKE`
4. Click **Save**

#### Option B: Using Command Line

```bash
# Connect to PostgreSQL
psql -U postgres

# Create database
CREATE DATABASE JJBIKE;

# (Optional) Create dedicated user
CREATE USER jjbike_user WITH PASSWORD 'secure_password';
ALTER ROLE jjbike_user SET client_encoding TO 'utf8';
GRANT ALL PRIVILEGES ON DATABASE JJBIKE TO jjbike_user;

# Exit psql
\q
```

### Step 3: Import SQL Scripts (In Order)

Execute the SQL scripts from the `1. Environments` folder in the following sequence:

#### OLTP Environment (Transactional):
```bash
# Using pgAdmin: Right-click database → Restore → Select SQL file

# Or using command line:
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/1. Scripts_Create_Table_Relational.sql"
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/2. Insert_Into_Customers.sql"
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/3. Insert_Into_Products.sql"
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/4. Insert_Into_Sellers.sql"
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/5. Insert_Into_Sales.sql"
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/6. Insert_Into_SaleItems.sql"
```

#### OLAP Environment (Analytical):
```bash
psql -U postgres -d JJBIKE -f "1. Environments/2. OLAP/1. Scripts_Create_Table_Dimensional.sql"
psql -U postgres -d JJBIKE -f "1. Environments/2. OLAP/2. Insert_Into_dim_time.sql"
psql -U postgres -d JJBIKE -f "1. Environments/2. OLAP/3. Script.sql"
psql -U postgres -d JJBIKE -f "1. Environments/2. OLAP/4. Cube.sql"
psql -U postgres -d JJBIKE -f "1. Environments/2. OLAP/5. KPI.sql"
```

### Step 4: Verify Database Setup

```bash
psql -U postgres -d JJBIKE -c "SELECT schema_name FROM information_schema.schemata;"
```

Expected output should show both `Relational` and `Dimensional` schemas.

### Step 5: Connect to Power BI

1. **Open Power BI Desktop**
2. Click **Get Data** → **PostgreSQL Database**
3. Enter connection details:
   - **Server:** `localhost`
   - **Database:** `JJBIKE`
   - **Username:** `postgres` (or your custom user)
   - **Password:** (your PostgreSQL password)
4. Click **Connect**
5. Select tables from `Dimensional` schema:
   - `dim_customer`
   - `dim_seller`
   - `dim_product`
   - `dim_time`
   - `fact_sales`
   - `sales_cube`
   - `kpi`
6. Click **Load** to import data

---

## 🚀 Project Workflow

### Phase 1: Transactional Environment (OLTP)

The **Relational schema** contains 5 normalized tables following 3NF principles:

| Table | Records | Purpose | Primary Key |
|-------|---------|---------|------------|
| **sellers** | N sellers | Stores seller information | id_seller (auto-generated) |
| **products** | N products | Product catalog with pricing | id_product (auto-generated) |
| **customers** | N customers | Customer profiles with demographics | id_customer (auto-generated) |
| **sales** | N transactions | Sale headers with date and total | id_sale (auto-generated) |
| **sale_items** | N items | Junction table (N:M) between sales and products | (id_sale, id_product) |

**Key Constraints:**
- All primary keys use `GENERATED ALWAYS AS IDENTITY` for automatic sequential generation
- Foreign keys use `ON DELETE RESTRICT` for products (prevent deletion if sold) and `ON DELETE CASCADE` for sales (cascade delete items)
- All business attributes are `NOT NULL` to ensure data integrity

### Phase 2: Analytical Environment (OLAP)

The **Dimensional schema** implements the Star Schema with dimensions and fact table:

#### Dimension Tables (with SCD Type 2 Versioning):
- **Surrogate Keys (SK):** Internal sequential IDs for efficient joins
- **Natural Keys:** References to source table IDs for traceability
- **Versioning:** `validity_start_date` and `validity_end_date` track dimension changes over time

#### Fact Table:
- Granularity: **One row per product item per sale**
- Links all dimensions via foreign keys
- Stores metrics: quantity, unit_price, total_price, discount

#### Time Dimension:
- **Continuous date range:** January 1, 1970 to December 31, 2049 (29,220 days)
- Programmatically generated using `GENERATE_SERIES()`
- Supports all temporal analyses (day, month, quarter, year, weekday)

### Phase 3: SCD Type 2 Implementation

**Slowly Changing Dimensions (Type 2)** preserves complete historical records:

Example: When a customer's status changes from "Silver" to "Gold":
1. The old record's `validity_end_date` is set to today
2. A new record is inserted with the updated status and today's `validity_start_date`
3. Both records coexist; fact table entries retain their historical dimension keys

**Mechanism:**
- CTE pattern detects changes by comparing all tracked attributes
- `INNER JOIN` with `validity_end_date IS NULL` filter ensures only active versions are used during fact table loads
- Historical fact table records automatically reference the correct dimension version

### Phase 4: Analytical Cube & KPI

**Analytical Cube:**
- Denormalized table joining fact_sales with all dimensions
- Eliminates surrogate and source keys for simplified Power BI connections
- Contains only business-relevant attributes for analysis

**KPI Table:**
- Aggregated monthly revenue (SUM of total_price)
- Fixed monthly targets (R$ 220,000 to R$ 270,000)
- Enables achievement percentage calculations

---

## 📊 Database Structure

### OLTP Schema (Relational) - Transactional Data
```
Relational.sellers
├─ id_seller (PK)
├─ seller_name

Relational.products
├─ id_product (PK)
├─ product_name
└─ product_price

Relational.customers
├─ id_customer (PK)
├─ customer_name
├─ customer_state
├─ customer_gender
└─ customer_status

Relational.sales
├─ id_sale (PK)
├─ id_seller (FK)
├─ id_customer (FK)
├─ sale_date
└─ total

Relational.sale_items (N:M Junction)
├─ id_sale (FK, PK)
├─ id_product (FK, PK)
├─ quantity
├─ unit_price
├─ total_price
└─ discount
```

### OLAP Schema (Dimensional) - Analytical Data
```
Dimensional.dim_product
├─ product_key (PK, SK)
├─ id_product
├─ product_name
├─ validity_start_date
└─ validity_end_date (SCD Type 2)

Dimensional.dim_seller
├─ seller_key (PK, SK)
├─ id_seller
├─ seller_name
├─ validity_start_date
└─ validity_end_date (SCD Type 2)

Dimensional.dim_customer
├─ customer_key (PK, SK)
├─ id_customer
├─ customer_name
├─ customer_state
├─ customer_gender
├─ customer_status
├─ validity_start_date
└─ validity_end_date (SCD Type 2)

Dimensional.dim_time
├─ time_key (PK, SK)
├─ time_date
├─ time_day
├─ time_month
├─ time_year
├─ time_weekday
└─ time_quarter

Dimensional.fact_sales
├─ sale_key (PK, SK)
├─ seller_key (FK)
├─ customer_key (FK)
├─ product_key (FK)
├─ time_key (FK)
├─ quantity
├─ unit_price
├─ total_price
└─ discount

Dimensional.sales_cube (Denormalized)
└─ All attributes from fact_sales + all dimension attributes

Dimensional.kpi
├─ month
├─ total_revenue
└─ target
```

---

## 🎯 Key Features

### 1. **Star Schema Implementation**
- Optimized for analytical queries
- Fast aggregations across dimensions
- Simplified join logic for Power BI

### 2. **Slowly Changing Dimensions (SCD Type 2)**
- Complete historical tracking of dimension changes
- Preserves analytical accuracy across time periods
- Example: Customer status upgrades are tracked with validity dates

### 3. **Automated Surrogate Keys**
- `GENERATED ALWAYS AS IDENTITY` for all primary keys
- Eliminates dependency on natural key stability
- Improves join performance

### 4. **Referential Integrity Constraints**
- Product deletion prevention (`ON DELETE RESTRICT`) maintains sales history
- Sale deletion cascade (`ON DELETE CASCADE`) prevents orphaned items
- Foreign key relationships enforce data consistency

### 5. **Time Dimension Coverage**
- 29,220 days spanning 80 years (1970–2049)
- Supports all granularities: day, month, quarter, year
- Enables time-series analysis

### 6. **KPI Tracking**
- Monthly revenue targets vs. actuals
- Dynamic achievement percentage calculations in Power BI
- Flexible filtering by month and year

---

## 📈 Power BI Artifacts

### Calculated Columns

**In fact_sales:**
```dax
discount_percent = TRUNC((discount / total_price) * 100, 2)
```
Calculates discount percentage with two decimal places.

**In dim_customer:**
```dax
full_location = SWITCH(customer_state,
    "AC", "Acre", "AL", "Alagoas", ..., "SP", "Sao Paulo", "Unknown") & ", Brazil"
```
Maps Brazilian state abbreviations to full names for geographic visualization.

### Measures (KPI Dashboard)

```dax
measure_target = 
IF(ISFILTERED('kpi'[month]) || ISFILTERED('dim_time'[time_year]),
   SUM('kpi'[target]), 0)

measure_total_revenue = 
IF(ISFILTERED('kpi'[month]) || ISFILTERED('dim_time'[time_year]),
   SUM('kpi'[total_revenue]), 0)
```
Ensure KPI cards display data only when filtered by month or year.

### Reports

1. **Customers Report**
   - Total value by state
   - Total value by customer status
   - Total value by gender
   - Top 5 customers by revenue

2. **Sellers Report**
   - Top 5 best-selling sellers
   - Top 5 worst-selling sellers
   - Top 5 sellers by month (month-to-month comparison)

3. **Products Report**
   - Top 5 best-selling products
   - Top 5 least-selling products
   - Top 5 products with highest accumulated discount
   - Top 5 products with lowest accumulated discount

### Dashboards

1. **Sales Dashboard**
   - Total value of products sold (month-to-month comparison)
   - Total quantity of products sold (month-to-month comparison)
   - Total discount (month-to-month comparison)
   - Filter cards: Product, Seller, Customer

2. **KPI Dashboard**
   - Target vs. total acquired value (KPI cards)
   - Target and revenue by month (line/column chart)
   - Filter cards: Month, Year

### Hierarchies (Analytical Cube)

| Hierarchy | Structure |
|-----------|-----------|
| **Geographic** | customer_state → customer_name |
| **Time** | time_year → time_quarter → time_month → time_day |

**Loose Dimension Attributes** (not in hierarchies):
- customer_gender, customer_status (from dim_customer)
- seller_name (from dim_seller)
- product_name (from dim_product)

---

## 📂 Project Structure

```
JJBike_PostgreSQL/
│
├── 1. Environments/
│   ├── 1. OLTP/
│   │   ├── 1. Scripts_Create_Table_Relational.sql      # Relational schema creation
│   │   ├── 2. Insert_Into_Customers.sql                # Customer data load
│   │   ├── 3. Insert_Into_Products.sql                 # Product data load
│   │   ├── 4. Insert_Into_Sellers.sql                  # Seller data load
│   │   ├── 5. Insert_Into_Sales.sql                    # Sales data load
│   │   └── 6. Insert_Into_SaleItems.sql                # Sale items data load
│   │
│   └── 2. OLAP/
│       ├── 1. Scripts_Create_Table_Dimensional.sql     # Dimensional schema creation
│       ├── 2. Insert_Into_dim_time.sql                 # Time dimension population
│       ├── 3. Script.sql                               # Dimension loads (SCD Type 2)
│       ├── 4. Cube.sql                                 # Analytical cube creation
│       └── 5. KPI.sql                                  # KPI table creation
│
├── 2. Artifacts/
│   └── [Power BI files and resources]
│
├── 3. Translations/
│   └── [Brazilian Portuguese documentation]
│
├── Analysis.pdf                                         # Comprehensive project analysis
├── LICENSE                                              # MIT License
├── .gitignore                                           # Git configuration
└── README.md                                            # This file
```

---

## 📚 Learning Outcomes

This project develops proficiency in:

### **SQL & Database Design**
- Transactional database design (OLTP, 3NF normalization)
- Dimensional database design (OLAP, Star Schema)
- Advanced SQL: CTEs, window functions, date manipulation, aggregate functions
- Data integrity: constraints, referential integrity, cascade operations
- Slowly Changing Dimensions (SCD Type 2) implementation

### **Business Intelligence Concepts**
- Data warehouse architecture and modeling
- Fact and dimension tables design
- Surrogate key generation and management
- Historical data tracking and versioning
- KPI definition and tracking

### **PostgreSQL Administration**
- Schema creation and management
- Table design and optimization
- Data loading and transformation
- Query optimization
- Automatic key generation with IDENTITY

### **Power BI Development**
- Data connection and configuration
- Data modeling and relationships
- Calculated columns and measures (DAX)
- Report and dashboard design
- Interactive filters and slicers
- Analytical hierarchies
- Time-series analysis

### **Business Analysis**
- Requirements gathering and analysis
- Metric selection and KPI design
- Multi-dimensional analysis
- Geographic and temporal segmentation
- Performance tracking

---

## 🤝 Contributing

Contributions, suggestions, and improvements are welcome!

To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -m 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

This project is available for **educational and portfolio purposes**.

---

## 👤 Author

**Malba Vinicius Lopes Santos**

- GitHub: [@mlbvncs](https://github.com/mlbvncs)
- Project: Business Intelligence Analysis using PostgreSQL and Power BI

---

## 📖 References

- **PostgreSQL Documentation:** https://www.postgresql.org/docs/
- **Power BI Documentation:** https://docs.microsoft.com/power-bi/
- **Star Schema Modeling:** Kimball & Ross, "The Data Warehouse Toolkit"
- **Slowly Changing Dimensions:** Kimball's SCD Type 2 Patterns

---

## 🌟 Acknowledgments

This project demonstrates comprehensive Business Intelligence skills including:
- Complete data warehouse design and implementation
- PostgreSQL and pgAdmin 4 proficiency
- Power BI visualization and reporting
- SQL optimization and data transformation
- Data modeling best practices

If you found this project useful, please consider giving it a ⭐ and sharing it with others interested in business intelligence!

---

**Last Updated:** June 6, 2026  
**Status:** Active & Maintained  
**Project Type:** Educational Portfolio
