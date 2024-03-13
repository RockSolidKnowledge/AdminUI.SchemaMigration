CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "ServiceProviders" (
    "Id" serial NOT NULL,
    "EntityId" character varying(200) NOT NULL,
    "EncryptionCertificate" bytea,
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
VALUES ('20190305133319_PostgreSqlSaml2PInitial', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "ServiceProviders" ADD "AllowIdpInitiatedSso" boolean NOT NULL DEFAULT FALSE;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20200225104719_Added AllowIdpInitiatedSso', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "ServiceProviders" ADD "RequireAuthenticationRequestsSigned" boolean;

ALTER TABLE "ServiceProviders" RENAME COLUMN "RequireSamlRequestDestination" TO "RequireSamlMessageDestination";

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20200914074950_RskSamlV3', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "ServiceProviders" ADD "ArtifactDeliveryBindingType" text;

ALTER TABLE "ServiceProviders" ADD "NameIdentifierFormat" text;

ALTER TABLE "ServiceProviders" ADD "RequireSignedArtifactResolveRequests" boolean;

ALTER TABLE "ServiceProviders" ADD "RequireSignedArtifactResponses" boolean;

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
VALUES ('20220128115407_RskSamlPackageUpdate', '8.0.2');

COMMIT;

