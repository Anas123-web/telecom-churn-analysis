# 📊 Telecom Customer Churn Analysis

## 🧠 Project Overview
The **Telecom Customer Churn Analysis** project aims to identify the key factors influencing customer churn and provide actionable insights to help reduce churn rates.  
This end-to-end project integrates **Python (EDA)**, **MS SQL Server**, and **Power BI** to perform data analysis, store insights, and visualize business metrics interactively.

---

## 🎯 Objectives
- Analyze customer behavior and service usage to determine churn patterns.
- Identify key drivers of churn such as inactivity, support calls, and subscription type.
- Build SQL queries and views for analytical insights.
- Create a Power BI dashboard for executive-level reporting.

---

## 🧩 Project Phases

### **Phase 1 — Data Cleaning (Python)**
- Imported telecom churn dataset (`telecom_churn_data.csv`).
- Handled missing values (`gender`, `maximum_days_inactive`, `churn`).
- Converted columns to correct data types.
- Exported cleaned dataset as `cleaned_telecom_churn_data.csv`.

**Key Libraries:**  
`pandas`, `matplotlib`, `seaborn`

---

### **Phase 2 — Exploratory Data Analysis (Python)**
Performed visual and statistical exploration to uncover patterns.

**Analyses:**
- Churn distribution overall
- Churn by gender
- Churn by multi-screen and mail subscription
- Relation between churn and customer support calls
- Correlation heatmap of numeric features

**Insights:**
- Higher churn observed among customers with more support calls.
- Inactive and less-engaged users tend to churn more.
- Multi-screen and mail subscriptions correlate with higher retention.

---

### **Phase 3 — SQL Integration (MS SQL Server)**
Stored the cleaned dataset in SQL Server and created analytical queries & views.

**Setup Steps:**
1. Connected Python to SQL Server using `pyodbc`.
2. Created database: `Telecom_Churn_DB`
3. Created table: `Telecom_Churn`
4. Inserted all 2000 records from the cleaned dataset.
5. Created SQL Views for Power BI integration.

**Key SQL Views:**
| View Name | Description |
|------------|--------------|
| `v_churn_summary` | Overall churn metrics |
| `v_churn_by_gender` | Churn by gender |
| `v_churn_by_multiscreen` | Churn by multi-screen users |
| `v_churn_by_mail` | Churn by mail subscription |
| `v_avg_usage_by_churn` | Average usage stats for churned vs non-churned |
| `v_churn_by_support_calls` | Churn vs support calls |
| `v_churn_by_age_group` | Age group–wise churn rate |
| `v_churn_by_year` | Year-over-year churn trends |

---

### **Phase 4 — Power BI Dashboard**
Connected Power BI to SQL Server to create an **interactive dashboard**.

**Dashboard Components:**
#### 🔹 KPI Section (Top Row)
| KPI | Data Source | Visual | Description |
|------|--------------|---------|--------------|
| Total Customers | DAX (`COUNTROWS`) | Card | Total customers |
| Churned Customers | DAX (`CALCULATE`) | Card | Customers who left |
| AVG of Churn| DAX (`AVG`) | Card | Average churn |
| Avg Support Calls (Churners) | DAX (`AVERAGE`) | Card | Engagement metric |

#### 🔹 Visual Insights
- **Churn by Gender:** Bar Chart (from `v_churn_by_gender`)
- **Churn by Age Group:** Column Chart (`v_churn_by_age_group`)
- **Churn by Multi-Screen Usage:** Stacked Column Chart
- **Churn vs Support Calls:** Line Chart (`v_churn_by_support_calls`)
- **Yearly Churn Trend:** Line Chart (`v_churn_by_year`)
- **Mail Subscription Impact:** Donut Chart (`v_churn_by_mail`)

#### 🔹 Filters (Slicers)
- Gender  
- Multi-screen  
- Mail Subscribed  
- Year  

**Final Output:**  
An interactive dashboard displaying customer churn KPIs, demographics, and behavioral insights with live SQL connection.

---

## ⚙️ Tech Stack

| Category | Tools / Technologies |
|-----------|----------------------|
| Programming | Python (Pandas, Matplotlib, Seaborn) |
| Database | MS SQL Server |
| Integration | pyodbc |
| Visualization | Power BI |
| Version Control | GitHub |

---

## 📊 Sample SQL Queries

```sql
-- Churn Rate Calculation
SELECT 
    COUNT(*) AS Total_Customers,
    SUM(COALESCE(churn, 0)) AS Churned_Customers,
    ROUND(SUM(COALESCE(churn, 0)) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM Telecom_Churn;

-- Churn by Gender
SELECT 
    gender,
    SUM(churn) AS Churned_Customers,
    ROUND(SUM(churn)*100.0/COUNT(*), 2) AS Churn_Rate
FROM Telecom_Churn
GROUP BY gender;
