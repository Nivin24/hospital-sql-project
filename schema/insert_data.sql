-- Load departments
COPY departments(name, description)
FROM '/Users/nivinbenny/Documents/Data Science/SQL/hospital-sql-project/data/departments.csv'
DELIMITER ','
CSV HEADER;

-- Load rooms
COPY rooms(room_number, room_type, is_available)
FROM '/Users/nivinbenny/Documents/Data Science/SQL/hospital-sql-project/data/rooms.csv'
DELIMITER ','
CSV HEADER;

-- Load medicines
COPY medicines(name, manufacturer, dosage)
FROM '/Users/nivinbenny/Documents/Data Science/SQL/hospital-sql-project/data/medicines.csv'
DELIMITER ','
CSV HEADER;

-- Load patients
COPY patients(name, gender, dob, contact)
FROM '/Users/nivinbenny/Documents/Data Science/SQL/hospital-sql-project/data/patients.csv'
DELIMITER ','
CSV HEADER;

-- Load doctors
COPY doctors(name, specialization, department_id, contact, email)
FROM '/Users/nivinbenny/Documents/Data Science/SQL/hospital-sql-project/data/doctors.csv'
DELIMITER ','
CSV HEADER;

-- Load appointments
COPY appointments(patient_id, doctor_id, appointment_date, appointment_time, status, notes)
FROM '/Users/nivinbenny/Documents/Data Science/SQL/hospital-sql-project/data/appointments.csv'
DELIMITER ','
CSV HEADER;

-- Load prescriptions
COPY prescriptions(appointment_id, medicine_id, dosage_instruction, quantity)
FROM '/Users/nivinbenny/Documents/Data Science/SQL/hospital-sql-project/data/prescriptions.csv'
DELIMITER ','
CSV HEADER;

-- Load admissions
COPY admissions(patient_id, room_id, admission_date, discharge_date, reason)
FROM '/Users/nivinbenny/Documents/Data Science/SQL/hospital-sql-project/data/admissions.csv'
DELIMITER ','
CSV HEADER;