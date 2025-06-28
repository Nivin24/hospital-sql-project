-- Procedure to insert a new patient with gender validation

CREATE OR REPLACE PROCEDURE insert_patient(
    name TEXT,
    gender TEXT,
    dob DATE,
    contact TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Gender validation
    IF gender NOT IN ('Male', 'Female', 'Other') THEN
        RAISE EXCEPTION 'Invalid gender: %. Must be Male, Female, or Other.', gender;
    END IF;

    -- Insert into patients table
    INSERT INTO patients(name, gender, dob, contact)
    VALUES (name, gender, dob, contact);

    RAISE NOTICE '✅ New patient inserted: %', name;
END;
$$;