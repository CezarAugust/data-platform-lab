
	USE master
	GO

	-- Standardization

	ALTER DATABASE model SET AUTO_CLOSE OFF
	GO
	ALTER DATABASE model SET AUTO_SHRINK OFF
	GO
	ALTER DATABASE model SET PAGE_VERIFY CHECKSUM
	GO
	ALTER DATABASE model SET RECOVERY FULL
	GO

	-- File Configuration (balanced for lab / production-like) and auto-Growth 
	ALTER DATABASE model 
		MODIFY FILE (NAME = modeldev, SIZE = 2096MB,FILEGROWTH = 1024MB)
	GO
	
	ALTER DATABASE model 		
		MODIFY FILE (NAME = modellog, SIZE = 2096MB,FILEGROWTH = 1024MB)
	GO
