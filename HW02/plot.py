import re
import matplotlib.pyplot as plt

ns, times = [], []
with open("scaling.out") as f:
    lines = f.read().splitlines()

i = 0
while i < len(lines):
    m = re.match(r"n=(\d+)", lines[i])
    if m:
        ns.append(int(m.group(1)))
        times.append(float(lines[i + 1]))  # the time line right after n=...
        i += 4  # skip n= line, time, first, last
    else:
        i += 1

plt.figure()
plt.plot(ns, times, marker='o')
plt.xscale('log', base=2)
plt.yscale('log')
plt.xlabel('n (array size)')
plt.ylabel('Time (ms)')
plt.title('scan scaling: time vs n')
plt.grid(True, which='both', ls='--', alpha=0.5)
plt.savefig('task1.pdf')