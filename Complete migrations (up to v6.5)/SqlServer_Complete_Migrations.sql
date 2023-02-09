IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [ApiResources] (
    [Id] int NOT NULL IDENTITY,
    [Description] nvarchar(1000) NULL,
    [DisplayName] nvarchar(200) NULL,
    [Enabled] bit NOT NULL,
    [Name] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_ApiResources] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Clients] (
    [Id] int NOT NULL IDENTITY,
    [AbsoluteRefreshTokenLifetime] int NOT NULL,
    [AccessTokenLifetime] int NOT NULL,
    [AccessTokenType] int NOT NULL,
    [AllowAccessTokensViaBrowser] bit NOT NULL,
    [AllowOfflineAccess] bit NOT NULL,
    [AllowPlainTextPkce] bit NOT NULL,
    [AllowRememberConsent] bit NOT NULL,
    [AlwaysIncludeUserClaimsInIdToken] bit NOT NULL,
    [AlwaysSendClientClaims] bit NOT NULL,
    [AuthorizationCodeLifetime] int NOT NULL,
    [BackChannelLogoutSessionRequired] bit NOT NULL,
    [BackChannelLogoutUri] nvarchar(2000) NULL,
    [ClientClaimsPrefix] nvarchar(200) NULL,
    [ClientId] nvarchar(200) NOT NULL,
    [ClientName] nvarchar(200) NULL,
    [ClientUri] nvarchar(2000) NULL,
    [ConsentLifetime] int NULL,
    [Description] nvarchar(1000) NULL,
    [EnableLocalLogin] bit NOT NULL,
    [Enabled] bit NOT NULL,
    [FrontChannelLogoutSessionRequired] bit NOT NULL,
    [FrontChannelLogoutUri] nvarchar(2000) NULL,
    [IdentityTokenLifetime] int NOT NULL,
    [IncludeJwtId] bit NOT NULL,
    [LogoUri] nvarchar(2000) NULL,
    [PairWiseSubjectSalt] nvarchar(200) NULL,
    [ProtocolType] nvarchar(200) NOT NULL,
    [RefreshTokenExpiration] int NOT NULL,
    [RefreshTokenUsage] int NOT NULL,
    [RequireClientSecret] bit NOT NULL,
    [RequireConsent] bit NOT NULL,
    [RequirePkce] bit NOT NULL,
    [SlidingRefreshTokenLifetime] int NOT NULL,
    [UpdateAccessTokenClaimsOnRefresh] bit NOT NULL,
    CONSTRAINT [PK_Clients] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [IdentityResources] (
    [Id] int NOT NULL IDENTITY,
    [Description] nvarchar(1000) NULL,
    [DisplayName] nvarchar(200) NULL,
    [Emphasize] bit NOT NULL,
    [Enabled] bit NOT NULL,
    [Name] nvarchar(200) NOT NULL,
    [Required] bit NOT NULL,
    [ShowInDiscoveryDocument] bit NOT NULL,
    CONSTRAINT [PK_IdentityResources] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [ApiClaims] (
    [Id] int NOT NULL IDENTITY,
    [ApiResourceId] int NOT NULL,
    [Type] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_ApiClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ApiClaims_ApiResources_ApiResourceId] FOREIGN KEY ([ApiResourceId]) REFERENCES [ApiResources] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ApiScopes] (
    [Id] int NOT NULL IDENTITY,
    [ApiResourceId] int NOT NULL,
    [Description] nvarchar(1000) NULL,
    [DisplayName] nvarchar(200) NULL,
    [Emphasize] bit NOT NULL,
    [Name] nvarchar(200) NOT NULL,
    [Required] bit NOT NULL,
    [ShowInDiscoveryDocument] bit NOT NULL,
    CONSTRAINT [PK_ApiScopes] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ApiScopes_ApiResources_ApiResourceId] FOREIGN KEY ([ApiResourceId]) REFERENCES [ApiResources] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ApiSecrets] (
    [Id] int NOT NULL IDENTITY,
    [ApiResourceId] int NOT NULL,
    [Description] nvarchar(1000) NULL,
    [Expiration] datetime2 NULL,
    [Type] nvarchar(250) NULL,
    [Value] nvarchar(2000) NULL,
    CONSTRAINT [PK_ApiSecrets] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ApiSecrets_ApiResources_ApiResourceId] FOREIGN KEY ([ApiResourceId]) REFERENCES [ApiResources] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ClientClaims] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Type] nvarchar(250) NOT NULL,
    [Value] nvarchar(250) NOT NULL,
    CONSTRAINT [PK_ClientClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientClaims_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ClientCorsOrigins] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Origin] nvarchar(150) NOT NULL,
    CONSTRAINT [PK_ClientCorsOrigins] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientCorsOrigins_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ClientGrantTypes] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [GrantType] nvarchar(250) NOT NULL,
    CONSTRAINT [PK_ClientGrantTypes] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientGrantTypes_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ClientIdPRestrictions] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Provider] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_ClientIdPRestrictions] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientIdPRestrictions_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ClientPostLogoutRedirectUris] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [PostLogoutRedirectUri] nvarchar(2000) NOT NULL,
    CONSTRAINT [PK_ClientPostLogoutRedirectUris] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientPostLogoutRedirectUris_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ClientProperties] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Key] nvarchar(250) NOT NULL,
    [Value] nvarchar(2000) NOT NULL,
    CONSTRAINT [PK_ClientProperties] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientProperties_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ClientRedirectUris] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [RedirectUri] nvarchar(2000) NOT NULL,
    CONSTRAINT [PK_ClientRedirectUris] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientRedirectUris_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ClientScopes] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Scope] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_ClientScopes] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientScopes_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ClientSecrets] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Description] nvarchar(2000) NULL,
    [Expiration] datetime2 NULL,
    [Type] nvarchar(250) NULL,
    [Value] nvarchar(2000) NOT NULL,
    CONSTRAINT [PK_ClientSecrets] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientSecrets_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [IdentityClaims] (
    [Id] int NOT NULL IDENTITY,
    [IdentityResourceId] int NOT NULL,
    [Type] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_IdentityClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_IdentityClaims_IdentityResources_IdentityResourceId] FOREIGN KEY ([IdentityResourceId]) REFERENCES [IdentityResources] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ApiScopeClaims] (
    [Id] int NOT NULL IDENTITY,
    [ApiScopeId] int NOT NULL,
    [Type] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_ApiScopeClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ApiScopeClaims_ApiScopes_ApiScopeId] FOREIGN KEY ([ApiScopeId]) REFERENCES [ApiScopes] ([Id]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_ApiClaims_ApiResourceId] ON [ApiClaims] ([ApiResourceId]);
GO

CREATE UNIQUE INDEX [IX_ApiResources_Name] ON [ApiResources] ([Name]);
GO

CREATE INDEX [IX_ApiScopeClaims_ApiScopeId] ON [ApiScopeClaims] ([ApiScopeId]);
GO

CREATE INDEX [IX_ApiScopes_ApiResourceId] ON [ApiScopes] ([ApiResourceId]);
GO

CREATE UNIQUE INDEX [IX_ApiScopes_Name] ON [ApiScopes] ([Name]);
GO

CREATE INDEX [IX_ApiSecrets_ApiResourceId] ON [ApiSecrets] ([ApiResourceId]);
GO

CREATE INDEX [IX_ClientClaims_ClientId] ON [ClientClaims] ([ClientId]);
GO

CREATE INDEX [IX_ClientCorsOrigins_ClientId] ON [ClientCorsOrigins] ([ClientId]);
GO

CREATE INDEX [IX_ClientGrantTypes_ClientId] ON [ClientGrantTypes] ([ClientId]);
GO

CREATE INDEX [IX_ClientIdPRestrictions_ClientId] ON [ClientIdPRestrictions] ([ClientId]);
GO

CREATE INDEX [IX_ClientPostLogoutRedirectUris_ClientId] ON [ClientPostLogoutRedirectUris] ([ClientId]);
GO

CREATE INDEX [IX_ClientProperties_ClientId] ON [ClientProperties] ([ClientId]);
GO

