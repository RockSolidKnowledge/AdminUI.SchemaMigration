CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "SamlArtifacts" (
    "Key" character varying(200) NOT NULL,
    "EntityId" character varying(200) NOT NULL,
    "MessageType" character varying(50) NOT NULL,
    "Message" character varying(50000) NOT NULL,
    "CreationTime" timestamp with time zone NOT NULL,
    "Expiration" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_SamlArtifacts" PRIMARY KEY ("Key")
);

CREATE INDEX "IX_SamlArtifacts_Expiration" ON "SamlArtifacts" ("Expiration");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20220114164545_PostgreSqlSamlArtifactInitialMigration', '8.0.1');

COMMIT;

