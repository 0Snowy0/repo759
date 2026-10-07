import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
 
t, ms = [], []
with open("times1.txt") as f:
  for line in f:
    a, b = line.split()
    t.append(int(a)); ms.append(float(b))
 
plt.figure(figsize=(6, 4))
plt.plot(t, ms, marker="o")
plt.xlabel("Number of threads t")
plt.ylabel("mmul time (ms)")
plt.title("mmul time vs. threads (n = 1024)")
plt.xticks(range(1, 21))
plt.grid(True)
plt.tight_layout()
plt.savefig("task1.pdf")