-- Load departments
COPY departments(name, description)
FROM 'data/departments.csv'
DELIMITER ','
CSV HEADER;

-- Load rooms
COPY rooms(room_number, room_type, is_available)
FROM 'data/rooms.csv'
DELIMITER ','
CSV HEADER;

-- Load medicines
COPY medicines(name, manufacturer, dosage)
FROM 'data/medicines.csv'
DELIMITER ','
CSV HEADER;

-- Load patients
COPY patients(name, gender, dob, contact)
FROM 'data/patients.csv'
DELIMITER ','
CSV HEADER;

-- Load doctors
COPY doctors(name, specialization, department_id, contact, email)
FROM 'data/doctors.csv'
DELIMITER ','
CSV HEADER;

-- Load appointments
COPY appointments(patient_id, doctor_id, appointment_date, appointment_time, status, notes)
FROM 'data/appointments.csv'
DELIMITER ','
CSV HEADER;

-- Load prescriptions
COPY prescriptions(appointment_id, medicine_id, dosage_instruction, quantity)
FROM 'data/prescriptions.csv'
DELIMITER ','
CSV HEADER;

-- Load admissions
COPY admissions(patient_id, room_id, admission_date, discharge_date, reason)
FROM 'data/admissions.csv'
DELIMITER ','
CSV HEADER;