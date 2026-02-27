CREATE DATABASE heart_disease_db;
USE heart_disease_db;

CREATE TABLE heart_data (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    HeartDisease ENUM('Yes','No') NOT NULL,
    BMI DECIMAL(5,2) NOT NULL,
    Smoking ENUM('Yes','No') NOT NULL,
    AlcoholDrinking ENUM('Yes','No') NOT NULL,
    Stroke ENUM('Yes','No') NOT NULL,
    PhysicalHealth INT NOT NULL,
    MentalHealth INT NOT NULL,
    DiffWalking ENUM('Yes','No') NOT NULL,
    Sex ENUM('Male','Female') NOT NULL,
    AgeCategory ENUM(
        '18-24','25-29','30-34','35-39','40-44','45-49','50-54',
        '55-59','60-64','65-69','70-74','75-79','80 or older') NOT NULL,
    Race ENUM(
        'White','Black','Asian','American Indian/Alaskan Native',
        'Hispanic','Other') NOT NULL,
    Diabetic ENUM('Yes','No','No, borderline diabetes','Yes (during pregnancy)') NOT NULL,
    PhysicalActivity ENUM('Yes','No') NOT NULL,
    GenHealth ENUM('Poor','Fair','Good','Very good','Excellent') NOT NULL,
    SleepTime INT NOT NULL,
    Asthma ENUM('Yes','No') NOT NULL,
    KidneyDisease ENUM('Yes','No') NOT NULL,
    SkinCancer ENUM('Yes','No') NOT NULL
);


SELECT COUNT(*) AS total_records FROM heart_data;

SELECT * FROM heart_data LIMIT 10;

-- NULL VALUES
SELECT
  SUM(HeartDisease IS NULL) AS null_HeartDisease,
  SUM(BMI IS NULL) AS null_BMI,
  SUM(Smoking IS NULL) AS null_Smoking,
  SUM(AlcoholDrinking IS NULL) AS null_AlcoholDrinking,
  SUM(Stroke IS NULL) AS null_Stroke,
  SUM(PhysicalHealth IS NULL) AS null_PhysicalHealth,
  SUM(MentalHealth IS NULL) AS null_MentalHealth,
  SUM(DiffWalking IS NULL) AS null_DiffWalking,
  SUM(Sex IS NULL) AS null_Sex,
  SUM(AgeCategory IS NULL) AS null_AgeCategory,
  SUM(Race IS NULL) AS null_Race,
  SUM(Diabetic IS NULL) AS null_Diabetic,
  SUM(PhysicalActivity IS NULL) AS null_PhysicalActivity,
  SUM(GenHealth IS NULL) AS null_GenHealth,
  SUM(SleepTime IS NULL) AS null_SleepTime,
  SUM(Asthma IS NULL) AS null_Asthma,
  SUM(KidneyDisease IS NULL) AS null_KidneyDisease,
  SUM(SkinCancer IS NULL) AS null_SkinCancer
FROM heart_data;

-- UNIQUE VALUES 
SELECT DISTINCT HeartDisease FROM heart_data;
SELECT DISTINCT Sex FROM heart_data;
SELECT DISTINCT Smoking FROM heart_data;
SELECT DISTINCT GenHealth FROM heart_data;
SELECT DISTINCT Diabetic FROM heart_data;

SELECT * 
FROM heart_data
WHERE HeartDisease = 'Yes';

SELECT *
FROM heart_data
WHERE AgeCategory IN ('40-44','45-49','50-54','55-59');

ALTER TABLE heart_data
ADD COLUMN BMI_Category VARCHAR(20);
UPDATE heart_data
SET BMI_Category =
  CASE
    WHEN BMI < 18.5 THEN 'Underweight'
    WHEN BMI < 25 THEN 'Normal'
    WHEN BMI < 30 THEN 'Overweight'
    ELSE 'Obese'
  END;

ALTER TABLE heart_data
ADD COLUMN Age_Group VARCHAR(20);
UPDATE heart_data
SET Age_Group =
  CASE
    WHEN AgeCategory IN ('18-24','25-29','30-34') THEN '18-34'
    WHEN AgeCategory IN ('35-39','40-44','45-49') THEN '35-49'
    WHEN AgeCategory IN ('50-54','55-59','60-64') THEN '50-64'
    WHEN AgeCategory IN ('65-69','70-74','75-79') THEN '65-79'
    ELSE '80+'
  END;

ALTER TABLE heart_data
ADD COLUMN High_Risk VARCHAR(10);
UPDATE heart_data
SET High_Risk =
  CASE
    WHEN Smoking = 'Yes'
      OR Stroke = 'Yes'
      OR KidneyDisease = 'Yes'
      OR Diabetic IN ('Yes','No, borderline diabetes','Yes (during pregnancy)')
      OR BMI >= 30
    THEN 'High'
    ELSE 'Low'
  END;

CREATE VIEW tableau_heart_view AS
SELECT
    PatientID,
    HeartDisease,
    BMI,
    BMI_Category,
    Smoking,
    AlcoholDrinking,
    Stroke,
    PhysicalHealth,
    MentalHealth,
    DiffWalking,
    Sex,
    AgeCategory,
    Age_Group,
    Race,
    Diabetic,
    PhysicalActivity,
    GenHealth,
    SleepTime,
    Asthma,
    KidneyDisease,
    SkinCancer,
    High_Risk
FROM heart_data;

SELECT * FROM tableau_heart_view LIMIT 20;
