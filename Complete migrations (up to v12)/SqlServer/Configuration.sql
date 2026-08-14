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
CREATE TABLE [ApiResources] (
    [Id] int NOT NULL IDENTITY,
    [Description] nvarchar(1000) NULL,
    [DisplayName] nvarchar(200) NULL,
    [Enabled] bit NOT NULL,
    [Name] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_ApiResources] PRIMARY KEY ([Id])
);

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

CREATE TABLE [ApiClaims] (
    [Id] int NOT NULL IDENTITY,
    [ApiResourceId] int NOT NULL,
    [Type] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_ApiClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ApiClaims_ApiResources_ApiResourceId] FOREIGN KEY ([ApiResourceId]) REFERENCES [ApiResources] ([Id]) ON DELETE CASCADE
);

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

CREATE TABLE [ClientClaims] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Type] nvarchar(250) NOT NULL,
    [Value] nvarchar(250) NOT NULL,
    CONSTRAINT [PK_ClientClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientClaims_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [ClientCorsOrigins] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Origin] nvarchar(150) NOT NULL,
    CONSTRAINT [PK_ClientCorsOrigins] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientCorsOrigins_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [ClientGrantTypes] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [GrantType] nvarchar(250) NOT NULL,
    CONSTRAINT [PK_ClientGrantTypes] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientGrantTypes_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [ClientIdPRestrictions] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Provider] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_ClientIdPRestrictions] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientIdPRestrictions_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [ClientPostLogoutRedirectUris] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [PostLogoutRedirectUri] nvarchar(2000) NOT NULL,
    CONSTRAINT [PK_ClientPostLogoutRedirectUris] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientPostLogoutRedirectUris_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [ClientProperties] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Key] nvarchar(250) NOT NULL,
    [Value] nvarchar(2000) NOT NULL,
    CONSTRAINT [PK_ClientProperties] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientProperties_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [ClientRedirectUris] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [RedirectUri] nvarchar(2000) NOT NULL,
    CONSTRAINT [PK_ClientRedirectUris] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientRedirectUris_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [ClientScopes] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [Scope] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_ClientScopes] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClientScopes_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
);

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

CREATE TABLE [IdentityClaims] (
    [Id] int NOT NULL IDENTITY,
    [IdentityResourceId] int NOT NULL,
    [Type] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_IdentityClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_IdentityClaims_IdentityResources_IdentityResourceId] FOREIGN KEY ([IdentityResourceId]) REFERENCES [IdentityResources] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [ApiScopeClaims] (
    [Id] int NOT NULL IDENTITY,
    [ApiScopeId] int NOT NULL,
    [Type] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_ApiScopeClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ApiScopeClaims_ApiScopes_ApiScopeId] FOREIGN KEY ([ApiScopeId]) REFERENCES [ApiScopes] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_ApiClaims_ApiResourceId] ON [ApiClaims] ([ApiResourceId]);

CREATE UNIQUE INDEX [IX_ApiResources_Name] ON [ApiResources] ([Name]);

CREATE INDEX [IX_ApiScopeClaims_ApiScopeId] ON [ApiScopeClaims] ([ApiScopeId]);

CREATE INDEX [IX_ApiScopes_ApiResourceId] ON [ApiScopes] ([ApiResourceId]);

CREATE UNIQUE INDEX [IX_ApiScopes_Name] ON [ApiScopes] ([Name]);

CREATE INDEX [IX_ApiSecrets_ApiResourceId] ON [ApiSecrets] ([ApiResourceId]);

CREATE INDEX [IX_ClientClaims_ClientId] ON [ClientClaims] ([ClientId]);

CREATE INDEX [IX_ClientCorsOrigins_ClientId] ON [ClientCorsOrigins] ([ClientId]);

CREATE INDEX [IX_ClientGrantTypes_ClientId] ON [ClientGrantTypes] ([ClientId]);

