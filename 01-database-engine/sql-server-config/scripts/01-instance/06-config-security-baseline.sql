	USE master
	GO
	
	PRINT '=== SECURITY BASELINE START ==='
	GO

		SET NOCOUNT ON
	
	-- ADVANCED OPTIONS
	
	EXEC sp_configure 'show advanced options', 1
		RECONFIGURE
	GO

	-- XP_CMDSHELL

	EXEC sp_configure 'xp_cmdshell', 0
		RECONFIGURE
	GO
	
	-- OLE AUTOMATION
	
	EXEC sp_configure 'ole automation procedures', 0
		RECONFIGURE
	GO
		
	-- CLR (Common Language Runtime)
	
	EXEC sp_configure 'clr enabled', 0
		RECONFIGURE
	GO
	
	-- AD HOC DISTRIBUTED QUERIES
	
	EXEC sp_configure 'Ad Hoc Distributed Queries', 0
		RECONFIGURE
	GO
	
	-- CROSS DATABASE OWNERSHIP CHAINING

	EXEC sp_configure 'cross db ownership chaining', 0
		RECONFIGURE
	GO
	
	-- REMOTE ADMIN CONNECTION (DAC)

	EXEC sp_configure 'remote admin connections', 1
		RECONFIGURE
	GO
	
	-- LOGIN AUDITING

	EXEC xp_instance_regwrite
    N'HKEY_LOCAL_MACHINE',
    N'Software\Microsoft\MSSQLServer\MSSQLServer',
    N'AuditLevel',
    REG_DWORD,
    2; 
	GO
	
	-- DEFAULT TRACE

	EXEC sp_configure 'default trace enabled', 1;
		RECONFIGURE
	GO

	 -- CONTAINED DATABASE AUTHENTICATION

	EXEC sp_configure 'contained database authentication', 0
		RECONFIGURE
	GO
	
	-- PRIORITY BOOST

	EXEC sp_configure 'priority boost', 0
		RECONFIGURE
	GO
	
	-- LIGHTWEIGHT POOLING
	
	EXEC sp_configure 'lightweight pooling', 0
		RECONFIGURE
	GO
	
	
	PRINT '=== SECURITY BASELINE END ==='
	GO
