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
VALUES ('20190305133541_MySqlWsfederationInitial', '8.0.2');

COMMIT;

