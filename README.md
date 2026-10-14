[README2.md](https://github.com/user-attachments/files/33434153/README2.md)
# Gianluca Leto – Data Analysis & Business Portfolio

Master's student in International Business and Entrepreneurship (Digital Management) at the University of Pavia, on a double degree in International Strategic Marketing at HEC Liège. I combine analytical skills (Python, SQL, R, Power BI, Excel) with business understanding, and I am open to Data Analyst / Business Analyst opportunities.

This repository collects two university projects that show how I work with data and with teams.

🔗 [LinkedIn](https://linkedin.com/in/gianluca-leto)

---

## Projects

| Project | Course | Focus | Tools |
|---|---|---|---|
| [NYC Airbnb Price Analysis](#1-nyc-airbnb-price-analysis) | Statistical Learning | Predicting price categories of NYC listings | R, caret, pROC, rpart, randomForest, tidytext |
| [HiveLearn – Adaptive Pathways for Continuous Business Growth](#2-hivelearn--adaptive-pathways-for-continuous-business-growth) | Applied Project Management and Agile Methods | Designing a learning & talent-development platform | Value Proposition Canvas, prototyping, Scrumban |

---

## 1. NYC Airbnb Price Analysis

📁 [`nyc-airbnb-analysis/`](./nyc-airbnb-analysis) · 📄 [Presentation (PDF)](./nyc-airbnb-analysis/presentation.pdf) · 💻 [R script](./nyc-airbnb-analysis/analysis.R)

**Course:** Statistical Learning – University of Pavia

**Team:** 2 students

### Goal
Identify the economic drivers of the New York City short-term rental market and build a model that predicts whether a listing belongs to the *high-price* or *low-price* category.

### Approach
1. **Data cleaning** – missing values in `reviews_per_month` imputed with 0 (no reviews); outliers removed by keeping prices between 1 and 1,000 USD.
2. **Target creation** – binary variable `high_price`, using the median price as threshold to obtain balanced classes.
3. **Stratified sampling** – 70% training / 30% test split with the `caret` package, preserving the class proportions.
4. **Logistic regression** with **stepwise selection (AIC)** to keep a parsimonious model, and **odds ratios** to interpret each factor.
5. **Performance evaluation** – confusion matrix, sensitivity/specificity, Cohen's Kappa, ROC curve and AUC.
6. **Decision tree, Random Forest and text mining** of listing titles to cross-check the results and compare Manhattan vs Brooklyn.

### Key results
<!-- Update these figures after re-running the script (see analysis.R) -->
- Accuracy ≈ **82%** on the test set, AUC ≈ **0.89**, Kappa ≈ **0.65** ("substantial" agreement on the Landis & Koch scale).
- **Location and room type** are the main price drivers: a listing in Manhattan has ≈ 12.6× the odds of being classified as high-price compared to the baseline borough, while a private room (vs. an entire home) reduces those odds by ≈ 96%.
- The Random Forest and the decision tree confirm the ranking: room type first, neighbourhood second, availability much less relevant.

### My contribution
Data cleaning, target creation, stratified sampling, logistic regression, stepwise selection, odds-ratio interpretation and model performance evaluation (confusion matrix, Kappa, ROC/AUC). The decision tree, Random Forest and text-mining sections were developed by my project partner.

### Reproducing the analysis
The dataset (*AB_NYC_2019*, public Airbnb NYC listings) is not included. Download it, save it as `AB_NYC_2019.xlsx` in the same folder as the script, set that folder as working directory in R and run `analysis.R`.
Required packages: `tidyverse`, `readxl`, `caret`, `pROC`, `rpart`, `rpart.plot`, `randomForest`, `e1071`, `tidytext`.

---

## 2. HiveLearn – Adaptive Pathways for Continuous Business Growth

📁 [`project-management-hivelearn/`](./project-management-hivelearn) · 📄 [Final presentation (PDF)](./project-management-hivelearn/presentation.pdf)

**Course:** Applied Project Management and Agile Methods – University of Pavia

**Team:** Group 5, 9 students

### Goal
Design **HiveLearn**, a unified platform that maps skills, identifies gaps and guides growth across an organisation, turning employee potential into measurable performance and supporting peer-to-peer learning.

### What the project covered
- **Strategic analysis and Value Proposition Canvas** matching customer pains and gains (skill-gap visibility, unstructured career growth, unclear training ROI, retention risks) with the platform's products and services.
- **Prototype of the platform** with dedicated interfaces for employees, mentors and managers, including:
  - **Employee Journeys** – real internal career paths showing roles, skills acquired and achievements;
  - **Mentor Interface** and a **traffic-light quality-assurance loop** for peer-generated courses;
  - **Cross Pollination** – job shadowing across departments to reduce the "silo effect".
- **Project management across three iterations** (concept and stakeholder map → user stories and mentee interface → roll-out plan, employee survey, manager interface and budget), integrating feedback at each step.
- **Methodology** – the team moved from a consensus-based approach to a hybrid **Scrumban** model: delegation by strengths, short check-ins every 2–3 days and continuous review.

### My contribution
Design and presentation of the **Employee Journeys** section of the prototype: a dedicated area of the app that shows how colleagues progressed within the company (role changes, skills acquired, key achievements) to inspire and guide new employees. The figures shown in the prototype screens are illustrative mock-up data.

---

## Skills demonstrated
**Data & analytics:** data cleaning, classification, logistic regression, model evaluation (ROC/AUC, Kappa), Random Forest, text mining, R

**Business & project management:** value proposition design, user stories, agile/Scrumban, stakeholder analysis, prototyping, teamwork
