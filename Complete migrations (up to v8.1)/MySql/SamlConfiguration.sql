CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

CREATE TABLE `ServiceProviders` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `EntityId` varchar(200) NOT NULL,
    `EncryptionCertificate` longblob NULL,
    `SignAssertions` tinyint(1) NOT NULL,
    `EncryptAssertions` tinyint(1) NOT NULL,
    `RequireSamlRequestDestination` tinyint(1) NOT NULL,
    CONSTRAINT `PK_ServiceProviders` PRIMARY KEY (`Id`)
);

CREATE TABLE `ServiceProviderAssertionConsumerServices` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Binding` varchar(2000) NOT NULL,
    `Location` varchar(2000) NOT NULL,
    `Index` int NOT NULL,
    `IsDefault` tinyint(1) NOT NULL,
    `ServiceProviderId` int NOT NULL,
    CONSTRAINT `PK_ServiceProviderAssertionConsumerServices` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ServiceProviderAssertionConsumerServices_ServiceProviders_Se~` FOREIGN KEY (`ServiceProviderId`) REFERENCES `ServiceProviders` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ServiceProviderClaimMappings` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `OriginalClaimType` varchar(250) NOT NULL,
    `NewClaimType` varchar(250) NOT NULL,
    `ServiceProviderId` int NOT NULL,
    CONSTRAINT `PK_ServiceProviderClaimMappings` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ServiceProviderClaimMappings_ServiceProviders_ServiceProvide~` FOREIGN KEY (`ServiceProviderId`) REFERENCES `ServiceProviders` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ServiceProviderSignCertificates` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Certificate` longblob NOT NULL,
    `ServiceProviderId` int NOT NULL,
    CONSTRAINT `PK_ServiceProviderSignCertificates` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ServiceProviderSignCertificates_ServiceProviders_ServiceProv~` FOREIGN KEY (`ServiceProviderId`) REFERENCES `ServiceProviders` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ServiceProviderSingleLogoutServices` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Binding` varchar(2000) NOT NULL,
    `Location` varchar(2000) NOT NULL,
    `Index` int NOT NULL,
    `IsDefault` tinyint(1) NOT NULL,
    `ServiceProviderId` int NOT NULL,
    CONSTRAINT `PK_ServiceProviderSingleLogoutServices` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ServiceProviderSingleLogoutServices_ServiceProviders_Service~` FOREIGN KEY (`ServiceProviderId`) REFERENCES `ServiceProviders` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ServiceProviderAssertionConsumerServices_ServiceProviderId` ON `ServiceProviderAssertionConsumerServices` (`ServiceProviderId`);

CREATE INDEX `IX_ServiceProviderClaimMappings_ServiceProviderId` ON `ServiceProviderClaimMappings` (`ServiceProviderId`);

CREATE UNIQUE INDEX `IX_ServiceProviders_EntityId` ON `ServiceProviders` (`EntityId`);

CREATE INDEX `IX_ServiceProviderSignCertificates_ServiceProviderId` ON `ServiceProviderSignCertificates` (`ServiceProviderId`);

CREATE INDEX `IX_ServiceProviderSingleLogoutServices_ServiceProviderId` ON `ServiceProviderSingleLogoutServices` (`ServiceProviderId`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20190305133042_MySqlSaml2PInitial', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `ServiceProviders` ADD `AllowIdpInitiatedSso` tinyint(1) NOT NULL DEFAULT FALSE;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20200225105251_Added AllowIdpInitiated', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `ServiceProviders` ADD `RequireAuthenticationRequestsSigned` tinyint(1) NULL;

ALTER TABLE `ServiceProviders` CHANGE `RequireSamlRequestDestination` `RequireSamlMessageDestination` tinyint(1) NOT NULL;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20200914074711_RskSamlV3', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `ServiceProviders` ADD `ArtifactDeliveryBindingType` longtext CHARACTER SET utf8mb4 NULL;

ALTER TABLE `ServiceProviders` ADD `NameIdentifierFormat` longtext CHARACTER SET utf8mb4 NULL;

ALTER TABLE `ServiceProviders` ADD `RequireSignedArtifactResolveRequests` tinyint(1) NULL;

ALTER TABLE `ServiceProviders` ADD `RequireSignedArtifactResponses` tinyint(1) NULL;

CREATE TABLE `ServiceProviderArtifactResolutionServices` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Binding` varchar(2000) CHARACTER SET utf8mb4 NOT NULL,
    `Location` varchar(2000) CHARACTER SET utf8mb4 NOT NULL,
    `Index` int NOT NULL,
    `IsDefault` tinyint(1) NOT NULL,
    `ServiceProviderId` int NOT NULL,
    CONSTRAINT `PK_ServiceProviderArtifactResolutionServices` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ServiceProviderArtifactResolutionServices_ServiceProviders_S~` FOREIGN KEY (`ServiceProviderId`) REFERENCES `ServiceProviders` (`Id`) ON DELETE CASCADE
) CHARACTER SET=utf8mb4;

CREATE INDEX `IX_ServiceProviderArtifactResolutionServices_ServiceProviderId` ON `ServiceProviderArtifactResolutionServices` (`ServiceProviderId`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20220112145727_RskSamlPackageUpdate', '8.0.2');

COMMIT;

