BEGIN TRANSACTION TransactionOne

	CREATE TABLE [dbo].[ExtendedApiResources] (
	    [Id]              NVARCHAR (450) NOT NULL,
	    [ApiResourceName] NVARCHAR (200) NOT NULL,
	    [NormalizedName]  NVARCHAR (200) NOT NULL,
	    [Reserved]        BIT            NOT NULL,
	    CONSTRAINT [PK_ExtendedApiResources] PRIMARY KEY CLUSTERED ([Id] ASC)
	);
	
	CREATE UNIQUE NONCLUSTERED INDEX [ApiNameIndex]
	    ON [dbo].[ExtendedApiResources]([ApiResourceName] ASC);
	
	CREATE UNIQUE NONCLUSTERED INDEX [ApiResourceNameIndex]
	    ON [dbo].[ExtendedApiResources]([NormalizedName] ASC);
	
	CREATE TABLE [dbo].[ExtendedClients] (
	    [Id]                   NVARCHAR (450) NOT NULL,
	    [ClientId]             NVARCHAR (200) NOT NULL,
	    [Description]          NVARCHAR (MAX) NULL,
	    [NormalizedClientId]   NVARCHAR (200) NOT NULL,
	    [NormalizedClientName] NVARCHAR (200) NULL,
	    [Reserved]             BIT            NOT NULL
	    CONSTRAINT [PK_ExtendedClients] PRIMARY KEY CLUSTERED ([Id] ASC)
	);
	
	CREATE UNIQUE NONCLUSTERED INDEX [ClientIdIndex]
	    ON [dbo].[ExtendedClients]([NormalizedClientId] ASC);
	
	CREATE UNIQUE NONCLUSTERED INDEX [ClientNameIndex]
	    ON [dbo].[ExtendedClients]([NormalizedClientName] ASC) WHERE ([NormalizedClientName] IS NOT NULL);
	
	CREATE UNIQUE NONCLUSTERED INDEX [IdIndex]
	    ON [dbo].[ExtendedClients]([ClientId] ASC);
	
	CREATE TABLE [dbo].[ExtendedIdentityResources] (
	    [Id]                   NVARCHAR (450) NOT NULL,
	    [IdentityResourceName] NVARCHAR (200) NOT NULL,
	    [NormalizedName]       NVARCHAR (200) NOT NULL,
	    [Reserved]             BIT            NOT NULL,
	    CONSTRAINT [PK_ExtendedIdentityResources] PRIMARY KEY CLUSTERED ([Id] ASC)
	);
	
	CREATE UNIQUE NONCLUSTERED INDEX [IdentityNameIndex]
	    ON [dbo].[ExtendedIdentityResources]([IdentityResourceName] ASC);
	
	CREATE UNIQUE NONCLUSTERED INDEX [IdentityResourceNameIndex]
	    ON [dbo].[ExtendedIdentityResources]([NormalizedName] ASC);
			
	IF (NOT EXISTS (SELECT * 
	                 FROM INFORMATION_SCHEMA.TABLES 
	                 WHERE TABLE_SCHEMA = 'dbo' 
	                 AND  TABLE_NAME = '__EFMigrationsHistory'))
	BEGIN
		CREATE TABLE [dbo].[__EFMigrationsHistory](
			[MigrationId] [nvarchar](150) NOT NULL,
			[ProductVersion] [nvarchar](32) NOT NULL,
		 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
		(
			[MigrationId] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]
	END
	
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20171026080114_InitialSqlServerConfigurationDbMigration', '2.1.4-rtm-31024')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20171026080756_InitialSqlServerOperationalDbMigration', '2.1.4-rtm-31024')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20171026080835_InitialSqlServerExtendedConfigurationDbMigration', '2.1.4-rtm-31024')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20171122163758_UserSearchOptimizationOperationalDbMigration', '2.1.4-rtm-31024')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20171122163636_UserSearchOptimizationConfigurationDbMigration', '2.1.4-rtm-31024')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20181109163923_IdentityServer2.3SqlServerConfigurationDbMigration', '2.1.4-rtm-31024')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20181109164134_IdentityServer2.3SqlServerSqlServerOperationalDbMigration', '2.1.4-rtm-31024')

	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20200702075849_V3toV4SqlServerConfigurationDbMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20200702080430_V3toV4SqlServerOperationalDbMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20210602104947_IdentityProvidersSqlServerConfigurationMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20210106132452_DuendeSqlServerConfigurationMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20210105164242_DuendeSqlServerMigrationOperational', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20210602110024_PersistedGrantConsumeTimeSqlServerOperationalMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20220104130635_DuendeV6SqlServerConfigurationMigration', '6.0.3')

COMMIT TRANSACTION TransactionOne