CREATE INDEX [IX_ClientRedirectUris_ClientId] ON [ClientRedirectUris] ([ClientId]);
GO

CREATE UNIQUE INDEX [IX_Clients_ClientId] ON [Clients] ([ClientId]);
GO

CREATE INDEX [IX_ClientScopes_ClientId] ON [ClientScopes] ([ClientId]);
GO

CREATE INDEX [IX_ClientSecrets_ClientId] ON [ClientSecrets] ([ClientId]);
GO

CREATE INDEX [IX_IdentityClaims_IdentityResourceId] ON [IdentityClaims] ([IdentityResourceId]);
GO

CREATE UNIQUE INDEX [IX_IdentityResources_Name] ON [IdentityResources] ([Name]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171026080114_InitialSqlServerConfigurationDbMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171122163636_UserSearchOptimizationConfigurationDbMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [IdentityResources] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
GO

ALTER TABLE [IdentityResources] ADD [NonEditable] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

ALTER TABLE [IdentityResources] ADD [Updated] datetime2 NULL;
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ClientSecrets]') AND [c].[name] = N'Value');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [ClientSecrets] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [ClientSecrets] ALTER COLUMN [Value] nvarchar(4000) NOT NULL;
GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ClientSecrets]') AND [c].[name] = N'Type');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [ClientSecrets] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [ClientSecrets] ALTER COLUMN [Type] nvarchar(250) NOT NULL;
GO

ALTER TABLE [ClientSecrets] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
GO

ALTER TABLE [Clients] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
GO

ALTER TABLE [Clients] ADD [DeviceCodeLifetime] int NOT NULL DEFAULT 0;
GO

ALTER TABLE [Clients] ADD [LastAccessed] datetime2 NULL;
GO

ALTER TABLE [Clients] ADD [NonEditable] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

ALTER TABLE [Clients] ADD [Updated] datetime2 NULL;
GO

ALTER TABLE [Clients] ADD [UserCodeType] nvarchar(100) NULL;
GO

ALTER TABLE [Clients] ADD [UserSsoLifetime] int NULL;
GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApiSecrets]') AND [c].[name] = N'Value');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [ApiSecrets] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [ApiSecrets] ALTER COLUMN [Value] nvarchar(4000) NOT NULL;
GO

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApiSecrets]') AND [c].[name] = N'Type');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [ApiSecrets] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [ApiSecrets] ALTER COLUMN [Type] nvarchar(250) NOT NULL;
GO

ALTER TABLE [ApiSecrets] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
GO

ALTER TABLE [ApiResources] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
GO

ALTER TABLE [ApiResources] ADD [LastAccessed] datetime2 NULL;
GO

ALTER TABLE [ApiResources] ADD [NonEditable] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

ALTER TABLE [ApiResources] ADD [Updated] datetime2 NULL;
GO

CREATE TABLE [ApiProperties] (
    [Id] int NOT NULL IDENTITY,
    [Key] nvarchar(250) NOT NULL,
    [Value] nvarchar(2000) NOT NULL,
    [ApiResourceId] int NOT NULL,
    CONSTRAINT [PK_ApiProperties] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ApiProperties_ApiResources_ApiResourceId] FOREIGN KEY ([ApiResourceId]) REFERENCES [ApiResources] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [IdentityProperties] (
    [Id] int NOT NULL IDENTITY,
    [Key] nvarchar(250) NOT NULL,
    [Value] nvarchar(2000) NOT NULL,
    [IdentityResourceId] int NOT NULL,
    CONSTRAINT [PK_IdentityProperties] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_IdentityProperties_IdentityResources_IdentityResourceId] FOREIGN KEY ([IdentityResourceId]) REFERENCES [IdentityResources] ([Id]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_ApiProperties_ApiResourceId] ON [ApiProperties] ([ApiResourceId]);
GO

