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
VALUES (N'20171026080835_InitialSqlServerExtendedConfigurationDbMigration', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171122163718_UserSearchOptimizationExtendedConfigurationDbMigration', N'8.0.2');
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
VALUES (N'20180626100745_ConfigurationEntries', N'8.0.2');
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
VALUES (N'20181205163055_ExtendedDataMigration2.3', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [ExtendedClients] ADD [ClientType] int NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190401104724_ClientType', N'8.0.2');
GO

COMMIT;
GO

