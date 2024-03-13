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

dotnet ef migrations script --context DuendeSqlServerConfigurationDbContext --output ./Migration_Scripts/SqlServer/Configuration.sql
dotnet ef migrations script --context DuendeSqlServerOperationalDbContext --output ./Migration_Scripts/SqlServer/Operational.sql

dotnet ef migrations script --context DuendeSqlServerExtendedConfigurationDbContext --output ./Migration_Scripts/SqlServer/ExtendedConfiguration.sql
dotnet ef migrations script --context SqlServerAuditDbContext --output ./Migration_Scripts/SqlServer/Audit.sql

dotnet ef migrations script --context SqlServerIdentityDbContext --output ./Migration_Scripts/SqlServer/Identity.sql

dotnet ef migrations script --context SqlServerSamlArtifactDbContext --output ./Migration_Scripts/SqlServer/SamlArtifact.sql
dotnet ef migrations script --context SqlServerSamlConfigurationDbContext --output ./Migration_Scripts/SqlServer/SamlConfiguration.sql
dotnet ef migrations script --context SqlServerWsFederationConfigurationDbContext --output ./Migration_Scripts/SqlServer/WsFederationConfiguration.sql


## MySql scripts:

dotnet ef migrations script --context DuendeMySqlConfigurationDbContext --output ./Migration_Scripts/MySql/Configuration.sql
dotnet ef migrations script --context DuendeMySqlOperationalDbContext --output ./Migration_Scripts/MySql/Operational.sql

dotnet ef migrations script --context DuendeMySqlExtendedConfigurationDbContext --output ./Migration_Scripts/MySql/ExtendedConfiguration.sql
dotnet ef migrations script --context MySqlAuditDbContext --output ./Migration_Scripts/MySql/Audit.sql

dotnet ef migrations script --context MySqlIdentityDbContext --output ./Migration_Scripts/MySql/Identity.sql

dotnet ef migrations script --context MySqlSamlArtifactDbContext --output ./Migration_Scripts/MySql/SamlArtifact.sql
dotnet ef migrations script --context MySqlSamlConfigurationDbContext --output ./Migration_Scripts/MySql/SamlConfiguration.sql
dotnet ef migrations script --context MySqlWsFederationConfigurationDbContext --output ./Migration_Scripts/MySql/WsFederationConfiguration.sql


## PostgreSql scripts:

dotnet ef migrations script --context DuendePostgreSqlConfigurationDbContext --output ./Migration_Scripts/PostgreSql/Configuration.sql
dotnet ef migrations script --context DuendePostgreSqlOperationalDbContext --output ./Migration_Scripts/PostgreSql/Operational.sql

dotnet ef migrations script --context DuendePostgreSqlExtendedConfigurationDbContext --output ./Migration_Scripts/PostgreSql/ExtendedConfiguration.sql
dotnet ef migrations script --context PostgreSqlAuditDbContext --output ./Migration_Scripts/PostgreSql/Audit.sql

dotnet ef migrations script --context PostgreSqlIdentityDbContext --output ./Migration_Scripts/PostgreSql/Identity.sql

dotnet ef migrations script --context PostgreSqlSamlArtifactDbContext --output ./Migration_Scripts/PostgreSql/SamlArtifact.sql
dotnet ef migrations script --context PostgreSqlSamlConfigurationDbContext --output ./Migration_Scripts/PostgreSql/SamlConfiguration.sql
dotnet ef migrations script --context PostgreSqlWsFederationConfigurationDbContext --output ./Migration_Scripts/PostgreSql/WsFederationConfiguration.sql
