USE master
GO

-- Change folder path
-- Resize primary data file
ALTER DATABASE tempdb 
	MODIFY FILE (NAME = tempdev,FILENAME = 'E:\tempdb\DATA\tempdev.mdf', SIZE = 12336MB, FILEGROWTH = 512MB)

-- Add second data file

ALTER DATABASE tempdb 
	ADD FILE (NAME = temp2,FILENAME = 'E:\tempdb\DATA\temp2.ndf' , SIZE = 12336MB, FILEGROWTH = 512MB)
GO

-- Log file
ALTER DATABASE tempdb 
	MODIFY FILE (NAME = templog, FILENAME = 'E:\tempdb\LOG\templog.ldf', SIZE = 4096MB, FILEGROWTH = 512MB)
GO

-- TEMPDB validation and configuration

USE tempdb
GO

SELECT 

	 name
	,physical_name
	,(size * 8 / 1024) As size_mb

FROM sys.database_files
GO
