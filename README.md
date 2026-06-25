
# Linux Server Performance Telemetry Framework

A production-grade, lightweight shell telemetry framework designed to capture, parse, and analyze real-time Linux core system performance metrics. Integrated into a Continuous Integration (CI) engine using a declarative automation pipeline.

## 🛠️ Features & Telemetry Metrics Captured

This framework bypasses heavy monitoring agents by interacting directly with core Linux pseudo-filesystems and system utilities to execute real-time stream processing:

* **OS Distribution Tracking:** Parses `/etc/os-release` to extract the host's precise operating system deployment info.
* **Workload & Load Average:** Utilizes `uptime` stream parsing to evaluate system pressure thresholds across 1, 5, and 15-minute intervals.
* **CPU Consumption Metrics:** Computes delta cycles between active and idle CPU states (`top -bn1`) to provide accurate absolute usage percentages.
* **Memory Optimization Analytics:** Tracks memory usage maps (`free -m`) calculating Used vs. Total capacities alongside dynamic percentage allocations.
* **Storage Capacity Mapping:** Monitors root storage health (`df -h`) isolating disk usage and threshold consumption limits.
* **Security & Session Auditing:** Monitors active user shell allocations (`who | wc -l`) for infrastructure audit tracking.
* **Process Isolation:** Isolates and flags the top 5 heavy-consumer process IDs (PIDs) currently consuming active CPU workloads.

## 🏗️ Architecture & CI Pipeline

The script is fully automated via a core Continuous Integration deployment loop. Upon every structural revision, the system triggers a declarative pipeline sequence:

1. **Source Code Execution:** Webhook/Manual execution signals the automated engine.
2. **Environment Synchronization:** Code assets are fetched from the remote version-control engine.
3. **Execution Runtime:** Grants automated operational permissions (`chmod +x`) and runs the core telemetry analytics module.

## 🚀 Local Deployment & Execution

### Prerequisites
Ensure your local environment has executable shell access:
```bash
# Verify execution environment
uname -a

Author : Rini Sanyal
