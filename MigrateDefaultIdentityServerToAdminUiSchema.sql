BEGIN TRANSACTION TransactionOne

	CREATE TABLE [ExtendedApiResources] (
		[Id] nvarchar(450) NOT NULL,
		[ApiResourceName] nvarchar(200) NOT NULL,
		[NormalizedName] nvarchar(200) NOT NULL,
		[Reserved] bit NOT NULL,
		CONSTRAINT [PK_ExtendedApiResources] PRIMARY KEY ([Id])
	);
	
	CREATE UNIQUE NONCLUSTERED INDEX [ApiNameIndex]
	    ON [dbo].[ExtendedApiResources]([ApiResourceName] ASC);
	
	CREATE UNIQUE NONCLUSTERED INDEX [ApiResourceNameIndex]
	    ON [dbo].[ExtendedApiResources]([NormalizedName] ASC);
	
	CREATE TABLE [ExtendedClients] (
		[Id] nvarchar(450) NOT NULL,
		[ClientId] nvarchar(200) NOT NULL,
		[Description] nvarchar(max) NULL,
		[NormalizedClientId] nvarchar(200) NOT NULL,
		[NormalizedClientName] nvarchar(200) NULL,
		[Reserved] bit NOT NULL,
		[ClientType] int NULL,
		CONSTRAINT [PK_ExtendedClients] PRIMARY KEY ([Id])
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
			
	
	CREATE TABLE [ConfigurationEntries] (
		[Key] nvarchar(450) NOT NULL,
		[Value] nvarchar(max) NULL,
		CONSTRAINT [PK_ConfigurationEntries] PRIMARY KEY ([Key])
	);

	UPDATE [dbo].[Clients]
										SET [NonEditable] = e.reserved
										from [dbo].ExtendedClients e
										WHERE [dbo].[Clients].ClientId = e.ClientId

	UPDATE [dbo].[ApiResources]
									SET [NonEditable] = e.reserved
									from [dbo].ExtendedApiResources e
									WHERE [dbo].[ApiResources].Name = e.ApiResourceName

	UPDATE [dbo].[IdentityResources]
									SET [NonEditable] = e.reserved
									from [dbo].ExtendedIdentityResources e
									WHERE [dbo].IdentityResources.Name = e.IdentityResourceName

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
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20180626100745_ConfigurationEntries', '6.0.3');
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20181109163923_IdentityServer2.3SqlServerConfigurationDbMigration', '2.1.4-rtm-31024')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20181109164134_IdentityServer2.3SqlServerSqlServerOperationalDbMigration', '2.1.4-rtm-31024')

	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20200702075849_V3toV4SqlServerConfigurationDbMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20200702080430_V3toV4SqlServerOperationalDbMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20210602104947_IdentityProvidersSqlServerConfigurationMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20210106132452_DuendeSqlServerConfigurationMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20210105164242_DuendeSqlServerMigrationOperational', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20210602110024_PersistedGrantConsumeTimeSqlServerOperationalMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20220104130635_DuendeV6SqlServerConfigurationMigration', '6.0.3')

	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20200626131535_InitialSqlServerDataProtectionKeyMigration', '6.0.3')
	
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20220608091949_Duende61Update', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20220608093217_Duende61ConfigurationUpdate', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20230620153729_Duende63ConfigurationUpdate', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20230901102018_ClaimValueSearchBugFixes', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20240104155203_DuendeV7SqlServerConfigurationMigration', '6.0.3')
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20240108131028_DuendeV7SqlServerOperationalMigration', '6.0.3')
	
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20171122163718_UserSearchOptimizationExtendedConfigurationDbMigration', '8.0.1');
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20181205163055_ExtendedDataMigration2.3', '8.0.1');
	INSERT INTO [dbo].[__EFMigrationsHistory] VALUES ('20190401104724_ClientType', '8.0.1');

COMMIT TRANSACTION TransactionOne