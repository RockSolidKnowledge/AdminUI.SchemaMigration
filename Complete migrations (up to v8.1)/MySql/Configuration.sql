CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

CREATE TABLE `ApiResources` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Description` varchar(1000) NULL,
    `DisplayName` varchar(200) NULL,
    `Enabled` bit NOT NULL,
    `Name` varchar(200) NOT NULL,
    CONSTRAINT `PK_ApiResources` PRIMARY KEY (`Id`)
);

CREATE TABLE `Clients` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `AbsoluteRefreshTokenLifetime` int NOT NULL,
    `AccessTokenLifetime` int NOT NULL,
    `AccessTokenType` int NOT NULL,
    `AllowAccessTokensViaBrowser` bit NOT NULL,
    `AllowOfflineAccess` bit NOT NULL,
    `AllowPlainTextPkce` bit NOT NULL,
    `AllowRememberConsent` bit NOT NULL,
    `AlwaysIncludeUserClaimsInIdToken` bit NOT NULL,
    `AlwaysSendClientClaims` bit NOT NULL,
    `AuthorizationCodeLifetime` int NOT NULL,
    `BackChannelLogoutSessionRequired` bit NOT NULL,
    `BackChannelLogoutUri` varchar(2000) NULL,
    `ClientClaimsPrefix` varchar(200) NULL,
    `ClientId` varchar(200) NOT NULL,
    `ClientName` varchar(200) NULL,
    `ClientUri` varchar(2000) NULL,
    `ConsentLifetime` int NULL,
    `Description` varchar(1000) NULL,
    `EnableLocalLogin` bit NOT NULL,
    `Enabled` bit NOT NULL,
    `FrontChannelLogoutSessionRequired` bit NOT NULL,
    `FrontChannelLogoutUri` varchar(2000) NULL,
    `IdentityTokenLifetime` int NOT NULL,
    `IncludeJwtId` bit NOT NULL,
    `LogoUri` varchar(2000) NULL,
    `PairWiseSubjectSalt` varchar(200) NULL,
    `ProtocolType` varchar(200) NOT NULL,
    `RefreshTokenExpiration` int NOT NULL,
    `RefreshTokenUsage` int NOT NULL,
    `RequireClientSecret` bit NOT NULL,
    `RequireConsent` bit NOT NULL,
    `RequirePkce` bit NOT NULL,
    `SlidingRefreshTokenLifetime` int NOT NULL,
    `UpdateAccessTokenClaimsOnRefresh` bit NOT NULL,
    CONSTRAINT `PK_Clients` PRIMARY KEY (`Id`)
);

CREATE TABLE `IdentityResources` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Description` varchar(1000) NULL,
    `DisplayName` varchar(200) NULL,
    `Emphasize` bit NOT NULL,
    `Enabled` bit NOT NULL,
    `Name` varchar(200) NOT NULL,
    `Required` bit NOT NULL,
    `ShowInDiscoveryDocument` bit NOT NULL,
    CONSTRAINT `PK_IdentityResources` PRIMARY KEY (`Id`)
);

