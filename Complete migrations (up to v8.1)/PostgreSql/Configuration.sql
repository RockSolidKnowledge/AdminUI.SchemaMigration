CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "ApiResources" (
    "Id" serial NOT NULL,
    "Description" varchar(1000),
    "DisplayName" varchar(200),
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
    "BackChannelLogoutUri" varchar(2000),
    "ClientClaimsPrefix" varchar(200),
    "ClientId" varchar(200) NOT NULL,
    "ClientName" varchar(200),
    "ClientUri" varchar(2000),
    "ConsentLifetime" int4,
    "Description" varchar(1000),
    "EnableLocalLogin" bool NOT NULL,
    "Enabled" bool NOT NULL,
    "FrontChannelLogoutSessionRequired" bool NOT NULL,
    "FrontChannelLogoutUri" varchar(2000),
    "IdentityTokenLifetime" int4 NOT NULL,
    "IncludeJwtId" bool NOT NULL,
    "LogoUri" varchar(2000),
    "PairWiseSubjectSalt" varchar(200),
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
    "Description" varchar(1000),
    "DisplayName" varchar(200),
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
    "Description" varchar(1000),
    "DisplayName" varchar(200),
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
    "Description" varchar(1000),
    "Expiration" timestamp,
    "Type" varchar(250),
    "Value" varchar(2000),
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
    "Description" varchar(2000),
    "Expiration" timestamp,
    "Type" varchar(250),
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
VALUES ('20171026082702_InitialPostgreSqlConfigurationDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171122163837_UserSearchOptimizationConfigurationDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "IdentityResources" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "IdentityResources" ADD "NonEditable" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE "IdentityResources" ADD "Updated" timestamp with time zone;

ALTER TABLE "ClientSecrets" ALTER COLUMN "Value" TYPE character varying(4000);

ALTER TABLE "ClientSecrets" ALTER COLUMN "Type" SET NOT NULL;

ALTER TABLE "ClientSecrets" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "Clients" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "Clients" ADD "DeviceCodeLifetime" integer NOT NULL DEFAULT 0;

ALTER TABLE "Clients" ADD "LastAccessed" timestamp with time zone;

ALTER TABLE "Clients" ADD "NonEditable" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE "Clients" ADD "Updated" timestamp with time zone;

ALTER TABLE "Clients" ADD "UserCodeType" character varying(100);

ALTER TABLE "Clients" ADD "UserSsoLifetime" integer;

ALTER TABLE "ApiSecrets" ALTER COLUMN "Value" TYPE character varying(4000);
ALTER TABLE "ApiSecrets" ALTER COLUMN "Value" SET NOT NULL;

ALTER TABLE "ApiSecrets" ALTER COLUMN "Type" SET NOT NULL;

ALTER TABLE "ApiSecrets" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "ApiResources" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "ApiResources" ADD "LastAccessed" timestamp with time zone;

ALTER TABLE "ApiResources" ADD "NonEditable" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE "ApiResources" ADD "Updated" timestamp with time zone;

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
VALUES ('20181112154834_IdentityServer2.3PostgreSqlConfigurationDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20200702113308_UpdateIdColumnsPostgreSqlConfigurationDbMigration', '8.0.2');

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
VALUES ('20200702113402_V3toV4PostgreSqlConfigurationDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "ApiResources" ADD "RequireResourceIndicator" boolean NOT NULL DEFAULT FALSE;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20210106163812_DuendePostgreSqlConfigurationMigration', '8.0.2');

COMMIT;

START TRANSACTION;

CREATE TABLE "IdentityProviders" (
    "Id" serial NOT NULL,
    "Scheme" character varying(200) NOT NULL,
    "DisplayName" character varying(200),
    "Enabled" boolean NOT NULL,
    "Type" character varying(20) NOT NULL,
    "Properties" text,
    CONSTRAINT "PK_IdentityProviders" PRIMARY KEY ("Id")
);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20210602105114_IdentityProvidersPostgreSqlConfigurationMigration', '8.0.2');

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

ALTER TABLE "IdentityProviders" ADD "LastAccessed" timestamp with time zone;

ALTER TABLE "IdentityProviders" ADD "NonEditable" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE "IdentityProviders" ADD "Updated" timestamp with time zone;

ALTER TABLE "ClientSecrets" ALTER COLUMN "Expiration" TYPE timestamp with time zone;

ALTER TABLE "ClientSecrets" ALTER COLUMN "Created" TYPE timestamp with time zone;

ALTER TABLE "Clients" ALTER COLUMN "Updated" TYPE timestamp with time zone;

ALTER TABLE "Clients" ALTER COLUMN "LastAccessed" TYPE timestamp with time zone;

ALTER TABLE "Clients" ALTER COLUMN "Created" TYPE timestamp with time zone;

ALTER TABLE "Clients" ADD "CibaLifetime" integer;

ALTER TABLE "Clients" ADD "PollingInterval" integer;

ALTER TABLE "ClientRedirectUris" ALTER COLUMN "RedirectUri" TYPE character varying(400);

ALTER TABLE "ClientPostLogoutRedirectUris" ALTER COLUMN "PostLogoutRedirectUri" TYPE character varying(400);

ALTER TABLE "ApiScopes" ADD "Created" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';

ALTER TABLE "ApiScopes" ADD "LastAccessed" timestamp with time zone;

ALTER TABLE "ApiScopes" ADD "NonEditable" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE "ApiScopes" ADD "Updated" timestamp with time zone;

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
VALUES ('20220104130806_DuendeV6PostgreSqlConfigurationMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "Clients" ADD "CoordinateLifetimeWithUserSession" boolean;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20220608093254_Duende61ConfigurationUpdate', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "Clients" ADD "DPoPClockSkew" interval NOT NULL DEFAULT INTERVAL '00:00:00';

ALTER TABLE "Clients" ADD "DPoPValidationMode" integer NOT NULL DEFAULT 0;

ALTER TABLE "Clients" ADD "InitiateLoginUri" character varying(2000);

ALTER TABLE "Clients" ADD "RequireDPoP" boolean NOT NULL DEFAULT FALSE;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20230620154509_Duende63ConfigurationUpdate', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "Clients" ADD "PushedAuthorizationLifetime" integer;

ALTER TABLE "Clients" ADD "RequirePushedAuthorization" boolean NOT NULL DEFAULT FALSE;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20240105112808_DuendeV7PostgreSqlConfigurationMigration', '8.0.2');

COMMIT;

