CREATE SCHEMA IF NOT EXISTS guest;

-- Move the tables
ALTER TABLE public."PersistedGrants" SET SCHEMA guest;
ALTER TABLE public."DeviceCodes" SET SCHEMA guest;
-- ALTER TABLE public."Keys" SET SCHEMA guest;
-- ALTER TABLE public."ServerSideSessions" SET SCHEMA guest;