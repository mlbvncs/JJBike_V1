# JJBike_V1 - Business Intelligence Analysis

A comprehensive **Business Intelligence (BI)** project demonstrating the complete development of a data warehouse using **PostgreSQL** (pgAdmin 4) and **Power BI**.

---

## 🎯 Quick Overview

This project builds a complete data warehouse solution for the fictional company **JJBike**, implementing:

- **OLTP Environment:** Relational schema with 5 operational tables storing transactional data
- **OLAP Environment:** Star Schema with dimensional modeling and Slowly Changing Dimensions (SCD Type 2)
- **Visualization Layer:** Power BI dashboards and reports with hierarchical cubes
- **KPI Tracking:** Monthly revenue targets vs. actual performance monitoring

**For detailed documentation, see [Analysis.pdf](./Analysis.pdf)**

---

## 🏗️ Architecture Overview

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
│  (who?)     │◄─────┤  (core)     ├────►│  (for whom?)│
└─────────────┘      └──────┬──────┘     └─────────────┘
                             │
                    ┌────────▼────────┐
                    │   dim_time      │
                    │  (when?)        │
                    └─────────────────┘
```

---

## 🛠 Technologies

| Technology | Purpose |
|-----------|---------|
| **PostgreSQL** | Relational database for OLTP and OLAP |
| **pgAdmin 4** | Database administration GUI |
| **SQL** | Data definition and transformation |
| **Power BI** | Data visualization and dashboards |

---

## 📦 Prerequisites

- **PostgreSQL** 12+ ([download](https://www.postgresql.org/download/))
- **pgAdmin 4** ([download](https://www.pgadmin.org/download/)) - *optional*
- **Power BI Desktop** ([download](https://powerbi.microsoft.com/en-us/desktop/)) - Windows/macOS only
- **Git** ([download](https://git-scm.com/))

---

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/mlbvncs/JJBike_V1.git
cd JJBike_V1
```

### 2. Create Database
```bash
psql -U postgres
CREATE DATABASE JJBIKE;
\q
```

### 3. Load SQL Scripts (In Order)

**OLTP Environment:**
```bash
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/1. Scripts_Create_Table_Relational.sql"
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/2. Insert_Into_Customers.sql"
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/3. Insert_Into_Products.sql"
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/4. Insert_Into_Sellers.sql"
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/5. Insert_Into_Sales.sql"
psql -U postgres -d JJBIKE -f "1. Environments/1. OLTP/6. Insert_Into_SaleItems.sql"
```

**OLAP Environment:**
```bash
psql -U postgres -d JJBIKE -f "1. Environments/2. OLAP/1. Scripts_Create_Table_Dimensional.sql"
psql -U postgres -d JJBIKE -f "1. Environments/2. OLAP/2. Insert_Into_dim_time.sql"
psql -U postgres -d JJBIKE -f "1. Environments/2. OLAP/3. Script.sql"
psql -U postgres -d JJBIKE -f "1. Environments/2. OLAP/4. Cube.sql"
psql -U postgres -d JJBIKE -f "1. Environments/2. OLAP/5. KPI.sql"
```

### 4. Verify Setup
```bash
psql -U postgres -d JJBIKE -c "SELECT schema_name FROM information_schema.schemata;"
```
You should see `Relational` and `Dimensional` schemas.

### 5. Connect Power BI
1. Open **Power BI Desktop**
2. **Get Data** → **PostgreSQL Database**
3. Enter connection details:
   - Server: `localhost`
   - Database: `JJBIKE`
   - Username: `postgres`
4. Select tables from `Dimensional` schema and click **Load**

---

## 📊 Key Features

✅ **Star Schema** - Optimized for analytical queries  
✅ **SCD Type 2** - Complete historical tracking of dimension changes  
✅ **Automated Surrogate Keys** - `GENERATED ALWAYS AS IDENTITY`  
✅ **Referential Integrity** - Constraints prevent data inconsistency  
✅ **Time Dimension** - 29,220 days (1970–2049)  
✅ **KPI Tracking** - Monthly revenue targets vs. actuals

---

## 📂 Project Structure

```
JJBike_V1/
├── 1. Environments/
│   ├── 1. OLTP/          # Relational schema (transactional)
│   └── 2. OLAP/          # Dimensional schema (analytical)
├── 2. Artifacts/         # Power BI files
├── 3. Translations/      # Portuguese documentation
├── Analysis.pdf          # Complete technical documentation
├── LICENSE
└── README.md
```

---

## 📈 Deliverables

### Power BI Reports
- **Customers Report** - Revenue by state, status, gender, and top customers
- **Sellers Report** - Top/worst sellers, month-to-month comparison
- **Products Report** - Best/least-selling products, discount analysis

### Power BI Dashboards
- **Sales Dashboard** - Value, quantity, and discount trends
- **KPI Dashboard** - Revenue vs. targets, monthly tracking

### Analytical Cube
- **Hierarchies:** Geographic (state → customer) & Time (year → quarter → month → day)
- **Dimensions:** Product, Seller, Customer, Time
- **Fact:** Sales (quantity, unit price, total price, discount)

---

## 📚 Learn More

For **complete technical documentation**, including:
- Detailed modeling methodology
- Database schema specifications
- SCD Type 2 implementation details
- Power BI calculations and measures
- Data warehouse architecture rationale

👉 **See [Analysis.pdf](./Analysis.pdf)**

---

## 🎓 Learning Outcomes

- Database design (OLTP & OLAP)
- SQL mastery (CTEs, window functions, aggregations)
- Star Schema modeling
- Slowly Changing Dimensions
- PostgreSQL administration
- Power BI development (DAX, hierarchies, reports)
- Business Intelligence concepts

---

## 🤝 Contributing

Contributions are welcome! Feel free to:
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a Pull Request

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

## 👤 Author

**Malba Vinicius Lopes Santos**  
GitHub: [@mlbvncs](https://github.com/mlbvncs)

---

**Last Updated:** June 23, 2026  
**Status:** Active & Maintained  
**Type:** Educational Portfolio

⭐ **If you found this useful, please consider starring this repository!**