CREATE INDEX [IX_ClientIdPRestrictions_ClientId] ON [ClientIdPRestrictions] ([ClientId]);

CREATE INDEX [IX_ClientPostLogoutRedirectUris_ClientId] ON [ClientPostLogoutRedirectUris] ([ClientId]);

CREATE INDEX [IX_ClientProperties_ClientId] ON [ClientProperties] ([ClientId]);

CREATE INDEX [IX_ClientRedirectUris_ClientId] ON [ClientRedirectUris] ([ClientId]);

CREATE UNIQUE INDEX [IX_Clients_ClientId] ON [Clients] ([ClientId]);

CREATE INDEX [IX_ClientScopes_ClientId] ON [ClientScopes] ([ClientId]);

CREATE INDEX [IX_ClientSecrets_ClientId] ON [ClientSecrets] ([ClientId]);

CREATE INDEX [IX_IdentityClaims_IdentityResourceId] ON [IdentityClaims] ([IdentityResourceId]);

CREATE UNIQUE INDEX [IX_IdentityResources_Name] ON [IdentityResources] ([Name]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171026080114_InitialSqlServerConfigurationDbMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171122163636_UserSearchOptimizationConfigurationDbMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [IdentityResources] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

ALTER TABLE [IdentityResources] ADD [NonEditable] bit NOT NULL DEFAULT CAST(0 AS bit);

ALTER TABLE [IdentityResources] ADD [Updated] datetime2 NULL;

DECLARE @var nvarchar(max);
SELECT @var = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ClientSecrets]') AND [c].[name] = N'Value');
IF @var IS NOT NULL EXEC(N'ALTER TABLE [ClientSecrets] DROP CONSTRAINT ' + @var + ';');
ALTER TABLE [ClientSecrets] ALTER COLUMN [Value] nvarchar(4000) NOT NULL;

DECLARE @var1 nvarchar(max);
SELECT @var1 = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ClientSecrets]') AND [c].[name] = N'Type');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [ClientSecrets] DROP CONSTRAINT ' + @var1 + ';');
ALTER TABLE [ClientSecrets] ALTER COLUMN [Type] nvarchar(250) NOT NULL;

ALTER TABLE [ClientSecrets] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

ALTER TABLE [Clients] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

ALTER TABLE [Clients] ADD [DeviceCodeLifetime] int NOT NULL DEFAULT 0;

ALTER TABLE [Clients] ADD [LastAccessed] datetime2 NULL;

ALTER TABLE [Clients] ADD [NonEditable] bit NOT NULL DEFAULT CAST(0 AS bit);

ALTER TABLE [Clients] ADD [Updated] datetime2 NULL;

ALTER TABLE [Clients] ADD [UserCodeType] nvarchar(100) NULL;

ALTER TABLE [Clients] ADD [UserSsoLifetime] int NULL;

DECLARE @var2 nvarchar(max);
SELECT @var2 = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApiSecrets]') AND [c].[name] = N'Value');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [ApiSecrets] DROP CONSTRAINT ' + @var2 + ';');
ALTER TABLE [ApiSecrets] ALTER COLUMN [Value] nvarchar(4000) NOT NULL;

DECLARE @var3 nvarchar(max);
SELECT @var3 = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApiSecrets]') AND [c].[name] = N'Type');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [ApiSecrets] DROP CONSTRAINT ' + @var3 + ';');
ALTER TABLE [ApiSecrets] ALTER COLUMN [Type] nvarchar(250) NOT NULL;

ALTER TABLE [ApiSecrets] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

ALTER TABLE [ApiResources] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

ALTER TABLE [ApiResources] ADD [LastAccessed] datetime2 NULL;

ALTER TABLE [ApiResources] ADD [NonEditable] bit NOT NULL DEFAULT CAST(0 AS bit);

ALTER TABLE [ApiResources] ADD [Updated] datetime2 NULL;

