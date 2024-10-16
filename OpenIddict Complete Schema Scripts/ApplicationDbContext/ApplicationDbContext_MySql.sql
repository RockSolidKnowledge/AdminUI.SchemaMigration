-- Generated for OpenIddict5 using the ApplicationDbContext in https://github.com/RockSolidKnowledge/Samples.OpenIddict.AdminUI

START TRANSACTION;

ALTER DATABASE CHARACTER SET utf8mb4;

CREATE TABLE `OpenIddictApplications` (
    `Id` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
    `ApplicationType` varchar(50) CHARACTER SET utf8mb4 NULL,
    `ClientId` varchar(100) CHARACTER SET utf8mb4 NULL,
    `ClientSecret` longtext CHARACTER SET utf8mb4 NULL,
    `ClientType` varchar(50) CHARACTER SET utf8mb4 NULL,
    `ConcurrencyToken` varchar(50) CHARACTER SET utf8mb4 NULL,
    `ConsentType` varchar(50) CHARACTER SET utf8mb4 NULL,
    `DisplayName` longtext CHARACTER SET utf8mb4 NULL,
    `DisplayNames` longtext CHARACTER SET utf8mb4 NULL,
    `JsonWebKeySet` longtext CHARACTER SET utf8mb4 NULL,
    `Permissions` longtext CHARACTER SET utf8mb4 NULL,
    `PostLogoutRedirectUris` longtext CHARACTER SET utf8mb4 NULL,
    `Properties` longtext CHARACTER SET utf8mb4 NULL,
    `RedirectUris` longtext CHARACTER SET utf8mb4 NULL,
    `Requirements` longtext CHARACTER SET utf8mb4 NULL,
    `Settings` longtext CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_OpenIddictApplications` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `OpenIddictScopes` (
    `Id` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
    `ConcurrencyToken` varchar(50) CHARACTER SET utf8mb4 NULL,
    `Description` longtext CHARACTER SET utf8mb4 NULL,
    `Descriptions` longtext CHARACTER SET utf8mb4 NULL,
    `DisplayName` longtext CHARACTER SET utf8mb4 NULL,
    `DisplayNames` longtext CHARACTER SET utf8mb4 NULL,
    `Name` varchar(200) CHARACTER SET utf8mb4 NULL,
    `Properties` longtext CHARACTER SET utf8mb4 NULL,
    `Resources` longtext CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_OpenIddictScopes` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `OpenIddictAuthorizations` (
    `Id` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
    `ApplicationId` varchar(255) CHARACTER SET utf8mb4 NULL,
    `ConcurrencyToken` varchar(50) CHARACTER SET utf8mb4 NULL,
    `CreationDate` datetime(6) NULL,
    `Properties` longtext CHARACTER SET utf8mb4 NULL,
    `Scopes` longtext CHARACTER SET utf8mb4 NULL,
    `Status` varchar(50) CHARACTER SET utf8mb4 NULL,
    `Subject` varchar(400) CHARACTER SET utf8mb4 NULL,
    `Type` varchar(50) CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_OpenIddictAuthorizations` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_OpenIddictAuthorizations_OpenIddictApplications_ApplicationId` FOREIGN KEY (`ApplicationId`) REFERENCES `OpenIddictApplications` (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `OpenIddictTokens` (
    `Id` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
    `ApplicationId` varchar(255) CHARACTER SET utf8mb4 NULL,
    `AuthorizationId` varchar(255) CHARACTER SET utf8mb4 NULL,
    `ConcurrencyToken` varchar(50) CHARACTER SET utf8mb4 NULL,
    `CreationDate` datetime(6) NULL,
    `ExpirationDate` datetime(6) NULL,
    `Payload` longtext CHARACTER SET utf8mb4 NULL,
    `Properties` longtext CHARACTER SET utf8mb4 NULL,
    `RedemptionDate` datetime(6) NULL,
    `ReferenceId` varchar(100) CHARACTER SET utf8mb4 NULL,
    `Status` varchar(50) CHARACTER SET utf8mb4 NULL,
    `Subject` varchar(400) CHARACTER SET utf8mb4 NULL,
    `Type` varchar(50) CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_OpenIddictTokens` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_OpenIddictTokens_OpenIddictApplications_ApplicationId` FOREIGN KEY (`ApplicationId`) REFERENCES `OpenIddictApplications` (`Id`),
    CONSTRAINT `FK_OpenIddictTokens_OpenIddictAuthorizations_AuthorizationId` FOREIGN KEY (`AuthorizationId`) REFERENCES `OpenIddictAuthorizations` (`Id`)
) CHARACTER SET=utf8mb4;

CREATE UNIQUE INDEX `IX_OpenIddictApplications_ClientId` ON `OpenIddictApplications` (`ClientId`);

CREATE INDEX `IX_OpenIddictAuthorizations_ApplicationId_Status_Subject_Type` ON `OpenIddictAuthorizations` (`ApplicationId`, `Status`, `Subject`, `Type`);

CREATE UNIQUE INDEX `IX_OpenIddictScopes_Name` ON `OpenIddictScopes` (`Name`);

CREATE INDEX `IX_OpenIddictTokens_ApplicationId_Status_Subject_Type` ON `OpenIddictTokens` (`ApplicationId`, `Status`, `Subject`, `Type`);

CREATE INDEX `IX_OpenIddictTokens_AuthorizationId` ON `OpenIddictTokens` (`AuthorizationId`);

CREATE UNIQUE INDEX `IX_OpenIddictTokens_ReferenceId` ON `OpenIddictTokens` (`ReferenceId`);

COMMIT;