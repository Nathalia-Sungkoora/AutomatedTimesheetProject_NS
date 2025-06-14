USE [master]
GO

/****** CREATE DATABASE IF IT DOESN'T EXIST ******/
IF DB_ID('TimesheetDB') IS NULL
BEGIN
    CREATE DATABASE [TimesheetDB]
     CONTAINMENT = NONE
     ON  PRIMARY 
    ( NAME = N'TimesheetDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TimesheetDB.mdf' , SIZE = 139264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
     LOG ON 
    ( NAME = N'TimesheetDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TimesheetDB_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
     WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF;
END
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [TimesheetDB].[dbo].[sp_fulltext_database] @action = 'enable';
END
GO

-- Set various database options
ALTER DATABASE [TimesheetDB] SET ANSI_NULL_DEFAULT OFF;
ALTER DATABASE [TimesheetDB] SET ANSI_NULLS OFF;
ALTER DATABASE [TimesheetDB] SET ANSI_PADDING OFF;
ALTER DATABASE [TimesheetDB] SET ANSI_WARNINGS OFF;
ALTER DATABASE [TimesheetDB] SET ARITHABORT OFF;
ALTER DATABASE [TimesheetDB] SET AUTO_CLOSE OFF;
ALTER DATABASE [TimesheetDB] SET AUTO_SHRINK OFF;
ALTER DATABASE [TimesheetDB] SET AUTO_UPDATE_STATISTICS ON;
ALTER DATABASE [TimesheetDB] SET CURSOR_CLOSE_ON_COMMIT OFF;
ALTER DATABASE [TimesheetDB] SET CURSOR_DEFAULT GLOBAL;
ALTER DATABASE [TimesheetDB] SET CONCAT_NULL_YIELDS_NULL OFF;
ALTER DATABASE [TimesheetDB] SET NUMERIC_ROUNDABORT OFF;
ALTER DATABASE [TimesheetDB] SET QUOTED_IDENTIFIER OFF;
ALTER DATABASE [TimesheetDB] SET RECURSIVE_TRIGGERS OFF;
ALTER DATABASE [TimesheetDB] SET ENABLE_BROKER;
ALTER DATABASE [TimesheetDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF;
ALTER DATABASE [TimesheetDB] SET DATE_CORRELATION_OPTIMIZATION OFF;
ALTER DATABASE [TimesheetDB] SET TRUSTWORTHY OFF;
ALTER DATABASE [TimesheetDB] SET ALLOW_SNAPSHOT_ISOLATION OFF;
ALTER DATABASE [TimesheetDB] SET PARAMETERIZATION SIMPLE;
ALTER DATABASE [TimesheetDB] SET READ_COMMITTED_SNAPSHOT OFF;
ALTER DATABASE [TimesheetDB] SET HONOR_BROKER_PRIORITY OFF;
ALTER DATABASE [TimesheetDB] SET RECOVERY FULL;
ALTER DATABASE [TimesheetDB] SET MULTI_USER;
ALTER DATABASE [TimesheetDB] SET PAGE_VERIFY CHECKSUM;
ALTER DATABASE [TimesheetDB] SET DB_CHAINING OFF;
ALTER DATABASE [TimesheetDB] SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF);
ALTER DATABASE [TimesheetDB] SET TARGET_RECOVERY_TIME = 60 SECONDS;
ALTER DATABASE [TimesheetDB] SET DELAYED_DURABILITY = DISABLED;
ALTER DATABASE [TimesheetDB] SET ACCELERATED_DATABASE_RECOVERY = OFF;
ALTER DATABASE [TimesheetDB] SET QUERY_STORE = ON;
ALTER DATABASE [TimesheetDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON);
ALTER DATABASE [TimesheetDB] SET READ_WRITE;
GO

USE [TimesheetDB]
GO

/****** TABLE: AUDITLOG ******/
IF OBJECT_ID('dbo.AuditLog', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[AuditLog](
	[AuditID] [int] IDENTITY(1,1) NOT NULL,
	  NULL,
	  NULL,
	  NULL,
	  NULL,
	[RowCount] [int] NULL,
	[AuditTime] [datetime] NULL,
	  NULL,
	[EmployeeID] [int] NULL,
	  NULL,
PRIMARY KEY CLUSTERED ([AuditID] ASC)
);
ALTER TABLE [dbo].[AuditLog] ADD DEFAULT (getdate()) FOR [AuditTime];
END
GO

/****** TABLE: CLIENT ******/
IF OBJECT_ID('dbo.Client', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Client](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	  NOT NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED ([ClientID] ASC),
UNIQUE NONCLUSTERED ([ClientName] ASC)
);
ALTER TABLE [dbo].[Client] ADD DEFAULT (getdate()) FOR [CreatedAt];
END
GO

/****** TABLE: DESCRIPTION ******/
IF OBJECT_ID('dbo.Description', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Description](
	[DescriptionID] [int] IDENTITY(1,1) NOT NULL,
	  NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED ([DescriptionID] ASC)
);
ALTER TABLE [dbo].[Description] ADD DEFAULT (getdate()) FOR [CreatedAt];
END
GO

/****** TABLE: EMPLOYEE ******/
IF OBJECT_ID('dbo.Employee', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	  NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED ([EmployeeID] ASC)
);
ALTER TABLE [dbo].[Employee] ADD DEFAULT (getdate()) FOR [CreatedAt];
END
GO

/****** TABLE: EXPENSE ******/
IF OBJECT_ID('dbo.Expense', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Expense](
	[ExpenseID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Month] [date] NULL,
	  NULL,
	  NULL,
	[ZarCost] [decimal](5, 2) NULL,
	[CreatedAt] [date] NULL,
PRIMARY KEY CLUSTERED ([ExpenseID] ASC)
);
ALTER TABLE [dbo].[Expense] ADD DEFAULT (getdate()) FOR [CreatedAt];
ALTER TABLE [dbo].[Expense] WITH CHECK ADD FOREIGN KEY([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]);
END
GO

/****** TABLE: LEAVE ******/
IF OBJECT_ID('dbo.Leave', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Leave](
	[LeaveID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	  NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[NumberOfDays] [decimal](4, 1) NULL,
	  NULL,
	  NULL,
	  NULL,
	[SubmissionDate] [date] NULL,
	[CreatedAt] [date] NULL,
PRIMARY KEY CLUSTERED ([LeaveID] ASC)
);
ALTER TABLE [dbo].[Leave] ADD DEFAULT (getdate()) FOR [CreatedAt];
ALTER TABLE [dbo].[Leave] WITH CHECK ADD FOREIGN KEY([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]);
END
GO

/****** TABLE: TIMESHEET ******/
IF OBJECT_ID('dbo.Timesheet', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Timesheet](
	[TimesheetID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	  NULL,
	[ClientID] [int] NOT NULL,
	  NULL,
	[DescriptionID] [int] NOT NULL,
	  NULL,
	  NULL,
	[TotalHours] [decimal](5, 2) NULL,
	  NULL,
	  NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED ([TimesheetID] ASC)
);
ALTER TABLE [dbo].[Timesheet] ADD DEFAULT (getdate()) FOR [CreatedAt];
ALTER TABLE [dbo].[Timesheet] WITH CHECK ADD FOREIGN KEY([ClientID]) REFERENCES [dbo].[Client] ([ClientID]);
ALTER TABLE [dbo].[Timesheet] WITH CHECK ADD FOREIGN KEY([DescriptionID]) REFERENCES [dbo].[Description] ([DescriptionID]);
ALTER TABLE [dbo].[Timesheet] WITH CHECK ADD FOREIGN KEY([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]);
END
GO

/****** SSIS PROJECT DEPLOYMENT SCRIPT ******/
DECLARE @ProjectBinary VARBINARY(MAX);

-- read the .ispac file as a single BLOB
SELECT @ProjectBinary = BulkColumn
FROM   OPENROWSET(
         BULK '$(IspacFullPath)',         
         SINGLE_BLOB
       ) AS ProjectFile;

EXEC SSISDB.catalog.deploy_project
     @folder_name   = N'Automated_Timesheet_Project',
     @project_name  = N'SSIS_Automated_Timesheet_Project',
     @project_stream= @ProjectBinary,
     @operation_id  = NULL;

EXEC SSISDB.catalog.create_folder 
     @folder_name = N'AutomatedTimesheetProject',
     @folder_id   = NULL;
