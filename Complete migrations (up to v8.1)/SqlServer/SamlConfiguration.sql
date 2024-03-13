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
VALUES (N'20190305134515_SqlServerSaml2PInitial', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [ServiceProviders] ADD [AllowIdpInitiatedSso] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200225104531_Added AllowIdpInitiatedSso', N'8.0.2');
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
VALUES (N'20200914075545_RskSamlV3', N'8.0.2');
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
VALUES (N'20220112143907_RskSamlPackageUpdate', N'8.0.2');
GO

COMMIT;
GO

