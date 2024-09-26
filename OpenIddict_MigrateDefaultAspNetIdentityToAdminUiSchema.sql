IF((SELECT COUNT(*) FROM [dbo].[AspNetUserClaims] WHERE ClaimType IS NULL) > 0) RAISERROR('All AspNetUserClaims must have a ClaimType value', 16, 1) 
GO

BEGIN TRANSACTION TransactionOne
	ALTER TABLE [dbo].[AspNetRoles] ADD [Description] NVARCHAR(MAX) NULL
	ALTER TABLE [dbo].[AspNetRoles] ADD [Reserved]	  BIT			NOT NULL DEFAULT(0)
	
	ALTER TABLE [dbo].[AspNetRoles] ALTER COLUMN Reserved BIT NOT NULL

	CREATE TABLE [dbo].[AspNetClaimTypes] (
	    [Id]                               NVARCHAR (450) NOT NULL,
	    [ConcurrencyStamp]                 NVARCHAR (MAX) NULL,
	    [DisplayName]                      NVARCHAR (MAX) NULL,
		[Description]                      NVARCHAR (MAX) NULL,
	    [Name]                             NVARCHAR (256) NOT NULL,
	    [NormalizedName]                   NVARCHAR (256) NULL,
	    [Required]                         BIT            NOT NULL,
	    [Reserved]                         BIT            NOT NULL,
	    [Rule]                             NVARCHAR (MAX) NULL,
	    [RuleValidationFailureDescription] NVARCHAR (MAX) NULL,
	    [UserEditable]                     BIT            DEFAULT ((0)) NOT NULL,
	    [ValueType]                        INT            NOT NULL,
	    CONSTRAINT [PK_AspNetClaimTypes] PRIMARY KEY CLUSTERED ([Id] ASC),
	    CONSTRAINT [AK_AspNetClaimTypes_Name] UNIQUE NONCLUSTERED ([Name] ASC)
	);

	CREATE UNIQUE NONCLUSTERED INDEX [ClaimTypeNameIndex] ON [dbo].[AspNetClaimTypes]([NormalizedName] ASC) WHERE ([NormalizedName] IS NOT NULL);
	
	WITH CTE AS (SELECT DISTINCT ClaimType FROM AspNetUserClaims)
	INSERT INTO [dbo].[AspNetClaimTypes] 
		(Id,	  ConcurrencyStamp, Name,		 NormalizedName,   Required, Reserved, ValueType)
	SELECT 
		 NEWID(), NEWID(),		    ClaimType,   UPPER(ClaimType), 0,		 0,		   0
	FROM CTE
			
	ALTER TABLE [dbo].[AspNetUserClaims] ALTER COLUMN ClaimType		NVARCHAR(256) NOT NULL
		
	ALTER TABLE [dbo].[AspNetUserLogins] ALTER COLUMN LoginProvider NVARCHAR(450) NOT NULL
	ALTER TABLE [dbo].[AspnetUserLogins] ALTER COLUMN ProviderKey	NVARCHAR(450) NOT NULL
		
	ALTER TABLE [dbo].[AspNetUserTokens] ALTER COLUMN LoginProvider NVARCHAR(450) NOT NULL
	ALTER TABLE [dbo].[AspNetUserTokens] ALTER COLUMN [Name]		NVARCHAR(450) NOT NULL
	
	ALTER TABLE [dbo].[AspNetUsers] ADD [FirstName]           NVARCHAR (MAX) NULL
	ALTER TABLE [dbo].[AspNetUsers] ADD [LastName]            NVARCHAR (MAX) NULL
	ALTER TABLE [dbo].[AspNetUsers] ADD [IsBlocked]			  BIT			 NOT NULL DEFAULT(0)
	ALTER TABLE [dbo].[AspNetUsers] ADD [IsDeleted]			  BIT			 NOT NULL DEFAULT(0)
		
	ALTER TABLE [dbo].[AspNetUserTokens] DROP CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
	GO

	ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
	GO

	ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
	GO

	ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
	GO

	ALTER TABLE [dbo].[AspNetUsers] DROP CONSTRAINT [PK_AspNetUsers]
		
	ALTER TABLE [dbo].[AspNetUsers] ADD CONSTRAINT [PK_AspNetUsers] PRIMARY KEY NONCLUSTERED ([Id] ASC)
	
	ALTER TABLE [dbo].[AspNetUserTokens] ADD CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY (UserId) REFERENCES [dbo].[AspNetUsers] ([Id])
	ALTER TABLE [dbo].[AspNetUserRoles]  ADD CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]  FOREIGN KEY (UserId) REFERENCES [dbo].[AspNetUsers] ([Id])
	ALTER TABLE [dbo].[AspNetUserRoles]  ADD CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY (UserId) REFERENCES [dbo].[AspNetUsers] ([Id])
	ALTER TABLE [dbo].[AspNetUserClaims] ADD CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY (UserId) REFERENCES [dbo].[AspNetUsers] ([Id])


	ALTER TABLE [dbo].[AspNetUsers] ADD [NormalizedFirstName] NVARCHAR(256) NULL;
	ALTER TABLE [dbo].[AspNetUsers] ADD [NormalizedLastName] NVARCHAR(256) NULL;
	CREATE INDEX [FirstNameIndex] ON [dbo].[AspNetUsers] ([NormalizedFirstName]);
	CREATE INDEX [LastNameIndex] ON [dbo].[AspNetUsers] ([NormalizedLastName]);
	CREATE INDEX [CountIndex] ON [dbo].[AspNetUsers] ([IsBlocked], [IsDeleted]);
	CREATE INDEX [CountIndexReversed] ON [dbo].[AspNetUsers] ([IsDeleted], [IsBlocked]);


	CREATE TABLE [dbo].[EnumClaimTypeAllowedValues] (
      [ClaimTypeId] nvarchar(450) NOT NULL,
      [Value] nvarchar(450) NOT NULL,
      CONSTRAINT [PK_EnumClaimTypeAllowedValues] PRIMARY KEY ([ClaimTypeId], [Value]),
      CONSTRAINT [FK_EnumClaimTypeAllowedValues_AspNetClaimTypes_ClaimTypeId] FOREIGN KEY ([ClaimTypeId]) REFERENCES [AspNetClaimTypes] ([Id]) ON DELETE CASCADE
	);
	
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

	INSERT INTO [dbo].[__EFMigrationsHistory]
	VALUES ('20171026080706_InitialSqlServerIdentityDbMigration', '2.1.4-rtm-31024')

	INSERT INTO [dbo].[__EFMigrationsHistory]
	VALUES ('20220110161021_ClaimTypeDisplayNameMigration', '2.1.4-rtm-31024')
	
	INSERT INTO [dbo].[__EFMigrationsHistory]
	VALUES ('20210430141851_EnumeratedClaimTypeMigration', '2.1.4-rtm-31024')

COMMIT TRANSACTION TransactionOne