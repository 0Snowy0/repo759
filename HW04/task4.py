import sys

import matplotlib
import pandas as pd

matplotlib.use("Agg")
import matplotlib.pyplot as plt

csv = sys.argv[1] if len(sys.argv) > 1 else "task4.csv"
df = pd.read_csv(csv)

best = df.groupby(["schedule", "threads"], as_index=False)["time_ms"].mean()

schedules = ["static", "dynamic", "guided"]
ymax = best["time_ms"].max() * 1.05  # same y-range in every plot, so they compare


def draw(ax, s):
    d = best[best["schedule"] == s].sort_values("threads")
    ax.plot(d["threads"], d["time_ms"], marker="o")
    ax.set_title(f"schedule({s})")
    ax.set_xlabel("Number of threads")
    ax.set_ylabel("Time (ms)")
    ax.set_xticks(range(1, 9))
    ax.set_ylim(0, ymax)
    ax.grid(True, alpha=0.3)


# One PDF per scheduling policy
for s in schedules:
    fig, ax = plt.subplots(figsize=(5.5, 4.5))
    draw(ax, s)
    fig.tight_layout()
    fig.savefig(f"task4_{s}.pdf")
    plt.close(fig)

fig, axes = plt.subplots(1, 3, figsize=(15, 4.5), sharey=True)
for ax, s in zip(axes, schedules):
    draw(ax, s)
fig.suptitle("N-body simulation time vs. number of threads (best of 3 runs)")
fig.tight_layout()
fig.savefig("task4.pdf")

print(best.to_string(index=False))