CREATE TABLE [ApiProperties] (
    [Id] int NOT NULL IDENTITY,
    [Key] nvarchar(250) NOT NULL,
    [Value] nvarchar(2000) NOT NULL,
    [ApiResourceId] int NOT NULL,
    CONSTRAINT [PK_ApiProperties] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ApiProperties_ApiResources_ApiResourceId] FOREIGN KEY ([ApiResourceId]) REFERENCES [ApiResources] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [IdentityProperties] (
    [Id] int NOT NULL IDENTITY,
    [Key] nvarchar(250) NOT NULL,
    [Value] nvarchar(2000) NOT NULL,
    [IdentityResourceId] int NOT NULL,
    CONSTRAINT [PK_IdentityProperties] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_IdentityProperties_IdentityResources_IdentityResourceId] FOREIGN KEY ([IdentityResourceId]) REFERENCES [IdentityResources] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_ApiProperties_ApiResourceId] ON [ApiProperties] ([ApiResourceId]);

CREATE INDEX [IX_IdentityProperties_IdentityResourceId] ON [IdentityProperties] ([IdentityResourceId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181109163923_IdentityServer2.3SqlServerConfigurationDbMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
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


CREATE NONCLUSTERED INDEX IX_ApiResourceScopes_ApiResourceId
    ON ApiResourceScopes(ApiResourceId ASC);




-- Add ApiScopeProperties

CREATE TABLE ApiScopeProperties (
    Id        INT             IDENTITY (1, 1) NOT NULL,
    [Key]     NVARCHAR (250)  NOT NULL,
    [Value]   NVARCHAR (2000) NOT NULL,
    ScopeId   INT             NOT NULL,
    CONSTRAINT PK_ApiScopeProperties PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiScopeProperties_ApiScopes_ScopeId FOREIGN KEY (ScopeId) REFERENCES ApiScopes (Id) ON DELETE CASCADE
);


CREATE NONCLUSTERED INDEX IX_ApiScopeProperties_ScopeId
    ON ApiScopeProperties(ScopeId ASC);




-- Add Renamed Tables

-- ApiResourceClaims

CREATE TABLE [ApiResourceClaims] (
    Id              INT            IDENTITY (1, 1) NOT NULL,
    [Type]          NVARCHAR (200) NOT NULL,
    ApiResourceId   INT            NOT NULL,
    CONSTRAINT PK_ApiResourceClaims PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiResourceClaims_ApiResources_ApiResourceId FOREIGN KEY (ApiResourceId) REFERENCES ApiResources (Id) ON DELETE CASCADE
);


CREATE NONCLUSTERED INDEX [IX_ApiResourceClaims_ApiResourceId]
    ON [ApiResourceClaims]([ApiResourceId] ASC);




-- ApiResourceProperties

CREATE TABLE [ApiResourceProperties] (
    [Id]            INT             IDENTITY (1, 1) NOT NULL,
    [Key]           NVARCHAR (250)  NOT NULL,
    [Value]         NVARCHAR (2000) NOT NULL,
    ApiResourceId   INT             NOT NULL,
    CONSTRAINT PK_ApiResourceProperties PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiResourceProperties_ApiResources_ApiResourceId FOREIGN KEY (ApiResourceId) REFERENCES ApiResources (Id) ON DELETE CASCADE
);


CREATE NONCLUSTERED INDEX [IX_ApiResourceProperties_ApiResourceId]
    ON [ApiResourceProperties]([ApiResourceId] ASC);




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


CREATE NONCLUSTERED INDEX IX_ApiResourceSecrets_ApiResourceId
    ON ApiResourceSecrets(ApiResourceId ASC);




-- IdentityResourceClaims

CREATE TABLE IdentityResourceClaims (
    Id                 INT            IDENTITY (1, 1) NOT NULL,
    [Type]             NVARCHAR (200) NOT NULL,
    IdentityResourceId INT            NOT NULL,
    CONSTRAINT PK_IdentityResourceClaims PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_IdentityResourceClaims_IdentityResources_IdentityResourceId FOREIGN KEY (IdentityResourceId) REFERENCES IdentityResources (Id) ON DELETE CASCADE
);


CREATE NONCLUSTERED INDEX [IX_IdentityResourceClaims_IdentityResourceId]
    ON IdentityResourceClaims(IdentityResourceId ASC);




-- IdentityResourceProperties

CREATE TABLE IdentityResourceProperties (
    Id                   INT             IDENTITY (1, 1) NOT NULL,
    [Key]                NVARCHAR (250)  NOT NULL,
    [Value]              NVARCHAR (2000) NOT NULL,
    IdentityResourceId   INT             NOT NULL,
    CONSTRAINT PK_IdentityResourceProperties PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_IdentityResourceProperties_IdentityResources_IdentityResourceId FOREIGN KEY (IdentityResourceId) REFERENCES IdentityResources (Id) ON DELETE CASCADE
);


CREATE NONCLUSTERED INDEX IX_IdentityResourceProperties_IdentityResourceId
    ON IdentityResourceProperties(IdentityResourceId ASC);




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


INSERT INTO ApiResourceProperties
 (Id, [Key], [Value], ApiResourceId)
SELECT 
 Id, [Key], [Value], ApiResourceId
FROM ApiProperties


SET IDENTITY_INSERT ApiResourceProperties OFF;


--ApiSecrets -> ApiResourceSecrets
SET IDENTITY_INSERT ApiResourceSecrets ON;  


INSERT INTO ApiResourceSecrets
 (Id, [Description], [Value], Expiration, [Type], Created, ApiResourceId)
SELECT 
 Id, [Description], [Value], Expiration, [Type], Created, ApiResourceId
FROM ApiSecrets


SET IDENTITY_INSERT ApiResourceSecrets OFF;  



--IdentityClaims -> IdentityResourceClaims
SET IDENTITY_INSERT IdentityResourceClaims ON;  


INSERT INTO IdentityResourceClaims
 (Id, [Type], IdentityResourceId)
SELECT 
 Id, [Type], IdentityResourceId
FROM IdentityClaims


SET IDENTITY_INSERT IdentityResourceClaims OFF;  




--IdentityProperties -> IdentityResourceProperties
SET IDENTITY_INSERT IdentityResourceProperties ON;  


INSERT INTO IdentityResourceProperties
 (Id, [Key], [Value], IdentityResourceId)
SELECT 
 Id, [Key], [Value], IdentityResourceId
FROM IdentityProperties


SET IDENTITY_INSERT IdentityResourceProperties OFF;  



-- ApiScopes -> ApiResourceScopes

INSERT INTO ApiResourceScopes 
 ([Scope], [ApiResourceId])
SELECT 
 [Name], [ApiResourceId]
FROM ApiScopes

-- Alter Existing Tables

-- ApiResources

ALTER TABLE ApiResources 
    ADD AllowedAccessTokenSigningAlgorithms NVARCHAR (100) NULL;
    
ALTER TABLE ApiResources 
    ADD ShowInDiscoveryDocument BIT NULL;
GO

UPDATE ApiResources SET ShowInDiscoveryDocument = 0;

ALTER TABLE ApiResources 
	ALTER COLUMN ShowInDiscoveryDocument BIT NOT NULL;

GO

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

GO

-- Clients

ALTER TABLE Clients
	ADD AllowedIdentityTokenSigningAlgorithms NVARCHAR (100) NULL
	
ALTER TABLE Clients
	ADD RequireRequestObject BIT NULL

GO

UPDATE Clients SET RequireRequestObject = 0
	
ALTER TABLE Clients
	ALTER COLUMN RequireRequestObject BIT NOT NULL

GO

-- Delete Old Tables

DROP TABLE ApiClaims
DROP TABLE ApiProperties
DROP TABLE ApiSecrets
DROP TABLE IdentityClaims
DROP TABLE IdentityProperties

COMMIT TRANSACTION

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200702075849_V3toV4SqlServerConfigurationDbMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [ApiResources] ADD [RequireResourceIndicator] bit NOT NULL DEFAULT CAST(0 AS bit);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210106132452_DuendeSqlServerConfigurationMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
CREATE TABLE [IdentityProviders] (
    [Id] int NOT NULL IDENTITY,
    [Scheme] nvarchar(200) NOT NULL,
    [DisplayName] nvarchar(200) NULL,
    [Enabled] bit NOT NULL,
    [Type] nvarchar(20) NOT NULL,
    [Properties] nvarchar(max) NULL,
    CONSTRAINT [PK_IdentityProviders] PRIMARY KEY ([Id])
);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210602104947_IdentityProvidersSqlServerConfigurationMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
DROP INDEX [IX_IdentityResourceProperties_IdentityResourceId] ON [IdentityResourceProperties];

DROP INDEX [IX_IdentityResourceClaims_IdentityResourceId] ON [IdentityResourceClaims];

DROP INDEX [IX_ClientScopes_ClientId] ON [ClientScopes];

DROP INDEX [IX_ClientRedirectUris_ClientId] ON [ClientRedirectUris];

DROP INDEX [IX_ClientProperties_ClientId] ON [ClientProperties];

DROP INDEX [IX_ClientPostLogoutRedirectUris_ClientId] ON [ClientPostLogoutRedirectUris];

DROP INDEX [IX_ClientIdPRestrictions_ClientId] ON [ClientIdPRestrictions];

DROP INDEX [IX_ClientGrantTypes_ClientId] ON [ClientGrantTypes];

DROP INDEX [IX_ClientCorsOrigins_ClientId] ON [ClientCorsOrigins];

DROP INDEX [IX_ClientClaims_ClientId] ON [ClientClaims];

DROP INDEX [IX_ApiScopeProperties_ScopeId] ON [ApiScopeProperties];

DROP INDEX [IX_ApiScopeClaims_ScopeId] ON [ApiScopeClaims];

DROP INDEX [IX_ApiResourceScopes_ApiResourceId] ON [ApiResourceScopes];

DROP INDEX [IX_ApiResourceProperties_ApiResourceId] ON [ApiResourceProperties];

DROP INDEX [IX_ApiResourceClaims_ApiResourceId] ON [ApiResourceClaims];

ALTER TABLE [IdentityProviders] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

ALTER TABLE [IdentityProviders] ADD [LastAccessed] datetime2 NULL;

ALTER TABLE [IdentityProviders] ADD [NonEditable] bit NOT NULL DEFAULT CAST(0 AS bit);

ALTER TABLE [IdentityProviders] ADD [Updated] datetime2 NULL;

ALTER TABLE [Clients] ADD [CibaLifetime] int NULL;

ALTER TABLE [Clients] ADD [PollingInterval] int NULL;

DECLARE @var4 nvarchar(max);
SELECT @var4 = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ClientRedirectUris]') AND [c].[name] = N'RedirectUri');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [ClientRedirectUris] DROP CONSTRAINT ' + @var4 + ';');
ALTER TABLE [ClientRedirectUris] ALTER COLUMN [RedirectUri] nvarchar(400) NOT NULL;

