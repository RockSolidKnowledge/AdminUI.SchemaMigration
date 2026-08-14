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

CREATE INDEX [IX_PersistedGrants_SubjectId_ClientId_Type] ON [PersistedGrants] ([SubjectId], [ClientId], [Type]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171026080756_InitialSqlServerOperationalDbMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171122163758_UserSearchOptimizationOperationalDbMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
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

CREATE UNIQUE INDEX [IX_DeviceCodes_DeviceCode] ON [DeviceCodes] ([DeviceCode]);

CREATE UNIQUE INDEX [IX_DeviceCodes_UserCode] ON [DeviceCodes] ([UserCode]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181109164134_IdentityServer2.3SqlServerSqlServerOperationalDbMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;

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

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200702080430_V3toV4SqlServerOperationalDbMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
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

CREATE INDEX [IX_Keys_Use] ON [Keys] ([Use]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210105164242_DuendeSqlServerMigrationOperational', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
CREATE INDEX [IX_PersistedGrants_ConsumedTime] ON [PersistedGrants] ([ConsumedTime]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210602110024_PersistedGrantConsumeTimeSqlServerOperationalMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [PersistedGrants] DROP CONSTRAINT [PK_PersistedGrants];

DECLARE @var nvarchar(max);
SELECT @var = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[PersistedGrants]') AND [c].[name] = N'Key');
IF @var IS NOT NULL EXEC(N'ALTER TABLE [PersistedGrants] DROP CONSTRAINT ' + @var + ';');
ALTER TABLE [PersistedGrants] ALTER COLUMN [Key] nvarchar(200) NULL;

ALTER TABLE [PersistedGrants] ADD [Id] bigint NOT NULL IDENTITY;

ALTER TABLE [PersistedGrants] ADD CONSTRAINT [PK_PersistedGrants] PRIMARY KEY ([Id]);

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

CREATE UNIQUE INDEX [IX_PersistedGrants_Key] ON [PersistedGrants] ([Key]) WHERE [Key] IS NOT NULL;

CREATE INDEX [IX_ServerSideSessions_DisplayName] ON [ServerSideSessions] ([DisplayName]);

CREATE INDEX [IX_ServerSideSessions_Expires] ON [ServerSideSessions] ([Expires]);

CREATE UNIQUE INDEX [IX_ServerSideSessions_Key] ON [ServerSideSessions] ([Key]);

CREATE INDEX [IX_ServerSideSessions_SessionId] ON [ServerSideSessions] ([SessionId]);

CREATE INDEX [IX_ServerSideSessions_SubjectId] ON [ServerSideSessions] ([SubjectId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220608091949_Duende61Update', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [ServerSideSessions] DROP CONSTRAINT [PK_ServerSideSessions];

DECLARE @var1 nvarchar(max);
SELECT @var1 = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ServerSideSessions]') AND [c].[name] = N'Id');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [ServerSideSessions] DROP CONSTRAINT ' + @var1 + ';');
ALTER TABLE [ServerSideSessions] ALTER COLUMN [Id] bigint NOT NULL;

ALTER TABLE [ServerSideSessions] ADD CONSTRAINT [PK_ServerSideSessions] PRIMARY KEY ([Id]);

CREATE TABLE [PushedAuthorizationRequests] (
    [Id] bigint NOT NULL IDENTITY,
    [ReferenceValueHash] nvarchar(max) NULL,
    [ExpiresAtUtc] datetime2 NOT NULL,
    [Parameters] nvarchar(max) NULL,
    CONSTRAINT [PK_PushedAuthorizationRequests] PRIMARY KEY ([Id])
);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240108131028_DuendeV7SqlServerOperationalMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
DECLARE @var2 nvarchar(max);
SELECT @var2 = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[PushedAuthorizationRequests]') AND [c].[name] = N'ReferenceValueHash');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [PushedAuthorizationRequests] DROP CONSTRAINT ' + @var2 + ';');
UPDATE [PushedAuthorizationRequests] SET [ReferenceValueHash] = N'' WHERE [ReferenceValueHash] IS NULL;
ALTER TABLE [PushedAuthorizationRequests] ALTER COLUMN [ReferenceValueHash] nvarchar(64) NOT NULL;
ALTER TABLE [PushedAuthorizationRequests] ADD DEFAULT N'' FOR [ReferenceValueHash];

DECLARE @var3 nvarchar(max);
SELECT @var3 = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[PushedAuthorizationRequests]') AND [c].[name] = N'Parameters');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [PushedAuthorizationRequests] DROP CONSTRAINT ' + @var3 + ';');
UPDATE [PushedAuthorizationRequests] SET [Parameters] = N'' WHERE [Parameters] IS NULL;
ALTER TABLE [PushedAuthorizationRequests] ALTER COLUMN [Parameters] nvarchar(max) NOT NULL;
ALTER TABLE [PushedAuthorizationRequests] ADD DEFAULT N'' FOR [Parameters];

CREATE INDEX [IX_PushedAuthorizationRequests_ExpiresAtUtc] ON [PushedAuthorizationRequests] ([ExpiresAtUtc]);

CREATE UNIQUE INDEX [IX_PushedAuthorizationRequests_ReferenceValueHash] ON [PushedAuthorizationRequests] ([ReferenceValueHash]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250121150503_DuendeV7.1SqlServerOperationalMigration', N'10.0.11');

COMMIT;
GO