CREATE TABLE `ApiClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ApiResourceId` int NOT NULL,
    `Type` varchar(200) NOT NULL,
    CONSTRAINT `PK_ApiClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiClaims_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ApiScopes` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ApiResourceId` int NOT NULL,
    `Description` varchar(1000) NULL,
    `DisplayName` varchar(200) NULL,
    `Emphasize` bit NOT NULL,
    `Name` varchar(200) NOT NULL,
    `Required` bit NOT NULL,
    `ShowInDiscoveryDocument` bit NOT NULL,
    CONSTRAINT `PK_ApiScopes` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiScopes_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ApiSecrets` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ApiResourceId` int NOT NULL,
    `Description` varchar(1000) NULL,
    `Expiration` datetime(6) NULL,
    `Type` varchar(250) NULL,
    `Value` varchar(2000) NULL,
    CONSTRAINT `PK_ApiSecrets` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiSecrets_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClientId` int NOT NULL,
    `Type` varchar(250) NOT NULL,
    `Value` varchar(250) NOT NULL,
    CONSTRAINT `PK_ClientClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientClaims_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientCorsOrigins` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClientId` int NOT NULL,
    `Origin` varchar(150) NOT NULL,
    CONSTRAINT `PK_ClientCorsOrigins` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientCorsOrigins_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientGrantTypes` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClientId` int NOT NULL,
    `GrantType` varchar(250) NOT NULL,
    CONSTRAINT `PK_ClientGrantTypes` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientGrantTypes_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientIdPRestrictions` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClientId` int NOT NULL,
    `Provider` varchar(200) NOT NULL,
    CONSTRAINT `PK_ClientIdPRestrictions` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientIdPRestrictions_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientPostLogoutRedirectUris` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClientId` int NOT NULL,
    `PostLogoutRedirectUri` varchar(2000) NOT NULL,
    CONSTRAINT `PK_ClientPostLogoutRedirectUris` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientPostLogoutRedirectUris_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClientId` int NOT NULL,
    `Key` varchar(250) NOT NULL,
    `Value` varchar(2000) NOT NULL,
    CONSTRAINT `PK_ClientProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientProperties_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientRedirectUris` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClientId` int NOT NULL,
    `RedirectUri` varchar(2000) NOT NULL,
    CONSTRAINT `PK_ClientRedirectUris` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientRedirectUris_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientScopes` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClientId` int NOT NULL,
    `Scope` varchar(200) NOT NULL,
    CONSTRAINT `PK_ClientScopes` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientScopes_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientSecrets` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClientId` int NOT NULL,
    `Description` varchar(2000) NULL,
    `Expiration` datetime(6) NULL,
    `Type` varchar(250) NULL,
    `Value` varchar(2000) NOT NULL,
    CONSTRAINT `PK_ClientSecrets` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientSecrets_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `IdentityClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `IdentityResourceId` int NOT NULL,
    `Type` varchar(200) NOT NULL,
    CONSTRAINT `PK_IdentityClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_IdentityClaims_IdentityResources_IdentityResourceId` FOREIGN KEY (`IdentityResourceId`) REFERENCES `IdentityResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ApiScopeClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ApiScopeId` int NOT NULL,
    `Type` varchar(200) NOT NULL,
    CONSTRAINT `PK_ApiScopeClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiScopeClaims_ApiScopes_ApiScopeId` FOREIGN KEY (`ApiScopeId`) REFERENCES `ApiScopes` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiClaims_ApiResourceId` ON `ApiClaims` (`ApiResourceId`);

CREATE UNIQUE INDEX `IX_ApiResources_Name` ON `ApiResources` (`Name`);

CREATE INDEX `IX_ApiScopeClaims_ApiScopeId` ON `ApiScopeClaims` (`ApiScopeId`);

CREATE INDEX `IX_ApiScopes_ApiResourceId` ON `ApiScopes` (`ApiResourceId`);

CREATE UNIQUE INDEX `IX_ApiScopes_Name` ON `ApiScopes` (`Name`);

CREATE INDEX `IX_ApiSecrets_ApiResourceId` ON `ApiSecrets` (`ApiResourceId`);

CREATE INDEX `IX_ClientClaims_ClientId` ON `ClientClaims` (`ClientId`);

CREATE INDEX `IX_ClientCorsOrigins_ClientId` ON `ClientCorsOrigins` (`ClientId`);

CREATE INDEX `IX_ClientGrantTypes_ClientId` ON `ClientGrantTypes` (`ClientId`);

CREATE INDEX `IX_ClientIdPRestrictions_ClientId` ON `ClientIdPRestrictions` (`ClientId`);

CREATE INDEX `IX_ClientPostLogoutRedirectUris_ClientId` ON `ClientPostLogoutRedirectUris` (`ClientId`);

CREATE INDEX `IX_ClientProperties_ClientId` ON `ClientProperties` (`ClientId`);

CREATE INDEX `IX_ClientRedirectUris_ClientId` ON `ClientRedirectUris` (`ClientId`);

CREATE UNIQUE INDEX `IX_Clients_ClientId` ON `Clients` (`ClientId`);

CREATE INDEX `IX_ClientScopes_ClientId` ON `ClientScopes` (`ClientId`);

CREATE INDEX `IX_ClientSecrets_ClientId` ON `ClientSecrets` (`ClientId`);

CREATE INDEX `IX_IdentityClaims_IdentityResourceId` ON `IdentityClaims` (`IdentityResourceId`);

CREATE UNIQUE INDEX `IX_IdentityResources_Name` ON `IdentityResources` (`Name`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20171026082716_InitialMySqlConfigurationDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `IdentityResources` ADD `Created` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00';

ALTER TABLE `IdentityResources` ADD `NonEditable` tinyint(1) NOT NULL DEFAULT FALSE;

ALTER TABLE `IdentityResources` ADD `Updated` datetime(6) NULL;

ALTER TABLE `ClientSecrets` MODIFY COLUMN `Value` varchar(4000) NOT NULL;

ALTER TABLE `ClientSecrets` MODIFY COLUMN `Type` varchar(250) NOT NULL;

ALTER TABLE `ClientSecrets` ADD `Created` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00';

ALTER TABLE `Clients` ADD `Created` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00';

ALTER TABLE `Clients` ADD `DeviceCodeLifetime` int NOT NULL DEFAULT 0;

ALTER TABLE `Clients` ADD `LastAccessed` datetime(6) NULL;

ALTER TABLE `Clients` ADD `NonEditable` tinyint(1) NOT NULL DEFAULT FALSE;

ALTER TABLE `Clients` ADD `Updated` datetime(6) NULL;

ALTER TABLE `Clients` ADD `UserCodeType` varchar(100) NULL;

ALTER TABLE `Clients` ADD `UserSsoLifetime` int NULL;

ALTER TABLE `ApiSecrets` MODIFY COLUMN `Value` varchar(4000) NOT NULL;

ALTER TABLE `ApiSecrets` MODIFY COLUMN `Type` varchar(250) NOT NULL;

ALTER TABLE `ApiSecrets` ADD `Created` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00';

ALTER TABLE `ApiResources` ADD `Created` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00';

ALTER TABLE `ApiResources` ADD `LastAccessed` datetime(6) NULL;

ALTER TABLE `ApiResources` ADD `NonEditable` tinyint(1) NOT NULL DEFAULT FALSE;

ALTER TABLE `ApiResources` ADD `Updated` datetime(6) NULL;

CREATE TABLE `ApiProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` varchar(250) NOT NULL,
    `Value` varchar(2000) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiProperties_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `IdentityProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` varchar(250) NOT NULL,
    `Value` varchar(2000) NOT NULL,
    `IdentityResourceId` int NOT NULL,
    CONSTRAINT `PK_IdentityProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_IdentityProperties_IdentityResources_IdentityResourceId` FOREIGN KEY (`IdentityResourceId`) REFERENCES `IdentityResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiProperties_ApiResourceId` ON `ApiProperties` (`ApiResourceId`);

CREATE INDEX `IX_IdentityProperties_IdentityResourceId` ON `IdentityProperties` (`IdentityResourceId`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20181112152920_IdentityServer2.3SMySqlConfigurationDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

START TRANSACTION;

-- Add New Tables

-- Add ApiResourceScopes

CREATE TABLE `ApiResourceScopes` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Scope` nvarchar(200) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceScopes` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceScopes_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceScopes_ApiResourceId` ON `ApiResourceScopes` (`ApiResourceId`);



