CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "AuditEntries" (
    "Id" bigserial NOT NULL,
    "When" timestamp with time zone NOT NULL,
    "Source" text,
    "SubjectType" text,
    "SubjectIdentifier" text,
    "Subject" text,
    "Action" text,
    "ResourceType" text,
    "Resource" text,
    "ResourceIdentifier" text,
    "Succeeded" boolean NOT NULL,
    "Description" text,
    "NormalisedSubject" text,
    "NormalisedAction" text,
    "NormalisedResource" text,
    "NormalisedSource" text,
    CONSTRAINT "PK_AuditEntries" PRIMARY KEY ("Id")
);

CREATE INDEX "IX_AuditEntries_When" ON "AuditEntries" ("When");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20181220155915_InitalPostgreSqlAuditDbMigration', '8.0.2');

COMMIT;

