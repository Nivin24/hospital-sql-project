--Patients Table
CREATE TABLE patients (
  patient_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  gender TEXT CHECK (gender IN ('Male', 'Female', 'Other')),
  dob DATE,
  contact TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--Departments Table
CREATE TABLE departments (
  department_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT
);
--Doctors Table
CREATE TABLE doctors (
  doctor_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  specialization TEXT,
  department_id INT REFERENCES departments(department_id),
  contact TEXT,
  email TEXT UNIQUE
);
--Appointments Table
CREATE TABLE appointments (
  appointment_id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES patients(patient_id),
  doctor_id INT REFERENCES doctors(doctor_id),
  appointment_date DATE NOT NULL,
  appointment_time TIME NOT NULL,
  status TEXT DEFAULT 'Scheduled' CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')),
  notes TEXT
);
--Medicines Table
CREATE TABLE medicines (
  medicine_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  manufacturer TEXT,
  dosage TEXT
);
--Prescriptions Table
CREATE TABLE prescriptions (
  prescription_id SERIAL PRIMARY KEY,
  appointment_id INT REFERENCES appointments(appointment_id),
  medicine_id INT REFERENCES medicines(medicine_id),
  dosage_instruction TEXT,
  quantity INT CHECK (quantity > 0)
);
--Rooms Table
CREATE TABLE rooms (
  room_id SERIAL PRIMARY KEY,
  room_number TEXT NOT NULL UNIQUE,
  room_type TEXT CHECK (room_type IN ('General', 'Semi-Private', 'Private', 'ICU')),
  is_available BOOLEAN DEFAULT TRUE
);
--Admissions Table
CREATE TABLE admissions (
  admission_id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES patients(patient_id),
  room_id INT REFERENCES rooms(room_id),
  admission_date DATE NOT NULL,
  discharge_date DATE,
  reason TEXT
);