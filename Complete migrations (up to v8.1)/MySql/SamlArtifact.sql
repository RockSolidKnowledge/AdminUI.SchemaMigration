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
VALUES ('20220114164323_MySqlSamlArtifactInitialMigration', '8.0.1');

COMMIT;

