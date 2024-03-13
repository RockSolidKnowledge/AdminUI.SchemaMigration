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
VALUES ('20171026082026_InitialMySqlIdentityDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `AspNetUsers` ADD `NormalizedFirstName` varchar(256) NULL;

ALTER TABLE `AspNetUsers` ADD `NormalizedLastName` varchar(256) NULL;

CREATE INDEX `FirstNameIndex` ON `AspNetUsers` (`NormalizedFirstName`);

CREATE INDEX `LastNameIndex` ON `AspNetUsers` (`NormalizedLastName`);

CREATE INDEX `CountIndex` ON `AspNetUsers` (`IsBlocked`, `IsDeleted`);

CREATE INDEX `CountIndexReversed` ON `AspNetUsers` (`IsDeleted`, `IsBlocked`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20171122164343_UserSearchOptimizationMigration', '8.0.2');

COMMIT;

START TRANSACTION;

CREATE TABLE `EnumClaimTypeAllowedValues` (
    `ClaimTypeId` varchar(95) NOT NULL,
    `Value` varchar(95) NOT NULL,
    CONSTRAINT `PK_EnumClaimTypeAllowedValues` PRIMARY KEY (`ClaimTypeId`, `Value`),
    CONSTRAINT `FK_EnumClaimTypeAllowedValues_AspNetClaimTypes_ClaimTypeId` FOREIGN KEY (`ClaimTypeId`) REFERENCES `AspNetClaimTypes` (`Id`) ON DELETE CASCADE
);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20210504100649_EnumeratedClaimTypeMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE `AspNetClaimTypes` ADD `DisplayName` longtext CHARACTER SET utf8mb4 NULL;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20220112114906_ClaimTypeDisplayNameMigration', '8.0.2');

COMMIT;