CREATE INDEX [IX_IdentityProperties_IdentityResourceId] ON [IdentityProperties] ([IdentityResourceId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181109163923_IdentityServer2.3SqlServerConfigurationDbMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

BEGIN TRANSACTION

--Add New Tables

-- Add ApiResourceScopes

CREATE TABLE ApiResourceScopes (
    Id             INT            IDENTITY (1, 1) NOT NULL,
    Scope          NVARCHAR (200) NOT NULL,
    ApiResourceId  INT            NOT NULL,
    CONSTRAINT PK_ApiResourceScopes PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiResourceScopes_ApiResources_ApiResourceId FOREIGN KEY (ApiResourceId) REFERENCES ApiResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX IX_ApiResourceScopes_ApiResourceId
    ON ApiResourceScopes(ApiResourceId ASC);
GO

-- Add ApiScopeProperties

CREATE TABLE ApiScopeProperties (
    Id        INT             IDENTITY (1, 1) NOT NULL,
    [Key]     NVARCHAR (250)  NOT NULL,
    [Value]   NVARCHAR (2000) NOT NULL,
    ScopeId   INT             NOT NULL,
    CONSTRAINT PK_ApiScopeProperties PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiScopeProperties_ApiScopes_ScopeId FOREIGN KEY (ScopeId) REFERENCES ApiScopes (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX IX_ApiScopeProperties_ScopeId
    ON ApiScopeProperties(ScopeId ASC);
GO

-- Add Renamed Tables

-- ApiResourceClaims

CREATE TABLE [dbo].[ApiResourceClaims] (
    Id              INT            IDENTITY (1, 1) NOT NULL,
    [Type]          NVARCHAR (200) NOT NULL,
    ApiResourceId   INT            NOT NULL,
    CONSTRAINT PK_ApiResourceClaims PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiResourceClaims_ApiResources_ApiResourceId FOREIGN KEY (ApiResourceId) REFERENCES ApiResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_ApiResourceClaims_ApiResourceId]
    ON [dbo].[ApiResourceClaims]([ApiResourceId] ASC);
GO

-- ApiResourceProperties

CREATE TABLE [dbo].[ApiResourceProperties] (
    [Id]            INT             IDENTITY (1, 1) NOT NULL,
    [Key]           NVARCHAR (250)  NOT NULL,
    [Value]         NVARCHAR (2000) NOT NULL,
    ApiResourceId   INT             NOT NULL,
    CONSTRAINT PK_ApiResourceProperties PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiResourceProperties_ApiResources_ApiResourceId FOREIGN KEY (ApiResourceId) REFERENCES ApiResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_ApiResourceProperties_ApiResourceId]
    ON [dbo].[ApiResourceProperties]([ApiResourceId] ASC);
GO

-- Add ApiResourceSecrets

CREATE TABLE ApiResourceSecrets (
    Id              INT             IDENTITY (1, 1) NOT NULL,
    [Description]   NVARCHAR (1000) NULL,
    [Value]         NVARCHAR (4000) NOT NULL,
    Expiration      DATETIME2 (7)   NULL,
    [Type]          NVARCHAR (250)  NOT NULL,
    Created         DATETIME2 (7)   NOT NULL,
    ApiResourceId   INT             NOT NULL,
    CONSTRAINT PK_ApiResourceSecrets PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiResourceSecrets_ApiResources_ApiResourceId FOREIGN KEY (ApiResourceId) REFERENCES ApiResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX IX_ApiResourceSecrets_ApiResourceId
    ON ApiResourceSecrets(ApiResourceId ASC);
GO

-- IdentityResourceClaims

CREATE TABLE IdentityResourceClaims (
    Id                 INT            IDENTITY (1, 1) NOT NULL,
    [Type]             NVARCHAR (200) NOT NULL,
    IdentityResourceId INT            NOT NULL,
    CONSTRAINT PK_IdentityResourceClaims PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_IdentityResourceClaims_IdentityResources_IdentityResourceId FOREIGN KEY (IdentityResourceId) REFERENCES IdentityResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_IdentityResourceClaims_IdentityResourceId]
    ON IdentityResourceClaims(IdentityResourceId ASC);
GO

-- IdentityResourceProperties

CREATE TABLE IdentityResourceProperties (
    Id                   INT             IDENTITY (1, 1) NOT NULL,
    [Key]                NVARCHAR (250)  NOT NULL,
    [Value]              NVARCHAR (2000) NOT NULL,
    IdentityResourceId   INT             NOT NULL,
    CONSTRAINT PK_IdentityResourceProperties PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_IdentityResourceProperties_IdentityResources_IdentityResourceId FOREIGN KEY (IdentityResourceId) REFERENCES IdentityResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX IX_IdentityResourceProperties_IdentityResourceId
    ON IdentityResourceProperties(IdentityResourceId ASC);
GO

-- Migrate Existing Data

--ApiClaims -> ApiResourceClaims
SET IDENTITY_INSERT ApiResourceClaims ON;


INSERT INTO ApiResourceClaims
 (Id, [Type], ApiResourceId)
SELECT 
 Id, [Type], ApiResourceId
FROM ApiClaims


SET IDENTITY_INSERT ApiResourceClaims OFF;


--ApiProperties -> ApiResourceProperties
SET IDENTITY_INSERT ApiResourceProperties ON;  
GO

INSERT INTO ApiResourceProperties
 (Id, [Key], [Value], ApiResourceId)
SELECT 
 Id, [Key], [Value], ApiResourceId
FROM ApiProperties
GO

SET IDENTITY_INSERT ApiResourceProperties OFF;
GO

--ApiSecrets -> ApiResourceSecrets
SET IDENTITY_INSERT ApiResourceSecrets ON;  
GO

INSERT INTO ApiResourceSecrets
 (Id, [Description], [Value], Expiration, [Type], Created, ApiResourceId)
SELECT 
 Id, [Description], [Value], Expiration, [Type], Created, ApiResourceId
FROM ApiSecrets
GO

SET IDENTITY_INSERT ApiResourceSecrets OFF;  
GO

--IdentityClaims -> IdentityResourceClaims
SET IDENTITY_INSERT IdentityResourceClaims ON;  
GO

INSERT INTO IdentityResourceClaims
 (Id, [Type], IdentityResourceId)
SELECT 
 Id, [Type], IdentityResourceId
FROM IdentityClaims
GO

SET IDENTITY_INSERT IdentityResourceClaims OFF;  
GO

--IdentityProperties -> IdentityResourceProperties
SET IDENTITY_INSERT IdentityResourceProperties ON;  
GO

INSERT INTO IdentityResourceProperties
 (Id, [Key], [Value], IdentityResourceId)
SELECT 
 Id, [Key], [Value], IdentityResourceId
FROM IdentityProperties
GO

SET IDENTITY_INSERT IdentityResourceProperties OFF;  
GO

-- ApiScopes -> ApiResourceScopes

INSERT INTO ApiResourceScopes 
 ([Scope], [ApiResourceId])
SELECT 
 [Name], [ApiResourceId]
FROM ApiScopes

-- Alter Existing Tables

-- ApiResources

ALTER TABLE ApiResources 
	ADD AllowedAccessTokenSigningAlgorithms NVARCHAR (100)
	NULL
	
ALTER TABLE ApiResources 
	ADD ShowInDiscoveryDocument BIT
	NULL
GO

UPDATE ApiResources SET ShowInDiscoveryDocument = 0

ALTER TABLE ApiResources 
	ALTER COLUMN ShowInDiscoveryDocument BIT NOT NULL
	


-- ApiScopeClaims

ALTER TABLE ApiScopeClaims
	DROP CONSTRAINT FK_ApiScopeClaims_ApiScopes_ApiScopeId
	
DROP INDEX IX_ApiScopeClaims_ApiScopeId
	ON ApiScopeClaims

exec sp_rename 'ApiScopeClaims.ApiScopeId', 'ScopeId', 'COLUMN';

CREATE NONCLUSTERED INDEX IX_ApiScopeClaims_ScopeId
    ON ApiScopeClaims(ScopeId ASC);
	
ALTER TABLE ApiScopeClaims
	ADD CONSTRAINT FK_ApiScopeClaims_ApiScopes_ScopeId 
	FOREIGN KEY (ScopeId) REFERENCES ApiScopes (Id) ON DELETE CASCADE
	
	
	
-- ApiScopes

ALTER TABLE ApiScopes
	DROP CONSTRAINT FK_ApiScopes_ApiResources_ApiResourceId
	
DROP INDEX IX_ApiScopes_ApiResourceId
	ON ApiScopes
	
ALTER TABLE ApiScopes 
	ADD [Enabled] BIT NULL
GO

UPDATE ApiScopes SET [Enabled] = 1

ALTER TABLE ApiScopes
	DROP COLUMN ApiResourceId;

ALTER TABLE ApiScopes 
	ALTER COLUMN Enabled BIT NOT NULL;



-- Clients

ALTER TABLE Clients
	ADD AllowedIdentityTokenSigningAlgorithms NVARCHAR (100) NULL
	
ALTER TABLE Clients
	ADD RequireRequestObject BIT NULL
GO

UPDATE Clients SET RequireRequestObject = 0
	
ALTER TABLE Clients
	ALTER COLUMN RequireRequestObject BIT NOT NULL

	

-- Delete Old Tables

DROP TABLE ApiClaims
DROP TABLE ApiProperties
DROP TABLE ApiSecrets
DROP TABLE IdentityClaims
DROP TABLE IdentityProperties

COMMIT TRANSACTION
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200702075849_V3toV4SqlServerConfigurationDbMigration', N'6.0.3');
GO

COMMIT;
GO

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [ExtendedApiResources] (
    [Id] nvarchar(450) NOT NULL,
    [ApiResourceName] nvarchar(200) NOT NULL,
    [NormalizedName] nvarchar(200) NOT NULL,
    [Reserved] bit NOT NULL,
    CONSTRAINT [PK_ExtendedApiResources] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [ExtendedClients] (
    [Id] nvarchar(450) NOT NULL,
    [ClientId] nvarchar(200) NOT NULL,
    [Description] nvarchar(max) NULL,
    [NormalizedClientId] nvarchar(200) NOT NULL,
    [NormalizedClientName] nvarchar(200) NULL,
    [Reserved] bit NOT NULL,
    CONSTRAINT [PK_ExtendedClients] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [ExtendedIdentityResources] (
    [Id] nvarchar(450) NOT NULL,
    [IdentityResourceName] nvarchar(200) NOT NULL,
    [NormalizedName] nvarchar(200) NOT NULL,
    [Reserved] bit NOT NULL,
    CONSTRAINT [PK_ExtendedIdentityResources] PRIMARY KEY ([Id])
);
GO

CREATE UNIQUE INDEX [ApiNameIndex] ON [ExtendedApiResources] ([ApiResourceName]);
GO

CREATE UNIQUE INDEX [ApiResourceNameIndex] ON [ExtendedApiResources] ([NormalizedName]);
GO

CREATE UNIQUE INDEX [IdIndex] ON [ExtendedClients] ([ClientId]);
GO

CREATE UNIQUE INDEX [ClientIdIndex] ON [ExtendedClients] ([NormalizedClientId]);
GO

CREATE UNIQUE INDEX [ClientNameIndex] ON [ExtendedClients] ([NormalizedClientName]) WHERE [NormalizedClientName] IS NOT NULL;
GO

CREATE UNIQUE INDEX [IdentityNameIndex] ON [ExtendedIdentityResources] ([IdentityResourceName]);
GO

CREATE UNIQUE INDEX [IdentityResourceNameIndex] ON [ExtendedIdentityResources] ([NormalizedName]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171026080835_InitialSqlServerExtendedConfigurationDbMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171122163718_UserSearchOptimizationExtendedConfigurationDbMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [ConfigurationEntries] (
    [Key] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_ConfigurationEntries] PRIMARY KEY ([Key])
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180626100745_ConfigurationEntries', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

UPDATE [dbo].[Clients]
                                    SET [NonEditable] = e.reserved
	                                from [dbo].ExtendedClients e
	                                WHERE [dbo].[Clients].ClientId = e.ClientId
GO

UPDATE [dbo].[ApiResources]
                                   SET [NonEditable] = e.reserved
	                               from [dbo].ExtendedApiResources e
	                               WHERE [dbo].[ApiResources].Name = e.ApiResourceName
GO

UPDATE [dbo].IdentityResources
                                   SET [NonEditable] = e.reserved
	                               from [dbo].ExtendedIdentityResources e
	                               WHERE [dbo].IdentityResources.Name = e.IdentityResourceName
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181205163055_ExtendedDataMigration2.3', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [ExtendedClients] ADD [ClientType] int NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190401104724_ClientType', N'6.0.3');
GO

COMMIT;
GO

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [PersistedGrants] (
    [Key] nvarchar(200) NOT NULL,
    [ClientId] nvarchar(200) NOT NULL,
    [CreationTime] datetime2 NOT NULL,
    [Data] nvarchar(max) NOT NULL,
    [Expiration] datetime2 NULL,
    [SubjectId] nvarchar(200) NULL,
    [Type] nvarchar(50) NOT NULL,
    CONSTRAINT [PK_PersistedGrants] PRIMARY KEY ([Key])
);
GO

CREATE INDEX [IX_PersistedGrants_SubjectId_ClientId_Type] ON [PersistedGrants] ([SubjectId], [ClientId], [Type]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171026080756_InitialSqlServerOperationalDbMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171122163758_UserSearchOptimizationOperationalDbMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [DeviceCodes] (
    [DeviceCode] nvarchar(200) NOT NULL,
    [UserCode] nvarchar(200) NOT NULL,
    [SubjectId] nvarchar(200) NULL,
    [ClientId] nvarchar(200) NOT NULL,
    [CreationTime] datetime2 NOT NULL,
    [Expiration] datetime2 NOT NULL,
    [Data] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_DeviceCodes] PRIMARY KEY ([UserCode])
);
GO

CREATE UNIQUE INDEX [IX_DeviceCodes_DeviceCode] ON [DeviceCodes] ([DeviceCode]);
GO

CREATE UNIQUE INDEX [IX_DeviceCodes_UserCode] ON [DeviceCodes] ([UserCode]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181109164134_IdentityServer2.3SqlServerSqlServerOperationalDbMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO


BEGIN TRANSACTION

-- Alter Existing Tables

-- DeviceCodes

ALTER TABLE DeviceCodes
	ADD SessionId NVARCHAR (100) NULL
	
ALTER TABLE DeviceCodes
	ADD [Description] NVARCHAR (200) NULL



-- PersistedGrants

ALTER TABLE PersistedGrants
	ADD SessionId NVARCHAR (100) NULL
	
ALTER TABLE PersistedGrants
	ADD [Description] NVARCHAR (200) NULL
	
ALTER TABLE PersistedGrants
	ADD ConsumedTime DATETIME2 (7) NULL

CREATE NONCLUSTERED INDEX IX_PersistedGrants_SubjectId_SessionId_Type
    ON PersistedGrants(SubjectId ASC, SessionId ASC, Type ASC);

COMMIT TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200702080430_V3toV4SqlServerOperationalDbMigration', N'6.0.3');
GO

COMMIT;
GO

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [ApiResources] ADD [RequireResourceIndicator] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210106132452_DuendeSqlServerConfigurationMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [IdentityProviders] (
    [Id] int NOT NULL IDENTITY,
    [Scheme] nvarchar(200) NOT NULL,
    [DisplayName] nvarchar(200) NULL,
    [Enabled] bit NOT NULL,
    [Type] nvarchar(20) NOT NULL,
    [Properties] nvarchar(max) NULL,
    CONSTRAINT [PK_IdentityProviders] PRIMARY KEY ([Id])
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210602104947_IdentityProvidersSqlServerConfigurationMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DROP INDEX [IX_IdentityResourceProperties_IdentityResourceId] ON [IdentityResourceProperties];
GO

DROP INDEX [IX_IdentityResourceClaims_IdentityResourceId] ON [IdentityResourceClaims];
GO

DROP INDEX [IX_ClientScopes_ClientId] ON [ClientScopes];
GO

DROP INDEX [IX_ClientRedirectUris_ClientId] ON [ClientRedirectUris];
GO

DROP INDEX [IX_ClientProperties_ClientId] ON [ClientProperties];
GO

DROP INDEX [IX_ClientPostLogoutRedirectUris_ClientId] ON [ClientPostLogoutRedirectUris];
GO

DROP INDEX [IX_ClientIdPRestrictions_ClientId] ON [ClientIdPRestrictions];
GO

DROP INDEX [IX_ClientGrantTypes_ClientId] ON [ClientGrantTypes];
GO

DROP INDEX [IX_ClientCorsOrigins_ClientId] ON [ClientCorsOrigins];
GO

DROP INDEX [IX_ClientClaims_ClientId] ON [ClientClaims];
GO

DROP INDEX [IX_ApiScopeProperties_ScopeId] ON [ApiScopeProperties];
GO

DROP INDEX [IX_ApiScopeClaims_ScopeId] ON [ApiScopeClaims];
GO

DROP INDEX [IX_ApiResourceScopes_ApiResourceId] ON [ApiResourceScopes];
GO

DROP INDEX [IX_ApiResourceProperties_ApiResourceId] ON [ApiResourceProperties];
GO

DROP INDEX [IX_ApiResourceClaims_ApiResourceId] ON [ApiResourceClaims];
GO

ALTER TABLE [IdentityProviders] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
GO

ALTER TABLE [IdentityProviders] ADD [LastAccessed] datetime2 NULL;
GO

ALTER TABLE [IdentityProviders] ADD [NonEditable] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

ALTER TABLE [IdentityProviders] ADD [Updated] datetime2 NULL;
GO

ALTER TABLE [Clients] ADD [CibaLifetime] int NULL;
GO

ALTER TABLE [Clients] ADD [PollingInterval] int NULL;
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ClientRedirectUris]') AND [c].[name] = N'RedirectUri');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [ClientRedirectUris] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [ClientRedirectUris] ALTER COLUMN [RedirectUri] nvarchar(400) NOT NULL;
GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ClientPostLogoutRedirectUris]') AND [c].[name] = N'PostLogoutRedirectUri');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [ClientPostLogoutRedirectUris] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [ClientPostLogoutRedirectUris] ALTER COLUMN [PostLogoutRedirectUri] nvarchar(400) NOT NULL;
GO

ALTER TABLE [ApiScopes] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
GO

ALTER TABLE [ApiScopes] ADD [LastAccessed] datetime2 NULL;
GO

ALTER TABLE [ApiScopes] ADD [NonEditable] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

ALTER TABLE [ApiScopes] ADD [Updated] datetime2 NULL;
GO

CREATE UNIQUE INDEX [IX_IdentityResourceProperties_IdentityResourceId_Key] ON [IdentityResourceProperties] ([IdentityResourceId], [Key]);
GO

CREATE UNIQUE INDEX [IX_IdentityResourceClaims_IdentityResourceId_Type] ON [IdentityResourceClaims] ([IdentityResourceId], [Type]);
GO

CREATE UNIQUE INDEX [IX_IdentityProviders_Scheme] ON [IdentityProviders] ([Scheme]);
GO

CREATE UNIQUE INDEX [IX_ClientScopes_ClientId_Scope] ON [ClientScopes] ([ClientId], [Scope]);
GO

CREATE UNIQUE INDEX [IX_ClientRedirectUris_ClientId_RedirectUri] ON [ClientRedirectUris] ([ClientId], [RedirectUri]);
GO

CREATE UNIQUE INDEX [IX_ClientProperties_ClientId_Key] ON [ClientProperties] ([ClientId], [Key]);
GO

CREATE UNIQUE INDEX [IX_ClientPostLogoutRedirectUris_ClientId_PostLogoutRedirectUri] ON [ClientPostLogoutRedirectUris] ([ClientId], [PostLogoutRedirectUri]);
GO

CREATE UNIQUE INDEX [IX_ClientIdPRestrictions_ClientId_Provider] ON [ClientIdPRestrictions] ([ClientId], [Provider]);
GO

CREATE UNIQUE INDEX [IX_ClientGrantTypes_ClientId_GrantType] ON [ClientGrantTypes] ([ClientId], [GrantType]);
GO

CREATE UNIQUE INDEX [IX_ClientCorsOrigins_ClientId_Origin] ON [ClientCorsOrigins] ([ClientId], [Origin]);
GO

CREATE UNIQUE INDEX [IX_ClientClaims_ClientId_Type_Value] ON [ClientClaims] ([ClientId], [Type], [Value]);
GO

CREATE UNIQUE INDEX [IX_ApiScopeProperties_ScopeId_Key] ON [ApiScopeProperties] ([ScopeId], [Key]);
GO

CREATE UNIQUE INDEX [IX_ApiScopeClaims_ScopeId_Type] ON [ApiScopeClaims] ([ScopeId], [Type]);
GO

CREATE UNIQUE INDEX [IX_ApiResourceScopes_ApiResourceId_Scope] ON [ApiResourceScopes] ([ApiResourceId], [Scope]);
GO

CREATE UNIQUE INDEX [IX_ApiResourceProperties_ApiResourceId_Key] ON [ApiResourceProperties] ([ApiResourceId], [Key]);
GO

CREATE UNIQUE INDEX [IX_ApiResourceClaims_ApiResourceId_Type] ON [ApiResourceClaims] ([ApiResourceId], [Type]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220104130635_DuendeV6SqlServerConfigurationMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Clients] ADD [CoordinateLifetimeWithUserSession] bit NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220608093217_Duende61ConfigurationUpdate', N'6.0.3');
GO

COMMIT;
GO

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Keys] (
    [Id] nvarchar(450) NOT NULL,
    [Version] int NOT NULL,
    [Created] datetime2 NOT NULL,
    [Use] nvarchar(450) NULL,
    [Algorithm] nvarchar(100) NOT NULL,
    [IsX509Certificate] bit NOT NULL,
    [DataProtected] bit NOT NULL,
    [Data] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Keys] PRIMARY KEY ([Id])
);
GO

CREATE INDEX [IX_Keys_Use] ON [Keys] ([Use]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210105164242_DuendeSqlServerMigrationOperational', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE INDEX [IX_PersistedGrants_ConsumedTime] ON [PersistedGrants] ([ConsumedTime]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210602110024_PersistedGrantConsumeTimeSqlServerOperationalMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [PersistedGrants] DROP CONSTRAINT [PK_PersistedGrants];
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[PersistedGrants]') AND [c].[name] = N'Key');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [PersistedGrants] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [PersistedGrants] ALTER COLUMN [Key] nvarchar(200) NULL;
GO

ALTER TABLE [PersistedGrants] ADD [Id] bigint NOT NULL IDENTITY;
GO

ALTER TABLE [PersistedGrants] ADD CONSTRAINT [PK_PersistedGrants] PRIMARY KEY ([Id]);
GO

CREATE TABLE [ServerSideSessions] (
    [Id] int NOT NULL IDENTITY,
    [Key] nvarchar(100) NOT NULL,
    [Scheme] nvarchar(100) NOT NULL,
    [SubjectId] nvarchar(100) NOT NULL,
    [SessionId] nvarchar(100) NULL,
    [DisplayName] nvarchar(100) NULL,
    [Created] datetime2 NOT NULL,
    [Renewed] datetime2 NOT NULL,
    [Expires] datetime2 NULL,
    [Data] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_ServerSideSessions] PRIMARY KEY ([Id])
);
GO

CREATE UNIQUE INDEX [IX_PersistedGrants_Key] ON [PersistedGrants] ([Key]) WHERE [Key] IS NOT NULL;
GO

CREATE INDEX [IX_ServerSideSessions_DisplayName] ON [ServerSideSessions] ([DisplayName]);
GO

CREATE INDEX [IX_ServerSideSessions_Expires] ON [ServerSideSessions] ([Expires]);
GO

CREATE UNIQUE INDEX [IX_ServerSideSessions_Key] ON [ServerSideSessions] ([Key]);
GO

CREATE INDEX [IX_ServerSideSessions_SessionId] ON [ServerSideSessions] ([SessionId]);
GO

CREATE INDEX [IX_ServerSideSessions_SubjectId] ON [ServerSideSessions] ([SubjectId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220608091949_Duende61Update', N'6.0.3');
GO

COMMIT;
GO

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [AuditEntries] (
    [Id] bigint NOT NULL IDENTITY,
    [When] datetime2 NOT NULL,
    [Source] nvarchar(max) NULL,
    [SubjectType] nvarchar(max) NULL,
    [SubjectIdentifier] nvarchar(max) NULL,
    [Subject] nvarchar(max) NULL,
    [Action] nvarchar(max) NULL,
    [ResourceType] nvarchar(max) NULL,
    [Resource] nvarchar(max) NULL,
    [ResourceIdentifier] nvarchar(max) NULL,
    [Succeeded] bit NOT NULL,
    [Description] nvarchar(max) NULL,
    [NormalisedSubject] nvarchar(max) NULL,
    [NormalisedAction] nvarchar(max) NULL,
    [NormalisedResource] nvarchar(max) NULL,
    [NormalisedSource] nvarchar(max) NULL,
    CONSTRAINT [PK_AuditEntries] PRIMARY KEY ([Id])
);
GO

CREATE INDEX [IX_AuditEntries_When] ON [AuditEntries] ([When]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181220155759_InitalSqlServerAuditDbMigration', N'6.0.3');
GO

COMMIT;
GO

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [AspNetClaimTypes] (
    [Id] nvarchar(450) NOT NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [Description] nvarchar(max) NULL,
    [Name] nvarchar(256) NOT NULL,
    [NormalizedName] nvarchar(256) NULL,
    [Required] bit NOT NULL,
    [Reserved] bit NOT NULL,
    [Rule] nvarchar(max) NULL,
    [RuleValidationFailureDescription] nvarchar(max) NULL,
    [UserEditable] bit NOT NULL DEFAULT CAST(0 AS bit),
    [ValueType] int NOT NULL,
    CONSTRAINT [PK_AspNetClaimTypes] PRIMARY KEY ([Id]),
    CONSTRAINT [AK_AspNetClaimTypes_Name] UNIQUE ([Name])
);
GO

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [Description] nvarchar(max) NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [Reserved] bit NOT NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [AccessFailedCount] int NOT NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [Email] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [FirstName] nvarchar(max) NULL,
    [IsBlocked] bit NOT NULL,
    [IsDeleted] bit NOT NULL,
    [LastName] nvarchar(max) NULL,
    [LockoutEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [PasswordHash] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [UserName] nvarchar(256) NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY NONCLUSTERED ([Id])
);
GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [ClaimType] nvarchar(256) NOT NULL,
    [ClaimValue] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetClaimTypes_ClaimType] FOREIGN KEY ([ClaimType]) REFERENCES [AspNetClaimTypes] ([Name]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE UNIQUE INDEX [ClaimTypeNameIndex] ON [AspNetClaimTypes] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetUserClaims_ClaimType] ON [AspNetUserClaims] ([ClaimType]);
GO

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
GO

CREATE UNIQUE CLUSTERED INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171026080706_InitialSqlServerIdentityDbMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [AspNetUsers] ADD [NormalizedFirstName] nvarchar(256) NULL;
GO

ALTER TABLE [AspNetUsers] ADD [NormalizedLastName] nvarchar(256) NULL;
GO

CREATE INDEX [FirstNameIndex] ON [AspNetUsers] ([NormalizedFirstName]);
GO

CREATE INDEX [LastNameIndex] ON [AspNetUsers] ([NormalizedLastName]);
GO

CREATE INDEX [CountIndex] ON [AspNetUsers] ([IsBlocked], [IsDeleted]);
GO

CREATE INDEX [CountIndexReversed] ON [AspNetUsers] ([IsDeleted], [IsBlocked]);
GO

CREATE PROCEDURE [dbo].[FindAllUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)

	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END

GO

CREATE PROCEDURE [dbo].[FindActiveUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		  ([IsBlocked] = 0 AND [IsDeleted] = 0)

	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		  ([IsBlocked] = 0 AND [IsDeleted] = 0)
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END

GO

CREATE PROCEDURE [dbo].[FindActiveOrBlockedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		   [IsDeleted] = 0

	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		   [IsDeleted] = 0
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END

GO

CREATE PROCEDURE [dbo].[FindActiveOrDeletedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		   [IsBlocked] = 0

	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		   [IsBlocked] = 0
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END

GO

CREATE PROCEDURE [dbo].[FindBlockedOrDeletedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		  ([IsDeleted] = 1 OR [IsBlocked] = 1)

	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		  ([IsDeleted] = 1 OR [IsBlocked] = 1)
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END

GO

CREATE PROCEDURE [dbo].[FindBlockedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		   [IsBlocked] = 1

	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		   [IsBlocked] = 1
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END

GO

CREATE PROCEDURE [dbo].[FindDeletedUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		   [IsDeleted] = 1

	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		   [IsDeleted] = 1
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171122162730_UserSearchOptimizationMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE VIEW [dbo].[ActiveUsers]
WITH SCHEMABINDING 
AS
SELECT        Id, Email, FirstName, LastName, UserName, NormalizedFirstName, NormalizedLastName, NormalizedUserName, NormalizedEmail
FROM            dbo.AspNetUsers
WHERE        (IsBlocked = 0) AND (IsDeleted = 0)
GO

CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20190723-131653] ON [dbo].[ActiveUsers]
(
   [NormalizedFirstName] ASC,
   [NormalizedLastName] ASC,
   [NormalizedUserName] ASC,
   [NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AspNetUsers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ActiveUsers'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ActiveUsers'
GO


CREATE PROCEDURE [dbo].[FindActiveByRoleWithCount]
	@RoleId nvarchar(450),
	@SearchTerm nvarchar(256) = null, 
	@PageNumber int,
	@PageSize int
AS
BEGIN
/* Searchs for all Active (IsBlocked = 0 && IsDeleted = 0) Users within a role				  */
/* If @SearchTerm is given it will search for LIKE on Email, Username, firstname and lastname */
/* If no @SearchTerm is given it will return all Active Users in that Role					  */
	SET NOCOUNT ON;

	IF @SearchTerm IS null
		BEGIN
		 -- Select Count of all users within role
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 

		--Select all users in role with SearchTerm
				SELECT  u.Id,
						u.[Email], 
						u.[FirstName], 
						u.[LastName], 	
						u.[UserName]
				FROM [AspNetUserRoles] ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId			
				WHERE (ur.[RoleId] = @RoleId) 
				ORDER BY u.[UserName]
				OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE --IF @SearchTerm is not Null
		BEGIN
			SET @SearchTerm = UPPER(@SearchTerm) + N'%'

		--Select Count With Search
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
			AND
				([NormalizedUserName] LIKE @SearchTerm  OR 
				[NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm  OR 
				[NormalizedLastName] LIKE @SearchTerm) 

		--Select all users in role with Search
			SELECT u.Id,
					u.[Email], 
					u.[FirstName], 
					u.[LastName], 	
					u.[UserName]
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
				AND
					([NormalizedUserName] LIKE @SearchTerm  OR 
					[NormalizedEmail] LIKE @SearchTerm  OR 
					[NormalizedFirstName] LIKE @SearchTerm  OR 
					[NormalizedLastName] LIKE @SearchTerm) 
			ORDER BY u.[UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

CREATE PROCEDURE [dbo].FindActiveUsersInRoleAndAllActiveUsersWithCount
	@RoleId nvarchar(450),
	@SearchTerm nvarchar(256) = null, 
	@PageNumber int,
	@PageSize int
AS
BEGIN
/* Searchs for all Active (IsBlocked = 0 && IsDeleted = 0) Users and if they are in the role  */
/* If @SearchTerm is given it will search for LIKE on Email, Username, firstname and lastname */
/* If no @SearchTerm is given it will return all Active Users in that Role					  */
	SET NOCOUNT ON;

	
	IF @SearchTerm IS null
		BEGIN
		  -- Select Count of all users within role
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 

	--Get All UserRole Entries with RoleID

		;WITH UserRoles_CTE
		AS
		(
			SELECT ur.[RoleId],
				   ur.[UserId]
			FROM [AspNetUserRoles] ur
			WHERE ur.[RoleId] = @RoleId
		)
		SELECT  u.Id,
				u.[Email], 
				u.[FirstName], 
				u.[LastName], 	
				u.[UserName],
			    CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
		FROM UserRoles_CTE ur
		RIGHT JOIN [ActiveUsers] u
		ON u.Id = ur.UserId			
		ORDER BY u.[UserName]

		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE -- IF @SearchTerm is not Null
		BEGIN
			SET @SearchTerm = UPPER(@SearchTerm) + N'%'

		--Select Count With Search
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE [NormalizedUserName] LIKE @SearchTerm  OR 
				[NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm  OR 
				[NormalizedLastName] LIKE @SearchTerm

		--Select users in result with Search
			;WITH UserRoles_CTE
			AS
			(
				SELECT ur.[RoleId],
					   ur.[UserId]
				FROM [AspNetUserRoles] ur
				WHERE ur.[RoleId] = @RoleId

			)
			SELECT u.Id,
					u.[Email], 
					u.[FirstName], 
					u.[LastName], 	
					u.[UserName],
					CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
			FROM UserRoles_CTE ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
				AND
					[NormalizedUserName] LIKE @SearchTerm  OR 
					[NormalizedEmail] LIKE @SearchTerm  OR 
					[NormalizedFirstName] LIKE @SearchTerm  OR 
					[NormalizedLastName] LIKE @SearchTerm
			ORDER BY u.[UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190723135545_RoleSearchOptimizationMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER PROCEDURE [dbo].[FindAllUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR 
			       [Id] LIKE @SearchTermLower);
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END

GO

ALTER PROCEDURE [dbo].[FindActiveUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 0 AND [IsDeleted] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName)  AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END


GO

ALTER PROCEDURE [dbo].[FindActiveOrBlockedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
    
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
					AND [NormalizedLastName] LIKE @LastName) AND [IsDeleted] = 0

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END


GO

ALTER PROCEDURE [dbo].[FindActiveOrDeletedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%';
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					[IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
				   AND [NormalizedLastName] LIKE @LastName)
				   AND  [IsBlocked] = 0

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)
				   AND [IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END

GO

ALTER PROCEDURE [dbo].[FindBlockedOrDeletedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1);
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1)

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindBlockedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 1;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsBlocked] = 1

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindDeletedUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm  OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 1;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm  OR 
				   [NormalizedLastName] LIKE @SearchTerm   OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsDeleted] = 1

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200706104335_UserSearchOptimizationUpdateMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO


ALTER PROCEDURE [dbo].[FindActiveByRoleWithCount]
	@RoleId nvarchar(450),
	@SearchTerm nvarchar(256) = null, 
	@PageNumber int,
	@PageSize int
AS
BEGIN
/* Searchs for all Active (IsBlocked = 0 && IsDeleted = 0) Users within a role				  */
/* If @SearchTerm is given it will search for LIKE on Email, Username, firstname and lastname */
/* If no @SearchTerm is given it will return all Active Users in that Role					  */
	SET NOCOUNT ON;

	IF @SearchTerm IS null
		BEGIN
		 -- Select Count of all users within role
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 

		--Select all users in role with SearchTerm
				SELECT  u.Id,
						u.[Email], 
						u.[FirstName], 
						u.[LastName], 	
						u.[UserName]
				FROM [AspNetUserRoles] ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId			
				WHERE (ur.[RoleId] = @RoleId) 
				ORDER BY u.[UserName]
				OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE --IF @SearchTerm is not Null
		BEGIN
            DECLARE @SearchTermLower nvarchar(256);
            SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
            
			SET @SearchTerm = UPPER(@SearchTerm) + N'%'

			DECLARE @NameSplitCount int;
			SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

			IF(@NameSplitCount = 0)
				BEGIN
								--Select Count With Search
					SELECT Count(*)
					FROM [AspNetUserRoles] ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE (ur.[RoleId] = @RoleId) 
					AND
						([NormalizedUserName] LIKE @SearchTerm  OR 
						[NormalizedEmail] LIKE @SearchTerm  OR 
						[NormalizedFirstName] LIKE @SearchTerm  OR
                         [NormalizedLastName] LIKE @SearchTerm OR
                         [Id] LIKE @SearchTermLower);

				--Select all users in role with Search
					SELECT u.Id,
							u.[Email], 
							u.[FirstName], 
							u.[LastName], 	
							u.[UserName]
					FROM [AspNetUserRoles] ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE (ur.[RoleId] = @RoleId) 
						AND
							([NormalizedUserName] LIKE @SearchTerm  OR 
							[NormalizedEmail] LIKE @SearchTerm  OR 
							[NormalizedFirstName] LIKE @SearchTerm  OR 
							[NormalizedLastName] LIKE @SearchTerm OR
                            [Id] LIKE @SearchTermLower) 
					ORDER BY u.[UserName]
					OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
				END
			ELSE
				BEGIN
					DECLARE @FirstName nvarchar(256);
					DECLARE @FirstNameCount int;
					DECLARE @LastName nvarchar(256);

					SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
					SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

					SELECT Count(*)
					FROM [AspNetUserRoles] ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE (ur.[RoleId] = @RoleId) 
					AND
					   ([NormalizedFirstName] LIKE @FirstName AND
					   [NormalizedLastName] LIKE @LastName)

				--Select all users in role with Search
					SELECT u.Id,
							u.[Email], 
							u.[FirstName], 
							u.[LastName], 	
							u.[UserName]
					FROM [AspNetUserRoles] ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE (ur.[RoleId] = @RoleId) 
					AND
					   ([NormalizedFirstName] LIKE @FirstName AND
					   [NormalizedLastName] LIKE @LastName)
					ORDER BY u.[UserName]
					OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
				END

		END
END
GO

ALTER PROCEDURE [dbo].FindActiveUsersInRoleAndAllActiveUsersWithCount
	@RoleId nvarchar(450),
	@SearchTerm nvarchar(256) = null, 
	@PageNumber int,
	@PageSize int
AS
BEGIN
/* Searchs for all Active (IsBlocked = 0 && IsDeleted = 0) Users and if they are in the role  */
/* If @SearchTerm is given it will search for LIKE on Email, Username, firstname and lastname */
/* If no @SearchTerm is given it will return all Active Users in that Role					  */
	SET NOCOUNT ON;

	
	IF @SearchTerm IS null
		BEGIN
		  -- Select Count of all users within role
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 

	--Get All UserRole Entries with RoleID

		;WITH UserRoles_CTE
		AS
		(
			SELECT ur.[RoleId],
				   ur.[UserId]
			FROM [AspNetUserRoles] ur
			WHERE ur.[RoleId] = @RoleId
		)
		SELECT  u.Id,
				u.[Email], 
				u.[FirstName], 
				u.[LastName], 	
				u.[UserName],
			    CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
		FROM UserRoles_CTE ur
		RIGHT JOIN [ActiveUsers] u
		ON u.Id = ur.UserId			
		ORDER BY u.[UserName]

		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE -- IF @SearchTerm is not Null
		BEGIN
            DECLARE @SearchTermLower nvarchar(256);
            SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
            
			SET @SearchTerm = UPPER(@SearchTerm) + N'%'
			
			DECLARE @NameSplitCount int;
			SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

			IF(@NameSplitCount = 0)
				BEGIN
			--Select Count With Search
					SELECT Count(*)
					FROM [AspNetUserRoles] ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE [NormalizedUserName] LIKE @SearchTerm  OR 
						[NormalizedEmail] LIKE @SearchTerm  OR 
						[NormalizedFirstName] LIKE @SearchTerm  OR 
						[NormalizedLastName] LIKE @SearchTerm OR 
					      [Id] LIKE @SearchTermLower

				--Select users in result with Search
					;WITH UserRoles_CTE
					AS
					(
						SELECT ur.[RoleId],
							   ur.[UserId]
						FROM [AspNetUserRoles] ur
						WHERE ur.[RoleId] = @RoleId

					)
					SELECT u.Id,
							u.[Email], 
							u.[FirstName], 
							u.[LastName], 	
							u.[UserName],
							CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
					FROM UserRoles_CTE ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE (ur.[RoleId] = @RoleId) 
						AND
							[NormalizedUserName] LIKE @SearchTerm  OR 
							[NormalizedEmail] LIKE @SearchTerm  OR 
							[NormalizedFirstName] LIKE @SearchTerm  OR 
							[NormalizedLastName] LIKE @SearchTerm OR
					        [Id] LIKE @SearchTermLower
					ORDER BY u.[UserName]
					OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
				END
		ELSE
			BEGIN
				DECLARE @FirstName nvarchar(256);
				DECLARE @FirstNameCount int;
				DECLARE @LastName nvarchar(256);

				SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
				SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))	
			
				SELECT Count(*)
				FROM [AspNetUserRoles] ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId
				WHERE ([NormalizedFirstName] LIKE @FirstName AND
					   [NormalizedLastName] LIKE @LastName)

			--Select users in result with Search
				;WITH UserRoles_CTE
				AS
				(
					SELECT ur.[RoleId],
							ur.[UserId]
					FROM [AspNetUserRoles] ur
					WHERE ur.[RoleId] = @RoleId

				)
				SELECT u.Id,
						u.[Email], 
						u.[FirstName], 
						u.[LastName], 	
						u.[UserName],
						CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
				FROM UserRoles_CTE ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId
				WHERE ([NormalizedFirstName] LIKE @FirstName AND
					   [NormalizedLastName] LIKE @LastName)
				ORDER BY u.[UserName]
				OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
			END
	END
END
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200706104406_RoleSearchOptimizationUpdateMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [EnumClaimTypeAllowedValues] (
    [ClaimTypeId] nvarchar(450) NOT NULL,
    [Value] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_EnumClaimTypeAllowedValues] PRIMARY KEY ([ClaimTypeId], [Value]),
    CONSTRAINT [FK_EnumClaimTypeAllowedValues_AspNetClaimTypes_ClaimTypeId] FOREIGN KEY ([ClaimTypeId]) REFERENCES [AspNetClaimTypes] ([Id]) ON DELETE CASCADE
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210430141851_EnumeratedClaimTypeMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER PROCEDURE [dbo].[FindAllUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR 
			       [Id] LIKE @SearchTermLower);
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END

GO

ALTER PROCEDURE [dbo].[FindActiveUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 0 AND [IsDeleted] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName)  AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END


GO

ALTER PROCEDURE [dbo].[FindActiveOrBlockedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
    
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
					AND [NormalizedLastName] LIKE @LastName) AND [IsDeleted] = 0

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END


GO

ALTER PROCEDURE [dbo].[FindActiveOrDeletedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%';
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					[IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
				   AND [NormalizedLastName] LIKE @LastName)
				   AND  [IsBlocked] = 0

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)
				   AND [IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END

GO

ALTER PROCEDURE [dbo].[FindBlockedOrDeletedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1);
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1)

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindBlockedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 1;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsBlocked] = 1

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindDeletedUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm  OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 1;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm  OR 
				   [NormalizedLastName] LIKE @SearchTerm   OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsDeleted] = 1

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20211209115717_AddingIdToStoredProceduresMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [AspNetClaimTypes] ADD [DisplayName] nvarchar(max) NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220110161021_ClaimTypeDisplayNameMigration', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE PROCEDURE [dbo].[FindAllUsersWithCountWithClaimValueSearch] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	
	IF(@NameSplitCount = 0)
		BEGIN

			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
				SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
				FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)

			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR 
			       [AspNetUsers].[Id] LIKE @SearchTermLower OR
				   CTE_ClaimSearch.[UserId] IS NOT NULL);

			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
				SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
				FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)

			SELECT [AspNetUsers].[Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON
			CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id]

			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [AspNetUsers].[Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL)

			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END

GO

CREATE PROCEDURE [dbo].[FindActiveUsersWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)

			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsBlocked] = 0 AND [IsDeleted] = 0;

			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   ([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName)  AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END


GO

CREATE PROCEDURE [dbo].[FindActiveOrBlockedWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
    
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsDeleted] = 0;

			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR 
				CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
					AND [NormalizedLastName] LIKE @LastName) AND [IsDeleted] = 0

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END


GO

CREATE PROCEDURE [dbo].[FindActiveOrDeletedUsersWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%';
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)

			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsBlocked] = 0;

			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
					[IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
				   AND [NormalizedLastName] LIKE @LastName)
				   AND  [IsBlocked] = 0

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)
				   AND [IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END

GO

CREATE PROCEDURE [dbo].[FindBlockedOrDeletedWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1);

			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1)

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

CREATE PROCEDURE [dbo].[FindBlockedUsersWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'

    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsBlocked] = 1;


			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsBlocked] = 1

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

CREATE PROCEDURE [dbo].[FindDeletedUsersWithCountWithClaimValueSearch] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))

	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)

			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm  OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsDeleted] = 1;

			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm  OR 
				   [NormalizedLastName] LIKE @SearchTerm   OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);

			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))

			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsDeleted] = 1

			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220225154308_ClaimValueSearchMigration', N'6.0.3');
