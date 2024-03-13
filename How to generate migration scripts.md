# GENERATE MIGRATION SCRIPTS

Before running the migration scripts you need 2 things:
1. Add Microsoft.EntityFrameworkCore.Design package
2. Make sure you have the right the DbProvider and the ConnectionStrings in the appsettings.json file

Migration scripts in order:
1. Duende - Configuration: Default Duende migration. You don't need if you have generated them already. 
2. Duende - Operational: Default Duende migration. You don't need if you have generated them already. 
3. AdminUI - Extended configuration: Essential for running AdminUI.
4. AdminUI - Audits: This is needed for audits tab.
5. ASPNETCore - Identity: You don't need if you use custom identity or have generated them already.
6. RSK - SAML Artifacts: You don't need if you don't want to use SAML.
7. RSK - SAML Configuration: You don't need if you don't want to use SAML.
8. RSK - WSFederation: You don't need if you don't want to use WSFederation.


## SqlServer scripts:

dotnet ef migrations script --context DuendeSqlServerConfigurationDbContext --output ./Migration_Scripts/SqlServer_DuendeSqlServerConfigurationDbContext.txt
dotnet ef migrations script --context DuendeSqlServerOperationalDbContext --output ./Migration_Scripts/SqlServer_DuendeSqlServerOperationalDbContext.txt

dotnet ef migrations script --context DuendeSqlServerExtendedConfigurationDbContext --output ./Migration_Scripts/SqlServer_DuendeSqlServerExtendedConfigurationDbContext.txt
dotnet ef migrations script --context SqlServerAuditDbContext --output ./Migration_Scripts/SqlServer_SqlServerAuditDbContext.txt

dotnet ef migrations script --context SqlServerIdentityDbContext --output ./Migration_Scripts/SqlServer_SqlServerIdentityDbContext.txt

dotnet ef migrations script --context SqlServerSamlArtifactDbContext --output ./Migration_Scripts/SqlServer_SqlServerSamlArtifactDbContext.txt
dotnet ef migrations script --context SqlServerSamlConfigurationDbContext --output ./Migration_Scripts/SqlServer_SqlServerSamlConfigurationDbContext.txt
dotnet ef migrations script --context SqlServerWsFederationConfigurationDbContext --output ./Migration_Scripts/SqlServer_SqlServerWsFederationConfigurationDbContext.txt


## MySql scripts:

dotnet ef migrations script --context DuendeMySqlConfigurationDbContext --output ./Migration_Scripts/MySql_DuendeMySqlConfigurationDbContext.txt
dotnet ef migrations script --context DuendeMySqlOperationalDbContext --output ./Migration_Scripts/MySql_DuendeMySqlOperationalDbContext.txt

dotnet ef migrations script --context DuendeMySqlExtendedConfigurationDbContext --output ./Migration_Scripts/MySql_DuendeMySqlExtendedConfigurationDbContext.txt
dotnet ef migrations script --context MySqlAuditDbContext --output ./Migration_Scripts/MySql_MySqlAuditDbContext.txt

dotnet ef migrations script --context MySqlIdentityDbContext --output ./Migration_Scripts/MySql_MySqlIdentityDbContext.txt

dotnet ef migrations script --context MySqlSamlArtifactDbContext --output ./Migration_Scripts/MySql_MySqlSamlArtifactDbContext.txt
dotnet ef migrations script --context MySqlSamlConfigurationDbContext --output ./Migration_Scripts/MySql_MySqlSamlConfigurationDbContext.txt
dotnet ef migrations script --context MySqlWsFederationConfigurationDbContext --output ./Migration_Scripts/MySql_MySqlWsFederationConfigurationDbContext.txt


## PostgreSql scripts:

dotnet ef migrations script --context DuendePostgreSqlConfigurationDbContext --output ./Migration_Scripts/PostgreSql_DuendePostgreSqlConfigurationDbContext.txt
dotnet ef migrations script --context DuendePostgreSqlOperationalDbContext --output ./Migration_Scripts/PostgreSql_DuendePostgreSqlOperationalDbContext.txt

dotnet ef migrations script --context DuendePostgreSqlExtendedConfigurationDbContext --output ./Migration_Scripts/PostgreSql_DuendePostgreSqlExtendedConfigurationDbContext.txt
dotnet ef migrations script --context PostgreSqlAuditDbContext --output ./Migration_Scripts/PostgreSql_PostgreSqlAuditDbContext.txt

dotnet ef migrations script --context PostgreSqlIdentityDbContext --output ./Migration_Scripts/PostgreSql_PostgreSqlIdentityDbContext.txt

dotnet ef migrations script --context PostgreSqlSamlArtifactDbContext --output ./Migration_Scripts/PostgreSql_PostgreSqlSamlArtifactDbContext.txt
dotnet ef migrations script --context PostgreSqlSamlConfigurationDbContext --output ./Migration_Scripts/PostgreSql_PostgreSqlSamlConfigurationDbContext.txt
dotnet ef migrations script --context PostgreSqlWsFederationConfigurationDbContext --output ./Migration_Scripts/PostgreSql_PostgreSqlWsFederationConfigurationDbContext.txt
