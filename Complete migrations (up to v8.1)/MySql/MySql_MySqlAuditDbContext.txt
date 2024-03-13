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
VALUES ('20181220155839_InitalMySqlAuditDbMigration', '8.0.2');

COMMIT;