-- Add ApiScopeProperties

CREATE TABLE `ApiScopeProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` nvarchar(250) NOT NULL,
    `Value` nvarchar(2000) NOT NULL,
    `ScopeId` int NOT NULL,
    CONSTRAINT `PK_ApiScopeProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiScopeProperties_ApiScopes_ScopeId` FOREIGN KEY (`ScopeId`) REFERENCES `ApiScopes` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiScopeProperties_ScopeId` ON `ApiScopeProperties` (`ScopeId`);



-- Add Renamed Tables

-- ApiResourceClaims

CREATE TABLE `ApiResourceClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Type` nvarchar(200) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceClaims_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceClaims_ApiResourceId` ON `ApiResourceClaims` (`ApiResourceId`);



-- ApiResourceProperties

CREATE TABLE `ApiResourceProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` nvarchar(250) NOT NULL,
    `Value` nvarchar(2000) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceProperties_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceProperties_ApiResourceId` ON `ApiResourceProperties` (`ApiResourceId`);



-- Add ApiResourceSecrets

CREATE TABLE `ApiResourceSecrets` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Description` nvarchar(1000) NULL,
    `Value` nvarchar(4000) NOT NULL,
    `Expiration` date NULL,
    `Type` nvarchar(250) NOT NULL,
    `Created` date NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceSecrets` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceSecrets_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceSecrets_ApiResourceId` ON `ApiResourceSecrets` (`ApiResourceId`);