DECLARE @var5 nvarchar(max);
SELECT @var5 = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ClientPostLogoutRedirectUris]') AND [c].[name] = N'PostLogoutRedirectUri');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [ClientPostLogoutRedirectUris] DROP CONSTRAINT ' + @var5 + ';');
ALTER TABLE [ClientPostLogoutRedirectUris] ALTER COLUMN [PostLogoutRedirectUri] nvarchar(400) NOT NULL;

ALTER TABLE [ApiScopes] ADD [Created] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

ALTER TABLE [ApiScopes] ADD [LastAccessed] datetime2 NULL;

ALTER TABLE [ApiScopes] ADD [NonEditable] bit NOT NULL DEFAULT CAST(0 AS bit);

ALTER TABLE [ApiScopes] ADD [Updated] datetime2 NULL;

CREATE UNIQUE INDEX [IX_IdentityResourceProperties_IdentityResourceId_Key] ON [IdentityResourceProperties] ([IdentityResourceId], [Key]);

CREATE UNIQUE INDEX [IX_IdentityResourceClaims_IdentityResourceId_Type] ON [IdentityResourceClaims] ([IdentityResourceId], [Type]);

CREATE UNIQUE INDEX [IX_IdentityProviders_Scheme] ON [IdentityProviders] ([Scheme]);