GO

COMMIT;
GO

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [SamlArtifacts] (
    [Key] nvarchar(200) NOT NULL,
    [EntityId] nvarchar(200) NOT NULL,
    [MessageType] nvarchar(50) NOT NULL,
    [Message] nvarchar(max) NOT NULL,
    [CreationTime] datetime2 NOT NULL,
    [Expiration] datetime2 NOT NULL,
    CONSTRAINT [PK_SamlArtifacts] PRIMARY KEY ([Key])
);
GO

CREATE INDEX [IX_SamlArtifacts_Expiration] ON [SamlArtifacts] ([Expiration]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220114164649_SqlServerSamlArtifactInitialMigration', N'6.0.3');
GO

COMMIT;
GO

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [ServiceProviders] (
    [Id] int NOT NULL IDENTITY,
    [EntityId] nvarchar(200) NOT NULL,
    [EncryptionCertificate] varbinary(max) NULL,
    [SignAssertions] bit NOT NULL,
    [EncryptAssertions] bit NOT NULL,
    [RequireSamlRequestDestination] bit NOT NULL,
    CONSTRAINT [PK_ServiceProviders] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [ServiceProviderAssertionConsumerServices] (
    [Id] int NOT NULL IDENTITY,
    [Binding] nvarchar(2000) NOT NULL,
    [Location] nvarchar(2000) NOT NULL,
    [Index] int NOT NULL,
    [IsDefault] bit NOT NULL,
    [ServiceProviderId] int NOT NULL,
    CONSTRAINT [PK_ServiceProviderAssertionConsumerServices] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ServiceProviderAssertionConsumerServices_ServiceProviders_ServiceProviderId] FOREIGN KEY ([ServiceProviderId]) REFERENCES [ServiceProviders] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ServiceProviderClaimMappings] (
    [Id] int NOT NULL IDENTITY,
    [OriginalClaimType] nvarchar(250) NOT NULL,
    [NewClaimType] nvarchar(250) NOT NULL,
    [ServiceProviderId] int NOT NULL,
    CONSTRAINT [PK_ServiceProviderClaimMappings] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ServiceProviderClaimMappings_ServiceProviders_ServiceProviderId] FOREIGN KEY ([ServiceProviderId]) REFERENCES [ServiceProviders] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ServiceProviderSignCertificates] (
    [Id] int NOT NULL IDENTITY,
    [Certificate] varbinary(max) NOT NULL,
    [ServiceProviderId] int NOT NULL,
    CONSTRAINT [PK_ServiceProviderSignCertificates] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ServiceProviderSignCertificates_ServiceProviders_ServiceProviderId] FOREIGN KEY ([ServiceProviderId]) REFERENCES [ServiceProviders] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ServiceProviderSingleLogoutServices] (
    [Id] int NOT NULL IDENTITY,
    [Binding] nvarchar(2000) NOT NULL,
    [Location] nvarchar(2000) NOT NULL,
    [Index] int NOT NULL,
    [IsDefault] bit NOT NULL,
    [ServiceProviderId] int NOT NULL,
    CONSTRAINT [PK_ServiceProviderSingleLogoutServices] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ServiceProviderSingleLogoutServices_ServiceProviders_ServiceProviderId] FOREIGN KEY ([ServiceProviderId]) REFERENCES [ServiceProviders] ([Id]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_ServiceProviderAssertionConsumerServices_ServiceProviderId] ON [ServiceProviderAssertionConsumerServices] ([ServiceProviderId]);
