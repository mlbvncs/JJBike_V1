# JJBike PostgreSQL - Business Intelligence Analysis

A comprehensive Business Intelligence project that combines PostgreSQL and Power BI to build a data warehouse so that the administrator of the fictional company JJBike can understand their business.

---

## 📋 Table of Contents

- [Project Description](#project-description)
- [Technologies Used](#technologies-used)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the Project](#running-the-project)
- [Project Structure](#project-structure)
- [Project Objectives](#project-objectives)
- [Learning Outcomes](#learning-outcomes)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)

---

## 📝 Project Description

This project demonstrates the complete development of a Business Intelligence solution using PostgreSQL as the database management system and Power BI as a tool for visualization and generating reports, dashboards, and cubes.

**Main areas of focus:**
- Requirements Gathering: Defining the indicators and questions that the project should answer
- Transactional Modeling (PostgreSQL): Creating the ERD (Drawing the logical diagram and populating the normalized tables)
- Dimensional Modeling (PostgreSQL): Star Schema Structure (Creating and populating the fact and dimension tables using surrogate keys)
- Integration and Transformation (Power BI): Data Handling (Connecting PostgreSQL to Power Query to adjust types and relationships)
- Visualization and Delivery: Reports, dashboards, and cube

---

## 🛠 Technologies Used

| Technology |
|-----------|
| **PostgreSQL** |
| **SQL** |
| **Power BI** |
| **Git** |
| **GitHub** |

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

#### Option B: Using pgAdmin 4 (GUI)

1. Open pgAdmin 4 and connect to your PostgreSQL server
2. Right-click on "Databases" → Create → Database
3. Enter `jjbike_db` as the database name
4. Create a user with appropriate permissions

### Step 3: Import Database Scripts

1. Navigate to the **1. Environments** folder to locate the SQL scripts
2. Import the scripts into your PostgreSQL database:

```bash
psql -U postgres -d jjbike_db -f "path/to/script.sql"
```

Or using pgAdmin 4:
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

Navigate to the **1. Environments** folder and execute the SQL scripts in the following recommended order:

```bash
# Example: Run data initialization scripts
psql -U postgres -d jjbike_db -f "1. Environments/2.OLAP/1. Scripts_Create_Tables_Relational.sql"
```

### 3. Connect to Power BI

1. Open **Power BI Desktop**
2. Click on **Get Data** → **PostgreSQL database**
3. Enter connection details:
   - **Server:** localhost (or your PostgreSQL server address)
   - **Database:** jjbike_db
   - **Username:** postgres (or your custom user)
   - **Password:** your_password_here
4. Select the tables you want to analyze
5. Click **Load** to import the data
6. Build your dashboards and reports

### 4. Explore the Analysis

- Check the **Analysis.pdf** file for detailed findings and methodology
- Review the reports, dashboards, and cube created in Power BI
- Examine the SQL queries in the **1. Environments** folder for data insights

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

- ✅ To build a data warehouse so that the administrator of the fictional company JJBike can understand their business.

---

## 📚 Learning Outcomes

This project enhances skills in:

- **SQL**
- **Business Intelligence Analysis**
- **PostgreSQL Administration**
- **Power BI Development**
- **Data Visualization**

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
- Portfolio: Business Intelligence Analysis

---

## 🌟 Acknowledgments

This project was developed to demonstrate comprehensive BI skills and provide a practical example of PostgreSQL and Power BI integration.

If you found this project useful, please consider giving it a star ⭐ and sharing it with others interested in business intelligence!

---

**Last Updated:** June 05, 2026  
**Status:** Active Development