CREATE UNIQUE INDEX [IX_ClientScopes_ClientId_Scope] ON [ClientScopes] ([ClientId], [Scope]);

CREATE UNIQUE INDEX [IX_ClientRedirectUris_ClientId_RedirectUri] ON [ClientRedirectUris] ([ClientId], [RedirectUri]);

CREATE UNIQUE INDEX [IX_ClientProperties_ClientId_Key] ON [ClientProperties] ([ClientId], [Key]);

CREATE UNIQUE INDEX [IX_ClientPostLogoutRedirectUris_ClientId_PostLogoutRedirectUri] ON [ClientPostLogoutRedirectUris] ([ClientId], [PostLogoutRedirectUri]);

CREATE UNIQUE INDEX [IX_ClientIdPRestrictions_ClientId_Provider] ON [ClientIdPRestrictions] ([ClientId], [Provider]);

CREATE UNIQUE INDEX [IX_ClientGrantTypes_ClientId_GrantType] ON [ClientGrantTypes] ([ClientId], [GrantType]);

CREATE UNIQUE INDEX [IX_ClientCorsOrigins_ClientId_Origin] ON [ClientCorsOrigins] ([ClientId], [Origin]);

CREATE UNIQUE INDEX [IX_ClientClaims_ClientId_Type_Value] ON [ClientClaims] ([ClientId], [Type], [Value]);

