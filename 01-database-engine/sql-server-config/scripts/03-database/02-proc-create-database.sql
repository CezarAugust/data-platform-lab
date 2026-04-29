	
	USE master
	GO

	CREATE PROCEDURE dbo.Sp_DBA_CreateDatabase_Standard

	(
	    @DatabaseName SYSNAME = NULL,
	    @DataPath NVARCHAR(260) = NULL,
	    @LogPath NVARCHAR(260) = NULL,
		@Size NVARCHAR(260) = NULL,
		@AutoGrowth Nvarchar(260)= NULL
	)
	
	AS
	
	BEGIN
    
	SET NOCOUNT ON

	IF 

		@DatabaseName IS NULL AND
	    @DataPath IS NULL AND
	    @LogPath IS NULL AND
		@Size IS NULL AND
		@AutoGrowth  IS NULL

	BEGIN

	PRINT (
	'
	===========================================
	Procedure: DBA_CreateDatabase_Standard
	===========================================
	
	Parameters:
	
	@DatabaseName : Name Database
	@DataPath     : Path DATA (.mdf)
	@LogPath      : Path LOG (.ldf)
	@Size = Database size in mb, 
	@AutoGrowth = Size Auto Growth in mb
	
	Example:
	
	EXEC dbo.DBA_CreateDatabase_Standard
	    @DatabaseName = ''LabDB'',
	    @DataPath = ''F:\data\'',
	    @LogPath = ''G:\log\'',
		@Size = 2096, 
		@AutoGrowth = 1096
	
	===========================================
	'
		)

		RETURN

		END

    DECLARE @SQL NVARCHAR(MAX)

    -- ============================================
    -- 1. Validate if the database already exists.
    -- ============================================

    IF EXISTS (SELECT 1 FROM sys.databases WHERE name = @DatabaseName)
    BEGIN
        RAISERROR('Database already exists.', 16, 1)
        RETURN
    END

    -- ============================================
    -- 2. VALIDATE PATHS
    -- ============================================
	
	SET @DataPath = ISNULL(@DataPath, 'F:\data\')
	SET @LogPath  = ISNULL(@LogPath,  'G:\log\')
	SET @Size = IIF(RIGHT(UPPER(@Size),2) =  'MB',@Size,CONCAT(@Size,'MB'))
	SET @AutoGrowth = IIF(RIGHT(UPPER(@AutoGrowth),2) =  'MB',@AutoGrowth,CONCAT(@AutoGrowth,'MB'))


	DECLARE @DataExists INT, @LogExists INT;

    EXEC master.dbo.xp_fileexist @DataPath, @DataExists OUTPUT
    EXEC master.dbo.xp_fileexist @LogPath, @LogExists OUTPUT

    IF (@DataExists = 0 OR @LogExists = 0)
    BEGIN
        RAISERROR('Data or Log path does not exist.', 16, 1)
        RETURN
    END

    -- ============================================
    -- 3. CREATE DATABASE
    -- ============================================

    SET @SQL = '
    CREATE DATABASE [' + @DatabaseName + ']
    ON PRIMARY
    (
        NAME = ' + @DatabaseName + '_data,
        FILENAME = ''' + @DataPath + @DatabaseName + '.mdf'',
        SIZE = ' + @Size + ',
        FILEGROWTH = ' + @AutoGrowth + '
    )
    LOG ON
    (
        NAME = ' + @DatabaseName + '_log,
        FILENAME = ''' + @LogPath + @DatabaseName + '.ldf'',
        SIZE = 256MB,
        FILEGROWTH = 256MB
    );
    '

    EXEC(@SQL)

    -- ============================================
    -- 4. CONFIGURAÇÕES PADRÃO
    -- ============================================

    SET @SQL = '
    ALTER DATABASE [' + @DatabaseName + '] SET RECOVERY FULL;
    ALTER DATABASE [' + @DatabaseName + '] SET READ_COMMITTED_SNAPSHOT ON;
    ALTER DATABASE [' + @DatabaseName + '] SET AUTO_CLOSE OFF;
    ALTER DATABASE [' + @DatabaseName + '] SET AUTO_SHRINK OFF;
    ALTER DATABASE [' + @DatabaseName + '] SET PAGE_VERIFY CHECKSUM;
    ALTER DATABASE [' + @DatabaseName + '] SET AUTO_UPDATE_STATISTICS ON;
    ALTER DATABASE [' + @DatabaseName + '] SET AUTO_UPDATE_STATISTICS_ASYNC ON;
    ';

    EXEC(@SQL)

    -- ============================================
    -- 5. EXECUTION LOG
    -- ============================================
    
	PRINT 'Database created successfully: ' + @DatabaseName

	END
