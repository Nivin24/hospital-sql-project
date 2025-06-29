# 🏥 Hospital Analytics Management System (SQL Capstone Project)

## 📌 Project Overview

This is a **PostgreSQL-based Hospital Management System**, built as a **capstone project** during Week 22 of my training at Brototype.

It showcases advanced SQL concepts through a real-world healthcare data model including analytics, automation, performance optimization, and optional Python integration.

---

## 📚 Table of Contents

1. [Project Overview](#-project-overview)
2. [Key Features](#-key-features)
3. [Project Structure](#-project-folder-structure)
4. [Tech Stack](#-tech-stack)
5. [Concepts Covered](#-concepts-covered)
6. [Analytics Queries](#-analytics-queries)
7. [Setup Instructions](#-setup-instructions)
8. [ER Diagram](#er-diagram)
9. [Author](#-author)
10. [License](#-license)

---

## 🚀 Key Features

* ✅ Structured relational schema: Patients, Doctors, Appointments, Admissions, Prescriptions, Medicines, Departments, Rooms
* ✅ ER Diagram-based normalized design (1NF → 3NF)
* ✅ Advanced SQL: Joins, subqueries, aggregates, window functions, CTEs
* ✅ Triggers for automatic logging/workflows
* ✅ Stored procedures and user-defined functions (PL/pgSQL)
* ✅ Query performance tuning using indexes & `EXPLAIN ANALYZE`
* ✅ Python integration for querying and visualizations using `.env`
* ✅ Organized GitHub-friendly structure with markdown explanations and analytics insights

---

## 🧱 Project Folder Structure

```bash
hospital-sql-project/
├── README.md                      # Project overview & instructions
├── schema/                        # Database schema & data
│   ├── create_tables.sql          # Table creation
│   └── insert_data.sql            # Inserts using COPY or SQL
├── queries/                       # Core SQL logic
│   ├── analytics_queries.sql      # All analytical queries (joins, windows, CTEs)
│   ├── triggers_and_functions.sql # Triggers, functions (PL/pgSQL)
│   ├── stored_procedures.sql      # Stored procedure for inserting patients
│   └── optimization_notes.sql     # Indexing and EXPLAIN ANALYZE outputs
├── data/                          # 📁 CSV files for patient, doctor, medicine, etc.
│   ├── patients.csv
│   ├── appointments.csv
│   └── ... (other tables)
├── explain_outputs/               # Performance output logs
│   └── query_analysis.txt
├── extras/                        # Optional explanations & integration
│   ├── analytics_explained.md     # Explanation of each query
│   ├── hospital_analysis.ipynb    # Python + PostgreSQL integration
│   └── .env (not pushed)          # For credentials (ignored in Git)
├── screenshots/                   # Visuals like ER diagram
│   └── er_diagram.png
└── .gitignore                     # Excludes .env and unnecessary files
```

---
## 🧰 Tech Stack

| 🧩 Category       | 🛠️ Tool/Technology            |
| ----------------- | ------------------------------ |
| Database          | PostgreSQL                     |
| Language          | SQL + PL/pgSQL                 |
| Backend Scripting | Python (with psycopg2, pandas) |
| IDE & Utilities   | VSCode, DBeaver, CLI           |
| Version Control   | Git & GitHub                   |

🔐 Credentials (for Python) are stored securely in a `.env` file. Already excluded from Git using `.gitignore`.

---
## 🧠 Concepts Covered

* ✅ Relational DB design & normalization (1NF to 3NF)
* ✅ Foreign key constraints and integrity
* ✅ Stored Procedures with input validation
* ✅ Triggers and audit logging (AFTER INSERT)
* ✅ Window Functions (`ROW_NUMBER()`, `RANK()`)
* ✅ Common Table Expressions (CTEs)
* ✅ Indexing & performance analysis using `EXPLAIN ANALYZE`
* ✅ Python integration with SQL
* ✅ Query visualizations in Jupyter

---

## 📊 Analytics Queries

> Located in `queries/analytics_queries.sql` — full explanations in `extras/analytics_explained.md`


## 📊 Query Coverage Overview

**Covers:**

* 🔝 **Top 5 Doctors by Appointment Count**
* 📅 **Daily Appointments (7-day view)**
* 🏥 **Department-wise patient stats**
* 💊 **Top Prescribed Medicines**
* 🛏️ **Currently Admitted Patients**
* 🧾 **Latest Appointment per Patient**
* 📈 **Department Ranking via RANK()**
* ➕ **Re-admitted Patients (≥2)**
* ❌ **Doctors Without Any Appointments**
* 📊 **Average Appointments per Doctor**

Full explanations in `extras/analytics_explained.md`

---

## 📥 Setup Instructions

### 1. **Clone the Repository**

```bash
git clone https://github.com/your-username/hospital-sql-project.git
cd hospital-sql-project
```

### 2. **Create and Connect to PostgreSQL Database**

Make sure PostgreSQL is installed and running.

```bash
createdb hospital_db
```

*or use SQL:*

```sql
CREATE DATABASE hospital_db;
```

### 3. **Run Schema & Insert Sample Data**

Execute the schema and insert files:

```bash
psql -U postgres -d hospital_db -f schema/create_tables.sql
psql -U postgres -d hospital_db -f schema/insert_data.sql
```

If you're importing data from CSVs (as included):

```sql
\copy patients(name, gender, dob, contact) FROM 'data/patients.csv' DELIMITER ',' CSV HEADER;
\copy doctors(name, specialty, department_id) FROM 'data/doctors.csv' DELIMITER ',' CSV HEADER;
-- Add similar COPY commands for other tables
```

### 4. **Run Core Queries & Functions**

```bash
psql -U postgres -d hospital_db -f queries/analytics_queries.sql
psql -U postgres -d hospital_db -f queries/triggers_and_functions.sql
psql -U postgres -d hospital_db -f queries/stored_procedures.sql
```

---

## 📈 Optional: Python Integration (Jupyter Notebook)

Use the provided `.ipynb` in the `extras/` folder to:

* Connect to PostgreSQL using `psycopg2`
* Load data using `pandas`
* Use `.env` file for credentials (ensure it's in the same folder)
* Plot top queries using matplotlib

### .env Example (Not pushed to GitHub)

```ini
DB_NAME=hospital_db
DB_USER=postgres
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432
```

---

## 📤 How to Add Your Own Data

You can insert your own data in two ways:

### Option 1: Manual INSERT

```sql
INSERT INTO patients (name, gender, dob, contact)
VALUES ('John Doe', 'Male', '1990-01-01', '1234567890');
```

### Option 2: Use Stored Procedure

```sql
CALL insert_patient('John Doe', 'Male', '1990-01-01', '1234567890');
```

### Option 3: Import from CSV

Make sure your `.csv` file matches column order.

```sql
\copy patients(name, gender, dob, contact) FROM 'data/patients.csv' DELIMITER ',' CSV HEADER;
```

---
<a name="er-diagram"></a>

## 🖼️ ER Diagram

![ER Diagram](screenshots/er_diagram.png)

---

## 👨‍💻 Author

**Nivin Benny**  
Aspiring Data Scientist @ Brototype  
📫 [LinkedIn](https://www.linkedin.com/in/nivin-benny)
✉️ [nivinbennyvpz@gmail.com](mailto:nivinbennyvpz@gmail.com)

---

## 📎 License

This project is for educational and portfolio purposes only.

---

Feel free to ⭐️ this repo and share it if you find it helpful!

---

> Built with 💙 by Nivin Benny — Week 22 Capstone @ Brototype
