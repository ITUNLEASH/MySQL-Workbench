CREATE DATABASE Medical_Records;

USE Medical_Records;

-- In MySQL, the hierarchy is always database_name.table_name Don't forge the DOT between the database and the table.

CREATE TABLE Medical_Records.Medical_Invoice
(
	PatientID INT PRIMARY KEY,
	Address_Line VARCHAR(60) NOT NULL,
	City VARCHAR(60) NOT NULL,
	State VARCHAR(60) NOT NULL,
    Zip_Code VARCHAR(5) NOT NULL,
	First_Name VARCHAR(60) NOT NULL,
	Last_Name VARCHAR(60) NOT NULL,
	Home_Number VARCHAR(10) NULL,
	Mobile_Number VARCHAR(10) NOT NULL,
    Email_Address VARCHAR(80) NOT NULL,
	Admission_Date DATETIME NOT NULL 
);

CREATE TABLE Medical_Records.Medical_Service
(
    PatientID INT PRIMARY KEY,
    -- We need the actual data column to drive the logic below
    is_active TINYINT(1) DEFAULT 1, 
    
    Protocol_Development VARCHAR(300) NOT NULL,
    
    -- Generated columns for your statuses
    Clinical_Trial_Status VARCHAR(3) AS (CASE WHEN is_active = 1 THEN 'Yes' ELSE 'No' END),
    Safety_Reporting_Status VARCHAR(3) AS (CASE WHEN is_active = 1 THEN 'Yes' ELSE 'No' END),
    Sponsor_Collab_Status VARCHAR(3) AS (CASE WHEN is_active = 1 THEN 'Yes' ELSE 'No' END),
    
    Finding_Reviews VARCHAR(300) NOT NULL,
    External_Consultants ENUM('Dr. FistName LastName', 'Dr. FistName LastName', 'Dr. FistName LastName', 'Dr. FistName LastName', 'Dr. Call Lightman') NOT NULL,
    Recomendations VARCHAR(300) NOT NULL,
    Lab_Reports VARCHAR(300) NOT NULL
);

CREATE TABLE Medical_Records.Patient_Chart
(
    Medical_Chart_Number INT, -- Changed to FLOAT for precision
    Hopsital_Name ENUM('Guam Healthcare', 'Healing Hands', 'Loma Linda SDA Hospital', 'Hospital La Carlota', 'Intermountain Health') NOT NULL,
    PatientID INT PRIMARY KEY,
    First_Name VARCHAR(60) NOT NULL,
    Last_Name VARCHAR(60) NOT NULL,
    Admission_Date DATETIME NOT NULL,
    Initial_Exam VARCHAR(300) NOT NULL,
    Main_Complaint ENUM(
        'Abdominal Pain', 'Chest pain or Pressure', 'Dyspnea/Shortness of Breath', 
        'High Fever', 'Severe Headache/Migraine', 'Lacerations/Cuts/Deep wounds',
        'Broken bones/Fractures/Sprains', 'Back Pain', 'Dizziness/Vertigo', 
        'Syncope/Fainting/Passing out', 'Diarrhea/Vomiting/Gastroenteritis', 
        'Stroke symptoms (weakness/drooping)', 'Skin infections/Cellulitis', 
        'Allergic reaction/Anaphylaxis', 'Asthma/COPD exacerbation',
        'Sepsis/Infection', 'Urinary Tract Infection/Dysuria', 'Kidney stones'
    ),
    
    -- Added this column so your generated logic works
    is_active TINYINT(1) DEFAULT 1, 

    Medical_History_Provided VARCHAR(3) AS (CASE WHEN is_active = 1 THEN 'Yes' ELSE 'No' END),
    Known_Allergies VARCHAR(3) AS (CASE WHEN is_active = 1 THEN 'Yes' ELSE 'No' END),
    Medication_and_Dosages LONGTEXT
);


CREATE TABLE Medical_Records.Patient_Discharge_Form
(
    PatientID INT PRIMARY KEY,
    First_Name VARCHAR(60) NOT NULL,
    Last_Name VARCHAR(60) NOT NULL,
    Address_Line VARCHAR(60) NOT NULL,
    City VARCHAR(60) NOT NULL,
    State VARCHAR(60) NOT NULL,
    Zip_Code VARCHAR(5) NOT NULL,
    Home_Number VARCHAR(10) NULL,
    Mobile_Number VARCHAR(10) NOT NULL,
    Hopsital_Name ENUM('Guam Healthcare', 'Healing Hands') NOT NULL,
    
    -- Corrected: Use DATETIME type with a DEFAULT value
    Discharge_Date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    
    -- Added: The source column for your CASE logic
    is_active TINYINT(1) DEFAULT 1,

    -- Corrected: Generated columns (Note: they cannot be NOT NULL in some MySQL versions)
    COVID_19_Vaccine VARCHAR(3) AS (CASE WHEN is_active = 1 THEN 'Yes' ELSE 'No' END),
    Physician_Approval VARCHAR(3) AS (CASE WHEN is_active = 1 THEN 'Yes' ELSE 'No' END),
    
    -- Corrected: This must be a Generated Column to use a function like DATE_ADD
    Next_Checkup_Date DATETIME AS (DATE_ADD(Discharge_Date, INTERVAL 7 DAY)),

    Reason_for_Admission ENUM(
        'Abdominal Pain', 'Chest pain or Pressure', 'Dyspnea/Shortness of Breath', 
        'High Fever', 'Severe Headache/Migraine', 'Lacerations/Cuts/Deep wounds',
        'Broken bones/Fractures/Sprains', 'Back Pain', 'Dizziness/Vertigo', 
        'Syncope/Fainting/Passing out', 'Diarrhea/Vomiting/Gastroenteritis', 
        'Stroke symptoms (weakness/drooping)', 'Skin infections/Cellulitis', 
        'Allergic reaction/Anaphylaxis', 'Asthma/COPD exacerbation',
        'Sepsis/Infection', 'Urinary Tract Infection/Dysuria', 'Kidney stones') NOT NULL,
    
    Reason_for_Discharge ENUM(
        'Deceased','Clinical Stability','Recovery/Treatment Completion',
        'Achievement of Independence (ADLs)', 'Sufficient Wound Healing', 'Stabilized Medication Regimen',
        'Pain Management Controlled', 'Transition to Skilled Nursing Facility (SNF)', 
        'Stable Home Support System', 'Prevention of Hospital-Acquired Infections',
        'Patient Wishes (Discharge Against Medical Advice)', 'Administrative/Insurance Reasons') NOT NULL,
    
    Treatment_Summary VARCHAR(200) NOT NULL,
    Medication_Provided VARCHAR(3) AS (CASE WHEN is_active = 1 THEN 'Yes' ELSE 'No' END),
    Discharge_Doctor ENUM('Dr. George Britton', 'Dr. Nathalia Serna', 'Dr. Brianna Britton', 'Dr. Jayden Britton', 'Dr. Call Lightman') NOT NULL
);
