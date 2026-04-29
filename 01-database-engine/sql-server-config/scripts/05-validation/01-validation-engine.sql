
	-- Informations Virtual Machine (Sql Server)
	
	SELECT 
	    cpu_count,
	    scheduler_count,
	    physical_memory_kb / 1024 AS memory_mb
	FROM sys.dm_os_sys_info
	Go

	-- Informations Database Engine

	SELECT 
	   
	   SERVERPROPERTY('productversion') VersaoSQL, 
       SERVERPROPERTY ('edition') Edicao,
	   SERVERPROPERTY('InstanceDefaultDataPath') LOCALIZACAO_DADOS,
	   SERVERPROPERTY('InstanceDefaultLogPath') LOCALIZACAO_LOGS,
	   SERVERPROPERTY('ServerName') SERVERNAME,
	   SERVERPROPERTY('InstanceName') INSTANCIA,
	   SERVERPROPERTY('IsHadrEnabled') HADR_Habilitado 
	   Go

	   -- Version Complete
	   
	   Select 
			@@VERSION As Version_Complete_Db
		Go

	   -- Language 

		Select 
			@@Language As Language_DB
		Go

	   -- Service Local

	   Select 
			@@SERVICENAME As Name_Service
		Go


		-- Information Path Databases
		
		Select 
			Name
			,crdate 
			,filename

				From Sysdatabases
			Go

		-- Information Databases

		Select 
			 Name
		    ,Create_Date 
			,Recovery_Model_Desc
			,compatibility_level
			,collation_name
			,is_read_committed_snapshot_on
			,state_desc

				From sys.databases
			Go


		-- TEMPDB validation

		Use tempdb
		Go
		
		Select
		
			 name
			,physical_name
			,(size * 8 / 1024) As size_mb
		
		From sys.database_files
		Go

