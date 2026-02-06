import pandas as pd
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\query_results\5_optiomal_skills.csv")

# Expected columns: skill, in_demand_skill, avg_salary

# Create a color palette (one color per skill)
cmap = plt.get_cmap("tab20")
colors = [cmap(i) for i in range(len(df))]

# Create figure
fig, ax = plt.subplots(figsize=(10, 7))
fig.patch.set_facecolor("black")
ax.set_facecolor("black")

# Bubble plot with unique colors + interleaved labels (above / below)
for i, row in df.iterrows():
    ax.scatter(
        row["in_demand_skill"],
        row["avg_salary"],
        s=row["in_demand_skill"] * 15,
        color=colors[i],
        alpha=0.85,
        edgecolors="white",
        linewidth=0.8
    )

    # Alternate label position (above / below)
    y_offset = 10 if i % 2 == 0 else -14
    valign = "bottom" if i % 2 == 0 else "top"

    ax.annotate(
        row["skill"],
        (row["in_demand_skill"], row["avg_salary"]),
        textcoords="offset points",
        xytext=(0, y_offset),
        ha="center",
        va=valign,
        color="white",
        fontsize=9
    )

# Titles and labels
ax.set_title(
    "Optimal Skills: Demand vs Average Salary",
    color="white",
    fontsize=14,
    pad=12
)
ax.set_xlabel("In-Demand Frequency", color="white")
ax.set_ylabel("Average Salary", color="white")

# White ticks and spines
ax.tick_params(colors="white")
for spine in ax.spines.values():
    spine.set_color("white")

plt.tight_layout()
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\optimal_skills.png",dpi=300,facecolor="black",bbox_inches="tight")
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\optimal_skills.pdf",facecolor="black",bbox_inches="tight")
plt.show()