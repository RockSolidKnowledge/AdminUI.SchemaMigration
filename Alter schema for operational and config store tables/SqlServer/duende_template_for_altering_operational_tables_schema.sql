USE IdentityExpressDb;  
GO
ALTER SCHEMA guest TRANSFER dbo.PersistedGrants;  
ALTER SCHEMA guest TRANSFER dbo.DeviceCodes;  
ALTER SCHEMA guest TRANSFER dbo.Keys;  
ALTER SCHEMA guest TRANSFER dbo.ServerSideSessions;  
GO