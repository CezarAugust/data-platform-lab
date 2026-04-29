-- CPU / Parallelism configuration

EXEC sp_configure 'max degree of parallelism', 0
	RECONFIGURE
GO

EXEC sp_configure 'cost threshold for parallelism', 50
	RECONFIGURE
GO
