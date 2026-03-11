# Explainable & Adaptive Anomaly Detection for Automated Data Cleaning

An end-to-end data cleaning and anomaly detection framework that combines **rule-based statistical methods, machine learning, explainable AI, and human feedback**.
The system identifies anomalous records in large datasets, explains model decisions using **SHAP**, and continuously improves detection accuracy through an **adaptive human-in-the-loop feedback mechanism** integrated with **SQL Server**.

---

# Project Overview

Data quality is a critical challenge in modern data-driven systems. Real-world datasets often contain:

* Missing values
* Inconsistent formatting
* Extreme or erroneous values
* Data entry mistakes

Traditional rule-based cleaning methods lack adaptability, while machine learning models often lack interpretability.

This project proposes a **hybrid anomaly detection pipeline** that integrates:

• Statistical rule-based detection (IQR method)
• Machine learning anomaly detection (Isolation Forest)
• Explainable AI using SHAP
• Human-in-the-loop adaptive retraining
• SQL Server database integration

The framework automatically cleans data, identifies anomalies, explains why anomalies occur, and updates the model based on human feedback.

---

# Dataset

Dataset: **Data Science Job Salaries Dataset**

Records: **151,445 rows**

Features included:

| Feature            | Description                    |
| ------------------ | ------------------------------ |
| work_year          | Year the salary was paid       |
| experience_level   | Entry, Mid, Senior, Executive  |
| employment_type    | Full-time, Part-time, Contract |
| job_title          | Job role                       |
| salary             | Salary in local currency       |
| salary_currency    | Currency code                  |
| salary_in_usd      | Salary converted to USD        |
| employee_residence | Country of employee            |
| remote_ratio       | Remote work percentage         |
| company_location   | Company country                |
| company_size       | Company size (S/M/L)           |

---

# System Architecture

Pipeline workflow:

```
SQL Server Database
        │
        ▼
Data Loading (Python + SQLAlchemy)
        │
        ▼
Data Cleaning (Pandas)
        │
        ▼
Synthetic Anomaly Injection
        │
        ▼
Rule-Based Detection (IQR)
        │
        ▼
ML Detection (Isolation Forest)
        │
        ▼
Explainability (SHAP)
        │
        ▼
Human Feedback (SQL Table)
        │
        ▼
Adaptive Model Retraining
```

---

# Key Results

| Metric                        | Result          |
| ----------------------------- | --------------- |
| Dataset size                  | 151,445 records |
| Injected synthetic anomalies  | 757             |
| Rule-based anomalies detected | 1077            |
| ML-based anomalies detected   | 756             |
| Overlap between both methods  | 345             |
| Human feedback entries        | 3               |
| False positives corrected     | 2               |

The adaptive feedback loop helped refine anomaly detection and reduce misclassification.

---

# Anomaly Detection Methods

## Rule-Based Detection (IQR)

Uses the Interquartile Range method to identify extreme values.

Formula:

```
Lower Bound = Q1 − 1.5 × IQR
Upper Bound = Q3 + 1.5 × IQR
```

Records outside these bounds are flagged as anomalies.

Advantages:

* Simple
* Fast
* Interpretable

Limitations:

* Cannot capture multivariate anomalies
* Sensitive to skewed distributions

---

## ML-Based Detection (Isolation Forest)

Isolation Forest isolates anomalies using random partitioning of data.

Key characteristics:

* Designed for large datasets
* Works well with high-dimensional data
* Detects contextual anomalies
* Does not assume normal distribution

Model parameters used:

```
IsolationForest(
    contamination = 0.005
    n_estimators = 200
)
```

---

# Explainable AI (SHAP)

To interpret model predictions, **SHAP (SHapley Additive exPlanations)** was used.

SHAP calculates how much each feature contributes to the anomaly score.

Example explanation:

| Feature       | Contribution |
| ------------- | ------------ |
| salary_in_usd | -7.28        |
| work_year     | +0.11        |
| remote_ratio  | +0.34        |

Interpretation:

The extremely high salary value was the primary reason for anomaly detection.

---

# Human Feedback & Adaptive Learning

Users can review detected anomalies and provide feedback through the SQL table:

```
anomaly_feedback
```

Example feedback query:

```sql
INSERT INTO anomaly_feedback (record_id, anomaly_type, user_feedback, comments)
VALUES (42, 'ml_based', 'false_positive', 'Verified by HR manager');
```

Feedback types:

| Feedback       | Meaning             |
| -------------- | ------------------- |
| true_anomaly   | Confirmed anomaly   |
| false_positive | Incorrect detection |

The system then:

1. Reads the feedback table
2. Identifies false positives
3. Retrains the anomaly model
4. Updates the anomaly predictions

This creates a **self-improving anomaly detection system**.

---

# Visualization

Two scatter plots were generated:

### ML-Based Detection

* Blue points → Normal records
* Red points → ML detected anomalies

### Rule-Based Detection

* Blue points → Normal records
* Orange points → Rule-based anomalies

These visualizations help compare detection performance between statistical and machine learning methods.

---

# Technologies Used

| Technology       | Purpose                 |
| ---------------- | ----------------------- |
| Python           | Core implementation     |
| Pandas           | Data cleaning           |
| NumPy            | Numerical operations    |
| Scikit-learn     | Isolation Forest model  |
| SHAP             | Explainable AI          |
| Matplotlib       | Visualization           |
| SQL Server       | Database storage        |
| SQLAlchemy       | Python–SQL integration  |
| Jupyter Notebook | Development environment |

---

# How to Run the Project

Clone the repository:

```
git clone https://github.com/yourusername/explainable-anomaly-detection.git
```

Install dependencies:

```
pip install -r requirements.txt
```

Run the notebook:

```
jupyter notebook notebooks/anomaly_detection_pipeline.ipynb
```

Ensure SQL Server is running and the dataset table exists before executing the pipeline.

---

# Future Improvements

* Real-time anomaly detection pipelines
* Reinforcement learning for feedback adaptation
* Automated anomaly correction
* Dashboard visualization using Power BI / Streamlit
* Cross-domain anomaly detection frameworks

---

# Author

**Prathish A**