-- IdentityResourceClaims

CREATE TABLE `IdentityResourceClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Type` nvarchar(200) NOT NULL,
    `IdentityResourceId` int NOT NULL,
    CONSTRAINT `PK_IdentityResourceClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_IdentityResourceClaims_IdentityResources_IdentityResourceId` FOREIGN KEY (`IdentityResourceId`) REFERENCES `IdentityResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_IdentityResourceClaims_IdentityResourceId` ON `IdentityResourceClaims` (`IdentityResourceId`);



-- IdentityResourceProperties

CREATE TABLE `IdentityResourceProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` nvarchar(250) NOT NULL,
    `Value` nvarchar(2000) NOT NULL,
    `IdentityResourceId` int NOT NULL,
    CONSTRAINT `PK_IdentityResourceProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_IdentityResourceProperties_IdentityResources_IdentityResource` FOREIGN KEY (`IdentityResourceId`) REFERENCES `IdentityResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_IdentityResourceProperties_IdentityResourceId` ON `IdentityResourceProperties` (`IdentityResourceId`);



-- Migrate Existing Data

-- ApiClaims -> ApiResourceClaims

INSERT INTO `ApiResourceClaims`
 (`Id`, `Type`, `ApiResourceId`)
SELECT 
 `Id`, `Type`, `ApiResourceId`
FROM `ApiClaims`;



-- ApiProperties -> ApiResourceProperties

INSERT INTO `ApiResourceProperties`
 (`Id`, `Key`, `Value`, `ApiResourceId`)
SELECT 
 `Id`, `Key`, `Value`, `ApiResourceId`
FROM `ApiProperties`;



-- ApiSecrets -> ApiResourceSecrets

INSERT INTO `ApiResourceSecrets`
 (`Id`, `Description`, `Value`, `Expiration`, `Type`, `Created`, `ApiResourceId`)
SELECT 
 `Id`, `Description`, `Value`, `Expiration`, `Type`, `Created`, `ApiResourceId`
FROM `ApiSecrets`;



-- IdentityClaims -> IdentityResourceClaims

INSERT INTO `IdentityResourceClaims`
 (`Id`, `Type`, `IdentityResourceId`)
SELECT 
 `Id`, `Type`, `IdentityResourceId`
FROM `IdentityClaims`;



-- IdentityProperties -> IdentityResourceProperties

INSERT INTO `IdentityResourceProperties`
 (`Id`, `Key`, `Value`, `IdentityResourceId`)
SELECT 
 `Id`, `Key`, `Value`, `IdentityResourceId`
FROM `IdentityProperties`;


-- ApiScopes -> ApiResourceScopes
INSERT INTO `ApiResourceScopes` 
 (`Scope`, `ApiResourceId`)
SELECT 
 `Name`, `ApiResourceId`
FROM `ApiScopes`;


-- Alter Existing Tables
SET @OLDSAFEUPDATEVALUE = @@SQL_SAFE_UPDATES;
SET SQL_SAFE_UPDATES = 0;

-- ApiResources	

