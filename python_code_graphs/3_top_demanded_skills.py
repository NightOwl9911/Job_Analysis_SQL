import pandas as pd
import matplotlib.pyplot as plt

# -------- Load data --------
analyst_df = pd.read_csv(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\query_results\3_top_demanded_skills_data_analyst.csv")
scientist_df = pd.read_csv(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\query_results\3_top_demanded_skills_data_scientist.csv")

analyst_df.columns = ["Skill", "Value"]
scientist_df.columns = ["Skill", "Value"]

# -------- Create subplots --------
fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Set black background
fig.patch.set_facecolor("black")

for ax in axes:
    ax.set_facecolor("black")
    ax.tick_params(colors="white")
    ax.spines["bottom"].set_color("white")
    ax.spines["left"].set_color("white")
    ax.spines["top"].set_color("black")
    ax.spines["right"].set_color("black")

# -------- Data Analyst --------
axes[0].bar(
    analyst_df["Skill"],
    analyst_df["Value"],
    color="red"
)
axes[0].set_title(
    "Top In-Demand Skills — Data Analyst",
    color="white"
)
axes[0].set_ylabel("Demand", color="white")
axes[0].tick_params(axis="x", rotation=45, colors="white")

# -------- Data Scientist --------
axes[1].bar(
    scientist_df["Skill"],
    scientist_df["Value"],
    color="red"
)
axes[1].set_title(
    "Top In-Demand Skills — Data Scientist",
    color="white"
)
axes[1].tick_params(axis="x", rotation=45, colors="white")

plt.tight_layout()

# -------- Save outputs --------
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\in_demand_skills.png",dpi=300,facecolor="black",bbox_inches="tight")
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\in_demand_skills.pdf",facecolor="black",bbox_inches="tight")
plt.show()