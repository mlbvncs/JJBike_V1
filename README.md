# JJBike PostgreSQL - Business Intelligence Analysis

A comprehensive Business Intelligence project that combines PostgreSQL and Power BI to analyze and visualize business data from the fictional company JJBike.

---

## 📋 Table of Contents

- [Project Description](#project-description)
- [Technologies Used](#technologies-used)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the Project](#running-the-project)
- [Project Structure](#project-structure)
- [Project Objectives](#project-objectives)
- [Analysis Highlights](#analysis-highlights)
- [Learning Outcomes](#learning-outcomes)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)

---

## 📝 Project Description

This project demonstrates the complete development of a Business Intelligence solution using PostgreSQL as the database management system and Power BI as the visualization and reporting tool.

**Key Focus Areas:**
- Data organization and management using PostgreSQL
- SQL-based data extraction and transformation
- Data modeling and standardization (including Brazilian Portuguese translations)
- Business metrics and KPI development
- Interactive dashboard creation with Power BI
- Data-driven decision-making support

The project includes comprehensive analysis of business metrics such as sales performance, revenue trends, product analysis, customer behavior, and profitability indicators.

---

## 🛠 Technologies Used

| Technology | Purpose |
|-----------|---------|
| **PostgreSQL** | Relational database management system for data storage and management |
| **SQL** | Data querying, and extraction |
| **Power BI** | Data visualization, interactive dashboard creation, and transformation |
| **Git** | Version control |
| **GitHub** | Repository hosting and collaboration |

---

## 📦 Prerequisites

Before getting started, ensure you have the following installed on your system:

- **PostgreSQL** (version 12.0 or higher)
  - Download: https://www.postgresql.org/download/
  
- **Power BI Desktop** (latest version)
  - Download: https://powerbi.microsoft.com/en-us/desktop/
  
- **Git** (for cloning the repository)
  - Download: https://git-scm.com/

- **pgAdmin** (optional, for GUI database management)
  - Download: https://www.pgadmin.org/download/

### System Requirements
- OS: Windows, macOS, or Linux
- RAM: Minimum 4GB (8GB recommended)
- Disk Space: At least 500MB free space

---

## 💻 Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/mlbvncs/JJBike_PostgreSQL.git
cd JJBike_PostgreSQL
```

### Step 2: Set Up PostgreSQL Database

#### Option A: Using Command Line

1. **Start PostgreSQL service** (if not already running):
   - **Windows:** PostgreSQL service should start automatically
   - **macOS/Linux:** 
   ```bash
   sudo systemctl start postgresql
   ```

2. **Access PostgreSQL terminal:**
   ```bash
   psql -U postgres
   ```

3. **Create a new database:**
   ```sql
   CREATE DATABASE jjbike_db;
   ```

4. **Create a user (optional but recommended):**
   ```sql
   CREATE USER jjbike_user WITH PASSWORD 'your_password_here';
   ALTER ROLE jjbike_user SET client_encoding TO 'utf8';
   ALTER ROLE jjbike_user SET default_transaction_isolation TO 'read committed';
   ALTER ROLE jjbike_user SET default_transaction_deferrable TO on;
   GRANT ALL PRIVILEGES ON DATABASE jjbike_db TO jjbike_user;
   ```

#### Option B: Using pgAdmin (GUI)

1. Open pgAdmin and connect to your PostgreSQL server
2. Right-click on "Databases" → Create → Database
3. Enter `jjbike_db` as the database name
4. Create a user with appropriate permissions

### Step 3: Import Database Scripts

1. Navigate to the **2. Artifacts** folder to locate the SQL scripts
2. Import the scripts into your PostgreSQL database:

```bash
psql -U postgres -d jjbike_db -f "path/to/script.sql"
```

Or using pgAdmin:
- Right-click on the database → Restore
- Select the SQL file and follow the wizard

### Step 4: Configure Environment Variables

1. Create a `.env` file in the root directory (if needed):
   ```
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=jjbike_db
   DB_USER=jjbike_user
   DB_PASSWORD=your_password_here
   ```

2. Update connection strings in your Power BI configuration as needed

---

## 🚀 Running the Project

### 1. Verify Database Setup

```bash
psql -U postgres -d jjbike_db -c "SELECT version();"
```

### 2. Execute SQL Queries

Navigate to the **2. Artifacts** folder and execute the SQL scripts in the following recommended order:

```bash
# Example: Run data initialization scripts
psql -U postgres -d jjbike_db -f "2. Artifacts/01_schema_creation.sql"
psql -U postgres -d jjbike_db -f "2. Artifacts/02_data_import.sql"
psql -U postgres -d jjbike_db -f "2. Artifacts/03_views_and_queries.sql"
```

### 3. Connect to Power BI

1. Open **Power BI Desktop**
2. Click on **Get Data** → **PostgreSQL database**
3. Enter connection details:
   - **Server:** localhost (or your PostgreSQL server address)
   - **Database:** jjbike_db
   - **Username:** postgres (or your custom user)
   - **Password:** your_password_here
4. Select the tables and views you want to analyze
5. Click **Load** to import the data
6. Build your dashboards and reports

### 4. Explore the Analysis

- Check the **Analysis.pdf** file for detailed findings and methodology
- Review the dashboards created in Power BI
- Examine the SQL queries in the **2. Artifacts** folder for data insights

---

## 📂 Project Structure

```
JJBike_PostgreSQL/
│
├── 1. Environments/
│   ├── SQL scripts
│
├── 2. Artifacts/
│   └── Power BI resources
│
├── 3. Translations/
│   ├── Brazilian Portuguese analysis translation
│
├── Analysis.pdf
│   └── Comprehensive analysis report and findings
│
├── LICENSE
│   └── MIT License
│
├── .gitignore
│   └── Git ignore configuration
│
└── README.md
    └── This file
```

### Key Folders Explained

**1. Environments/**
- Core SQL scripts for database schema creation and data management
- SQL queries used for data extraction and analysis

**2. Artifacts/**
- Power BI files and related resources

**3. Translations/**
- Brazilian Portuguese analysis translation

---

## 🎯 Project Objectives

- ✅ Organize and manage business data using PostgreSQL
- ✅ Perform SQL-based data extraction, transformation, and analysis
- ✅ Build Key Performance Indicators (KPIs) for business metrics
- ✅ Create interactive and intuitive dashboards with Power BI
- ✅ Generate actionable insights to support business decisions
- ✅ Demonstrate data visualization best practices
- ✅ Provide a reproducible BI solution template

---

## 📊 Analysis Highlights

The project includes comprehensive analyses of:

- **Sales Performance:** Total sales, sales trends, and performance metrics
- **Revenue Analysis:** Revenue by period, growth trends, and forecasting
- **Product Analysis:** Best-selling products, product performance, and inventory insights
- **Category Performance:** Sales and revenue breakdown by category
- **Customer Behavior:** Purchasing patterns, customer segmentation, and retention
- **Profitability Indicators:** Profit margins, cost analysis, and ROI metrics
- **Operational Metrics:** Efficiency indicators, performance benchmarks, and KPIs

---

## 📚 Learning Outcomes

This project strengthens skills in:

- **Database Design:** Designing efficient relational database schemas
- **SQL Development:** Writing complex queries
- **Data Analysis:** Analyzing data to extract meaningful insights
- **Business Intelligence:** Building end-to-end BI solutions
- **PostgreSQL Administration:** Database management and optimization
- **Power BI Development:** Creating dashboards and reports
- **Data Visualization:** Presenting data effectively and intuitively

---

## 🤝 Contributing

Contributions, suggestions, and improvements are welcome!

To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

This project is available for educational and portfolio purposes.

---

## 👤 Author

**Malba Vinicius Lopes Santos**

- GitHub: [@mlbvncs](https://github.com/mlbvncs)
- Portfolio: Business Intelligence & Data Analysis

---

## 🌟 Acknowledgments

This project was developed to demonstrate comprehensive BI skills and provide a practical example of PostgreSQL and Power BI integration.

If you found this project useful, please consider giving it a star ⭐ and sharing it with others interested in business intelligence!

---

**Last Updated:** June 05, 2026  
**Status:** Active Development