ALTER TABLE `ApiResources`
	ADD `AllowedAccessTokenSigningAlgorithms` nvarchar (100)
	NULL;
	
ALTER TABLE `ApiResources`
	ADD `ShowInDiscoveryDocument` bit
	NULL;
	
UPDATE `ApiResources` SET `ShowInDiscoveryDocument` = 0;

ALTER TABLE `ApiResources`
	MODIFY `ShowInDiscoveryDocument` bit NOT NULL;
	
	

-- ApiScopeClaims

ALTER TABLE `ApiScopeClaims`
	DROP FOREIGN KEY `FK_ApiScopeClaims_ApiScopes_ApiScopeId`;
	
DROP INDEX `IX_ApiScopeClaims_ApiScopeId`
	ON `ApiScopeClaims`;
		
ALTER TABLE `ApiScopeClaims` CHANGE `ApiScopeId` `ScopeId` int(11);

CREATE INDEX `IX_ApiScopeClaims_ScopeId` ON `ApiScopeClaims` (`ScopeId`);
	
ALTER TABLE `ApiScopeClaims`
	ADD CONSTRAINT `FK_ApiScopeClaims_ApiScopes_ScopeId`
	FOREIGN KEY (`ScopeId`) REFERENCES `ApiScopes` (`Id`) ON DELETE CASCADE;
	
	
	
-- ApiScopes

ALTER TABLE `ApiScopes`
	DROP FOREIGN KEY `FK_ApiScopes_ApiResources_ApiResourceId`;
	
DROP INDEX `IX_ApiScopes_ApiResourceId`
	ON `ApiScopes`;
	
ALTER TABLE `ApiScopes`
	ADD `Enabled` bit NULL;

UPDATE `ApiScopes` SET Enabled = 1;

ALTER TABLE `ApiScopes` 
	MODIFY `Enabled` bit NOT NULL;
		
ALTER TABLE `ApiScopes`
	DROP COLUMN `ApiResourceId`;
	

-- Clients

ALTER TABLE `Clients`
	ADD `AllowedIdentityTokenSigningAlgorithms` nvarchar(100) NULL;
	
ALTER TABLE `Clients`
	ADD `RequireRequestObject` bit NULL;
	
UPDATE `Clients` SET `RequireRequestObject` = 0;
	
ALTER TABLE `Clients`
	MODIFY `RequireRequestObject` bit NOT NULL;
	
SET SQL_SAFE_UPDATES = @OLDSAFEUPDATEVALUE;
			
-- Delete Old Tables

DROP TABLE `ApiClaims`;
DROP TABLE `ApiProperties`;
DROP TABLE `ApiSecrets`;
DROP TABLE `IdentityClaims`;
DROP TABLE `IdentityProperties`;

COMMIT;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20200702075924_V3toV4MySqlConfigurationDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `ApiResources` ADD `RequireResourceIndicator` tinyint(1) NOT NULL DEFAULT FALSE;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20210106162829_DuendeMySqlConfigurationMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `IdentityResources` MODIFY COLUMN `Name` varchar(200) NOT NULL;

ALTER TABLE `IdentityResources` MODIFY COLUMN `DisplayName` varchar(200) NULL;

ALTER TABLE `IdentityResources` MODIFY COLUMN `Description` varchar(1000) NULL;

ALTER TABLE `IdentityResourceProperties` MODIFY COLUMN `Value` varchar(2000) NOT NULL;

ALTER TABLE `IdentityResourceProperties` MODIFY COLUMN `Key` varchar(250) NOT NULL;

ALTER TABLE `IdentityResourceClaims` MODIFY COLUMN `Type` varchar(200) NOT NULL;

ALTER TABLE `ClientSecrets` MODIFY COLUMN `Value` longtext NOT NULL;

ALTER TABLE `ClientSecrets` MODIFY COLUMN `Type` varchar(250) NOT NULL;

ALTER TABLE `ClientSecrets` MODIFY COLUMN `Description` varchar(2000) NULL;

ALTER TABLE `ClientScopes` MODIFY COLUMN `Scope` varchar(200) NOT NULL;

