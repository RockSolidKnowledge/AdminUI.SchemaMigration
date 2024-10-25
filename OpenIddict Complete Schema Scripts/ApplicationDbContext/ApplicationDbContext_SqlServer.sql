-- Generated for OpenIddict5 using the ApplicationDbContext in https://github.com/RockSolidKnowledge/Samples.OpenIddict.AdminUI

BEGIN TRANSACTION;
GO

CREATE TABLE [OpenIddictApplications] (
    [Id] nvarchar(450) NOT NULL,
    [ApplicationType] nvarchar(50) NULL,
    [ClientId] nvarchar(100) NULL,
    [ClientSecret] nvarchar(max) NULL,
    [ClientType] nvarchar(50) NULL,
    [ConcurrencyToken] nvarchar(50) NULL,
    [ConsentType] nvarchar(50) NULL,
    [DisplayName] nvarchar(max) NULL,
    [DisplayNames] nvarchar(max) NULL,
    [JsonWebKeySet] nvarchar(max) NULL,
    [Permissions] nvarchar(max) NULL,
    [PostLogoutRedirectUris] nvarchar(max) NULL,
    [Properties] nvarchar(max) NULL,
    [RedirectUris] nvarchar(max) NULL,
    [Requirements] nvarchar(max) NULL,
    [Settings] nvarchar(max) NULL,
    CONSTRAINT [PK_OpenIddictApplications] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [OpenIddictScopes] (
    [Id] nvarchar(450) NOT NULL,
    [ConcurrencyToken] nvarchar(50) NULL,
    [Description] nvarchar(max) NULL,
    [Descriptions] nvarchar(max) NULL,
    [DisplayName] nvarchar(max) NULL,
    [DisplayNames] nvarchar(max) NULL,
    [Name] nvarchar(200) NULL,
    [Properties] nvarchar(max) NULL,
    [Resources] nvarchar(max) NULL,
    CONSTRAINT [PK_OpenIddictScopes] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [OpenIddictAuthorizations] (
    [Id] nvarchar(450) NOT NULL,
    [ApplicationId] nvarchar(450) NULL,
    [ConcurrencyToken] nvarchar(50) NULL,
    [CreationDate] datetime2 NULL,
    [Properties] nvarchar(max) NULL,
    [Scopes] nvarchar(max) NULL,
    [Status] nvarchar(50) NULL,
    [Subject] nvarchar(400) NULL,
    [Type] nvarchar(50) NULL,
    CONSTRAINT [PK_OpenIddictAuthorizations] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_OpenIddictAuthorizations_OpenIddictApplications_ApplicationId] FOREIGN KEY ([ApplicationId]) REFERENCES [OpenIddictApplications] ([Id])
);
GO

CREATE TABLE [OpenIddictTokens] (
    [Id] nvarchar(450) NOT NULL,
    [ApplicationId] nvarchar(450) NULL,
    [AuthorizationId] nvarchar(450) NULL,
    [ConcurrencyToken] nvarchar(50) NULL,
    [CreationDate] datetime2 NULL,
    [ExpirationDate] datetime2 NULL,
    [Payload] nvarchar(max) NULL,
    [Properties] nvarchar(max) NULL,
    [RedemptionDate] datetime2 NULL,
    [ReferenceId] nvarchar(100) NULL,
    [Status] nvarchar(50) NULL,
    [Subject] nvarchar(400) NULL,
    [Type] nvarchar(50) NULL,
    CONSTRAINT [PK_OpenIddictTokens] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_OpenIddictTokens_OpenIddictApplications_ApplicationId] FOREIGN KEY ([ApplicationId]) REFERENCES [OpenIddictApplications] ([Id]),
    CONSTRAINT [FK_OpenIddictTokens_OpenIddictAuthorizations_AuthorizationId] FOREIGN KEY ([AuthorizationId]) REFERENCES [OpenIddictAuthorizations] ([Id])
);
GO

CREATE UNIQUE INDEX [IX_OpenIddictApplications_ClientId] ON [OpenIddictApplications] ([ClientId]) WHERE [ClientId] IS NOT NULL;
GO

CREATE INDEX [IX_OpenIddictAuthorizations_ApplicationId_Status_Subject_Type] ON [OpenIddictAuthorizations] ([ApplicationId], [Status], [Subject], [Type]);
GO

CREATE UNIQUE INDEX [IX_OpenIddictScopes_Name] ON [OpenIddictScopes] ([Name]) WHERE [Name] IS NOT NULL;
GO

CREATE INDEX [IX_OpenIddictTokens_ApplicationId_Status_Subject_Type] ON [OpenIddictTokens] ([ApplicationId], [Status], [Subject], [Type]);
GO

CREATE INDEX [IX_OpenIddictTokens_AuthorizationId] ON [OpenIddictTokens] ([AuthorizationId]);
GO

CREATE UNIQUE INDEX [IX_OpenIddictTokens_ReferenceId] ON [OpenIddictTokens] ([ReferenceId]) WHERE [ReferenceId] IS NOT NULL;
GO

COMMIT;
GO

