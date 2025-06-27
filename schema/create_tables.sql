CREATE TABLE patients (
  patient_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  gender TEXT CHECK (gender IN ('Male', 'Female', 'Other')),
  dob DATE,
  contact TEXT
);