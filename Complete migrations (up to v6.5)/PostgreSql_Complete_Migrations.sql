CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "ApiResources" (
    "Id" serial NOT NULL,
    "Description" varchar(1000) NULL,
    "DisplayName" varchar(200) NULL,
    "Enabled" bool NOT NULL,
    "Name" varchar(200) NOT NULL,
    CONSTRAINT "PK_ApiResources" PRIMARY KEY ("Id")
);

CREATE TABLE "Clients" (
    "Id" serial NOT NULL,
    "AbsoluteRefreshTokenLifetime" int4 NOT NULL,
    "AccessTokenLifetime" int4 NOT NULL,
    "AccessTokenType" int4 NOT NULL,
    "AllowAccessTokensViaBrowser" bool NOT NULL,
    "AllowOfflineAccess" bool NOT NULL,
    "AllowPlainTextPkce" bool NOT NULL,
    "AllowRememberConsent" bool NOT NULL,
    "AlwaysIncludeUserClaimsInIdToken" bool NOT NULL,
    "AlwaysSendClientClaims" bool NOT NULL,
    "AuthorizationCodeLifetime" int4 NOT NULL,
    "BackChannelLogoutSessionRequired" bool NOT NULL,
    "BackChannelLogoutUri" varchar(2000) NULL,
    "ClientClaimsPrefix" varchar(200) NULL,
    "ClientId" varchar(200) NOT NULL,
    "ClientName" varchar(200) NULL,
    "ClientUri" varchar(2000) NULL,
    "ConsentLifetime" int4 NULL,
    "Description" varchar(1000) NULL,
    "EnableLocalLogin" bool NOT NULL,
    "Enabled" bool NOT NULL,
    "FrontChannelLogoutSessionRequired" bool NOT NULL,
    "FrontChannelLogoutUri" varchar(2000) NULL,
    "IdentityTokenLifetime" int4 NOT NULL,
    "IncludeJwtId" bool NOT NULL,
    "LogoUri" varchar(2000) NULL,
    "PairWiseSubjectSalt" varchar(200) NULL,
    "ProtocolType" varchar(200) NOT NULL,
    "RefreshTokenExpiration" int4 NOT NULL,
    "RefreshTokenUsage" int4 NOT NULL,
    "RequireClientSecret" bool NOT NULL,
    "RequireConsent" bool NOT NULL,
    "RequirePkce" bool NOT NULL,
    "SlidingRefreshTokenLifetime" int4 NOT NULL,
    "UpdateAccessTokenClaimsOnRefresh" bool NOT NULL,
    CONSTRAINT "PK_Clients" PRIMARY KEY ("Id")
);

CREATE TABLE "IdentityResources" (
    "Id" serial NOT NULL,
    "Description" varchar(1000) NULL,
    "DisplayName" varchar(200) NULL,
    "Emphasize" bool NOT NULL,
    "Enabled" bool NOT NULL,
    "Name" varchar(200) NOT NULL,
    "Required" bool NOT NULL,
    "ShowInDiscoveryDocument" bool NOT NULL,
    CONSTRAINT "PK_IdentityResources" PRIMARY KEY ("Id")
);

