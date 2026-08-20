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
CREATE TABLE [SamlArtifacts] (
    [Key] nvarchar(200) NOT NULL,
    [EntityId] nvarchar(200) NOT NULL,
    [MessageType] nvarchar(50) NOT NULL,
    [Message] nvarchar(max) NOT NULL,
    [CreationTime] datetime2 NOT NULL,
    [Expiration] datetime2 NOT NULL,
    CONSTRAINT [PK_SamlArtifacts] PRIMARY KEY ([Key])
);

CREATE INDEX [IX_SamlArtifacts_Expiration] ON [SamlArtifacts] ([Expiration]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220114164649_SqlServerSamlArtifactInitialMigration', N'10.0.11');

COMMIT;
GO

