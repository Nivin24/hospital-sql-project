-- Indexes for JOIN and GROUP BY performance
CREATE INDEX IF NOT EXISTS idx_appointments_doctor_id ON appointments(doctor_id);
CREATE INDEX IF NOT EXISTS idx_doctors_department_id ON doctors(department_id);

-- EXPLAIN ANALYZE 1: Top 5 Doctors by Appointments
EXPLAIN ANALYZE
SELECT d.name AS doctor_name, COUNT(a.appointment_id) AS appointment_count
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name
ORDER BY appointment_count DESC
LIMIT 5;

-- EXPLAIN ANALYZE 2: Patient Count by Department
EXPLAIN ANALYZE
SELECT dep.name AS department_name, COUNT(DISTINCT a.patient_id) AS patient_count
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dep ON d.department_id = dep.department_id
GROUP BY dep.name
ORDER BY patient_count DESC;

-- EXPLAIN ANALYZE 3: Department-Wise Appointment Ranking
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