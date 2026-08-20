-- This set of migrations are dependent on Configuration tables from IdentityServer already existing run ./Configuration.sql script first

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
CREATE TABLE [ExtendedApiResources] (
    [Id] nvarchar(450) NOT NULL,
    [ApiResourceName] nvarchar(200) NOT NULL,
    [NormalizedName] nvarchar(200) NOT NULL,
    [Reserved] bit NOT NULL,
    CONSTRAINT [PK_ExtendedApiResources] PRIMARY KEY ([Id])
);

CREATE TABLE [ExtendedClients] (
    [Id] nvarchar(450) NOT NULL,
    [ClientId] nvarchar(200) NOT NULL,
    [Description] nvarchar(max) NULL,
    [NormalizedClientId] nvarchar(200) NOT NULL,
    [NormalizedClientName] nvarchar(200) NULL,
    [Reserved] bit NOT NULL,
    CONSTRAINT [PK_ExtendedClients] PRIMARY KEY ([Id])
);

CREATE TABLE [ExtendedIdentityResources] (
    [Id] nvarchar(450) NOT NULL,
    [IdentityResourceName] nvarchar(200) NOT NULL,
    [NormalizedName] nvarchar(200) NOT NULL,
    [Reserved] bit NOT NULL,
    CONSTRAINT [PK_ExtendedIdentityResources] PRIMARY KEY ([Id])
);

CREATE UNIQUE INDEX [ApiNameIndex] ON [ExtendedApiResources] ([ApiResourceName]);

CREATE UNIQUE INDEX [ApiResourceNameIndex] ON [ExtendedApiResources] ([NormalizedName]);

CREATE UNIQUE INDEX [IdIndex] ON [ExtendedClients] ([ClientId]);

CREATE UNIQUE INDEX [ClientIdIndex] ON [ExtendedClients] ([NormalizedClientId]);

CREATE UNIQUE INDEX [ClientNameIndex] ON [ExtendedClients] ([NormalizedClientName]) WHERE [NormalizedClientName] IS NOT NULL;

CREATE UNIQUE INDEX [IdentityNameIndex] ON [ExtendedIdentityResources] ([IdentityResourceName]);

CREATE UNIQUE INDEX [IdentityResourceNameIndex] ON [ExtendedIdentityResources] ([NormalizedName]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171026080835_InitialSqlServerExtendedConfigurationDbMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171122163718_UserSearchOptimizationExtendedConfigurationDbMigration', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
CREATE TABLE [ConfigurationEntries] (
    [Key] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_ConfigurationEntries] PRIMARY KEY ([Key])
);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180626100745_ConfigurationEntries', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
UPDATE [Clients]
                                    SET [NonEditable] = e.reserved
	                                from ExtendedClients e
	                                WHERE [Clients].ClientId = e.ClientId

UPDATE [ApiResources]
                                   SET [NonEditable] = e.reserved
	                               from ExtendedApiResources e
	                               WHERE [ApiResources].Name = e.ApiResourceName

UPDATE IdentityResources
                                   SET [NonEditable] = e.reserved
	                               from ExtendedIdentityResources e
	                               WHERE IdentityResources.Name = e.IdentityResourceName

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181205163055_ExtendedDataMigration2.3', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [ExtendedClients] ADD [ClientType] int NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190401104724_ClientType', N'10.0.11');

COMMIT;
GO