GO

CREATE INDEX [IX_ServiceProviderClaimMappings_ServiceProviderId] ON [ServiceProviderClaimMappings] ([ServiceProviderId]);
GO

CREATE UNIQUE INDEX [IX_ServiceProviders_EntityId] ON [ServiceProviders] ([EntityId]);
GO

CREATE INDEX [IX_ServiceProviderSignCertificates_ServiceProviderId] ON [ServiceProviderSignCertificates] ([ServiceProviderId]);
GO

CREATE INDEX [IX_ServiceProviderSingleLogoutServices_ServiceProviderId] ON [ServiceProviderSingleLogoutServices] ([ServiceProviderId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190305134515_SqlServerSaml2PInitial', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [ServiceProviders] ADD [AllowIdpInitiatedSso] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200225104531_Added AllowIdpInitiatedSso', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [ServiceProviders] ADD [RequireAuthenticationRequestsSigned] bit NULL;
GO

EXEC sp_rename N'[ServiceProviders].[RequireSamlRequestDestination]', N'RequireSamlMessageDestination', N'COLUMN';
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200914075545_RskSamlV3', N'6.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [ServiceProviders] ADD [ArtifactDeliveryBindingType] nvarchar(max) NULL;
GO

ALTER TABLE [ServiceProviders] ADD [NameIdentifierFormat] nvarchar(max) NULL;
GO

ALTER TABLE [ServiceProviders] ADD [RequireSignedArtifactResolveRequests] bit NULL;
GO

ALTER TABLE [ServiceProviders] ADD [RequireSignedArtifactResponses] bit NULL;
GO

CREATE TABLE [ServiceProviderArtifactResolutionServices] (
    [Id] int NOT NULL IDENTITY,
    [Binding] nvarchar(2000) NOT NULL,
    [Location] nvarchar(2000) NOT NULL,
    [Index] int NOT NULL,
    [IsDefault] bit NOT NULL,
    [ServiceProviderId] int NOT NULL,
    CONSTRAINT [PK_ServiceProviderArtifactResolutionServices] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ServiceProviderArtifactResolutionServices_ServiceProviders_ServiceProviderId] FOREIGN KEY ([ServiceProviderId]) REFERENCES [ServiceProviders] ([Id]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_ServiceProviderArtifactResolutionServices_ServiceProviderId] ON [ServiceProviderArtifactResolutionServices] ([ServiceProviderId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220112143907_RskSamlPackageUpdate', N'6.0.3');
GO

COMMIT;
GO

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [RelyingParties] (
    [Id] int NOT NULL IDENTITY,
    [Realm] nvarchar(200) NOT NULL,
    [TokenType] nvarchar(max) NULL,
    [SignatureAlgorithm] nvarchar(max) NULL,
    [DigestAlgorithm] nvarchar(max) NULL,
    [SamlNameIdentifierFormat] nvarchar(max) NULL,
    CONSTRAINT [PK_RelyingParties] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [RelyingPartyClaimMappings] (
    [Id] int NOT NULL IDENTITY,
    [OriginalClaimType] nvarchar(250) NOT NULL,
    [NewClaimType] nvarchar(250) NOT NULL,
    [RelyingPartyId] int NOT NULL,
    CONSTRAINT [PK_RelyingPartyClaimMappings] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_RelyingPartyClaimMappings_RelyingParties_RelyingPartyId] FOREIGN KEY ([RelyingPartyId]) REFERENCES [RelyingParties] ([Id]) ON DELETE CASCADE
);
GO

CREATE UNIQUE INDEX [IX_RelyingParties_Realm] ON [RelyingParties] ([Realm]);
GO

CREATE INDEX [IX_RelyingPartyClaimMappings_RelyingPartyId] ON [RelyingPartyClaimMappings] ([RelyingPartyId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190305133618_SqlServerWsfederationInitial', N'6.0.3');
GO

COMMIT;
GO

