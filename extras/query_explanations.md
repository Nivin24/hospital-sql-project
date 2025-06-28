# 📊 Analytics Queries Explained

This document explains the purpose, logic, and importance of each analytics query used in this project.

---

## Table of Contents
1. [Top 5 Doctors by Number of Appointments](#-1-top-5-doctors-by-number-of-appointments)
2. [Patient Count by Department](#-2-patient-count-by-department)
3. [List of Currently Admitted Patients](#-3-list-of-currently-admitted-patients)
4. [Most Prescribed Medicines (Top 5)](#-4-most-prescribed-medicines-top-5)
5. [Daily Appointment Count (Last 7 Days)](#-5-daily-appointment-count-last-7-days)
6. [Average Number of Appointments Per Doctor](#-6-average-number-of-appointments-per-doctor)
7. [Latest Appointment for Each Patient (Using Window Function)](#-7-latest-appointment-for-each-patient-using-window-function)
8. [Department-Wise Appointment Ranking by Volume (CTE + RANK)](#department-wise-ranking)
9. [Patients with Multiple Admissions (≥2)](#multiple-admissions)
10. [Doctors Without Any Appointments](#-10-doctors-without-any-appointments)

## 🔹 1. Top 5 Doctors by Number of Appointments

```sql
SELECT d.name AS doctor_name, COUNT(a.appointment_id) AS appointment_count
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name
ORDER BY appointment_count DESC
LIMIT 5;

```
**Purpose**: Identify the most frequently consulted doctors.

**Logic**: Joins the doctors and appointments tables, groups by doctor name, and counts how many appointments each doctor has.

**Use Case**: Helps hospital admins recognize high-demand doctors and optimize scheduling or support.

## 🔹 2. Patient Count by Department

```sql
SELECT dep.name AS department_name, COUNT(DISTINCT a.patient_id) AS patient_count
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dep ON d.department_id = dep.department_id
GROUP BY dep.name
ORDER BY patient_count DESC;

```

**Purpose**: Determine which departments see the highest number of unique patients.

**Logic**: Traverses relationships from appointments → doctors → departments, and counts distinct patients per department.

**Use Case**: Used for departmental load analysis and resource allocation.

## 🔹 3. List of Currently Admitted Patients

```sql
SELECT p.name AS patient_name, r.room_number, a.admission_date
FROM admissions a
JOIN patients p ON a.patient_id = p.id
JOIN rooms r ON a.room_id = r.id
WHERE a.discharge_date IS NULL
ORDER BY a.admission_date;

```

**Purpose**: View patients who are currently admitted.

**Logic**: Filters the admissions table for rows with no discharge date.

**Use Case**: Useful for real-time hospital room occupancy status.

---

## 🔹 4. Most Prescribed Medicines (Top 5)

```sql
SELECT m.name AS medicine_name, COUNT(p.prescription_id) AS times_prescribed
FROM prescriptions p
JOIN medicines m ON p.medicine_id = m.medicine_id
GROUP BY m.name
ORDER BY times_prescribed DESC
LIMIT 5;

```

**Purpose**: Identify the medicines that are prescribed most frequently.

**Logic**: Joins prescriptions with medicines, counts how many times each medicine was prescribed.

**Use Case**: Helps in inventory planning, bulk procurement, and understanding treatment trends.

## 🔹 5. Daily Appointment Count (Last 7 Days)

```sql
SELECT appointment_date, COUNT(*) AS total_appointments
FROM appointments
WHERE appointment_date >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY appointment_date
ORDER BY appointment_date DESC;

```

**Purpose**: Track how many appointments occurred each day in the last week.

**Logic**: Filters recent appointments by date and groups them by each day.

**Use Case**: Useful for visualizing traffic patterns and peak booking days.

## 🔹 6. Average Number of Appointments Per Doctor

```sql
SELECT d.name AS doctor_name, ROUND(AVG(sub.appointment_count), 2) AS avg_appointments
FROM doctors d
JOIN (
    SELECT doctor_id, COUNT(*) AS appointment_count
    FROM appointments
    GROUP BY doctor_id
) sub ON d.doctor_id = sub.doctor_id
GROUP BY d.name
ORDER BY avg_appointments DESC;

```

**Purpose**: Understand how busy each doctor is on average.

**Logic**: Subquery computes total appointments per doctor, then outer query joins with doctors to calculate average.

**Use Case**: Helps distribute workload fairly or identify under-booked doctors.

---

## 🔹 7. Latest Appointment for Each Patient (Using Window Function)

```sql
SELECT *
FROM (
    SELECT 
        p.name AS patient_name,
        a.appointment_date,
        a.appointment_time,
        d.name AS doctor_name,
        ROW_NUMBER() OVER (
            PARTITION BY a.patient_id 
            ORDER BY a.appointment_date DESC, a.appointment_time DESC
        ) AS rn
    FROM appointments a
    JOIN patients p ON a.patient_id = p.patient_id
    JOIN doctors d ON a.doctor_id = d.doctor_id
) sub
WHERE rn = 1;

```
**Purpose**: Get the most recent appointment for each patient.

**Logic**: Uses a window function (ROW_NUMBER()) to rank appointments for each patient by date and time, then selects only the most recent (rn = 1).

**Use Case**: Useful for tracking the last visit of patients, sending follow-up reminders, or audit logs.
<a name="department-wise-ranking"></a>
## 🔹 8. Department-Wise Appointment Ranking by Volume (CTE + RANK)

```sql
WITH dept_appointments AS (
    SELECT 
        dep.name AS department_name,
        COUNT(a.appointment_id) AS total_appointments
    FROM appointments a
    JOIN doctors d ON a.doctor_id = d.doctor_id
    JOIN departments dep ON d.department_id = dep.department_id
    GROUP BY dep.name
)
SELECT 
    department_name,
    total_appointments,
    RANK() OVER (ORDER BY total_appointments DESC) AS dept_rank
FROM dept_appointments;

```

**Purpose**: Rank departments based on the number of appointments handled.

**Logic**: A CTE (WITH) is used to aggregate appointment counts per department, and RANK() assigns a rank based on volume.

**Use Case**: Helps in analyzing high-demand departments and allocating resources accordingly.
<a name="multiple-admissions"></a>
## 🔹 9. Patients with Multiple Admissions (≥2)

```sql
SELECT 
    p.name AS patient_name,
    COUNT(a.admission_id) AS admission_count
FROM admissions a
JOIN patients p ON a.patient_id = p.patient_id
GROUP BY p.name
HAVING COUNT(a.admission_id) >= 2
ORDER BY admission_count DESC;

```

**Purpose**: Identify patients who have been admitted more than once.

**Logic**: Groups by patient, counts their admissions, and filters with HAVING.

**Use Case**: Useful for analyzing chronic conditions, readmissions, or high-care patients.

## 🔹 10. Doctors Without Any Appointments

```sql
SELECT d.name AS doctor_name, dep.name AS department
FROM doctors d
JOIN departments dep ON d.department_id = dep.department_id
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.appointment_id IS NULL;
```

**Purpose**: Find doctors who currently have no appointments.

**Logic**: Uses a LEFT JOIN and filters where the join did not match any appointments.

**Use Case**: Can be used to investigate staffing inefficiencies or onboarding of new doctors.

