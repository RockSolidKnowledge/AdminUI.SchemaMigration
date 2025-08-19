START TRANSACTION;

CREATE TABLE "ConfigurationEntries" (
    "Key" text NOT NULL,
    "Value" text NULL,
    CONSTRAINT "PK_ConfigurationEntries" PRIMARY KEY ("Key")
);

INSERT INTO "ConfigurationEntries" ("Key", "Value")
    VALUES ('policy', '{
    "PolicyClaims": [],
    "Version": "07/07/2025 14:01:26 +00:00",
    "ResourceType": "accessPolicy",
    "ResourceIdentifier": "07/07/2025 14:01:26 +00:00"
}');

COMMIT;