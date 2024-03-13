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
VALUES (N'20181220155759_InitalSqlServerAuditDbMigration', N'8.0.2');
GO

COMMIT;
GO

