# 🏥 Hospital Analytics Management System (SQL Capstone Project)

## 📌 Project Overview

This project is a **PostgreSQL-based Hospital Management System**, built as part of my Week 22 capstone at **Brototype**.  
It demonstrates **real-world healthcare data management**, with deep SQL logic, automation, analytics, and performance optimization.

---

## 🚀 Features

- ✅ Fully normalized relational schema (1NF → 3NF)
- ✅ Realistic hospital datasets: patients, doctors, appointments, admissions, prescriptions
- ✅ **Triggers** for automated logging
- ✅ **Stored procedures** with input validation
- ✅ **Functions** for reusable logic
- ✅ **Analytics queries** using JOINs, CTEs, window functions
- ✅ **Performance tuning** with indexes & `EXPLAIN ANALYZE`
- ✅ Python integration (optional) via `psycopg2` and `pandas`

---

## 🧱 Project Structure

hospital-sql-project/
├── README.md                      # ✅ Project overview and usage guide
├── schema/                        # 📁 DB schema and data
│   ├── create_tables.sql          # Table creation scripts
│   ├── insert_data.sql            # COPY from CSVs
├── queries/                       # 📁 SQL logic layer
│   ├── analytics_queries.sql      # Joins, aggregates, CTEs, etc.
│   ├── triggers_and_functions.sql # Triggers + PL/pgSQL logic
│   └── optimization_notes.sql     # Indexing + EXPLAIN ANALYZE
├── data/                          # 📁 CSV files for patient, doctor, medicine, etc.
│   ├── patients.csv
│   ├── appointments.csv
│   └── ... (other tables)
├── explain_outputs/               # 📁 Performance analysis output
│   └── query_analysis.txt         # EXPLAIN ANALYZE results
├── extras/                        # 📁 Extended docs and insights
│   ├── analytics_explained.md     # Detailed markdown for each analytical SQL query
│   └── hospital_analysis.ipynb    # (Optional) Python Jupyter notebook
└── screenshots/
    └── er_diagram.png             # ER diagram image

---

---

## 🧠 Concepts Covered

- ✅ Relational DB design & normalization (1NF to 3NF)
- ✅ Foreign key constraints and integrity
- ✅ Stored Procedures with input validation
- ✅ Triggers and audit logging (AFTER INSERT)
- ✅ Window Functions (`ROW_NUMBER()`, `RANK()`)
- ✅ Common Table Expressions (CTEs)
- ✅ Indexing & performance analysis using `EXPLAIN ANALYZE`

---

## 🛠️ Tech Stack

| Component     | Tool                   |
|---------------|------------------------|
| Database      | PostgreSQL             |
| Language      | SQL + PL/pgSQL         |
| Optional API  | Python (psycopg2, pandas) |
| Versioning    | Git & GitHub           |
| Tools         | VSCode, DBeaver, CLI   |

---

## 📊 Analytics Queries

Found in `queries/analytics_queries.sql`, and explained in detail inside:
- `extras/analytics_explained.md`

### ✅ **Covers:**

- 🔝 **Top 5 Doctors by Appointment Count**  
  Identify the most consulted doctors based on the number of appointments.

- 🏥 **Patient Count by Department**  
  Analyze which departments handle the highest number of unique patients.

- 🛏️ **Currently Admitted Patients**  
  List patients who are currently admitted (no discharge date).

- 💊 **Top Prescribed Medicines**  
  Find the most frequently prescribed medicines.

- 📅 **Daily Appointments (7-day view)**  
  View how many appointments were scheduled per day over the last week.

- ⚖️ **Average Number of Appointments Per Doctor**  
  Calculate how busy each doctor is on average.

- 🧾 **Latest Appointment per Patient (Window Function)**  
  Use ROW_NUMBER to extract the most recent appointment for each patient.

- 📈 **Department Ranking by Appointment Volume (CTE + RANK)**  
  Rank departments based on the total number of appointments.

- ➕ **Re-admitted Patients (≥2 Admissions)**  
  Identify patients who have been admitted multiple times.

- ❌ **Doctors Without Any Appointments**  
  Highlight doctors who currently have no appointments.


---

## ⚙️ Setup Instructions

1. **Clone the repository:**

```bash
git clone https://github.com/your-username/hospital-sql-project.git
cd hospital-sql-project
```

2. **Create and connect to PostgreSQL database:**
- Ensure PostgreSQL is installed and running.

```bash
createdb hospital_db
```

or 

```sql
CREATE DATABASE hospital_db;
```

3. **Execute Schema and Load Sample Data**

Run the following commands to set up your tables and insert sample data:

```bash
psql -U postgres -d hospital_db -f schema/create_tables.sql
psql -U postgres -d hospital_db -f schema/insert_data.sql
```
💡 Note:
The insert_data.sql script includes \COPY commands to import data from CSV files located in the /data folder.

4. **Run All SQL Queries and Logic Files**

Execute the following files one by one:

```bash
psql -U postgres -d hospital_db -f queries/analytics_queries.sql
psql -U postgres -d hospital_db -f queries/triggers_and_functions.sql
psql -U postgres -d hospital_db -f queries/stored_procedures.sql
psql -U postgres -d hospital_db -f queries/optimization_notes.sql
```

5. **(Optional) Python Integration**

If you want to use Python for interacting with PostgreSQL (data retrieval, analysis, visualizations):

1.	Navigate to the extras/ folder:
```bash
cd hospital-sql-project/extras
```

2.	Run the notebook:

```bash
jupyter notebook hospital_analysis.ipynb
```

📌 This notebook connects to the PostgreSQL database using psycopg2 and fetches results into pandas DataFrames.

6. **(Optional) Add Your Own Data**
	•	Replace or modify the CSV files inside the /data folder
	•	Update the insert_data.sql file if schema or format changes
	•	Or manually insert records using standard SQL:

```sql
INSERT INTO patients (name, gender, dob, contact)
VALUES ('John Doe', 'Male', '1990-01-01', '1234567890');
```

	•	Or, if you’ve enabled stored procedures for inserting data, use:

    ```sql
    CALL insert_patient('John Doe', 'Male', '1990-01-01', '1234567890');
    ```

---

## 🖼️ ER Diagram

![ER Diagram](screenshots/er_diagram.png)

---

## 👨‍💻 Author

- **Nivin Benny**
- Aspiring Data Scientist @ Brototype
- 📫 [LinkedIn](https://www.linkedin.com/in/nivinbenny) *(Add your real link)*