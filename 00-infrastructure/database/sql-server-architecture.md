# 🗄️ SQL Server – Infrastructure Setup & Design

## Purpose

This document defines how SQL Server is provisioned and configured at the infrastructure level within this lab environment.

It establishes:

* Deployment standards
* Storage architecture
* Instance-level configuration principles
* Integration with observability and automation layers

This document represents the **design contract** of the SQL Server instance.

---

## Context

SQL Server is the core component of the data platform, supporting:

* OLTP workload simulation
* Performance tuning scenarios
* Observability pipelines

It runs on a dedicated virtual machine:

* Host: `vm-primary-db`

---

## Architecture Position


Application / Workload
        ↓
SQL Server Instance
        ↓
Data Files (F:\data)
Log Files  (G:\log)
```

---

## Deployment Model

### Instance Type

* Standalone SQL Server instance
* Developer/Enterprise edition (lab context)
* Default port: `1433`

---

### Collation

* `SQL_Latin1_General_CP1_CI_AI`

This collation is enforced at instance level to ensure consistency across:

* System databases
* TempDB
* User databases

---

### Authentication Mode

* Mixed Mode (SQL Server + Windows)

---

## Storage Architecture

The environment uses **physically separated SSDs** for each workload type:

| Component    | Path         | Purpose                                 |
| ------------ | ------------ | --------------------------------------- |
| Data Files   | `F:\data\`   | Query processing & reads                |
| Log Files    | `G:\log\`    | Transaction logging (sequential writes) |
| Backup Files | `E:\backup\` | Backup operations                       |

---

### Design Rationale

| Decision                        | Impact                                            |
| ------------------------------- | ------------------------------------------------- |
| Separate disks for Data and Log | Eliminates I/O contention                         |
| Dedicated backup location       | Prevents interference with transactional workload |
| Fixed growth (MB)               | Avoids file fragmentation                         |

---

## Default Paths Configuration

Configured at instance level:

* Default Data → `F:\data`
* Default Log → `G:\log`
* Default Backup → `E:\backup`

---

## Instance-Level Configuration

Key configurations applied:

| Setting                        | Purpose                                 |
| ------------------------------ | --------------------------------------- |
| Max Server Memory              | Prevent OS resource starvation          |
| MAXDOP                         | Control parallel query execution        |
| Cost Threshold for Parallelism | Prevent inefficient parallel plans      |
| Optimize for Ad Hoc Workloads  | Reduce plan cache pressure              |
| Error Log Retention            | Improve diagnostics and troubleshooting |

---

## Security Baseline

The instance is configured to minimize attack surface and enforce secure defaults.

### Principles

* Least privilege access
* Feature minimization
* Explicit enablement only when required

### Controls Applied

* `xp_cmdshell` disabled → blocks OS command execution
* OLE Automation disabled → reduces COM exposure
* CLR disabled → prevents unmanaged code execution

---

## TempDB Strategy

TempDB is configured to support concurrency and reduce contention:

* Multiple data files (aligned with CPU count)
* Pre-sized files
* Fixed growth configuration

### Objective

* Reduce allocation contention
* Improve workload scalability
* Maintain predictable performance

---

## Recovery Model

* Default: FULL

Enables:

* Point-in-time recovery
* Transaction log backup strategy

---

## Backup Strategy

Backups are automated via SQL Server Agent jobs.

### Strategy

* Full backups → daily
* Transaction log backups → interval-based
* Retention policy → automated cleanup

### Implementation

Defined in:

* `../../05-alerting-automation/backup`

---

## Observability Integration

The SQL Server instance integrates with multiple observability layers:

### Components

* DBA Dash → fast diagnostics and performance analysis
* Python Agent → custom metrics collection
* Grafana → visualization layer

---

### Data Flow


SQL Server
   ↓
Python Agent → Grafana
   ↓
DBA Dash (direct diagnostics)
```

---

### References

* `../../03-observability`
* `../../04-visualization`

---

## Implementation Reference

All configurations defined in this document are applied via:

* `../../01-database-engine/sql-server-config`

This ensures consistency, repeatability, and automation.

---

## Limitations

This lab environment is not production-grade and includes:

* Limited CPU resources
* Reduced memory capacity
* No high availability (HA/DR) configuration

These constraints are acceptable for:

* Learning
* Testing
* Architectural validation

---

## Lab Considerations

This environment is designed for:

* Experimentation
* Performance testing
* Observability integration

Not intended for production SLAs or mission-critical workloads.

---

## Conclusion

This SQL Server setup provides a structured and consistent foundation for the data platform.

It enables:

* Predictable performance through I/O isolation
* Controlled data growth
* Secure baseline configuration
* Integration with monitoring and automation tools

---

## Key Principle

> Infrastructure defines the standard — configuration enforces it.

---
