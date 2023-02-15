USE IdentityExpressDb;  
GO
ALTER SCHEMA guest TRANSFER dbo.ExtendedClients;  
ALTER SCHEMA guest TRANSFER dbo.ExtendedApiResources;  
ALTER SCHEMA guest TRANSFER dbo.ExtendedIdentityResources;  
ALTER SCHEMA guest TRANSFER dbo.ConfigurationEntries;  
GO
ALTER SCHEMA guest TRANSFER dbo.Clients;  
ALTER SCHEMA guest TRANSFER dbo.ClientGrantTypes;  
ALTER SCHEMA guest TRANSFER dbo.ClientRedirectUris;  
ALTER SCHEMA guest TRANSFER dbo.ClientPostLogoutRedirectUris;  
ALTER SCHEMA guest TRANSFER dbo.ClientScopes;  
ALTER SCHEMA guest TRANSFER dbo.ClientSecrets;  
ALTER SCHEMA guest TRANSFER dbo.ClientClaims;  
ALTER SCHEMA guest TRANSFER dbo.ClientIdPRestrictions;  
ALTER SCHEMA guest TRANSFER dbo.ClientCorsOrigins;  
ALTER SCHEMA guest TRANSFER dbo.ClientProperties;  
GO  
ALTER SCHEMA guest TRANSFER dbo.IdentityResources;  
ALTER SCHEMA guest TRANSFER dbo.IdentityResourceClaims;  
ALTER SCHEMA guest TRANSFER dbo.IdentityResourceProperties;  
ALTER SCHEMA guest TRANSFER dbo.IdentityProviders;  
GO  
ALTER SCHEMA guest TRANSFER dbo.ApiResources;  
ALTER SCHEMA guest TRANSFER dbo.ApiResourceSecrets;  
ALTER SCHEMA guest TRANSFER dbo.ApiResourceScopes;  
ALTER SCHEMA guest TRANSFER dbo.ApiResourceClaims;  
ALTER SCHEMA guest TRANSFER dbo.ApiResourceProperties;  
GO 
ALTER SCHEMA guest TRANSFER dbo.ApiScopes;  
ALTER SCHEMA guest TRANSFER dbo.ApiScopeClaims;  
ALTER SCHEMA guest TRANSFER dbo.ApiScopeProperties;  
GO 