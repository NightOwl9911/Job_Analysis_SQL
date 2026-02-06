import pandas as pd
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\query_results\4_top_paying_skills.csv")

# Rename columns if needed
df.columns = ["Skill", "Value"]

# Sort and take top 20
df_top20 = df.sort_values(by="Value", ascending=False).head(10)

# Create taller figure for spacing
fig, ax = plt.subplots(figsize=(10, 10))

# Black background
fig.patch.set_facecolor("black")
ax.set_facecolor("black")

# Bar chart with dotted pattern
ax.bar(
    df_top20["Skill"],
    df_top20["Value"],
    width=0.5,
    edgecolor="pink",
    facecolor="none",
    linewidth=2,
    hatch="..",           # 👈 dotted pattern
)

# Titles and labels
ax.set_title("Top 20 Paying Skills", color="white", pad=20)
ax.set_ylabel("Salary / Pay", color="white")

# White ticks
ax.tick_params(axis="x", colors="white", rotation=45, pad=8)
ax.tick_params(axis="y", colors="white")

# White spines
for spine in ax.spines.values():
    spine.set_color("white")

# Extra spacing
plt.margins(x=0.15)

plt.tight_layout()
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\top_paying_skills.png",dpi=300,facecolor="black",bbox_inches="tight")
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\top_paying_skills.pdf",facecolor="black",bbox_inches="tight")
plt.show()