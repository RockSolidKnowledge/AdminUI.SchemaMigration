CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "ExtendedApiResources" (
    "Id" text NOT NULL,
    "ApiResourceName" varchar(200) NOT NULL,
    "NormalizedName" varchar(200) NOT NULL,
    "Reserved" bool NOT NULL,
    CONSTRAINT "PK_ExtendedApiResources" PRIMARY KEY ("Id")
);

CREATE TABLE "ExtendedClients" (
    "Id" text NOT NULL,
    "ClientId" varchar(200) NOT NULL,
    "Description" text,
    "NormalizedClientId" varchar(200) NOT NULL,
    "NormalizedClientName" varchar(200),
    "Reserved" bool NOT NULL,
    CONSTRAINT "PK_ExtendedClients" PRIMARY KEY ("Id")
);

CREATE TABLE "ExtendedIdentityResources" (
    "Id" text NOT NULL,
    "IdentityResourceName" varchar(200) NOT NULL,
    "NormalizedName" varchar(200) NOT NULL,
    "Reserved" bool NOT NULL,
    CONSTRAINT "PK_ExtendedIdentityResources" PRIMARY KEY ("Id")
);

CREATE UNIQUE INDEX "ApiNameIndex" ON "ExtendedApiResources" ("ApiResourceName");

CREATE UNIQUE INDEX "ApiResourceNameIndex" ON "ExtendedApiResources" ("NormalizedName");

CREATE UNIQUE INDEX "IdIndex" ON "ExtendedClients" ("ClientId");

CREATE UNIQUE INDEX "ClientIdIndex" ON "ExtendedClients" ("NormalizedClientId");

CREATE UNIQUE INDEX "ClientNameIndex" ON "ExtendedClients" ("NormalizedClientName");

CREATE UNIQUE INDEX "IdentityNameIndex" ON "ExtendedIdentityResources" ("IdentityResourceName");

CREATE UNIQUE INDEX "IdentityResourceNameIndex" ON "ExtendedIdentityResources" ("NormalizedName");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171026082855_InitialPostgreSqlExtendedConfigurationDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171122163921_UserSearchOptimizationExtendedConfigurationDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

CREATE TABLE "ConfigurationEntries" (
    "Key" text NOT NULL,
    "Value" text,
    CONSTRAINT "PK_ConfigurationEntries" PRIMARY KEY ("Key")
);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20180724143733_ConfigurationEntries', '8.0.2');

COMMIT;

START TRANSACTION;

UPDATE public."Clients"
	                                SET   "NonEditable" = "Reserved"
	                                From public."ExtendedClients"
	                                WHERE "Clients"."ClientId" = "ExtendedClients"."ClientId";

UPDATE public."ApiResources"
	                                SET   "NonEditable" = "Reserved"
	                                From public."ExtendedApiResources"
	                                WHERE "ApiResources"."Name" = "ExtendedApiResources"."ApiResourceName";

UPDATE public."IdentityResources"
	                                SET   "NonEditable" = "Reserved"
	                                From public."ExtendedIdentityResources"
	                                WHERE "IdentityResources"."Name" = "ExtendedIdentityResources"."IdentityResourceName";

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20181205165028_ExtendedDataMigration2.3', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "ExtendedClients" ADD "ClientType" integer;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20190401105052_ClientType', '8.0.2');

COMMIT;

