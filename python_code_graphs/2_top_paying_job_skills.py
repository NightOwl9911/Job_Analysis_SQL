import pandas as pd
import matplotlib.pyplot as plt

# Load dataset
df = pd.read_csv(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\query_results\2_top_paying_job_skills.csv")

# Split and explode skills column
skills_series = df["skills"].dropna().str.split(", ")
all_skills = skills_series.explode()

# Count frequency
skill_counts = all_skills.value_counts()

# Select top 25
top_25_skills = skill_counts.head(25).sort_values(ascending=True)

# Create plot
plt.figure(figsize=(12, 10))
ax = plt.gca()

# Black background
ax.set_facecolor("black")
plt.gcf().patch.set_facecolor("black")

# Yellow bars
top_25_skills.plot(kind="barh", color="yellow")

# Titles and labels
plt.title("Top 25 Skill Frequency in Top Paying Data Jobs (Colombia) - 2023", color="white", fontsize=16)
plt.xlabel("Frequency", color="white", fontsize=12)
plt.ylabel("Skill", color="white", fontsize=12)

# White ticks
ax.tick_params(axis='x', colors='white')
ax.tick_params(axis='y', colors='white')

# Remove spines for cleaner look
for spine in ax.spines.values():
    spine.set_visible(False)

plt.tight_layout()
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\top_25_skills_colombia.png", dpi=300, bbox_inches="tight")
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\top_25_skills_colombia.pdf", bbox_inches="tight")
plt.show()