ALTER TABLE `Clients` MODIFY COLUMN `UserCodeType` varchar(100) NULL;

ALTER TABLE `Clients` MODIFY COLUMN `ProtocolType` varchar(200) NOT NULL;

ALTER TABLE `Clients` MODIFY COLUMN `PairWiseSubjectSalt` varchar(200) NULL;

ALTER TABLE `Clients` MODIFY COLUMN `LogoUri` varchar(2000) NULL;

ALTER TABLE `Clients` MODIFY COLUMN `FrontChannelLogoutUri` varchar(2000) NULL;

ALTER TABLE `Clients` MODIFY COLUMN `Description` varchar(1000) NULL;

ALTER TABLE `Clients` MODIFY COLUMN `ClientUri` varchar(2000) NULL;

ALTER TABLE `Clients` MODIFY COLUMN `ClientName` varchar(200) NULL;

ALTER TABLE `Clients` MODIFY COLUMN `ClientId` varchar(200) NOT NULL;

ALTER TABLE `Clients` MODIFY COLUMN `ClientClaimsPrefix` varchar(200) NULL;

ALTER TABLE `Clients` MODIFY COLUMN `BackChannelLogoutUri` varchar(2000) NULL;

ALTER TABLE `Clients` MODIFY COLUMN `AllowedIdentityTokenSigningAlgorithms` varchar(100) NULL;

ALTER TABLE `ClientRedirectUris` MODIFY COLUMN `RedirectUri` varchar(2000) NOT NULL;

ALTER TABLE `ClientProperties` MODIFY COLUMN `Value` varchar(2000) NOT NULL;

ALTER TABLE `ClientProperties` MODIFY COLUMN `Key` varchar(250) NOT NULL;

ALTER TABLE `ClientPostLogoutRedirectUris` MODIFY COLUMN `PostLogoutRedirectUri` varchar(2000) NOT NULL;

ALTER TABLE `ClientIdPRestrictions` MODIFY COLUMN `Provider` varchar(200) NOT NULL;

ALTER TABLE `ClientGrantTypes` MODIFY COLUMN `GrantType` varchar(250) NOT NULL;

ALTER TABLE `ClientCorsOrigins` MODIFY COLUMN `Origin` varchar(150) NOT NULL;

ALTER TABLE `ClientClaims` MODIFY COLUMN `Value` varchar(250) NOT NULL;

ALTER TABLE `ClientClaims` MODIFY COLUMN `Type` varchar(250) NOT NULL;

ALTER TABLE `ApiScopes` MODIFY COLUMN `Name` varchar(200) NOT NULL;

ALTER TABLE `ApiScopes` MODIFY COLUMN `DisplayName` varchar(200) NULL;

ALTER TABLE `ApiScopes` MODIFY COLUMN `Description` varchar(1000) NULL;

ALTER TABLE `ApiScopeProperties` MODIFY COLUMN `Value` varchar(2000) NOT NULL;

ALTER TABLE `ApiScopeProperties` MODIFY COLUMN `Key` varchar(250) NOT NULL;

ALTER TABLE `ApiScopeClaims` MODIFY COLUMN `Type` varchar(200) NOT NULL;

ALTER TABLE `ApiResourceSecrets` MODIFY COLUMN `Value` longtext NOT NULL;

ALTER TABLE `ApiResourceSecrets` MODIFY COLUMN `Type` varchar(250) NOT NULL;

ALTER TABLE `ApiResourceSecrets` MODIFY COLUMN `Description` varchar(1000) NULL;

ALTER TABLE `ApiResourceScopes` MODIFY COLUMN `Scope` varchar(200) NOT NULL;

ALTER TABLE `ApiResources` MODIFY COLUMN `Name` varchar(200) NOT NULL;

ALTER TABLE `ApiResources` MODIFY COLUMN `DisplayName` varchar(200) NULL;

ALTER TABLE `ApiResources` MODIFY COLUMN `Description` varchar(1000) NULL;

