import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
 
def load(path):
    x, y = [], []
    with open(path) as f:
        for line in f:
            a, b = line.split()
            x.append(int(a)); y.append(float(b))
    return x, y
 
# time vs ts, linear (y) - log (x)
ts, ms = load("times_ts.txt")
plt.figure(figsize=(6, 4))
plt.semilogx(ts, ms, marker="o", base=2)
plt.xlabel("Threshold ts")
plt.ylabel("msort time (ms)")
plt.title("msort time vs. threshold (n = 10^6, t = 8)")
plt.grid(True)
plt.tight_layout()
plt.savefig("task3_ts.pdf")
best = ts[ms.index(min(ms))]
print("best ts =", best)