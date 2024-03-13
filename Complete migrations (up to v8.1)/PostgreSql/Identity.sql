CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "AspNetClaimTypes" (
    "Id" text NOT NULL,
    "ConcurrencyStamp" text,
    "Description" text,
    "Name" varchar(256) NOT NULL,
    "NormalizedName" varchar(256),
    "Required" bool NOT NULL,
    "Reserved" bool NOT NULL,
    "Rule" text,
    "RuleValidationFailureDescription" text,
    "UserEditable" bool NOT NULL DEFAULT FALSE,
    "ValueType" int4 NOT NULL,
    CONSTRAINT "PK_AspNetClaimTypes" PRIMARY KEY ("Id"),
    CONSTRAINT "AK_AspNetClaimTypes_Name" UNIQUE ("Name")
);

CREATE TABLE "AspNetRoles" (
    "Id" text NOT NULL,
    "ConcurrencyStamp" text,
    "Description" text,
    "Name" varchar(256),
    "NormalizedName" varchar(256),
    "Reserved" bool NOT NULL,
    CONSTRAINT "PK_AspNetRoles" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetUsers" (
    "Id" text NOT NULL,
    "AccessFailedCount" int4 NOT NULL,
    "ConcurrencyStamp" text,
    "Email" varchar(256),
    "EmailConfirmed" bool NOT NULL,
    "FirstName" text,
    "IsBlocked" bool NOT NULL,
    "IsDeleted" bool NOT NULL,
    "LastName" text,
    "LockoutEnabled" bool NOT NULL,
    "LockoutEnd" timestamptz,
    "NormalizedEmail" varchar(256),
    "NormalizedUserName" varchar(256),
    "PasswordHash" text,
    "PhoneNumber" text,
    "PhoneNumberConfirmed" bool NOT NULL,
    "SecurityStamp" text,
    "TwoFactorEnabled" bool NOT NULL,
    "UserName" varchar(256),
    CONSTRAINT "PK_AspNetUsers" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetRoleClaims" (
    "Id" serial NOT NULL,
    "ClaimType" text,
    "ClaimValue" text,
    "RoleId" text NOT NULL,
    CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserClaims" (
    "Id" serial NOT NULL,
    "ClaimType" varchar(256) NOT NULL,
    "ClaimValue" text,
    "UserId" text NOT NULL,
    CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetUserClaims_AspNetClaimTypes_ClaimType" FOREIGN KEY ("ClaimType") REFERENCES "AspNetClaimTypes" ("Name") ON DELETE CASCADE,
    CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserLogins" (
    "LoginProvider" text NOT NULL,
    "ProviderKey" text NOT NULL,
    "ProviderDisplayName" text,
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
    "Value" text,
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
VALUES ('20171026081544_InitialPostgreSqlIdentityDbMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "AspNetUsers" ADD "NormalizedFirstName" character varying(256);

ALTER TABLE "AspNetUsers" ADD "NormalizedLastName" character varying(256);

CREATE INDEX "FirstNameIndex" ON "AspNetUsers" ("NormalizedFirstName");

CREATE INDEX "LastNameIndex" ON "AspNetUsers" ("NormalizedLastName");

CREATE INDEX "CountIndex" ON "AspNetUsers" ("IsBlocked", "IsDeleted");

CREATE INDEX "CountIndexReversed" ON "AspNetUsers" ("IsDeleted", "IsBlocked");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20171122162832_UserSearchOptimizationMigration', '8.0.2');

COMMIT;

START TRANSACTION;

CREATE TABLE "EnumClaimTypeAllowedValues" (
    "ClaimTypeId" text NOT NULL,
    "Value" text NOT NULL,
    CONSTRAINT "PK_EnumClaimTypeAllowedValues" PRIMARY KEY ("ClaimTypeId", "Value"),
    CONSTRAINT "FK_EnumClaimTypeAllowedValues_AspNetClaimTypes_ClaimTypeId" FOREIGN KEY ("ClaimTypeId") REFERENCES "AspNetClaimTypes" ("Id") ON DELETE CASCADE
);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20210430142540_EnumeratedClaimTypeMigration', '8.0.2');

COMMIT;

START TRANSACTION;

ALTER TABLE "AspNetClaimTypes" ADD "DisplayName" text;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20220112114931_ClaimTypeDisplayNameMigration', '8.0.2');

COMMIT;

