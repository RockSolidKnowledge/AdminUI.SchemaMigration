-- Make sure the target schema exists
CREATE SCHEMA IF NOT EXISTS guest;

-- Move the tables from public to guest
ALTER TABLE public."ExtendedClients" SET SCHEMA guest;
ALTER TABLE public."ExtendedApiResources" SET SCHEMA guest;
ALTER TABLE public."ExtendedIdentityResources" SET SCHEMA guest;
ALTER TABLE public."ConfigurationEntries" SET SCHEMA guest;

ALTER TABLE public."Clients" SET SCHEMA guest;
ALTER TABLE public."ClientGrantTypes" SET SCHEMA guest;
ALTER TABLE public."ClientRedirectUris" SET SCHEMA guest;
ALTER TABLE public."ClientPostLogoutRedirectUris" SET SCHEMA guest;
ALTER TABLE public."ClientScopes" SET SCHEMA guest;
ALTER TABLE public."ClientSecrets" SET SCHEMA guest;
ALTER TABLE public."ClientClaims" SET SCHEMA guest;
ALTER TABLE public."ClientIdPRestrictions" SET SCHEMA guest;
ALTER TABLE public."ClientCorsOrigins" SET SCHEMA guest;
ALTER TABLE public."ClientProperties" SET SCHEMA guest;

ALTER TABLE public."IdentityResources" SET SCHEMA guest;
ALTER TABLE public."IdentityResourceClaims" SET SCHEMA guest;
ALTER TABLE public."IdentityResourceProperties" SET SCHEMA guest;
ALTER TABLE public."IdentityProviders" SET SCHEMA guest;

ALTER TABLE public."ApiResources" SET SCHEMA guest;
ALTER TABLE public."ApiResourceSecrets" SET SCHEMA guest;
ALTER TABLE public."ApiResourceScopes" SET SCHEMA guest;
ALTER TABLE public."ApiResourceClaims" SET SCHEMA guest;
ALTER TABLE public."ApiResourceProperties" SET SCHEMA guest;

ALTER TABLE public."ApiScopes" SET SCHEMA guest;
ALTER TABLE public."ApiScopeClaims" SET SCHEMA guest;
ALTER TABLE public."ApiScopeProperties" SET SCHEMA guest;
