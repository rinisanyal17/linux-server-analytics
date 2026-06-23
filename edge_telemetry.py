#!/usr/bin/env python3
import subprocess
import json
import sys
import time

def get_cpu_usage_pct():
    """
    Reads /proc/stat directly to calculate active CPU utilization
    without process invocation overhead.
    """
    try:
        with open('/proc/stat', 'r') as f:
            first_line = f.readline()
        
        # Split the string: ['cpu', 'user', 'nice', 'system', 'idle', ...]
        fields = first_line.split()
        
        # Convert all string values to integers, skipping the word 'cpu'
        cpu_ticks = [int(x) for x in fields[1:]]
        
        # Index 3 is 'idle' time
        idle_time = cpu_ticks[3]
        total_time = sum(cpu_ticks)
        
        return {
            "idle": idle_time,
            "total": total_time
        }
    except Exception:
        return None

def get_system_telemetry():
    telemetry = {
        "node_metadata": {
            "machine_arch": "raspberrypi4-64",
            "os_target": "yocto-bsp-platform"
        },
        "metrics": {}
    }
    
    try:
        # --- CPU TELEMETRY SAMPLE 1 ---
        sample1 = get_cpu_usage_pct()
        time.sleep(0.1) # Short sleep to calculate the delta
        sample2 = get_cpu_usage_pct()
        
        if sample1 and sample2:
            delta_idle = sample2["idle"] - sample1["idle"]
            delta_total = sample2["total"] - sample1["total"]
            cpu_pct = round((1.0 - (delta_idle / delta_total)) * 100, 2)
        else:
            cpu_pct = 0.0

        # --- MEMORY TELEMETRY ---
        result = subprocess.run(['free', '-m'], capture_output=True, text=True, check=True)
        lines = result.stdout.splitlines()
        mem_row = lines[1].split()
        
        total_mem = float(mem_row[1])
        free_mem = float(mem_row[3])
        used_mem = float(mem_row[2])
        used_pct = round((used_mem / total_mem) * 100, 2)
        
        # --- INJECT INTO PAYLOAD ---
        telemetry["metrics"]["memory_total_mb"] = total_mem
        telemetry["metrics"]["memory_free_mb"] = free_mem
        telemetry["metrics"]["memory_used_pct"] = used_pct
        telemetry["metrics"]["cpu_used_pct"] = cpu_pct
        
        # Serialize and Print
        print(json.dumps(telemetry, indent=4))
        
    except subprocess.CalledProcessError as e:
        print(f"Kernel telemetric execution failure: {e}", file=sys.stderr)
    except Exception as e:
        print(f"Parsing runtime error: {e}", file=sys.stderr)

if __name__ == "__main__":
    get_system_telemetry()
