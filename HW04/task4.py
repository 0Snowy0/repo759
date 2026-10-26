import pandas as pd
import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt

df = pd.read_csv("task4_times.csv")
mean = df.groupby(["schedule", "threads"], as_index=False)["time_ms"].min()

schedules = ["static", "dynamic", "guided"]
fig, axes = plt.subplots(1, 3, figsize=(15, 4.5), sharey=True)

for ax, s in zip(axes, schedules):
    d = mean[mean["schedule"] == s].sort_values("threads")
    ax.plot(d["threads"], d["time_ms"], marker="o")
    ax.set_title(f"schedule({s})")
    ax.set_xlabel("Number of threads")
    ax.set_xticks(range(1, 9))
    ax.grid(True, alpha=0.3)

axes[0].set_ylabel("Time (ms)")
fig.suptitle("N-body simulation time vs. number of threads")
fig.tight_layout()
fig.savefig("task4.pdf")
print(mean.to_string(index=False))