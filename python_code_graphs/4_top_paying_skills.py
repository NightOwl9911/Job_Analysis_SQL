import pandas as pd
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\query_results\4_top_paying_skills.csv")

# Rename columns and capitalize headers
df.columns = ["SKILL", "VALUE"]

# Sort and take top 20
df = df.sort_values(by="VALUE", ascending=False).head(20)

# ---- Figure sizing (tuned to remove bottom space) ----
fig_height = 0.62 * len(df) + 0.8   # tighter canvas, but taller rows
fig, ax = plt.subplots(figsize=(10, fig_height))
fig.patch.set_facecolor("black")
ax.set_facecolor("black")
ax.axis("off")

# ---- Title ABOVE table ----
fig.text(
    0.5, 0.975,
    "TOP 20 PAYING SKILLS",
    ha="center",
    va="top",
    color="white",
    fontsize=14,
    fontweight="bold"
)

# ---- Create table ----
table = ax.table(
    cellText=df.values,
    colLabels=df.columns,
    cellLoc="center",
    loc="upper center"
)

# Font & spacing
table.auto_set_font_size(False)
table.set_fontsize(11)
table.scale(1, 2.3)   # 👈 more vertical separation between rows

# Colors
line_color = "#2dd4bf"
text_color = "white"

# ---- Styling ----
for (row, col), cell in table.get_celld().items():
    cell.set_edgecolor(line_color)
    cell.set_linewidth(1.8)
    cell.set_facecolor("black")
    cell.get_text().set_color(text_color)

    if row == 0:
        cell.get_text().set_weight("bold")

# ---- Remove remaining black space ----
plt.subplots_adjust(
    top=0.94,
    bottom=0.01
)

plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\top_payings_skills.png",dpi=300,facecolor="black",bbox_inches="tight")
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\top_payings_skills.pdf",facecolor="black",bbox_inches="tight")
plt.show()









