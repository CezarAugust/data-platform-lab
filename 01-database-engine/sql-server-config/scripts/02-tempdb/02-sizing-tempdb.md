## TEMPDB Design Rationale

The TEMPDB configuration is based on a 2-core CPU system with SSD-backed storage.

### Data files
- 2 data files aligned with CPU cores
- Each file pre-sized to 12 GB to minimize autogrowth events and reduce allocation contention

### Log file
- 4 GB initial size to support internal transaction bursts without frequent growth

### Growth strategy
- Fixed 512 MB growth increments
- Avoids percentage-based growth to ensure predictable I/O behavior

### Design rationale
- Multi-file structure reduces PFS/GAM/SGAM contention
- Pre-sizing reduces fragmentation and runtime overhead
- Fixed growth ensures stable performance under OLTP workload simulation
