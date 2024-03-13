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
VALUES ('20171026082841_InitialMySqlExtendedConfigurationDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

CREATE TABLE `ConfigurationEntries` (
    `Key` varchar(95) NOT NULL,
    `Value` longtext NULL,
    CONSTRAINT `PK_ConfigurationEntries` PRIMARY KEY (`Key`)
);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20180725083018_ConfigurationEntries', '8.0.2');

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
VALUES ('20181205164929_ExtendedDataMigration2.3', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `ExtendedClients` ADD `ClientType` int NULL;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20190321122253_ClientType', '8.0.2');

COMMIT;

