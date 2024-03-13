CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "RelyingParties" (
    "Id" serial NOT NULL,
    "Realm" character varying(200) NOT NULL,
    "TokenType" text,
    "SignatureAlgorithm" text,
    "DigestAlgorithm" text,
    "SamlNameIdentifierFormat" text,
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
VALUES ('20190305133422_PostgreSqlWsfederationInitial', '8.0.2');

COMMIT;

