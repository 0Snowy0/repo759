import matplotlib.pyplot as plt

def load(path):
  """Read 'n time' pairs, skipping blank or broken lines."""
  ns, ts = [], []
  with open(path) as f:
    for line in f:
      parts = line.split()
      if len(parts) != 2:
        print(f"{path}: skipping line {line.strip()!r}")
        continue
      ns.append(int(parts[0]))
      ts.append(float(parts[1]))
  return ns, ts

def plot(task, threads_list, title, outfile):
  plt.figure(figsize=(7, 5))
  for threads in threads_list:
    ns, ts = load(f"{task}_{threads}.dat")
    plt.plot(ns, ts, marker="o", label=f"threads_per_block = {threads}")
  plt.xscale("log", base=2)
  plt.yscale("log")
  plt.xlabel("n")
  plt.ylabel("Time (ms)")
  plt.title(title)
  plt.grid(True, which="both", alpha=0.3)
  plt.legend()
  plt.tight_layout()
  plt.savefig(outfile)
  plt.close()
  print(f"Wrote {outfile}")

plot("task1", [1024, 512], "matmul time vs n", "task1.pdf")
plot("task2", [1024, 512], "stencil time vs n (R = 128)", "task2.pdf")