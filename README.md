[README.md](https://github.com/user-attachments/files/33680249/README.md)

# Gianluca Leto – Data Analysis & Business Portfolio

Master's student in International Business and Entrepreneurship (Digital Management) at the University of Pavia, on a double degree in International Strategic Marketing at HEC Liège. I combine analytical skills (Python, SQL, R, Power BI, Excel) with business understanding, and I am open to Data Analyst / Business Analyst opportunities.

This repository collects five university projects that show how I work with data, business strategy and teams.

🔗 [LinkedIn](https://linkedin.com/in/gianluca-leto)

---

## Projects

| Project | Course | Focus | Tools |
|---|---|---|---|
| [NYC Airbnb Price Analysis](#1-nyc-airbnb-price-analysis) | Statistical Learning | Predicting price categories of NYC listings | R, caret, pROC, rpart, randomForest, tidytext |
| [HiveLearn – Adaptive Pathways for Continuous Business Growth](#2-hivelearn--adaptive-pathways-for-continuous-business-growth) | Applied Project Management and Agile Methods | Designing a learning & talent-development platform | Value Proposition Canvas, prototyping, Scrumban |
| [Stellantis Expansion in Indonesia – Joint Venture Business Case](#3-stellantis-expansion-in-indonesia--joint-venture-business-case) | Managing International Growth | Market-entry strategy, valuation and financing of a joint venture | DCF, WACC, Porter's 5 Forces, PESTEL, Balanced Scorecard |
| [Royal DSM – From Coal Mining to Sustainable Health and Nutrition](#4-royal-dsm--from-coal-mining-to-sustainable-health-and-nutrition) | Transformative Innovation | Case study on how a company reinvented itself over a century, with managerial lessons | BANI, Remain–Reframe–Revolution, organisational unlearning, corporate purpose |
| [How Can Italy Really Reduce Its Energy Dependence?](#5-how-can-italy-really-reduce-its-energy-dependence) | Energy and Environmental Economics | Multi-criteria comparison of policy options to cut Italy's energy imports | Multi-criteria assessment, energy trilemma, policy analysis |

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

## 3. Stellantis Expansion in Indonesia – Joint Venture Business Case

📁 [`strategy-stellantis-indonesia/`](./strategy-stellantis-indonesia) · 📄 [Final presentation (PDF)](./strategy-stellantis-indonesia/presentation.pdf)

**Course:** Managing International Growth – University of Pavia

**Team:** 5 students

> Academic case study. The figures are estimates and assumptions made for the project, not real Stellantis plans.

### Goal
Define how Stellantis could enter the Indonesian electric-vehicle market and reach a **5% share of the BEV segment**, and test whether the plan makes financial sense.

### What the project covered
- **Strategic options** – joint venture, greenfield investment and acquisition compared on pros and cons, with a joint venture with **Indomobil Group** (Karawang plant, local CKD assembly within 12–18 months) as the chosen option.
- **Business plan** – operational and strategic objectives, a 36-month roadmap and a Business Model Canvas. The plan relies on meeting the **40% local content rule (TKDN)**, which unlocks a 0% luxury tax.
- **Market and environment** – local market analysis, Porter's 5 Forces and PESTEL.
- **Valuation and M&A** – joint-venture structure (51% Stellantis / 49% Indomobil), 5-year DCF with a WACC of 14.05%, synergies, risks and integration timeline.
- **Financing** – €250M capital need and a 60/40 equity/debt mix, including a €100M syndicated green loan, with debt service coverage ratio (DSCR) by year.
- **Governance, accounting and control** – management structure, stakeholder matrix, projected P&L and cash flow, Balanced Scorecard, and sensitivity analysis under three scenarios.
- **Regulation, sustainability and risk management.**

### Key results
- Target enterprise value of **€460M** (DCF-based value ≈ €522M), tested in a sensitivity range of €415M–€645M.
- Operating break-even within **24 months** of the start of CKD production, with net income turning positive in year 2.
- Minimum debt service coverage ratio of **1.15×**, with the loan structured in local currency to reduce exchange-rate risk.

### My contribution
I was responsible for the **Valuation & M&A** and **Financing** sections. The project was presented in class as part of the final exam.

- **Valuation & M&A:** I built the **DCF analysis** (5-year cash flow projection and WACC assumptions), cross-checked it with an EV/EBITDA multiple, and derived the target enterprise value. I also defined the joint-venture structure and each partner's contribution (51% Stellantis / 49% Indomobil), and covered the synergies, the integration risks with their mitigations, and the integration timeline.
- **Financing:** the €250M capital need and how it is split across retrofitting, market entry, working capital and a contingency reserve. I compared equity and debt financing and justified the 60/40 mix, including the €100M syndicated green loan, its repayment schedule and the debt service coverage ratio (DSCR) year by year.

---

## 4. Royal DSM – From Coal Mining to Sustainable Health and Nutrition

📁 [`innovation-royal-dsm/`](./innovation-royal-dsm) · 📄 [Final presentation (PDF)](./innovation-royal-dsm/presentation.pdf) · 📄 [Essay (PDF)](./innovation-royal-dsm/essay.pdf)

**Course:** Transformative Innovation – University of Pavia

**Team:** 6 students (group INNOV8)

> Academic case study based on public sources (company documents, managerial literature, academic and industry sources).

### Goal
Understand how Royal DSM, founded in 1902 as the state-owned *Dutch State Mines*, managed to reinvent itself several times: from coal mining to commodity chemicals, and finally to a purpose-led leader in nutrition, health and biosciences. The project explains why the transformation worked and what managers can learn from it.

### What the project covered
- **History and triggers of change** – the collapse of the coal paradigm (mines closed by 1974), the "commodity trap" of petrochemicals and the cultural inertia inherited from the state-owned company.
- **Transformation phases** – from coal to chemicals, then specialty materials, then life sciences through acquisitions (Gist-Brocades, Roche Vitamins, Martek), up to the 2023 merger with Firmenich.
- **Success factors and barriers** – visionary leadership, open collaboration, long-term investor appeal, versus cultural resistance, timing and short-term financial pressure.
- **Theoretical analysis** – BANI context, the *Remain – Reframe – Revolution* framework, organisational unlearning, mission vs. purpose, and "fluid and continuous" vs. "deep and bounded" transformation.
- **Managerial implications** – practical lessons for managers (see below).

### Key takeaways
- Transformation is both structural (divestments, acquisitions, new capabilities) and cultural (unlearning, new narrative, purpose). Companies that manage only one side tend to fail.
- Sustainability can be a growth driver, not just a cost.

### My contribution
I wrote the **Managerial Implications** section (presentation and essay), which turns DSM's story into lessons that managers can apply:
- **Internal carbon price (€50 per ton)** – a financial mechanism that makes high-emission projects less attractive in internal budgets, so sustainability becomes the economically rational choice.
- **Innovation ecosystem** – open innovation and capability-driven acquisitions: competitive advantage comes from orchestrating an external network, not from owning every resource.
- **Institutionalised agility** – horizon scanning, talent mobility and interdisciplinary learning, so that reinvention becomes a permanent capability.
- **Pitfalls to avoid and general lessons** – do not cling to legacy businesses, do not expect culture to change just because structure does, do not treat M&A as a goal in itself, do not ignore timing.

---

## 5. How Can Italy Really Reduce Its Energy Dependence?

📁 [`energy-dependence-italy/`](./energy-dependence-italy) · 📄 [Final presentation (PDF)](./energy-dependence-italy/presentation.pdf) · 📄 [Research paper (PDF)](./energy-dependence-italy/paper.pdf)

**Course:** Energy and Environmental Economics – University of Pavia

**Team:** 4 students

> Academic research project. It is a qualitative policy analysis based on public data and literature.

### Goal
Answer the question: *how can Italy reduce its energy dependence while balancing energy security, environmental sustainability and affordability?* The main argument is that the aim is not full self-sufficiency, but lower systemic vulnerability, and that this requires a coordinated portfolio of measures rather than a single technology.

### What the project covered
- **Theoretical framework** – energy security as a multidimensional concept, energy accounting (primary energy, final energy, electricity) and the energy trilemma.
- **Italy's starting point** – import dependency of 79.2% in 2022 and 74.6% in 2023, final consumption by fuel, exposure by sector (transport, buildings, industry, services) and the electricity system.
- **Methodology** – a qualitative multi-criteria assessment of five options (energy efficiency, electrification, renewable electricity, grid flexibility, biomethane and hydrogen) against eight criteria, ranked High / Medium / Low.
- **Comparison and policy implications** – ranking of the options, short vs. long-term contribution, trade-offs and a recommended policy package.

### Key results
- Energy efficiency comes first in the ranking, followed by renewable electricity, electrification, grid flexibility and, selectively, biomethane and hydrogen.
- Sequencing matters: reduce demand first, then electrify efficient uses, then supply them with domestic renewables, while building flexibility in parallel.

### My contribution
I wrote the **Energy Efficiency** and **Renewable Electricity** sections (paper and presentation).
- **Energy efficiency:** the economic rationale (efficiency as an investment decision and the "energy efficiency gap"), the market failures that hold it back (information problems, split incentives, capital constraints, behavioural biases, externalities), the "failure-matching" principle for policy instruments, and limits such as the rebound effect, timing and distributional effects. Applied to Italy, with priority on buildings and industry.
- **Renewable electricity (solar and wind):** how renewables reduce imported fuels and gas-price exposure (merit-order effect, 51.83% of national electricity production in 2024 vs. 42% from natural gas), their system costs (intermittency, grid congestion, curtailment, permitting, market design, social acceptance) and why they are "necessary but not sufficient".

---

## Skills demonstrated
**Data & analytics:** data cleaning, classification, logistic regression, model evaluation (ROC/AUC, Kappa), Random Forest, text mining, R

**Business & project management:** value proposition design, user stories, agile/Scrumban, stakeholder analysis, prototyping, teamwork

**Strategy & finance:** market-entry strategy, DCF valuation and WACC, joint-venture structuring, financing (equity vs debt, DSCR), Balanced Scorecard, Porter's 5 Forces, PESTEL, risk management

**Innovation, sustainability & policy analysis:** case-study research, change management, open innovation, corporate purpose, internal carbon pricing, energy economics, multi-criteria assessment, policy recommendations
