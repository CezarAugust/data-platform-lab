# DBA Dash – Observability Design & Setup

## Purpose

This document describes the role of **DBA Dash** within the lab architecture, focusing on:

* Why it is used
* Where it fits in the environment
* How it complements other observability components

This is **not a step-by-step installation guide**, but a reference for architectural decisions and operational usage.

---

##  Context

The project adopts a hybrid observability approach combining:

* Native SQL Server monitoring
* Custom data collection (Python)
* Visualization layer (Grafana)

Within this context, DBA Dash is used as a **specialized SQL Server diagnostics tool**.

---

##  Architecture Position

```text
SQL Server (Primary DB VM)
        ↓
DBA Dash Collector
        ↓
Repository Database (DBADashDB)
        ↓
DBA Dash UI
```

### Deployment

* Hosted on: `vm-monitoring`
* Connects to: `vm-primary-db`
* Stores data in: dedicated repository database

---

##  Design Decision

### Why DBA Dash?

| Capability               | Reason                                 |
| ------------------------ | -------------------------------------- |
| Wait statistics analysis | Fast identification of bottlenecks     |
| Historical performance   | Native persistence without custom code |
| Low setup complexity     | Faster baseline visibility             |

---

### Why not only Grafana?

Grafana requires:

* Custom data pipelines
* Query design
* Metric modeling

DBA Dash provides:

✔ ready-to-use SQL Server insights
✔ no initial modeling effort

---

### Why not only Python Agent?

The Python agent is designed for:

* Custom metrics
* Integration with external systems
* Flexible data pipelines

However, it requires:

* Development effort
* Maintenance

DBA Dash complements it by providing **instant diagnostics**

---

##  Configuration Principles

Only key configurations are documented here:

### Repository Database

* Dedicated database (`DBADashDB`)
* Isolated from production workloads

---

### Data Collection Strategy

| Metric      | Frequency | Rationale                  |
| ----------- | --------- | -------------------------- |
| Wait Stats  | 1–5 min   | Detect contention patterns |
| CPU         | 1 min     | Near real-time visibility  |
| Blocking    | 30 sec    | Critical for OLTP          |
| File Growth | 5–15 min  | Capacity planning          |

---

### Access & Permissions

* Prefer least privilege access
* Avoid sysadmin when possible
* Restrict network access to monitoring VM

---

## Security Considerations

* Monitoring tools must not increase attack surface
* Credentials should not be hardcoded
* Access limited to internal network

---

## Operational Usage

DBA Dash is primarily used for:

### Rapid Diagnostics

* Identify top waits
* Detect blocking chains
* Analyze query performance spikes

---

### Baseline Validation

* Compare expected vs actual performance
* Validate configuration changes (e.g., MAXDOP, TempDB)

---

### Cross-Validation

Used alongside:

* Python agent → custom metrics
* Grafana → visualization

---

##  Integration with Project

| Component    | Role                   |
| ------------ | ---------------------- |
| Python Agent | Custom data collection |
| Grafana      | Visualization          |
| DBA Dash     | Deep SQL diagnostics   |

---

## Limitations

* Not designed for full observability pipelines
* Limited integration with external systems
* UI-driven (less flexible than code-based approaches)

---

## Conclusion

DBA Dash plays a focused role in the architecture:

> Fast, reliable SQL Server diagnostics with minimal setup

It is not a replacement for custom observability solutions, but a **complementary tool** that accelerates troubleshooting and baseline analysis.

---
