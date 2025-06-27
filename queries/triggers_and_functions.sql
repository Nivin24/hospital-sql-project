-- Function: Log inserts into patients table
CREATE OR REPLACE FUNCTION log_patient_insert()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO user_audit(user_id, action)
  VALUES (NEW.patient_id, 'INSERT INTO patients');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: When a new patient is added
CREATE TRIGGER trigger_log_patient_insert
AFTER INSERT ON patients
FOR EACH ROW
EXECUTE FUNCTION log_patient_insert();