ALTER TABLE `ApiResources` MODIFY COLUMN `AllowedAccessTokenSigningAlgorithms` varchar(100) NULL;

ALTER TABLE `ApiResourceProperties` MODIFY COLUMN `Value` varchar(2000) NOT NULL;

ALTER TABLE `ApiResourceProperties` MODIFY COLUMN `Key` varchar(250) NOT NULL;

ALTER TABLE `ApiResourceClaims` MODIFY COLUMN `Type` varchar(200) NOT NULL;

CREATE TABLE `IdentityProviders` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Scheme` varchar(200) NOT NULL,
    `DisplayName` varchar(200) NULL,
    `Enabled` tinyint(1) NOT NULL,
    `Type` varchar(20) NOT NULL,
    `Properties` longtext NULL,
    CONSTRAINT `PK_IdentityProviders` PRIMARY KEY (`Id`)
);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20210602105143_IdentityProvidersMySqlConfigurationMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `IdentityProviders` ADD `Created` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00';

ALTER TABLE `IdentityProviders` ADD `LastAccessed` datetime(6) NULL;

ALTER TABLE `IdentityProviders` ADD `NonEditable` tinyint(1) NOT NULL DEFAULT FALSE;

ALTER TABLE `IdentityProviders` ADD `Updated` datetime(6) NULL;

ALTER TABLE `ClientSecrets` MODIFY COLUMN `Value` varchar(4000) CHARACTER SET utf8mb4 NOT NULL;

ALTER TABLE `Clients` ADD `CibaLifetime` int NULL;

ALTER TABLE `Clients` ADD `PollingInterval` int NULL;

ALTER TABLE `ClientRedirectUris` MODIFY COLUMN `RedirectUri` varchar(400) CHARACTER SET utf8mb4 NOT NULL;

ALTER TABLE `ClientPostLogoutRedirectUris` MODIFY COLUMN `PostLogoutRedirectUri` varchar(400) CHARACTER SET utf8mb4 NOT NULL;

ALTER TABLE `ApiScopes` ADD `Created` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00';

ALTER TABLE `ApiScopes` ADD `LastAccessed` datetime(6) NULL;

ALTER TABLE `ApiScopes` ADD `NonEditable` tinyint(1) NOT NULL DEFAULT FALSE;

ALTER TABLE `ApiScopes` ADD `Updated` datetime(6) NULL;

ALTER TABLE `ApiResourceSecrets` MODIFY COLUMN `Value` varchar(4000) CHARACTER SET utf8mb4 NOT NULL;

CREATE UNIQUE INDEX `IX_IdentityResourceProperties_IdentityResourceId_Key` ON `IdentityResourceProperties` (`IdentityResourceId`, `Key`);

ALTER TABLE `IdentityResourceProperties` DROP INDEX `IX_IdentityResourceProperties_IdentityResourceId`;

CREATE UNIQUE INDEX `IX_IdentityResourceClaims_IdentityResourceId_Type` ON `IdentityResourceClaims` (`IdentityResourceId`, `Type`);

ALTER TABLE `IdentityResourceClaims` DROP INDEX `IX_IdentityResourceClaims_IdentityResourceId`;

CREATE UNIQUE INDEX `IX_IdentityProviders_Scheme` ON `IdentityProviders` (`Scheme`);

CREATE UNIQUE INDEX `IX_ClientScopes_ClientId_Scope` ON `ClientScopes` (`ClientId`, `Scope`);

ALTER TABLE `ClientScopes` DROP INDEX `IX_ClientScopes_ClientId`;

CREATE UNIQUE INDEX `IX_ClientRedirectUris_ClientId_RedirectUri` ON `ClientRedirectUris` (`ClientId`, `RedirectUri`);

ALTER TABLE `ClientRedirectUris` DROP INDEX `IX_ClientRedirectUris_ClientId`;

CREATE UNIQUE INDEX `IX_ClientProperties_ClientId_Key` ON `ClientProperties` (`ClientId`, `Key`);

ALTER TABLE `ClientProperties` DROP INDEX `IX_ClientProperties_ClientId`;

CREATE UNIQUE INDEX `IX_ClientPostLogoutRedirectUris_ClientId_PostLogoutRedirectUri` ON `ClientPostLogoutRedirectUris` (`ClientId`, `PostLogoutRedirectUri`);

ALTER TABLE `ClientPostLogoutRedirectUris` DROP INDEX `IX_ClientPostLogoutRedirectUris_ClientId`;

CREATE UNIQUE INDEX `IX_ClientIdPRestrictions_ClientId_Provider` ON `ClientIdPRestrictions` (`ClientId`, `Provider`);

ALTER TABLE `ClientIdPRestrictions` DROP INDEX `IX_ClientIdPRestrictions_ClientId`;

CREATE UNIQUE INDEX `IX_ClientGrantTypes_ClientId_GrantType` ON `ClientGrantTypes` (`ClientId`, `GrantType`);

ALTER TABLE `ClientGrantTypes` DROP INDEX `IX_ClientGrantTypes_ClientId`;

CREATE UNIQUE INDEX `IX_ClientCorsOrigins_ClientId_Origin` ON `ClientCorsOrigins` (`ClientId`, `Origin`);

ALTER TABLE `ClientCorsOrigins` DROP INDEX `IX_ClientCorsOrigins_ClientId`;

CREATE UNIQUE INDEX `IX_ClientClaims_ClientId_Type_Value` ON `ClientClaims` (`ClientId`, `Type`, `Value`);

ALTER TABLE `ClientClaims` DROP INDEX `IX_ClientClaims_ClientId`;

CREATE UNIQUE INDEX `IX_ApiScopeProperties_ScopeId_Key` ON `ApiScopeProperties` (`ScopeId`, `Key`);

ALTER TABLE `ApiScopeProperties` DROP INDEX `IX_ApiScopeProperties_ScopeId`;

CREATE UNIQUE INDEX `IX_ApiScopeClaims_ScopeId_Type` ON `ApiScopeClaims` (`ScopeId`, `Type`);

ALTER TABLE `ApiScopeClaims` DROP INDEX `IX_ApiScopeClaims_ScopeId`;

CREATE UNIQUE INDEX `IX_ApiResourceScopes_ApiResourceId_Scope` ON `ApiResourceScopes` (`ApiResourceId`, `Scope`);

ALTER TABLE `ApiResourceScopes` DROP INDEX `IX_ApiResourceScopes_ApiResourceId`;

CREATE UNIQUE INDEX `IX_ApiResourceProperties_ApiResourceId_Key` ON `ApiResourceProperties` (`ApiResourceId`, `Key`);

ALTER TABLE `ApiResourceProperties` DROP INDEX `IX_ApiResourceProperties_ApiResourceId`;

CREATE UNIQUE INDEX `IX_ApiResourceClaims_ApiResourceId_Type` ON `ApiResourceClaims` (`ApiResourceId`, `Type`);

ALTER TABLE `ApiResourceClaims` DROP INDEX `IX_ApiResourceClaims_ApiResourceId`;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20220104115922_DuendeV6MySqlConfigurationMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `Clients` ADD `CoordinateLifetimeWithUserSession` tinyint(1) NULL;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20220608093234_Duende61ConfigurationUpdate', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `Clients` ADD `DPoPClockSkew` time(6) NOT NULL DEFAULT '00:00:00';

ALTER TABLE `Clients` ADD `DPoPValidationMode` int NOT NULL DEFAULT 0;

ALTER TABLE `Clients` ADD `InitiateLoginUri` varchar(2000) CHARACTER SET utf8mb4 NULL;

ALTER TABLE `Clients` ADD `RequireDPoP` tinyint(1) NOT NULL DEFAULT FALSE;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20230620154609_Duende63ConfigurationUpdate', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `Clients` ADD `PushedAuthorizationLifetime` int NULL;

ALTER TABLE `Clients` ADD `RequirePushedAuthorization` tinyint(1) NOT NULL DEFAULT FALSE;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20240105120950_DuendeV7MySqlConfigurationMigration', '8.0.2');

COMMIT;

