CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "PersistedGrants" (
    "Key" varchar(200) NOT NULL,
    "ClientId" varchar(200) NOT NULL,
    "CreationTime" timestamp NOT NULL,
    "Data" varchar(50000) NOT NULL,
    "Expiration" timestamp,
    "SubjectId" varchar(200),
    "Type" varchar(50) NOT NULL,
    CONSTRAINT "PK_PersistedGrants" PRIMARY KEY ("Key")
);

CREATE INDEX "IX_PersistedGrants_SubjectId_ClientId_Type" ON "PersistedGrants" ("SubjectId", "ClientId", "Type");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171026082436_InitialPostgreSqlOperationalDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171122163955_UserSearchOptimizationOperationalDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

CREATE TABLE "DeviceCodes" (
    "DeviceCode" character varying(200) NOT NULL,
    "UserCode" character varying(200) NOT NULL,
    "SubjectId" character varying(200),
    "ClientId" character varying(200) NOT NULL,
    "CreationTime" timestamp with time zone NOT NULL,
    "Expiration" timestamp with time zone NOT NULL,
    "Data" character varying(50000) NOT NULL,
    CONSTRAINT "PK_DeviceCodes" PRIMARY KEY ("UserCode")
);

CREATE UNIQUE INDEX "IX_DeviceCodes_DeviceCode" ON "DeviceCodes" ("DeviceCode");

CREATE UNIQUE INDEX "IX_DeviceCodes_UserCode" ON "DeviceCodes" ("UserCode");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20181112154906_IdentityServer2.3PostgreSqlOperationalDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

-- Alter Existing Tables

-- DeviceCodes

ALTER TABLE "DeviceCodes"
	ADD "SessionId" character varying(100) NULL;
	
ALTER TABLE "DeviceCodes"
	ADD "Description" character varying(200) NULL;



-- PersistedGrants

ALTER TABLE "PersistedGrants"
	ADD "SessionId" character varying(100) NULL;
	
ALTER TABLE "PersistedGrants"
	ADD "Description" character varying(200) NULL;
	
ALTER TABLE "PersistedGrants"
	ADD "ConsumedTime" timestamp without time zone NULL;

CREATE INDEX "IX_PersistedGrants_SubjectId_SessionId_Type" ON "PersistedGrants" ("SubjectId", "SessionId", "Type");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20200702113344_V3toV4PostgreSqlOperationalDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

CREATE TABLE "Keys" (
    "Id" text NOT NULL,
    "Version" integer NOT NULL,
    "Created" timestamp without time zone NOT NULL,
    "Use" text,
    "Algorithm" character varying(100) NOT NULL,
    "IsX509Certificate" boolean NOT NULL,
    "DataProtected" boolean NOT NULL,
    "Data" text NOT NULL,
    CONSTRAINT "PK_Keys" PRIMARY KEY ("Id")
);

CREATE INDEX "IX_Keys_Use" ON "Keys" ("Use");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20210106150433_DuendePostgreSqlOperationalMigration', '8.0.2');

COMMIT;

START TRANSACTION;

CREATE INDEX "IX_PersistedGrants_ConsumedTime" ON "PersistedGrants" ("ConsumedTime");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20210602110147_PersistedGrantConsumeTimePostgreSqlOperationalMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "PersistedGrants" DROP CONSTRAINT "PK_PersistedGrants";

ALTER TABLE "PersistedGrants" ALTER COLUMN "Expiration" TYPE timestamp with time zone;

ALTER TABLE "PersistedGrants" ALTER COLUMN "CreationTime" TYPE timestamp with time zone;

ALTER TABLE "PersistedGrants" ALTER COLUMN "ConsumedTime" TYPE timestamp with time zone;

ALTER TABLE "PersistedGrants" ALTER COLUMN "Key" DROP NOT NULL;

ALTER TABLE "PersistedGrants" ADD "Id" bigserial NOT NULL;

ALTER TABLE "Keys" ALTER COLUMN "Created" TYPE timestamp with time zone;

ALTER TABLE "DeviceCodes" ALTER COLUMN "Expiration" TYPE timestamp with time zone;

ALTER TABLE "DeviceCodes" ALTER COLUMN "CreationTime" TYPE timestamp with time zone;

ALTER TABLE "PersistedGrants" ADD CONSTRAINT "PK_PersistedGrants" PRIMARY KEY ("Id");

CREATE TABLE "ServerSideSessions" (
    "Id" serial NOT NULL,
    "Key" character varying(100) NOT NULL,
    "Scheme" character varying(100) NOT NULL,
    "SubjectId" character varying(100) NOT NULL,
    "SessionId" character varying(100),
    "DisplayName" character varying(100),
    "Created" timestamp with time zone NOT NULL,
    "Renewed" timestamp with time zone NOT NULL,
    "Expires" timestamp with time zone,
    "Data" text NOT NULL,
    CONSTRAINT "PK_ServerSideSessions" PRIMARY KEY ("Id")
);

CREATE UNIQUE INDEX "IX_PersistedGrants_Key" ON "PersistedGrants" ("Key");

CREATE INDEX "IX_ServerSideSessions_DisplayName" ON "ServerSideSessions" ("DisplayName");

CREATE INDEX "IX_ServerSideSessions_Expires" ON "ServerSideSessions" ("Expires");

CREATE UNIQUE INDEX "IX_ServerSideSessions_Key" ON "ServerSideSessions" ("Key");

CREATE INDEX "IX_ServerSideSessions_SessionId" ON "ServerSideSessions" ("SessionId");

CREATE INDEX "IX_ServerSideSessions_SubjectId" ON "ServerSideSessions" ("SubjectId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20220608092054_Duende61Update', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "ServerSideSessions" ALTER COLUMN "Id" TYPE bigint;

CREATE TABLE "PushedAuthorizationRequests" (
    "Id" bigserial NOT NULL,
    "ReferenceValueHash" text,
    "ExpiresAtUtc" timestamp with time zone NOT NULL,
    "Parameters" text,
    CONSTRAINT "PK_PushedAuthorizationRequests" PRIMARY KEY ("Id")
);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20240108113635_DuendeV7PostgreSqlOperationalMigration', '8.0.2');

COMMIT;

