#  VM Primary Database (SQL Server)

## Overview

This virtual machine is the primary database node of a production-like SQL Server lab environment.

It is designed for performance analysis, workload simulation, and study of database engine behavior under constrained resources.

---

## Role in the Lab Architecture

This VM represents the core transactional database engine.

It is responsible for:

- OLTP workload processing
- Transactional operations (INSERT, UPDATE, DELETE)
- Query execution for simulated applications
- Maintaining data consistency and integrity
- Log generation and write-ahead logging behavior

---

## Compute Specifications

- 2 vCPUs
- 16 GB RAM
- Cloud-based Virtual Machine

---

##  Storage Layout

| Volume | Purpose |
|--------|--------|
| C: | Operating system and SQL Server binaries |
| D: | TEMPDB (temporary objects, spills, sorts) |
| F: | DATA files (tables, indexes, user data) |
| G: | LOG files (transaction log, sequential writes) |
| H: | BACKUP storage |

---

## 🔄 Workload Characteristics

This environment simulates:

- High-concurrency OLTP workloads
- Mixed read/write operations
- TEMPDB pressure under heavy sorting and hashing
- IO contention scenarios across multiple volumes
- Transaction log write sensitivity

---

##  Observability Focus

This VM is used to analyze:

- CPU utilization under parallel queries
- TEMPDB contention (latch and allocation pressure)
- IO latency differences across disks
- Transaction log write performance
- Query execution behavior under stress

---

## Design Decisions

- TEMPDB isolated to reduce allocation contention
- LOG separated for sequential write optimization
- DATA isolated to reduce read/write interference
- Storage separation to emulate production-like architecture patterns

---

##  Constraints

- Limited compute (2 vCPUs, 8 GB RAM)
- Virtualized storage performance variability
- No high availability or clustering in this stage

---

##  Purpose

This VM is part of a **database performance engineering lab**, used for:

- Query tuning experiments
- Performance benchmarking
- Bottleneck identification
- TEMPDB contention analysis
- IO latency studies

---

## 🔮 Future Evolution

This node may later evolve into:

- Primary replica in a high availability topology
- Part of a failover simulation architecture
- Integrated with observability and automation layers
