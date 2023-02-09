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
VALUES ('20171026082716_InitialMySqlConfigurationDbMigration', '6.0.3');

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
VALUES ('20181112152920_IdentityServer2.3SMySqlConfigurationDbMigration', '6.0.3');

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
VALUES ('20200702075924_V3toV4MySqlConfigurationDbMigration', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

CREATE TABLE `ExtendedApiResources` (
    `Id` varchar(127) NOT NULL,
    `ApiResourceName` varchar(200) NOT NULL,
    `NormalizedName` varchar(200) NOT NULL,
    `Reserved` bit NOT NULL,
    CONSTRAINT `PK_ExtendedApiResources` PRIMARY KEY (`Id`)
);

CREATE TABLE `ExtendedClients` (
    `Id` varchar(127) NOT NULL,
    `ClientId` varchar(200) NOT NULL,
    `Description` longtext NULL,
    `NormalizedClientId` varchar(200) NOT NULL,
    `NormalizedClientName` varchar(200) NULL,
    `Reserved` bit NOT NULL,
    CONSTRAINT `PK_ExtendedClients` PRIMARY KEY (`Id`)
);

CREATE TABLE `ExtendedIdentityResources` (
    `Id` varchar(127) NOT NULL,
    `IdentityResourceName` varchar(200) NOT NULL,
    `NormalizedName` varchar(200) NOT NULL,
    `Reserved` bit NOT NULL,
    CONSTRAINT `PK_ExtendedIdentityResources` PRIMARY KEY (`Id`)
);

CREATE UNIQUE INDEX `ApiNameIndex` ON `ExtendedApiResources` (`ApiResourceName`);

CREATE UNIQUE INDEX `ApiResourceNameIndex` ON `ExtendedApiResources` (`NormalizedName`);

CREATE UNIQUE INDEX `IdIndex` ON `ExtendedClients` (`ClientId`);

CREATE UNIQUE INDEX `ClientIdIndex` ON `ExtendedClients` (`NormalizedClientId`);

CREATE UNIQUE INDEX `ClientNameIndex` ON `ExtendedClients` (`NormalizedClientName`);

CREATE UNIQUE INDEX `IdentityNameIndex` ON `ExtendedIdentityResources` (`IdentityResourceName`);

CREATE UNIQUE INDEX `IdentityResourceNameIndex` ON `ExtendedIdentityResources` (`NormalizedName`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20171026082841_InitialMySqlExtendedConfigurationDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

CREATE TABLE `ConfigurationEntries` (
    `Key` varchar(95) NOT NULL,
    `Value` longtext NULL,
    CONSTRAINT `PK_ConfigurationEntries` PRIMARY KEY (`Key`)
);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20180725083018_ConfigurationEntries', '6.0.3');

COMMIT;

START TRANSACTION;

UPDATE Clients t1 
                                            INNER JOIN ExtendedClients t2 
                                                 ON t1.ClientId = t2.ClientId
                                    SET t1.NonEditable = t2.Reserved;

UPDATE ApiResources t1 
                                            INNER JOIN ExtendedApiResources t2 
                                                 ON t1.Name = t2.ApiResourceName
                                    SET t1.NonEditable = t2.Reserved;

UPDATE IdentityResources t1 
                                            INNER JOIN ExtendedIdentityResources t2 
                                                 ON t1.Name = t2.IdentityResourceName
                                    SET t1.NonEditable = t2.Reserved;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20181205164929_ExtendedDataMigration2.3', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE `ExtendedClients` ADD `ClientType` int NULL;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20190321122253_ClientType', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

CREATE TABLE `PersistedGrants` (
    `Key` varchar(200) NOT NULL,
    `ClientId` varchar(200) NOT NULL,
    `CreationTime` datetime(6) NOT NULL,
    `Data` longtext NOT NULL,
    `Expiration` datetime(6) NULL,
    `SubjectId` varchar(200) NULL,
    `Type` varchar(50) NOT NULL,
    CONSTRAINT `PK_PersistedGrants` PRIMARY KEY (`Key`)
);

CREATE INDEX `IX_PersistedGrants_SubjectId_ClientId_Type` ON `PersistedGrants` (`SubjectId`, `ClientId`, `Type`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20171026082423_InitialMySqlOperationalDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

CREATE TABLE `DeviceCodes` (
    `DeviceCode` varchar(200) NOT NULL,
    `UserCode` varchar(200) NOT NULL,
    `SubjectId` varchar(200) NULL,
    `ClientId` varchar(200) NOT NULL,
    `CreationTime` datetime(6) NOT NULL,
    `Expiration` datetime(6) NOT NULL,
    `Data` longtext NOT NULL,
    CONSTRAINT `PK_DeviceCodes` PRIMARY KEY (`UserCode`)
);

CREATE UNIQUE INDEX `IX_DeviceCodes_DeviceCode` ON `DeviceCodes` (`DeviceCode`);

CREATE UNIQUE INDEX `IX_DeviceCodes_UserCode` ON `DeviceCodes` (`UserCode`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20181112153007_IdentityServer2.3MySqlOperationalDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

START TRANSACTION;

-- Alter Existing Tables

-- DeviceCodes

ALTER TABLE `DeviceCodes`
	ADD `SessionId` nvarchar(100) NULL;
	
ALTER TABLE `DeviceCodes`
	ADD `Description` nvarchar(200) NULL;



-- PersistedGrants

ALTER TABLE `PersistedGrants`
	ADD `SessionId` nvarchar(100) NULL;
	
ALTER TABLE `PersistedGrants`
	ADD `Description` nvarchar(200) NULL;
	
ALTER TABLE `PersistedGrants`
	ADD `ConsumedTime` date NULL;

ALTER TABLE `PersistedGrants` ADD INDEX `IX_PersistedGrants_SubjectId_SessionId_Type`  (`SubjectId`, `SessionId`, Type);

COMMIT;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20200702080404_V3toV4MySqlOperationalDbMigration', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

ALTER TABLE `ApiResources` ADD `RequireResourceIndicator` tinyint(1) NOT NULL DEFAULT FALSE;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20210106162829_DuendeMySqlConfigurationMigration', '6.0.3');

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
VALUES ('20210602105143_IdentityProvidersMySqlConfigurationMigration', '6.0.3');

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
VALUES ('20220104115922_DuendeV6MySqlConfigurationMigration', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE `Clients` ADD `CoordinateLifetimeWithUserSession` tinyint(1) NULL;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20220608093234_Duende61ConfigurationUpdate', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

CREATE TABLE `Keys` (
    `Id` varchar(95) NOT NULL,
    `Version` int NOT NULL,
    `Created` datetime(6) NOT NULL,
    `Use` varchar(95) NULL,
    `Algorithm` varchar(100) NOT NULL,
    `IsX509Certificate` tinyint(1) NOT NULL,
    `DataProtected` tinyint(1) NOT NULL,
    `Data` longtext CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK_Keys` PRIMARY KEY (`Id`)
);

CREATE INDEX `IX_Keys_Use` ON `Keys` (`Use`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20210106150621_DuendeMySqlOperationalMigration', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE `PersistedGrants` MODIFY COLUMN `Type` varchar(50) NOT NULL;

ALTER TABLE `PersistedGrants` MODIFY COLUMN `SubjectId` varchar(200) NULL;

ALTER TABLE `PersistedGrants` MODIFY COLUMN `SessionId` varchar(100) NULL;

ALTER TABLE `PersistedGrants` MODIFY COLUMN `Description` varchar(200) NULL;

ALTER TABLE `PersistedGrants` MODIFY COLUMN `Data` longtext NOT NULL;

ALTER TABLE `PersistedGrants` MODIFY COLUMN `ClientId` varchar(200) NOT NULL;

ALTER TABLE `PersistedGrants` MODIFY COLUMN `Key` varchar(200) NOT NULL;

ALTER TABLE `Keys` MODIFY COLUMN `Use` varchar(95) NULL;

ALTER TABLE `Keys` MODIFY COLUMN `Data` longtext NOT NULL;

ALTER TABLE `Keys` MODIFY COLUMN `Algorithm` varchar(100) NOT NULL;

ALTER TABLE `Keys` MODIFY COLUMN `Id` varchar(95) NOT NULL;

ALTER TABLE `DeviceCodes` MODIFY COLUMN `SubjectId` varchar(200) NULL;

ALTER TABLE `DeviceCodes` MODIFY COLUMN `SessionId` varchar(100) NULL;

ALTER TABLE `DeviceCodes` MODIFY COLUMN `DeviceCode` varchar(200) NOT NULL;

ALTER TABLE `DeviceCodes` MODIFY COLUMN `Description` varchar(200) NULL;

ALTER TABLE `DeviceCodes` MODIFY COLUMN `Data` longtext NOT NULL;

ALTER TABLE `DeviceCodes` MODIFY COLUMN `ClientId` varchar(200) NOT NULL;

ALTER TABLE `DeviceCodes` MODIFY COLUMN `UserCode` varchar(200) NOT NULL;

CREATE INDEX `IX_PersistedGrants_ConsumedTime` ON `PersistedGrants` (`ConsumedTime`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20210602110210_PersistedGrantConsumeTimeMySqlOperationalMigration', '6.0.3');

COMMIT;

START TRANSACTION;

DROP PROCEDURE IF EXISTS `POMELO_BEFORE_DROP_PRIMARY_KEY`;
DELIMITER //
CREATE PROCEDURE `POMELO_BEFORE_DROP_PRIMARY_KEY`(IN `SCHEMA_NAME_ARGUMENT` VARCHAR(255), IN `TABLE_NAME_ARGUMENT` VARCHAR(255))
BEGIN
	DECLARE HAS_AUTO_INCREMENT_ID TINYINT(1);
	DECLARE PRIMARY_KEY_COLUMN_NAME VARCHAR(255);
	DECLARE PRIMARY_KEY_TYPE VARCHAR(255);
	DECLARE SQL_EXP VARCHAR(1000);
	SELECT COUNT(*)
		INTO HAS_AUTO_INCREMENT_ID
		FROM `information_schema`.`COLUMNS`
		WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
			AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
			AND `Extra` = 'auto_increment'
			AND `COLUMN_KEY` = 'PRI'
			LIMIT 1;
	IF HAS_AUTO_INCREMENT_ID THEN
		SELECT `COLUMN_TYPE`
			INTO PRIMARY_KEY_TYPE
			FROM `information_schema`.`COLUMNS`
			WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
				AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
				AND `COLUMN_KEY` = 'PRI'
			LIMIT 1;
		SELECT `COLUMN_NAME`
			INTO PRIMARY_KEY_COLUMN_NAME
			FROM `information_schema`.`COLUMNS`
			WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
				AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
				AND `COLUMN_KEY` = 'PRI'
			LIMIT 1;
		SET SQL_EXP = CONCAT('ALTER TABLE `', (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA())), '`.`', TABLE_NAME_ARGUMENT, '` MODIFY COLUMN `', PRIMARY_KEY_COLUMN_NAME, '` ', PRIMARY_KEY_TYPE, ' NOT NULL;');
		SET @SQL_EXP = SQL_EXP;
		PREPARE SQL_EXP_EXECUTE FROM @SQL_EXP;
		EXECUTE SQL_EXP_EXECUTE;
		DEALLOCATE PREPARE SQL_EXP_EXECUTE;
	END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS `POMELO_AFTER_ADD_PRIMARY_KEY`;
DELIMITER //
CREATE PROCEDURE `POMELO_AFTER_ADD_PRIMARY_KEY`(IN `SCHEMA_NAME_ARGUMENT` VARCHAR(255), IN `TABLE_NAME_ARGUMENT` VARCHAR(255), IN `COLUMN_NAME_ARGUMENT` VARCHAR(255))
BEGIN
	DECLARE HAS_AUTO_INCREMENT_ID INT(11);
	DECLARE PRIMARY_KEY_COLUMN_NAME VARCHAR(255);
	DECLARE PRIMARY_KEY_TYPE VARCHAR(255);
	DECLARE SQL_EXP VARCHAR(1000);
	SELECT COUNT(*)
		INTO HAS_AUTO_INCREMENT_ID
		FROM `information_schema`.`COLUMNS`
		WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
			AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
			AND `COLUMN_NAME` = COLUMN_NAME_ARGUMENT
			AND `COLUMN_TYPE` LIKE '%int%'
			AND `COLUMN_KEY` = 'PRI';
	IF HAS_AUTO_INCREMENT_ID THEN
		SELECT `COLUMN_TYPE`
			INTO PRIMARY_KEY_TYPE
			FROM `information_schema`.`COLUMNS`
			WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
				AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
				AND `COLUMN_NAME` = COLUMN_NAME_ARGUMENT
				AND `COLUMN_TYPE` LIKE '%int%'
				AND `COLUMN_KEY` = 'PRI';
		SELECT `COLUMN_NAME`
			INTO PRIMARY_KEY_COLUMN_NAME
			FROM `information_schema`.`COLUMNS`
			WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
				AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
				AND `COLUMN_NAME` = COLUMN_NAME_ARGUMENT
				AND `COLUMN_TYPE` LIKE '%int%'
				AND `COLUMN_KEY` = 'PRI';
		SET SQL_EXP = CONCAT('ALTER TABLE `', (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA())), '`.`', TABLE_NAME_ARGUMENT, '` MODIFY COLUMN `', PRIMARY_KEY_COLUMN_NAME, '` ', PRIMARY_KEY_TYPE, ' NOT NULL AUTO_INCREMENT;');
		SET @SQL_EXP = SQL_EXP;
		PREPARE SQL_EXP_EXECUTE FROM @SQL_EXP;
		EXECUTE SQL_EXP_EXECUTE;
		DEALLOCATE PREPARE SQL_EXP_EXECUTE;
	END IF;
END //
DELIMITER ;

CALL POMELO_BEFORE_DROP_PRIMARY_KEY(NULL, 'PersistedGrants');
ALTER TABLE `PersistedGrants` DROP PRIMARY KEY;

ALTER TABLE `PersistedGrants` MODIFY COLUMN `Key` varchar(200) CHARACTER SET utf8mb4 NULL;

ALTER TABLE `PersistedGrants` ADD `Id` bigint NOT NULL DEFAULT 0;

ALTER TABLE `PersistedGrants` ADD CONSTRAINT `PK_PersistedGrants` PRIMARY KEY (`Id`);
CALL POMELO_AFTER_ADD_PRIMARY_KEY(NULL, 'PersistedGrants', 'Id');

CREATE TABLE `ServerSideSessions` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
    `Scheme` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
    `SubjectId` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
    `SessionId` varchar(100) CHARACTER SET utf8mb4 NULL,
    `DisplayName` varchar(100) CHARACTER SET utf8mb4 NULL,
    `Created` datetime(6) NOT NULL,
    `Renewed` datetime(6) NOT NULL,
    `Expires` datetime(6) NULL,
    `Data` longtext CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK_ServerSideSessions` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE UNIQUE INDEX `IX_PersistedGrants_Key` ON `PersistedGrants` (`Key`);

CREATE INDEX `IX_ServerSideSessions_DisplayName` ON `ServerSideSessions` (`DisplayName`);

CREATE INDEX `IX_ServerSideSessions_Expires` ON `ServerSideSessions` (`Expires`);

CREATE UNIQUE INDEX `IX_ServerSideSessions_Key` ON `ServerSideSessions` (`Key`);

CREATE INDEX `IX_ServerSideSessions_SessionId` ON `ServerSideSessions` (`SessionId`);

CREATE INDEX `IX_ServerSideSessions_SubjectId` ON `ServerSideSessions` (`SubjectId`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20220608092034_Duende61Update', '6.0.3');

DROP PROCEDURE `POMELO_BEFORE_DROP_PRIMARY_KEY`;

DROP PROCEDURE `POMELO_AFTER_ADD_PRIMARY_KEY`;

COMMIT;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

CREATE TABLE `AuditEntries` (
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `When` datetime(6) NOT NULL,
    `Source` longtext NULL,
    `SubjectType` longtext NULL,
    `SubjectIdentifier` longtext NULL,
    `Subject` longtext NULL,
    `Action` longtext NULL,
    `ResourceType` longtext NULL,
    `Resource` longtext NULL,
    `ResourceIdentifier` longtext NULL,
    `Succeeded` tinyint(1) NOT NULL,
    `Description` longtext NULL,
    `NormalisedSubject` longtext NULL,
    `NormalisedAction` longtext NULL,
    `NormalisedResource` longtext NULL,
    `NormalisedSource` longtext NULL,
    CONSTRAINT `PK_AuditEntries` PRIMARY KEY (`Id`)
);

CREATE INDEX `IX_AuditEntries_When` ON `AuditEntries` (`When`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20181220155839_InitalMySqlAuditDbMigration', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

CREATE TABLE `AspNetClaimTypes` (
    `Id` varchar(127) NOT NULL,
    `ConcurrencyStamp` longtext NULL,
    `Description` longtext NULL,
    `Name` varchar(256) NOT NULL,
    `NormalizedName` varchar(256) NULL,
    `Required` bit NOT NULL,
    `Reserved` bit NOT NULL,
    `Rule` longtext NULL,
    `RuleValidationFailureDescription` longtext NULL,
    `UserEditable` bit NOT NULL DEFAULT FALSE,
    `ValueType` int NOT NULL,
    CONSTRAINT `PK_AspNetClaimTypes` PRIMARY KEY (`Id`),
    CONSTRAINT `AK_AspNetClaimTypes_Name` UNIQUE (`Name`)
);

CREATE TABLE `AspNetRoles` (
    `Id` varchar(127) NOT NULL,
    `ConcurrencyStamp` longtext NULL,
    `Description` longtext NULL,
    `Name` varchar(256) NULL,
    `NormalizedName` varchar(256) NULL,
    `Reserved` bit NOT NULL,
    CONSTRAINT `PK_AspNetRoles` PRIMARY KEY (`Id`)
);

CREATE TABLE `AspNetUsers` (
    `Id` varchar(127) NOT NULL,
    `AccessFailedCount` int NOT NULL,
    `ConcurrencyStamp` longtext NULL,
    `Email` varchar(256) NULL,
    `EmailConfirmed` bit NOT NULL,
    `FirstName` longtext NULL,
    `IsBlocked` bit NOT NULL,
    `IsDeleted` bit NOT NULL,
    `LastName` longtext NULL,
    `LockoutEnabled` bit NOT NULL,
    `LockoutEnd` datetime(6) NULL,
    `NormalizedEmail` varchar(256) NULL,
    `NormalizedUserName` varchar(256) NULL,
    `PasswordHash` longtext NULL,
    `PhoneNumber` longtext NULL,
    `PhoneNumberConfirmed` bit NOT NULL,
    `SecurityStamp` longtext NULL,
    `TwoFactorEnabled` bit NOT NULL,
    `UserName` varchar(256) NULL,
    CONSTRAINT `PK_AspNetUsers` PRIMARY KEY (`Id`)
);

CREATE TABLE `AspNetRoleClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClaimType` longtext NULL,
    `ClaimValue` longtext NULL,
    `RoleId` varchar(127) NOT NULL,
    CONSTRAINT `PK_AspNetRoleClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClaimType` varchar(256) NOT NULL,
    `ClaimValue` longtext NULL,
    `UserId` varchar(127) NOT NULL,
    CONSTRAINT `PK_AspNetUserClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_AspNetUserClaims_AspNetClaimTypes_ClaimType` FOREIGN KEY (`ClaimType`) REFERENCES `AspNetClaimTypes` (`Name`) ON DELETE CASCADE,
    CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserLogins` (
    `LoginProvider` varchar(127) NOT NULL,
    `ProviderKey` varchar(127) NOT NULL,
    `ProviderDisplayName` longtext NULL,
    `UserId` varchar(127) NOT NULL,
    CONSTRAINT `PK_AspNetUserLogins` PRIMARY KEY (`LoginProvider`, `ProviderKey`),
    CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserRoles` (
    `UserId` varchar(127) NOT NULL,
    `RoleId` varchar(127) NOT NULL,
    CONSTRAINT `PK_AspNetUserRoles` PRIMARY KEY (`UserId`, `RoleId`),
    CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserTokens` (
    `UserId` varchar(127) NOT NULL,
    `LoginProvider` varchar(127) NOT NULL,
    `Name` varchar(127) NOT NULL,
    `Value` longtext NULL,
    CONSTRAINT `PK_AspNetUserTokens` PRIMARY KEY (`UserId`, `LoginProvider`, `Name`),
    CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE UNIQUE INDEX `ClaimTypeNameIndex` ON `AspNetClaimTypes` (`NormalizedName`);

CREATE INDEX `IX_AspNetRoleClaims_RoleId` ON `AspNetRoleClaims` (`RoleId`);

CREATE UNIQUE INDEX `RoleNameIndex` ON `AspNetRoles` (`NormalizedName`);

CREATE INDEX `IX_AspNetUserClaims_ClaimType` ON `AspNetUserClaims` (`ClaimType`);

CREATE INDEX `IX_AspNetUserClaims_UserId` ON `AspNetUserClaims` (`UserId`);

CREATE INDEX `IX_AspNetUserLogins_UserId` ON `AspNetUserLogins` (`UserId`);

CREATE INDEX `IX_AspNetUserRoles_RoleId` ON `AspNetUserRoles` (`RoleId`);

CREATE INDEX `EmailIndex` ON `AspNetUsers` (`NormalizedEmail`);

CREATE UNIQUE INDEX `UserNameIndex` ON `AspNetUsers` (`NormalizedUserName`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20171026082026_InitialMySqlIdentityDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE `AspNetUsers` ADD `NormalizedFirstName` varchar(256) NULL;

ALTER TABLE `AspNetUsers` ADD `NormalizedLastName` varchar(256) NULL;

CREATE INDEX `FirstNameIndex` ON `AspNetUsers` (`NormalizedFirstName`);

CREATE INDEX `LastNameIndex` ON `AspNetUsers` (`NormalizedLastName`);

CREATE INDEX `CountIndex` ON `AspNetUsers` (`IsBlocked`, `IsDeleted`);

CREATE INDEX `CountIndexReversed` ON `AspNetUsers` (`IsDeleted`, `IsBlocked`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20171122164343_UserSearchOptimizationMigration', '6.0.3');

COMMIT;

START TRANSACTION;

CREATE TABLE `EnumClaimTypeAllowedValues` (
    `ClaimTypeId` varchar(95) NOT NULL,
    `Value` varchar(95) NOT NULL,
    CONSTRAINT `PK_EnumClaimTypeAllowedValues` PRIMARY KEY (`ClaimTypeId`, `Value`),
    CONSTRAINT `FK_EnumClaimTypeAllowedValues_AspNetClaimTypes_ClaimTypeId` FOREIGN KEY (`ClaimTypeId`) REFERENCES `AspNetClaimTypes` (`Id`) ON DELETE CASCADE
);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20210504100649_EnumeratedClaimTypeMigration', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE `AspNetClaimTypes` ADD `DisplayName` longtext CHARACTER SET utf8mb4 NULL;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20220112114906_ClaimTypeDisplayNameMigration', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

ALTER DATABASE CHARACTER SET utf8mb4;

CREATE TABLE `SamlArtifacts` (
    `Key` varchar(200) CHARACTER SET utf8mb4 NOT NULL,
    `EntityId` varchar(200) CHARACTER SET utf8mb4 NOT NULL,
    `MessageType` varchar(50) CHARACTER SET utf8mb4 NOT NULL,
    `Message` longtext CHARACTER SET utf8mb4 NOT NULL,
    `CreationTime` datetime(6) NOT NULL,
    `Expiration` datetime(6) NOT NULL,
    CONSTRAINT `PK_SamlArtifacts` PRIMARY KEY (`Key`)
) CHARACTER SET=utf8mb4;

CREATE INDEX `IX_SamlArtifacts_Expiration` ON `SamlArtifacts` (`Expiration`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20220114164323_MySqlSamlArtifactInitialMigration', '6.0.3');

COMMIT;

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
VALUES ('20190305133042_MySqlSaml2PInitial', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE `ServiceProviders` ADD `AllowIdpInitiatedSso` tinyint(1) NOT NULL DEFAULT FALSE;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20200225105251_Added AllowIdpInitiated', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE `ServiceProviders` ADD `RequireAuthenticationRequestsSigned` tinyint(1) NULL;

ALTER TABLE `ServiceProviders` CHANGE `RequireSamlRequestDestination` `RequireSamlMessageDestination` tinyint(1) NOT NULL DEFAULT FALSE;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20200914074711_RskSamlV3', '6.0.3');

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
VALUES ('20220112145727_RskSamlPackageUpdate', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

CREATE TABLE `RelyingParties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Realm` varchar(200) NOT NULL,
    `TokenType` longtext NULL,
    `SignatureAlgorithm` longtext NULL,
    `DigestAlgorithm` longtext NULL,
    `SamlNameIdentifierFormat` longtext NULL,
    CONSTRAINT `PK_RelyingParties` PRIMARY KEY (`Id`)
);

CREATE TABLE `RelyingPartyClaimMappings` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `OriginalClaimType` varchar(250) NOT NULL,
    `NewClaimType` varchar(250) NOT NULL,
    `RelyingPartyId` int NOT NULL,
    CONSTRAINT `PK_RelyingPartyClaimMappings` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_RelyingPartyClaimMappings_RelyingParties_RelyingPartyId` FOREIGN KEY (`RelyingPartyId`) REFERENCES `RelyingParties` (`Id`) ON DELETE CASCADE
);

CREATE UNIQUE INDEX `IX_RelyingParties_Realm` ON `RelyingParties` (`Realm`);

CREATE INDEX `IX_RelyingPartyClaimMappings_RelyingPartyId` ON `RelyingPartyClaimMappings` (`RelyingPartyId`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20190305133541_MySqlWsfederationInitial', '6.0.3');

COMMIT;

