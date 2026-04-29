	
	-- Options Advanced
	EXEC sp_configure 'show advanced options', 1
		RECONFIGURE
	GO

	-- Agent Enable
	EXEC sp_configure 'Agent XPs', 1
		RECONFIGURE
	GO

	-- Check Service Agent Script
	EXEC xp_servicecontrol 'QUERYSTATE', 'SQLServerAgent'
	GO

	-- Aditional Category (Dba)
	EXEC msdb.dbo.sp_add_category
   	 @class = 'JOB',
   	 @type = 'LOCAL',
   	 @name = 'DBA Maintenance'
	GO

	-- History Volume Jobs
	EXEC msdb.dbo.sp_set_sqlagent_properties
   	 @jobhistory_max_rows = 10000,
   	 @jobhistory_max_rows_per_job = 1000
	GO
