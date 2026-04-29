EXEC sp_configure 'show advanced options', 1
	RECONFIGURE
GO

EXEC sp_configure 'max server memory (MB)', 5120
	RECONFIGURE
GO

EXEC sp_configure 'min server memory (MB)', 1024
	RECONFIGURE
GO