CREATE TABLE "ApiClaims" (
    "Id" serial NOT NULL,
    "ApiResourceId" int4 NOT NULL,
    "Type" varchar(200) NOT NULL,
    CONSTRAINT "PK_ApiClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ApiClaims_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ApiScopes" (
    "Id" serial NOT NULL,
    "ApiResourceId" int4 NOT NULL,
    "Description" varchar(1000) NULL,
    "DisplayName" varchar(200) NULL,
    "Emphasize" bool NOT NULL,
    "Name" varchar(200) NOT NULL,
    "Required" bool NOT NULL,
    "ShowInDiscoveryDocument" bool NOT NULL,
    CONSTRAINT "PK_ApiScopes" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ApiScopes_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ApiSecrets" (
    "Id" serial NOT NULL,
    "ApiResourceId" int4 NOT NULL,
    "Description" varchar(1000) NULL,
    "Expiration" timestamp NULL,
    "Type" varchar(250) NULL,
    "Value" varchar(2000) NULL,
    CONSTRAINT "PK_ApiSecrets" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ApiSecrets_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientClaims" (
    "Id" serial NOT NULL,
    "ClientId" int4 NOT NULL,
    "Type" varchar(250) NOT NULL,
    "Value" varchar(250) NOT NULL,
    CONSTRAINT "PK_ClientClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ClientClaims_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientCorsOrigins" (
    "Id" serial NOT NULL,
    "ClientId" int4 NOT NULL,
    "Origin" varchar(150) NOT NULL,
    CONSTRAINT "PK_ClientCorsOrigins" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ClientCorsOrigins_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientGrantTypes" (
    "Id" serial NOT NULL,
    "ClientId" int4 NOT NULL,
    "GrantType" varchar(250) NOT NULL,
    CONSTRAINT "PK_ClientGrantTypes" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ClientGrantTypes_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientIdPRestrictions" (
    "Id" serial NOT NULL,
    "ClientId" int4 NOT NULL,
    "Provider" varchar(200) NOT NULL,
    CONSTRAINT "PK_ClientIdPRestrictions" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ClientIdPRestrictions_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientPostLogoutRedirectUris" (
    "Id" serial NOT NULL,
    "ClientId" int4 NOT NULL,
    "PostLogoutRedirectUri" varchar(2000) NOT NULL,
    CONSTRAINT "PK_ClientPostLogoutRedirectUris" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ClientPostLogoutRedirectUris_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientProperties" (
    "Id" serial NOT NULL,
    "ClientId" int4 NOT NULL,
    "Key" varchar(250) NOT NULL,
    "Value" varchar(2000) NOT NULL,
    CONSTRAINT "PK_ClientProperties" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ClientProperties_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientRedirectUris" (
    "Id" serial NOT NULL,
    "ClientId" int4 NOT NULL,
    "RedirectUri" varchar(2000) NOT NULL,
    CONSTRAINT "PK_ClientRedirectUris" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ClientRedirectUris_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientScopes" (
    "Id" serial NOT NULL,
    "ClientId" int4 NOT NULL,
    "Scope" varchar(200) NOT NULL,
    CONSTRAINT "PK_ClientScopes" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ClientScopes_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientSecrets" (
    "Id" serial NOT NULL,
    "ClientId" int4 NOT NULL,
    "Description" varchar(2000) NULL,
    "Expiration" timestamp NULL,
    "Type" varchar(250) NULL,
    "Value" varchar(2000) NOT NULL,
    CONSTRAINT "PK_ClientSecrets" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ClientSecrets_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "IdentityClaims" (
    "Id" serial NOT NULL,
    "IdentityResourceId" int4 NOT NULL,
    "Type" varchar(200) NOT NULL,
    CONSTRAINT "PK_IdentityClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_IdentityClaims_IdentityResources_IdentityResourceId" FOREIGN KEY ("IdentityResourceId") REFERENCES "IdentityResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ApiScopeClaims" (
    "Id" serial NOT NULL,
    "ApiScopeId" int4 NOT NULL,
    "Type" varchar(200) NOT NULL,
    CONSTRAINT "PK_ApiScopeClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ApiScopeClaims_ApiScopes_ApiScopeId" FOREIGN KEY ("ApiScopeId") REFERENCES "ApiScopes" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiClaims_ApiResourceId" ON "ApiClaims" ("ApiResourceId");

CREATE UNIQUE INDEX "IX_ApiResources_Name" ON "ApiResources" ("Name");

CREATE INDEX "IX_ApiScopeClaims_ApiScopeId" ON "ApiScopeClaims" ("ApiScopeId");

CREATE INDEX "IX_ApiScopes_ApiResourceId" ON "ApiScopes" ("ApiResourceId");

CREATE UNIQUE INDEX "IX_ApiScopes_Name" ON "ApiScopes" ("Name");

CREATE INDEX "IX_ApiSecrets_ApiResourceId" ON "ApiSecrets" ("ApiResourceId");

CREATE INDEX "IX_ClientClaims_ClientId" ON "ClientClaims" ("ClientId");

CREATE INDEX "IX_ClientCorsOrigins_ClientId" ON "ClientCorsOrigins" ("ClientId");

CREATE INDEX "IX_ClientGrantTypes_ClientId" ON "ClientGrantTypes" ("ClientId");

CREATE INDEX "IX_ClientIdPRestrictions_ClientId" ON "ClientIdPRestrictions" ("ClientId");

CREATE INDEX "IX_ClientPostLogoutRedirectUris_ClientId" ON "ClientPostLogoutRedirectUris" ("ClientId");

CREATE INDEX "IX_ClientProperties_ClientId" ON "ClientProperties" ("ClientId");

CREATE INDEX "IX_ClientRedirectUris_ClientId" ON "ClientRedirectUris" ("ClientId");

CREATE UNIQUE INDEX "IX_Clients_ClientId" ON "Clients" ("ClientId");

CREATE INDEX "IX_ClientScopes_ClientId" ON "ClientScopes" ("ClientId");

CREATE INDEX "IX_ClientSecrets_ClientId" ON "ClientSecrets" ("ClientId");

CREATE INDEX "IX_IdentityClaims_IdentityResourceId" ON "IdentityClaims" ("IdentityResourceId");

CREATE UNIQUE INDEX "IX_IdentityResources_Name" ON "IdentityResources" ("Name");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171026082702_InitialPostgreSqlConfigurationDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171122163837_UserSearchOptimizationConfigurationDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE "IdentityResources" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "IdentityResources" ADD "NonEditable" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE "IdentityResources" ADD "Updated" timestamp with time zone NULL;

ALTER TABLE "ClientSecrets" ALTER COLUMN "Value" TYPE character varying(4000);

ALTER TABLE "ClientSecrets" ALTER COLUMN "Type" SET NOT NULL;

ALTER TABLE "ClientSecrets" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "Clients" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "Clients" ADD "DeviceCodeLifetime" integer NOT NULL DEFAULT 0;

ALTER TABLE "Clients" ADD "LastAccessed" timestamp with time zone NULL;

ALTER TABLE "Clients" ADD "NonEditable" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE "Clients" ADD "Updated" timestamp with time zone NULL;

ALTER TABLE "Clients" ADD "UserCodeType" character varying(100) NULL;

ALTER TABLE "Clients" ADD "UserSsoLifetime" integer NULL;

ALTER TABLE "ApiSecrets" ALTER COLUMN "Value" TYPE character varying(4000);
ALTER TABLE "ApiSecrets" ALTER COLUMN "Value" SET NOT NULL;

ALTER TABLE "ApiSecrets" ALTER COLUMN "Type" SET NOT NULL;

ALTER TABLE "ApiSecrets" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "ApiResources" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "ApiResources" ADD "LastAccessed" timestamp with time zone NULL;

ALTER TABLE "ApiResources" ADD "NonEditable" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE "ApiResources" ADD "Updated" timestamp with time zone NULL;

CREATE TABLE "ApiProperties" (
    "Id" serial NOT NULL,
    "Key" character varying(250) NOT NULL,
    "Value" character varying(2000) NOT NULL,
    "ApiResourceId" integer NOT NULL,
    CONSTRAINT "PK_ApiProperties" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ApiProperties_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "IdentityProperties" (
    "Id" serial NOT NULL,
    "Key" character varying(250) NOT NULL,
    "Value" character varying(2000) NOT NULL,
    "IdentityResourceId" integer NOT NULL,
    CONSTRAINT "PK_IdentityProperties" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_IdentityProperties_IdentityResources_IdentityResourceId" FOREIGN KEY ("IdentityResourceId") REFERENCES "IdentityResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiProperties_ApiResourceId" ON "ApiProperties" ("ApiResourceId");

CREATE INDEX "IX_IdentityProperties_IdentityResourceId" ON "IdentityProperties" ("IdentityResourceId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20181112154834_IdentityServer2.3PostgreSqlConfigurationDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20200702113308_UpdateIdColumnsPostgreSqlConfigurationDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

-- Add New Tables


-- Add ApiResourceScopes

CREATE TABLE "ApiResourceScopes" (
    "Id" SERIAL,
    "Scope" character varying(200) NOT NULL,
    "ApiResourceId" integer NOT NULL,
    CONSTRAINT "PK_ApiResourceScopes" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ApiResourceScopes_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiResourceScopes_ApiResourceId" ON "ApiResourceScopes" ("ApiResourceId");



-- Add ApiScopeProperties

CREATE TABLE "ApiScopeProperties" (
    "Id" SERIAL,
    "Key" character varying(250) NOT NULL,
    "Value" character varying(2000) NOT NULL,
    "ScopeId" integer NOT NULL,
    CONSTRAINT "PK_ApiScopeProperties" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ApiScopeProperties_ApiScopes_ScopeId" FOREIGN KEY ("ScopeId") REFERENCES "ApiScopes" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiScopeProperties_ScopeId" ON "ApiScopeProperties" ("ScopeId");



-- Add Renamed Tables

-- ApiResourceClaims

CREATE TABLE "ApiResourceClaims" (
    "Id" SERIAL,
    "Type" character varying(200) NOT NULL,
    "ApiResourceId" integer NOT NULL,
    CONSTRAINT "PK_ApiResourceClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ApiResourceClaims_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiResourceClaims_ApiResourceId" ON "ApiResourceClaims" ("ApiResourceId");



-- ApiResourceProperties

CREATE TABLE "ApiResourceProperties" (
    "Id" SERIAL,
    "Key" character varying(250) NOT NULL,
    "Value" character varying(2000) NOT NULL,
    "ApiResourceId" integer NOT NULL,
    CONSTRAINT "PK_ApiResourceProperties" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ApiResourceProperties_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiResourceProperties_ApiResourceId" ON "ApiResourceProperties" ("ApiResourceId");



-- Add ApiResourceSecrets

CREATE TABLE "ApiResourceSecrets" (
    "Id" SERIAL,
    "Description" character varying(1000) NULL,
    "Value" character varying(4000) NOT NULL,
    "Expiration" timestamp without time zone NULL,
    "Type" character varying(250) NOT NULL,
    "Created" timestamp without time zone NOT NULL,
    "ApiResourceId" integer NOT NULL,
    CONSTRAINT "PK_ApiResourceSecrets" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ApiResourceSecrets_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiResourceSecrets_ApiResourceId" ON "ApiResourceSecrets" ("ApiResourceId");



-- IdentityResourceClaims

CREATE TABLE "IdentityResourceClaims" (
    "Id" SERIAL,
    "Type" character varying(200) NOT NULL,
    "IdentityResourceId" integer NOT NULL,
    CONSTRAINT "PK_IdentityResourceClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_IdentityResourceClaims_IdentityResources_IdentityResourceId" FOREIGN KEY ("IdentityResourceId") REFERENCES "IdentityResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_IdentityResourceClaims_IdentityResourceId" ON "IdentityResourceClaims" ("IdentityResourceId");



-- IdentityResourceProperties

CREATE TABLE "IdentityResourceProperties" (
    "Id" SERIAL,
    "Key" character varying(250) NOT NULL,
    "Value" character varying(2000) NOT NULL,
    "IdentityResourceId" integer NOT NULL,
    CONSTRAINT "PK_IdentityResourceProperties" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_IdentityResourceProperties_IdentityResources_IdentityResour~" FOREIGN KEY ("IdentityResourceId") REFERENCES "IdentityResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_IdentityResourceProperties_IdentityResourceId" ON "IdentityResourceProperties" ("IdentityResourceId");



-- Migrate Existing Data

--ApiClaims -> ApiResourceClaims

INSERT INTO "ApiResourceClaims"
 ("Id", "Type", "ApiResourceId")
SELECT 
 "Id", "Type", "ApiResourceId"
FROM "ApiClaims";



--ApiProperties -> ApiResourceProperties

INSERT INTO "ApiResourceProperties"
 ("Id", "Key", "Value", "ApiResourceId")
SELECT 
 "Id", "Key", "Value", "ApiResourceId"
FROM "ApiProperties";



--ApiSecrets -> ApiResourceSecrets

INSERT INTO "ApiResourceSecrets"
 ("Id", "Description", "Value", "Expiration", "Type", "Created", "ApiResourceId")
SELECT 
 "Id", "Description", "Value", "Expiration", "Type", "Created", "ApiResourceId"
FROM "ApiSecrets";



--IdentityClaims -> IdentityResourceClaims

INSERT INTO "IdentityResourceClaims"
 ("Id", "Type", "IdentityResourceId")
SELECT 
 "Id", "Type", "IdentityResourceId"
FROM "IdentityClaims";



--IdentityProperties -> IdentityResourceProperties

INSERT INTO "IdentityResourceProperties"
 ("Id", "Key", "Value", "IdentityResourceId")
SELECT 
 "Id", "Key", "Value", "IdentityResourceId"
FROM "IdentityProperties";



-- ApiScopes -> ApiResourceScopes
INSERT INTO "ApiResourceScopes"
 ("Scope", "ApiResourceId")
SELECT 
 "Name", "ApiResourceId"
FROM "ApiScopes";

-- Alter Existing Tables

-- ApiResources

ALTER TABLE "ApiResources"
	ADD "AllowedAccessTokenSigningAlgorithms" character varying (100)
	NULL;
	
ALTER TABLE "ApiResources"
	ADD "ShowInDiscoveryDocument" BOOLEAN
	NULL;
	
UPDATE "ApiResources" SET "ShowInDiscoveryDocument" = FALSE;

ALTER TABLE "ApiResources"
	ALTER COLUMN "ShowInDiscoveryDocument" SET NOT NULL;
	
	

-- ApiScopeClaims

ALTER TABLE "ApiScopeClaims"
	DROP CONSTRAINT "FK_ApiScopeClaims_ApiScopes_ApiScopeId";
	
DROP INDEX "IX_ApiScopeClaims_ApiScopeId";
		
ALTER TABLE "ApiScopeClaims" RENAME "ApiScopeId" TO "ScopeId";

CREATE INDEX "IX_ApiScopeClaims_ScopeId" ON "ApiScopeClaims" ("ScopeId");

ALTER TABLE "ApiScopeClaims"
	ADD CONSTRAINT "FK_ApiScopeClaims_ApiScopes_ScopeId" 
	FOREIGN KEY ("ScopeId") REFERENCES "ApiScopes" ("Id") ON DELETE CASCADE;
	

	
-- ApiScopes

ALTER TABLE "ApiScopes"
	DROP CONSTRAINT "FK_ApiScopes_ApiResources_ApiResourceId";
	
DROP INDEX "IX_ApiScopes_ApiResourceId";

ALTER TABLE "ApiScopes"
	ADD "Enabled" BOOLEAN NULL;

UPDATE "ApiScopes" SET "Enabled" = TRUE;

ALTER TABLE "ApiScopes"
	ALTER COLUMN "Enabled" SET NOT NULL;
	
ALTER TABLE "ApiScopes"
	DROP COLUMN "ApiResourceId";
	
-- Clients

ALTER TABLE "Clients"
	ADD "AllowedIdentityTokenSigningAlgorithms" character varying(100) NULL;
	
ALTER TABLE "Clients"
	ADD "RequireRequestObject" BOOLEAN NULL;
	
UPDATE "Clients" SET "RequireRequestObject" = FALSE;
	
ALTER TABLE "Clients"
	ALTER COLUMN "RequireRequestObject" SET NOT NULL;



-- Delete Old Tables

DROP TABLE "ApiClaims";
DROP TABLE "ApiProperties";
DROP TABLE "ApiSecrets";
DROP TABLE "IdentityClaims";
DROP TABLE "IdentityProperties";

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20200702113402_V3toV4PostgreSqlConfigurationDbMigration', '6.0.3');

COMMIT;

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
    "Description" text NULL,
    "NormalizedClientId" varchar(200) NOT NULL,
    "NormalizedClientName" varchar(200) NULL,
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
VALUES ('20171026082855_InitialPostgreSqlExtendedConfigurationDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171122163921_UserSearchOptimizationExtendedConfigurationDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

CREATE TABLE "ConfigurationEntries" (
    "Key" text NOT NULL,
    "Value" text NULL,
    CONSTRAINT "PK_ConfigurationEntries" PRIMARY KEY ("Key")
);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20180724143733_ConfigurationEntries', '6.0.3');

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
VALUES ('20181205165028_ExtendedDataMigration2.3', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE "ExtendedClients" ADD "ClientType" integer NULL;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20190401105052_ClientType', '6.0.3');

COMMIT;

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
    "Expiration" timestamp NULL,
    "SubjectId" varchar(200) NULL,
    "Type" varchar(50) NOT NULL,
    CONSTRAINT "PK_PersistedGrants" PRIMARY KEY ("Key")
);

CREATE INDEX "IX_PersistedGrants_SubjectId_ClientId_Type" ON "PersistedGrants" ("SubjectId", "ClientId", "Type");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171026082436_InitialPostgreSqlOperationalDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171122163955_UserSearchOptimizationOperationalDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

CREATE TABLE "DeviceCodes" (
    "DeviceCode" character varying(200) NOT NULL,
    "UserCode" character varying(200) NOT NULL,
    "SubjectId" character varying(200) NULL,
    "ClientId" character varying(200) NOT NULL,
    "CreationTime" timestamp with time zone NOT NULL,
    "Expiration" timestamp with time zone NOT NULL,
    "Data" character varying(50000) NOT NULL,
    CONSTRAINT "PK_DeviceCodes" PRIMARY KEY ("UserCode")
);

CREATE UNIQUE INDEX "IX_DeviceCodes_DeviceCode" ON "DeviceCodes" ("DeviceCode");

CREATE UNIQUE INDEX "IX_DeviceCodes_UserCode" ON "DeviceCodes" ("UserCode");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20181112154906_IdentityServer2.3PostgreSqlOperationalDbMigration', '6.0.3');

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
VALUES ('20200702113344_V3toV4PostgreSqlOperationalDbMigration', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

ALTER TABLE "ApiResources" ADD "RequireResourceIndicator" boolean NOT NULL DEFAULT FALSE;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20210106163812_DuendePostgreSqlConfigurationMigration', '6.0.3');

COMMIT;

START TRANSACTION;

CREATE TABLE "IdentityProviders" (
    "Id" serial NOT NULL,
    "Scheme" character varying(200) NOT NULL,
    "DisplayName" character varying(200) NULL,
    "Enabled" boolean NOT NULL,
    "Type" character varying(20) NOT NULL,
    "Properties" text NULL,
    CONSTRAINT "PK_IdentityProviders" PRIMARY KEY ("Id")
);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20210602105114_IdentityProvidersPostgreSqlConfigurationMigration', '6.0.3');

COMMIT;

START TRANSACTION;

DROP INDEX "IX_IdentityResourceProperties_IdentityResourceId";

DROP INDEX "IX_IdentityResourceClaims_IdentityResourceId";

DROP INDEX "IX_ClientScopes_ClientId";

DROP INDEX "IX_ClientRedirectUris_ClientId";

DROP INDEX "IX_ClientProperties_ClientId";

DROP INDEX "IX_ClientPostLogoutRedirectUris_ClientId";

DROP INDEX "IX_ClientIdPRestrictions_ClientId";

DROP INDEX "IX_ClientGrantTypes_ClientId";

DROP INDEX "IX_ClientCorsOrigins_ClientId";

DROP INDEX "IX_ClientClaims_ClientId";

DROP INDEX "IX_ApiScopeProperties_ScopeId";

DROP INDEX "IX_ApiScopeClaims_ScopeId";

DROP INDEX "IX_ApiResourceScopes_ApiResourceId";

DROP INDEX "IX_ApiResourceProperties_ApiResourceId";

DROP INDEX "IX_ApiResourceClaims_ApiResourceId";

ALTER TABLE "IdentityResources" ALTER COLUMN "Updated" TYPE timestamp with time zone;

ALTER TABLE "IdentityResources" ALTER COLUMN "Created" TYPE timestamp with time zone;

ALTER TABLE "IdentityProviders" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "IdentityProviders" ADD "LastAccessed" timestamp with time zone NULL;

ALTER TABLE "IdentityProviders" ADD "NonEditable" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE "IdentityProviders" ADD "Updated" timestamp with time zone NULL;

ALTER TABLE "ClientSecrets" ALTER COLUMN "Expiration" TYPE timestamp with time zone;

ALTER TABLE "ClientSecrets" ALTER COLUMN "Created" TYPE timestamp with time zone;

ALTER TABLE "Clients" ALTER COLUMN "Updated" TYPE timestamp with time zone;

ALTER TABLE "Clients" ALTER COLUMN "LastAccessed" TYPE timestamp with time zone;

ALTER TABLE "Clients" ALTER COLUMN "Created" TYPE timestamp with time zone;

ALTER TABLE "Clients" ADD "CibaLifetime" integer NULL;

ALTER TABLE "Clients" ADD "PollingInterval" integer NULL;

ALTER TABLE "ClientRedirectUris" ALTER COLUMN "RedirectUri" TYPE character varying(400);

ALTER TABLE "ClientPostLogoutRedirectUris" ALTER COLUMN "PostLogoutRedirectUri" TYPE character varying(400);

ALTER TABLE "ApiScopes" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "ApiScopes" ADD "LastAccessed" timestamp with time zone NULL;

ALTER TABLE "ApiScopes" ADD "NonEditable" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE "ApiScopes" ADD "Updated" timestamp with time zone NULL;

ALTER TABLE "ApiResourceSecrets" ALTER COLUMN "Expiration" TYPE timestamp with time zone;

ALTER TABLE "ApiResourceSecrets" ALTER COLUMN "Created" TYPE timestamp with time zone;

ALTER TABLE "ApiResources" ALTER COLUMN "Updated" TYPE timestamp with time zone;

ALTER TABLE "ApiResources" ALTER COLUMN "LastAccessed" TYPE timestamp with time zone;

ALTER TABLE "ApiResources" ALTER COLUMN "Created" TYPE timestamp with time zone;

CREATE UNIQUE INDEX "IX_IdentityResourceProperties_IdentityResourceId_Key" ON "IdentityResourceProperties" ("IdentityResourceId", "Key");

CREATE UNIQUE INDEX "IX_IdentityResourceClaims_IdentityResourceId_Type" ON "IdentityResourceClaims" ("IdentityResourceId", "Type");

CREATE UNIQUE INDEX "IX_IdentityProviders_Scheme" ON "IdentityProviders" ("Scheme");

CREATE UNIQUE INDEX "IX_ClientScopes_ClientId_Scope" ON "ClientScopes" ("ClientId", "Scope");

CREATE UNIQUE INDEX "IX_ClientRedirectUris_ClientId_RedirectUri" ON "ClientRedirectUris" ("ClientId", "RedirectUri");

CREATE UNIQUE INDEX "IX_ClientProperties_ClientId_Key" ON "ClientProperties" ("ClientId", "Key");

CREATE UNIQUE INDEX "IX_ClientPostLogoutRedirectUris_ClientId_PostLogoutRedirectUri" ON "ClientPostLogoutRedirectUris" ("ClientId", "PostLogoutRedirectUri");

CREATE UNIQUE INDEX "IX_ClientIdPRestrictions_ClientId_Provider" ON "ClientIdPRestrictions" ("ClientId", "Provider");

CREATE UNIQUE INDEX "IX_ClientGrantTypes_ClientId_GrantType" ON "ClientGrantTypes" ("ClientId", "GrantType");

CREATE UNIQUE INDEX "IX_ClientCorsOrigins_ClientId_Origin" ON "ClientCorsOrigins" ("ClientId", "Origin");

CREATE UNIQUE INDEX "IX_ClientClaims_ClientId_Type_Value" ON "ClientClaims" ("ClientId", "Type", "Value");

CREATE UNIQUE INDEX "IX_ApiScopeProperties_ScopeId_Key" ON "ApiScopeProperties" ("ScopeId", "Key");

CREATE UNIQUE INDEX "IX_ApiScopeClaims_ScopeId_Type" ON "ApiScopeClaims" ("ScopeId", "Type");

CREATE UNIQUE INDEX "IX_ApiResourceScopes_ApiResourceId_Scope" ON "ApiResourceScopes" ("ApiResourceId", "Scope");

CREATE UNIQUE INDEX "IX_ApiResourceProperties_ApiResourceId_Key" ON "ApiResourceProperties" ("ApiResourceId", "Key");

CREATE UNIQUE INDEX "IX_ApiResourceClaims_ApiResourceId_Type" ON "ApiResourceClaims" ("ApiResourceId", "Type");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20220104130806_DuendeV6PostgreSqlConfigurationMigration', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE "Clients" ADD "CoordinateLifetimeWithUserSession" boolean NULL;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20220608093254_Duende61ConfigurationUpdate', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "Keys" (
    "Id" text NOT NULL,
    "Version" integer NOT NULL,
    "Created" timestamp without time zone NOT NULL,
    "Use" text NULL,
    "Algorithm" character varying(100) NOT NULL,
    "IsX509Certificate" boolean NOT NULL,
    "DataProtected" boolean NOT NULL,
    "Data" text NOT NULL,
    CONSTRAINT "PK_Keys" PRIMARY KEY ("Id")
);

CREATE INDEX "IX_Keys_Use" ON "Keys" ("Use");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20210106150433_DuendePostgreSqlOperationalMigration', '6.0.3');

COMMIT;

START TRANSACTION;

CREATE INDEX "IX_PersistedGrants_ConsumedTime" ON "PersistedGrants" ("ConsumedTime");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20210602110147_PersistedGrantConsumeTimePostgreSqlOperationalMigration', '6.0.3');

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
    "SessionId" character varying(100) NULL,
    "DisplayName" character varying(100) NULL,
    "Created" timestamp with time zone NOT NULL,
    "Renewed" timestamp with time zone NOT NULL,
    "Expires" timestamp with time zone NULL,
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
VALUES ('20220608092054_Duende61Update', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "AuditEntries" (
    "Id" bigserial NOT NULL,
    "When" timestamp with time zone NOT NULL,
    "Source" text NULL,
    "SubjectType" text NULL,
    "SubjectIdentifier" text NULL,
    "Subject" text NULL,
    "Action" text NULL,
    "ResourceType" text NULL,
    "Resource" text NULL,
    "ResourceIdentifier" text NULL,
    "Succeeded" boolean NOT NULL,
    "Description" text NULL,
    "NormalisedSubject" text NULL,
    "NormalisedAction" text NULL,
    "NormalisedResource" text NULL,
    "NormalisedSource" text NULL,
    CONSTRAINT "PK_AuditEntries" PRIMARY KEY ("Id")
);

CREATE INDEX "IX_AuditEntries_When" ON "AuditEntries" ("When");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20181220155915_InitalPostgreSqlAuditDbMigration', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "AspNetClaimTypes" (
    "Id" text NOT NULL,
    "ConcurrencyStamp" text NULL,
    "Description" text NULL,
    "Name" varchar(256) NOT NULL,
    "NormalizedName" varchar(256) NULL,
    "Required" bool NOT NULL,
    "Reserved" bool NOT NULL,
    "Rule" text NULL,
    "RuleValidationFailureDescription" text NULL,
    "UserEditable" bool NOT NULL DEFAULT FALSE,
    "ValueType" int4 NOT NULL,
    CONSTRAINT "PK_AspNetClaimTypes" PRIMARY KEY ("Id"),
    CONSTRAINT "AK_AspNetClaimTypes_Name" UNIQUE ("Name")
);

CREATE TABLE "AspNetRoles" (
    "Id" text NOT NULL,
    "ConcurrencyStamp" text NULL,
    "Description" text NULL,
    "Name" varchar(256) NULL,
    "NormalizedName" varchar(256) NULL,
    "Reserved" bool NOT NULL,
    CONSTRAINT "PK_AspNetRoles" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetUsers" (
    "Id" text NOT NULL,
    "AccessFailedCount" int4 NOT NULL,
    "ConcurrencyStamp" text NULL,
    "Email" varchar(256) NULL,
    "EmailConfirmed" bool NOT NULL,
    "FirstName" text NULL,
    "IsBlocked" bool NOT NULL,
    "IsDeleted" bool NOT NULL,
    "LastName" text NULL,
    "LockoutEnabled" bool NOT NULL,
    "LockoutEnd" timestamptz NULL,
    "NormalizedEmail" varchar(256) NULL,
    "NormalizedUserName" varchar(256) NULL,
    "PasswordHash" text NULL,
    "PhoneNumber" text NULL,
    "PhoneNumberConfirmed" bool NOT NULL,
    "SecurityStamp" text NULL,
    "TwoFactorEnabled" bool NOT NULL,
    "UserName" varchar(256) NULL,
    CONSTRAINT "PK_AspNetUsers" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetRoleClaims" (
    "Id" serial NOT NULL,
    "ClaimType" text NULL,
    "ClaimValue" text NULL,
    "RoleId" text NOT NULL,
    CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserClaims" (
    "Id" serial NOT NULL,
    "ClaimType" varchar(256) NOT NULL,
    "ClaimValue" text NULL,
    "UserId" text NOT NULL,
    CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetUserClaims_AspNetClaimTypes_ClaimType" FOREIGN KEY ("ClaimType") REFERENCES "AspNetClaimTypes" ("Name") ON DELETE CASCADE,
    CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserLogins" (
    "LoginProvider" text NOT NULL,
    "ProviderKey" text NOT NULL,
    "ProviderDisplayName" text NULL,
    "UserId" text NOT NULL,
    CONSTRAINT "PK_AspNetUserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey"),
    CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserRoles" (
    "UserId" text NOT NULL,
    "RoleId" text NOT NULL,
    CONSTRAINT "PK_AspNetUserRoles" PRIMARY KEY ("UserId", "RoleId"),
    CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserTokens" (
    "UserId" text NOT NULL,
    "LoginProvider" text NOT NULL,
    "Name" text NOT NULL,
    "Value" text NULL,
    CONSTRAINT "PK_AspNetUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name"),
    CONSTRAINT "FK_AspNetUserTokens_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE UNIQUE INDEX "ClaimTypeNameIndex" ON "AspNetClaimTypes" ("NormalizedName");

CREATE INDEX "IX_AspNetRoleClaims_RoleId" ON "AspNetRoleClaims" ("RoleId");

CREATE UNIQUE INDEX "RoleNameIndex" ON "AspNetRoles" ("NormalizedName");

CREATE INDEX "IX_AspNetUserClaims_ClaimType" ON "AspNetUserClaims" ("ClaimType");

CREATE INDEX "IX_AspNetUserClaims_UserId" ON "AspNetUserClaims" ("UserId");

CREATE INDEX "IX_AspNetUserLogins_UserId" ON "AspNetUserLogins" ("UserId");

CREATE INDEX "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles" ("RoleId");

CREATE INDEX "EmailIndex" ON "AspNetUsers" ("NormalizedEmail");

CREATE UNIQUE INDEX "UserNameIndex" ON "AspNetUsers" ("NormalizedUserName");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171026081544_InitialPostgreSqlIdentityDbMigration', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE "AspNetUsers" ADD "NormalizedFirstName" character varying(256) NULL;

ALTER TABLE "AspNetUsers" ADD "NormalizedLastName" character varying(256) NULL;

CREATE INDEX "FirstNameIndex" ON "AspNetUsers" ("NormalizedFirstName");

CREATE INDEX "LastNameIndex" ON "AspNetUsers" ("NormalizedLastName");

CREATE INDEX "CountIndex" ON "AspNetUsers" ("IsBlocked", "IsDeleted");

CREATE INDEX "CountIndexReversed" ON "AspNetUsers" ("IsDeleted", "IsBlocked");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171122162832_UserSearchOptimizationMigration', '6.0.3');

COMMIT;

START TRANSACTION;

CREATE TABLE "EnumClaimTypeAllowedValues" (
    "ClaimTypeId" text NOT NULL,
    "Value" text NOT NULL,
    CONSTRAINT "PK_EnumClaimTypeAllowedValues" PRIMARY KEY ("ClaimTypeId", "Value"),
    CONSTRAINT "FK_EnumClaimTypeAllowedValues_AspNetClaimTypes_ClaimTypeId" FOREIGN KEY ("ClaimTypeId") REFERENCES "AspNetClaimTypes" ("Id") ON DELETE CASCADE
);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20210430142540_EnumeratedClaimTypeMigration', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE "AspNetClaimTypes" ADD "DisplayName" text NULL;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20220112114931_ClaimTypeDisplayNameMigration', '6.0.3');

COMMIT;

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
VALUES ('20220114164545_PostgreSqlSamlArtifactInitialMigration', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "ServiceProviders" (
    "Id" serial NOT NULL,
    "EntityId" character varying(200) NOT NULL,
    "EncryptionCertificate" bytea NULL,
    "SignAssertions" boolean NOT NULL,
    "EncryptAssertions" boolean NOT NULL,
    "RequireSamlRequestDestination" boolean NOT NULL,
    CONSTRAINT "PK_ServiceProviders" PRIMARY KEY ("Id")
);

CREATE TABLE "ServiceProviderAssertionConsumerServices" (
    "Id" serial NOT NULL,
    "Binding" character varying(2000) NOT NULL,
    "Location" character varying(2000) NOT NULL,
    "Index" integer NOT NULL,
    "IsDefault" boolean NOT NULL,
    "ServiceProviderId" integer NOT NULL,
    CONSTRAINT "PK_ServiceProviderAssertionConsumerServices" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ServiceProviderAssertionConsumerServices_ServiceProviders_S~" FOREIGN KEY ("ServiceProviderId") REFERENCES "ServiceProviders" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ServiceProviderClaimMappings" (
    "Id" serial NOT NULL,
    "OriginalClaimType" character varying(250) NOT NULL,
    "NewClaimType" character varying(250) NOT NULL,
    "ServiceProviderId" integer NOT NULL,
    CONSTRAINT "PK_ServiceProviderClaimMappings" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ServiceProviderClaimMappings_ServiceProviders_ServiceProvid~" FOREIGN KEY ("ServiceProviderId") REFERENCES "ServiceProviders" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ServiceProviderSignCertificates" (
    "Id" serial NOT NULL,
    "Certificate" bytea NOT NULL,
    "ServiceProviderId" integer NOT NULL,
    CONSTRAINT "PK_ServiceProviderSignCertificates" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ServiceProviderSignCertificates_ServiceProviders_ServicePro~" FOREIGN KEY ("ServiceProviderId") REFERENCES "ServiceProviders" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ServiceProviderSingleLogoutServices" (
    "Id" serial NOT NULL,
    "Binding" character varying(2000) NOT NULL,
    "Location" character varying(2000) NOT NULL,
    "Index" integer NOT NULL,
    "IsDefault" boolean NOT NULL,
    "ServiceProviderId" integer NOT NULL,
    CONSTRAINT "PK_ServiceProviderSingleLogoutServices" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ServiceProviderSingleLogoutServices_ServiceProviders_Servic~" FOREIGN KEY ("ServiceProviderId") REFERENCES "ServiceProviders" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ServiceProviderAssertionConsumerServices_ServiceProviderId" ON "ServiceProviderAssertionConsumerServices" ("ServiceProviderId");

CREATE INDEX "IX_ServiceProviderClaimMappings_ServiceProviderId" ON "ServiceProviderClaimMappings" ("ServiceProviderId");

CREATE UNIQUE INDEX "IX_ServiceProviders_EntityId" ON "ServiceProviders" ("EntityId");

CREATE INDEX "IX_ServiceProviderSignCertificates_ServiceProviderId" ON "ServiceProviderSignCertificates" ("ServiceProviderId");

CREATE INDEX "IX_ServiceProviderSingleLogoutServices_ServiceProviderId" ON "ServiceProviderSingleLogoutServices" ("ServiceProviderId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20190305133319_PostgreSqlSaml2PInitial', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE "ServiceProviders" ADD "AllowIdpInitiatedSso" boolean NOT NULL DEFAULT FALSE;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20200225104719_Added AllowIdpInitiatedSso', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE "ServiceProviders" ADD "RequireAuthenticationRequestsSigned" boolean NULL;

ALTER TABLE "ServiceProviders" RENAME COLUMN "RequireSamlRequestDestination" TO "RequireSamlMessageDestination";

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20200914074950_RskSamlV3', '6.0.3');

COMMIT;

START TRANSACTION;

ALTER TABLE "ServiceProviders" ADD "ArtifactDeliveryBindingType" text NULL;

ALTER TABLE "ServiceProviders" ADD "NameIdentifierFormat" text NULL;

ALTER TABLE "ServiceProviders" ADD "RequireSignedArtifactResolveRequests" boolean NULL;

ALTER TABLE "ServiceProviders" ADD "RequireSignedArtifactResponses" boolean NULL;

CREATE TABLE "ServiceProviderArtifactResolutionServices" (
    "Id" serial NOT NULL,
    "Binding" character varying(2000) NOT NULL,
    "Location" character varying(2000) NOT NULL,
    "Index" integer NOT NULL,
    "IsDefault" boolean NOT NULL,
    "ServiceProviderId" integer NOT NULL,
    CONSTRAINT "PK_ServiceProviderArtifactResolutionServices" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ServiceProviderArtifactResolutionServices_ServiceProviders_~" FOREIGN KEY ("ServiceProviderId") REFERENCES "ServiceProviders" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ServiceProviderArtifactResolutionServices_ServiceProviderId" ON "ServiceProviderArtifactResolutionServices" ("ServiceProviderId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20220128115407_RskSamlPackageUpdate', '6.0.3');

COMMIT;

CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "RelyingParties" (
    "Id" serial NOT NULL,
    "Realm" character varying(200) NOT NULL,
    "TokenType" text NULL,
    "SignatureAlgorithm" text NULL,
    "DigestAlgorithm" text NULL,
    "SamlNameIdentifierFormat" text NULL,
    CONSTRAINT "PK_RelyingParties" PRIMARY KEY ("Id")
);

CREATE TABLE "RelyingPartyClaimMappings" (
    "Id" serial NOT NULL,
    "OriginalClaimType" character varying(250) NOT NULL,
    "NewClaimType" character varying(250) NOT NULL,
    "RelyingPartyId" integer NOT NULL,
    CONSTRAINT "PK_RelyingPartyClaimMappings" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_RelyingPartyClaimMappings_RelyingParties_RelyingPartyId" FOREIGN KEY ("RelyingPartyId") REFERENCES "RelyingParties" ("Id") ON DELETE CASCADE
);

CREATE UNIQUE INDEX "IX_RelyingParties_Realm" ON "RelyingParties" ("Realm");

CREATE INDEX "IX_RelyingPartyClaimMappings_RelyingPartyId" ON "RelyingPartyClaimMappings" ("RelyingPartyId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20190305133422_PostgreSqlWsfederationInitial', '6.0.3');

COMMIT;

