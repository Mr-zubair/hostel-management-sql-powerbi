# Hostel Management System: Relational Database Architecture & Power BI Analytics

An end-to-end database engineering and business intelligence solution designed to modernize university student housing operations—replacing manual paper ledgers with a normalized **MySQL** relational database and an interactive **Power BI** management dashboard.

* **Authors:** Muhammad Zubair & Muhammad Idrees (Department of Business Studies, Namal University, Mianwali)
* **Tools & Technologies:** MySQL (DDL & DML), Relational Modeling (3NF Normalization), Draw.io (ERD), Microsoft Power BI

---

## 1. Database Architecture & Normalization (MySQL)

The relational database (`HostelSystem`) models **12 core entities** supporting gender-separated student housing (`Jinnah Hall` and `Fatima Jinnah Hall`), room allocations, semester fee billing, installment payments, room inventory, maintenance ticketing, visitor security logs, and daily attendance tracking.

### Key Architectural Highlights
* **1NF–3NF Normalization Audit:** Audited an unnormalized baseline schema to eliminate multi-valued room/furniture strings (1NF), partial key dependencies in fee billing (2NF), and transitive staff-mess dependencies (3NF).
* **Referential Integrity:** Enforced `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE` (CNIC validation), `ENUM` status domains, and `ON DELETE CASCADE` / `SET NULL` constraints across all 12 tables.
* **Sample Dataset Scale:** 2 hostels, 50 rooms (capacity 2 per room = 100 total beds), 50 students (25 male, 25 female), 20 staff members, 50 semester fee assessments, 30 payment transactions (including partial installments), 20 maintenance tickets, 40 room inventory entries, 20 visitor logs, and 60 attendance records.

### Entity-Relationship Diagram (ERD)
![Entity-Relationship Diagram](images/erd_diagram.jpg)

---

## 2. Power BI Interactive Dashboard & Business Insights

### Page 1: Occupancy & Inventory Management
![Occupancy and Inventory Dashboard](images/dashboard_page1_operations.png)

* **Capacity Utilization:** Tracks **50 active students** across **50 rooms** (**100 total capacity**), identifying a **50% occupancy rate** and immediate capacity for enrollment expansion.
* **Asset Condition Monitoring:** Categorizes room assets (Beds, Chairs, Tables, Cupboards, Curtains, Fans) by condition: **64.1% Good**, **23.08% Fair**, **7.69% New**, **2.56% Broken**, and **2.56% Repair Needed**—enabling proactive maintenance and procurement budgeting.
* **Interactive Slicers:** Supports dynamic filtering by **Hostel Type** (`Male` / `Female`).

### Page 2: Fee Collection & Financial Performance
![Financial Performance Dashboard](images/dashboard_page2_financials.png)

* **Receivables & Target Tracking:** Monitors **PKR 566.00K collected** against **PKR 1.25M total billed fees** (45.28% collection rate) and a **PKR 1.13M target revenue** benchmark, highlighting outstanding receivables (`Unpaid` and `Pending`) requiring administrative follow-up.
* **Payment Channel Breakdown:** Digital channels lead fee collections, with **Online (PKR 200K / 35.34%)** and **Bank Transfer (PKR 189K / 33.39%)** accounting for **68.73%** of collected revenue alongside **Cash (PKR 177K / 31.27%)**.
* **Granular Drill-Down:** Interactive slicers allow filtering by **Semester**, **Student ID**, and **Payment Method**.

---

## 3. Repository Structure

* `sql/01_schema_ddl.sql` — MySQL DDL script creating the 12-table normalized schema
* `sql/02_seed_data_dml.sql` — MySQL DML script inserting realistic operational & financial records
* `powerbi/Hostel_Management_Dashboard.pbix` — Interactive 2-page Power BI Desktop report
* `docs/Database_Design_Document.pdf` — Formal 18-page database design specification, data dictionary, functional dependencies, and 3NF normalization analysis
* `docs/Dashboard_Analysis_Report.pdf` — Management report summarizing operational, inventory, demographic, and financial insights
* `images/` — High-resolution ERD and Power BI dashboard screenshots

---

## 4. How to Run Locally
1. **Database Setup:** Execute `sql/01_schema_ddl.sql` followed by `sql/02_seed_data_dml.sql` in MySQL Workbench or any MySQL 8.0+ client to build and populate `HostelSystem`.
2. **Dashboard Exploration:** Open `powerbi/Hostel_Management_Dashboard.pbix` in **Microsoft Power BI Desktop** to interact with the slicers and visuals.