CREATE UNIQUE INDEX [IX_ApiScopeProperties_ScopeId_Key] ON [ApiScopeProperties] ([ScopeId], [Key]);

CREATE UNIQUE INDEX [IX_ApiScopeClaims_ScopeId_Type] ON [ApiScopeClaims] ([ScopeId], [Type]);

CREATE UNIQUE INDEX [IX_ApiResourceScopes_ApiResourceId_Scope] ON [ApiResourceScopes] ([ApiResourceId], [Scope]);

CREATE UNIQUE INDEX [IX_ApiResourceProperties_ApiResourceId_Key] ON [ApiResourceProperties] ([ApiResourceId], [Key]);

CREATE UNIQUE INDEX [IX_ApiResourceClaims_ApiResourceId_Type] ON [ApiResourceClaims] ([ApiResourceId], [Type]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220104130635_DuendeV6SqlServerConfigurationMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [Clients] ADD [CoordinateLifetimeWithUserSession] bit NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220608093217_Duende61ConfigurationUpdate', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [Clients] ADD [DPoPClockSkew] time NOT NULL DEFAULT '00:00:00';

ALTER TABLE [Clients] ADD [DPoPValidationMode] int NOT NULL DEFAULT 0;

ALTER TABLE [Clients] ADD [InitiateLoginUri] nvarchar(2000) NULL;

ALTER TABLE [Clients] ADD [RequireDPoP] bit NOT NULL DEFAULT CAST(0 AS bit);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230620153729_Duende63ConfigurationUpdate', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [Clients] ADD [PushedAuthorizationLifetime] int NULL;

ALTER TABLE [Clients] ADD [RequirePushedAuthorization] bit NOT NULL DEFAULT CAST(0 AS bit);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240104155203_DuendeV7SqlServerConfigurationMigration', N'10.0.11');

COMMIT;
GO

