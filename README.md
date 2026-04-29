Medical_Records

Medical Records Management System (MySQL)
A relational database schema designed to manage patient lifecycles within a healthcare facility. This project focuses on structured data entry, automated status tracking, and clinical documentation for high-efficiency medical environments.

🏥 Core Features
Integrated Patient Lifecycle: Tracks a patient from initial arrival through diagnostic services and final discharge.

Automated Business Logic: Utilizes MySQL Generated Columns to automatically calculate "Yes/No" statuses (e.g., Physician Approval, COVID-19 Vaccination) based on active record flags.

Data Integrity: Implements strict ENUM types for hospitals, specific medical complaints, and attending physicians to ensure standardized reporting.

Dynamic Scheduling: Automatically calculates follow-up checkup dates (7-day intervals) using SQL temporal functions.

📊 Database Schema Overview
The system is organized into four primary tables within the Medical_Records database:

1. Patient Records (Medical_Records)
The foundational table containing PII (Personally Identifiable Information) including contact details, addresses, and admission timestamps.

2. Medical Service (Medical_Service)
Handles the clinical and research aspect of the patient's stay, including:

Protocol development and clinical trial tracking.

External consultant assignments via physician-specific ENUMs.

Lab report and recommendation documentation.

3. Patient Chart (Patient_Chart)
The active clinical record used during the patient's stay.

Main Complaint Tracking: Categorizes visits into 18+ specific medical emergencies (e.g., Sepsis, Stroke symptoms, Triage categories).

History & Allergies: Automated flags for medical history availability and known allergies.

4. Patient Discharge Form (Patient_Discharge_Form)
Finalizes the patient stay with:

Discharge Logic: Categorizes the reason for discharge (e.g., Clinical Stability, AMA, or Transfer).

Automated Follow-up: Generates a Next_Checkup_Date exactly 7 days post-discharge.

Summary of Care: Captures treatment summaries and specific medication provided.

🛠️ Technical Implementation
Language: MySQL

Tooling: Developed and tested in MySQL Workbench.

Key SQL Concepts: ENUM data types, VIRTUAL generated columns, DATETIME defaults, and PRIMARY KEY indexing.
