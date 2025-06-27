--Top 5 Doctors by Number of Appointments
SELECT d.name AS doctor_name, COUNT(a.id) AS appointment_count
FROM doctors d
JOIN appointments a ON d.id = a.doctor_id
GROUP BY d.name
ORDER BY appointment_count DESC
LIMIT 5;

--Patient Count by Department
SELECT dep.name AS department_name, COUNT(DISTINCT a.patient_id) AS patient_count
FROM appointments a
JOIN doctors d ON a.doctor_id = d.id
JOIN departments dep ON d.department_id = dep.id
GROUP BY dep.name
ORDER BY patient_count DESC;

--List of Currently Admitted Patients (No Discharge Date)
SELECT p.name AS patient_name, r.room_number, a.admission_date
FROM admissions a
JOIN patients p ON a.patient_id = p.id
JOIN rooms r ON a.room_id = r.id
WHERE a.discharge_date IS NULL
ORDER BY a.admission_date;

--Most Prescribed Medicines (Top 5)
SELECT m.name AS medicine_name, COUNT(p.id) AS times_prescribed
FROM prescriptions p
JOIN medicines m ON p.medicine_id = m.id
GROUP BY m.name
ORDER BY times_prescribed DESC
LIMIT 5;

--Daily Appointment Count (Last 7 Days)
SELECT appointment_date, COUNT(*) AS total_appointments
FROM appointments
WHERE appointment_date >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY appointment_date
ORDER BY appointment_date DESC;

--Average Number of Appointments Per Doctor
SELECT d.name AS doctor_name, ROUND(AVG(sub.appointment_count), 2) AS avg_appointments
FROM doctors d
JOIN (
    SELECT doctor_id, COUNT(*) AS appointment_count
    FROM appointments
    GROUP BY doctor_id
) sub ON d.id = sub.doctor_id
GROUP BY d.name
ORDER BY avg_appointments DESC;

--Latest Appointment for Each Patient (Using Window Function)
SELECT *
FROM (
    SELECT 
        p.name AS patient_name,
        a.appointment_date,
        a.appointment_time,
        d.name AS doctor_name,
        ROW_NUMBER() OVER (PARTITION BY a.patient_id ORDER BY a.appointment_date DESC, a.appointment_time DESC) AS rn
    FROM appointments a
    JOIN patients p ON a.patient_id = p.id
    JOIN doctors d ON a.doctor_id = d.id
) sub
WHERE rn = 1;

--Department-Wise Appointment Ranking by Volume (CTE + RANK)
WITH dept_appointments AS (
    SELECT 
        dep.name AS department_name,
        COUNT(a.id) AS total_appointments
    FROM appointments a
    JOIN doctors d ON a.doctor_id = d.id
    JOIN departments dep ON d.department_id = dep.id
    GROUP BY dep.name
)
SELECT 
    department_name,
    total_appointments,
    RANK() OVER (ORDER BY total_appointments DESC) AS dept_rank
FROM dept_appointments;

--Patients with Multiple Admissions (≥2)
SELECT 
    p.name AS patient_name,
    COUNT(a.id) AS admission_count
FROM admissions a
JOIN patients p ON a.patient_id = p.id
GROUP BY p.name
HAVING COUNT(a.id) >= 2
ORDER BY admission_count DESC;

--Doctors Without Any Appointments
SELECT d.name AS doctor_name, dep.name AS department
FROM doctors d
JOIN departments dep ON d.department_id = dep.id
LEFT JOIN appointments a ON d.id = a.doctor_id
WHERE a.id IS NULL;