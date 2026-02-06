import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv(
    r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\query_results\2_top_skills_by_frequency.csv"
)

# 🔑 IMPORTANT: columns are reversed in your CSV
frequency = df.iloc[:, 0]   # numbers
skills = df.iloc[:, 1]      # skill names

# Sort so highest frequency is at the top
order = frequency.argsort()
frequency = frequency.iloc[order]
skills = skills.iloc[order]

# 🔥 LIMIT TO TOP 15
frequency = frequency.tail(15)
skills = skills.tail(15)

# Sort so highest frequency is at the top
order = frequency.argsort()
frequency = frequency.iloc[order]
skills = skills.iloc[order]

plt.figure(figsize=(12, 10))
ax = plt.gca()

# Background
ax.set_facecolor("black")
plt.gcf().patch.set_facecolor("black")

# Correct orientation
ax.barh(skills, frequency, color="yellow")

# Labels & title
plt.title(
    "Top Skills by Frequency in Top Paying Data Jobs (Colombia) - 2023",
    color="white",
    fontsize=16
)
plt.xlabel("Frequency", color="white")
plt.ylabel("Skills", color="white")

# Ticks
ax.tick_params(axis="x", colors="white")
ax.tick_params(axis="y", colors="white")

# Clean look
for spine in ax.spines.values():
    spine.set_visible(False)

plt.tight_layout()
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\top_skills_by_frequency.png",dpi=300,facecolor="black",bbox_inches="tight")
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\top_skills_by_frequency.pdf",facecolor="black",bbox_inches="tight")
plt.show()