# Customer Subscription Churn Analysis
**By: Adam El Jobeili**

## Executive Summary
Initial analysis suggested a random churn distribution of ~57%. By transitioning from Excel to SQL to resolve look-ahead bias, I identified **Payment Failures** as the primary causal driver. A single payment failure increases churn risk by **2x**, signaling that churn is largely involuntary (billing-related) rather than behavioral.

---

## Process & Technical Challenges
* **Data Integrity:** Cleaned in Excel to remove nulls and validate tenure/usage ranges.
* **The Pivot to SQL:** Excel analysis showed uniform churn across all segments. Recognizing this as **survivorship bias**, I moved to SQL to isolate behavior windows.
* **Debugging:** Resolved `NULLIF` type mismatch errors by shifting logic from categorical strings (`tenure_bucket`) to raw numeric columns (`tenure_months`).

---

## Key Insights: The "Smoking Gun"
* **The #1 Predictor:** Payment Failures. Customers with 1+ failures churn at **61%**, compared to 31% for successful payers.
* **Involuntary Churn:** Flat churn rates across usage and tenure suggest customers aren't leaving due to dissatisfaction, but due to **billing friction**.
* **The Best Plan:** Standard Plan users with 0 failures are the most loyal segment (31% churn), significantly outperforming Basic and Premium tiers.

---

## Recommendations
1. **Optimize Dunning:** Implement automated retries and grace periods for failed payments to save the 60% at-risk group.
2. **Standard Plan Benchmarking:** Investigate why the Standard Plan retains users better than Premium/Basic tiers.
3. **Trigger-Based Outreach:** Use the "First Payment Failure" as an immediate trigger for Customer Success intervention.

