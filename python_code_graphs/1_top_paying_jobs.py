import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

# Load dataset
df = pd.read_csv(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\query_results\1_top_paying_jobs.csv")

# Remove duplicate job-title + company combinations
df_unique = df.drop_duplicates(subset=["job_title", "company_name"])

# Get top 20 highest paying job + company combos
top20 = df_unique.sort_values(by="salary_year_avg", ascending=False).head(10)

# Create combined label
top20["job_company"] = top20["job_title"] + " | " + top20["company_name"]

# ---- STYLE SETTINGS ----
plt.rcParams["figure.facecolor"] = "black"
plt.rcParams["axes.facecolor"] = "black"
plt.rcParams["axes.edgecolor"] = "white"
plt.rcParams["axes.labelcolor"] = "white"
plt.rcParams["xtick.color"] = "white"
plt.rcParams["ytick.color"] = "white"
plt.rcParams["text.color"] = "white"

# Plot
plt.figure(figsize=(14, 10))
plt.barh(top20["job_company"], top20["salary_year_avg"], color="darkblue")
plt.xlabel("Average Yearly Salary (USD)")
plt.ylabel("Job Title | Company")
plt.title("Top 20 Highest Paying Jobs (Unique Job + Company) - Colombia 2023")
plt.gca().invert_yaxis()

# Format salary axis with $
plt.gca().xaxis.set_major_formatter(
    ticker.FuncFormatter(lambda x, _: f"${x:,.0f}")
)

plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\top_10_jobs_colombia.png", dpi=300, bbox_inches="tight")
plt.savefig(r"C:\Users\WIN10\Desktop\Job_Analysis_SQL\job_analysis_graphs\top_10_jobs_colombia.pdf", bbox_inches="tight")
plt.show()










