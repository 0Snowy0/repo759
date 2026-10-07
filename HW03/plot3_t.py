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
ts, ms = load("times_t.txt")
plt.figure(figsize=(6, 4))
plt.semilogx(ts, ms, marker="o")
plt.xlabel("Number of threads t")
plt.ylabel("msort time (ms)")
plt.title("msort time vs. threads (n = 10^6)")
plt.xticks(range(1, 21))
plt.grid(True)
plt.tight_layout()
plt.savefig("task3_t.pdf")