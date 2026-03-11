CREATE TABLE anomaly_feedback (
    id INT IDENTITY(1,1) PRIMARY KEY,
    record_id INT,
    anomaly_type VARCHAR(50),
    user_feedback VARCHAR(50), -- e.g. 'true_anomaly' or 'false_positive'
    comments NVARCHAR(255),
    feedback_timestamp DATETIME DEFAULT GETDATE()
);
INSERT INTO anomaly_feedback (record_id, anomaly_type, user_feedback, comments)
VALUES 
(15, 'rule_based', 'false_positive', 'Salary spike due to annual bonus'),
(42, 'ml_based', 'true_anomaly', 'Confirmed by HR manager'),
(88, 'ml_based', 'false_positive', 'New role introduced with higher pay');

ALTER TABLE anomaly_feedback
ADD user_is_anomaly BIT;  

UPDATE anomaly_feedback
SET user_is_anomaly = 
    CASE 
        WHEN user_feedback = 'true_anomaly' THEN 1
        WHEN user_feedback = 'false_positive' THEN 0
        ELSE NULL
    END;
