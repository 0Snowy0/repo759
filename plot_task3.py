"""Plot vscale timing vs n for 512 and 16 threads per block.

Usage: python3 plot_task3.py [task3_timings.csv] [task3.pdf]
"""
import csv
import sys

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt

csv_path = sys.argv[1] if len(sys.argv) > 1 else "task3_timings.csv"
out_path = sys.argv[2] if len(sys.argv) > 2 else "task3.pdf"

series = {}
with open(csv_path, newline="") as f:
    for row in csv.DictReader(f):
        tpb = int(row["threads_per_block"])
        series.setdefault(tpb, []).append(
            (int(row["n"]), float(row["milliseconds"]))
        )

fig, ax = plt.subplots(figsize=(7, 4.5))
for tpb, style in ((512, "o-"), (16, "s--")):
    if tpb not in series:
        continue
    pts = sorted(series[tpb])
    ax.plot(
        [n for n, _ in pts],
        [t for _, t in pts],
        style,
        markersize=4,
        label=f"{tpb} threads per block",
    )

ax.set_xscale("log", base=2)
ax.set_yscale("log")
ax.set_xlabel("n (array length)")
ax.set_ylabel("vscale kernel time (ms)")
ax.set_title("vscale timing vs. n")
ax.grid(True, which="both", alpha=0.3)
ax.legend()
fig.tight_layout()
fig.savefig(out_path)
print(f"wrote {out_path}")
