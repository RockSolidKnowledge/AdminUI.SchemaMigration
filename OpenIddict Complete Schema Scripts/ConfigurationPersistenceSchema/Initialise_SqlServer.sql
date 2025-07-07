BEGIN TRANSACTION;
GO

CREATE TABLE [dbo].[ConfigurationEntries] (
	[Key] 				   NVARCHAR(450) NOT NULL,
	[Value] 			   NVARCHAR(max) NULL,
	CONSTRAINT [PK_ConfigurationEntries] PRIMARY KEY ([Key])
);

DECLARE @DefaultPolicyJson NVARCHAR(4000) = N'{
    "PolicyClaims": [],
    "Version": "07/07/2025 14:01:26 +00:00",
    "ResourceType": "accessPolicy",
    "ResourceIdentifier": "07/07/2025 14:01:26 +00:00"
}';

INSERT INTO [dbo].[ConfigurationEntries] (Key, Value)
VALUES ('policy', @DefaultPolicyJson);

COMMIT;
GO