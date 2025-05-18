# 🎯 Freemium User Conversion – Predictive Targeting Strategy

This project addresses a common challenge for freemium platforms: **how to identify and target free users who are most likely to upgrade** to a paid subscription.

Our predictive model was built on user-level behavioral data from a real marketing campaign involving **41,540 freemium users**, of which only **3.7% converted**. Using classification models and business-driven targeting strategy, we optimized which users should be marketed to — and **achieved a projected 219% ROI**.

---

## 🧠 Business Objective

> Identify and prioritize freemium users most likely to convert to paid users  
> in order to **maximize ROI and marketing efficiency**

---

## 📦 Dataset

- **Total records**: 41,540 users
- **Adopters**: 1,540 (3.7%)
- **Non-adopters**: 40,000
- **Features**:
  - Demographics: age, gender, country
  - Engagement: songs listened, tracks loved, shout activity
  - Social: friend count, average friend age/gender
  - Behavioral changes: delta in listening habits

---

## 🧪 Modeling Approach

### 1. Data Preparation
- Label: `adopter` (binary target – did the user convert?)
- Handled imbalance with **ROSE (Random Over-Sampling Examples)** to balance classes
- Split into training and validation via **10-fold cross-validation**

### 2. Models Evaluated
- ✅ Decision Tree (final model – best AUC)
- ❌ KNN
- ❌ Naive Bayes

### 3. Final Model: **CART Decision Tree (rpart)**
- **Cross-validated AUC**: 0.770
- Selected using `caret` with ROC as optimization metric
- Extracted top decision splits:
  - `delta_songsListened`
  - `lovedTracks`
  - `age`, `shouts`, `avg_friend_age`

<p align="center">
  <img src="https://i.imgur.com/cYnz4SB.png" width="600">
</p>

---
## 📈 Business Impact

### 📊 Cumulative Response Curve (CRC)
| % Targeted | % Conversions Captured |
|------------|-------------------------|
| 20%        | 45%                     |
| 40% ✅     | 80% (Optimal)           |
| 60%        | 90%                     |
| 100%       | 100%                    |

### 💸 ROI Analysis

<p align="center">
  <img src="https://i.imgur.com/kEWArY7.png" width="600">
</p>

- **Optimal Targeting Level**: Top 40% of users
- **Net Profit**: $88,765  
- **Marketing Cost**: $40,447  
- **ROI**: **219%**

> Targeting beyond 40% leads to diminishing returns and negative cost-to-conversion efficiency.


---

## 💡 Recommendations

- 📍 **Target Top 40% of scored users** from the model for future campaigns
- 🧠 Segment users further for tailored content
- 📉 Avoid mass marketing to low-conversion clusters

---

## 🛠 Tools & Stack

- 🐍 R (rpart, caret, pROC, ROSE, ggplot2)
- 📊 Excel / PowerPoint (for business communication)
- 📁 Files:
  - `homework2_final.R` – Code for data cleaning, modeling, evaluation
  - `HW2_Presentation-1.pptx` – Final business presentation
  - `data_test_output.xlsx` – Output predictions

---

## 👨‍💼 Team

- **Justin Varghese** – Predictive Modeling & Evaluation
- Anshu Mehta – EDA & Model Interpretation
- Shrawani Tare – Data Cleaning & Strategy
- Tenzin Jangchup – Visual Storytelling & Business Framing
- Chenxiang Ma – Feature Engineering & Testing

---

## 📬 Contact

Created with 🧠 + 💼 by Justin Varghese  
Reach out for collaborations in **freemium modeling**, **customer analytics**, or **campaign optimization**.

[🔗 GitHub Profile](https://github.com/blacckbeard4)
