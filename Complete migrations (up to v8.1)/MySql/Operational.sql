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
VALUES ('20171026082423_InitialMySqlOperationalDbMigration', '8.0.2');

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
VALUES ('20181112153007_IdentityServer2.3MySqlOperationalDbMigration', '8.0.2');

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
VALUES ('20200702080404_V3toV4MySqlOperationalDbMigration', '8.0.2');

COMMIT;

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
VALUES ('20210106150621_DuendeMySqlOperationalMigration', '8.0.2');

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
VALUES ('20210602110210_PersistedGrantConsumeTimeMySqlOperationalMigration', '8.0.2');

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
VALUES ('20220608092034_Duende61Update', '8.0.2');

DROP PROCEDURE `POMELO_BEFORE_DROP_PRIMARY_KEY`;

DROP PROCEDURE `POMELO_AFTER_ADD_PRIMARY_KEY`;

COMMIT;

START TRANSACTION;

ALTER TABLE `ServerSideSessions` MODIFY COLUMN `Id` bigint NOT NULL AUTO_INCREMENT;

CREATE TABLE `PushedAuthorizationRequests` (
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `ReferenceValueHash` longtext CHARACTER SET utf8mb4 NULL,
    `ExpiresAtUtc` datetime(6) NOT NULL,
    `Parameters` longtext CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_PushedAuthorizationRequests` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20240108113305_DuendeV7MySqlOperationalMigration', '8.0.2');

COMMIT;

