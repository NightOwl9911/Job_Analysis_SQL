import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load data
analyst_df = pd.read_csv(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\query_results\3_top_demanded_skills_data_analyst.csv")
scientist_df = pd.read_csv(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\query_results\3_top_demanded_skills_data_scientist.csv")

# Rename columns for clarity
analyst_df.columns = ["Skill", "Value"]
scientist_df.columns = ["Skill", "Value"]

# Add role labels
analyst_df["Role"] = "Data Analyst"
scientist_df["Role"] = "Data Scientist"

# Combine tables
combined_df = pd.concat([analyst_df, scientist_df], ignore_index=True)

# Pivot for side-by-side comparison
pivot_df = combined_df.pivot(
    index="Skill",
    columns="Role",
    values="Value"
)

# -------- Visualization --------
x = np.arange(len(pivot_df.index))
width = 0.35

plt.figure(figsize=(10, 6))

plt.bar(x - width / 2, pivot_df["Data Analyst"], width, label="Data Analyst")
plt.bar(x + width / 2, pivot_df["Data Scientist"], width, label="Data Scientist")

plt.xticks(x, pivot_df.index, rotation=45, ha="right")
plt.ylabel("Demand")
plt.title("Top In-Demand Skills: Data Analyst vs Data Scientist")
plt.legend()

# 🔍 Zoom Y-axis (IMPORTANT PART)
y_min = pivot_df.min().min() * 0.7   # slightly below lowest value
y_max = pivot_df.max().max() * 1.35  # slightly above highest value
plt.ylim(y_min, y_max)

plt.tight_layout()
plt.show()


