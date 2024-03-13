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
VALUES (N'20190305133618_SqlServerWsfederationInitial', N'8.0.2');
GO

COMMIT;
GO

