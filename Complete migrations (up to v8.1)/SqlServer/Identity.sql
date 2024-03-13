IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [AspNetClaimTypes] (
    [Id] nvarchar(450) NOT NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [Description] nvarchar(max) NULL,
    [Name] nvarchar(256) NOT NULL,
    [NormalizedName] nvarchar(256) NULL,
    [Required] bit NOT NULL,
    [Reserved] bit NOT NULL,
    [Rule] nvarchar(max) NULL,
    [RuleValidationFailureDescription] nvarchar(max) NULL,
    [UserEditable] bit NOT NULL DEFAULT CAST(0 AS bit),
    [ValueType] int NOT NULL,
    CONSTRAINT [PK_AspNetClaimTypes] PRIMARY KEY ([Id]),
    CONSTRAINT [AK_AspNetClaimTypes_Name] UNIQUE ([Name])
);
GO

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [Description] nvarchar(max) NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [Reserved] bit NOT NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [AccessFailedCount] int NOT NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [Email] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [FirstName] nvarchar(max) NULL,
    [IsBlocked] bit NOT NULL,
    [IsDeleted] bit NOT NULL,
    [LastName] nvarchar(max) NULL,
    [LockoutEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [PasswordHash] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [UserName] nvarchar(256) NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY NONCLUSTERED ([Id])
);
GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [ClaimType] nvarchar(256) NOT NULL,
    [ClaimValue] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetClaimTypes_ClaimType] FOREIGN KEY ([ClaimType]) REFERENCES [AspNetClaimTypes] ([Name]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE UNIQUE INDEX [ClaimTypeNameIndex] ON [AspNetClaimTypes] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetUserClaims_ClaimType] ON [AspNetUserClaims] ([ClaimType]);
GO

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
GO

CREATE UNIQUE CLUSTERED INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171026080706_InitialSqlServerIdentityDbMigration', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [AspNetUsers] ADD [NormalizedFirstName] nvarchar(256) NULL;
GO

ALTER TABLE [AspNetUsers] ADD [NormalizedLastName] nvarchar(256) NULL;
GO

CREATE INDEX [FirstNameIndex] ON [AspNetUsers] ([NormalizedFirstName]);
GO

CREATE INDEX [LastNameIndex] ON [AspNetUsers] ([NormalizedLastName]);
GO

CREATE INDEX [CountIndex] ON [AspNetUsers] ([IsBlocked], [IsDeleted]);
GO

CREATE INDEX [CountIndexReversed] ON [AspNetUsers] ([IsDeleted], [IsBlocked]);
GO

CREATE PROCEDURE [dbo].[FindAllUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)
	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END
GO

CREATE PROCEDURE [dbo].[FindActiveUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		  ([IsBlocked] = 0 AND [IsDeleted] = 0)
	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		  ([IsBlocked] = 0 AND [IsDeleted] = 0)
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END
GO

CREATE PROCEDURE [dbo].[FindActiveOrBlockedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		   [IsDeleted] = 0
	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		   [IsDeleted] = 0
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END
GO

CREATE PROCEDURE [dbo].[FindActiveOrDeletedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		   [IsBlocked] = 0
	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		   [IsBlocked] = 0
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END
GO

CREATE PROCEDURE [dbo].[FindBlockedOrDeletedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		  ([IsDeleted] = 1 OR [IsBlocked] = 1)
	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		  ([IsDeleted] = 1 OR [IsBlocked] = 1)
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END
GO

CREATE PROCEDURE [dbo].[FindBlockedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		   [IsBlocked] = 1
	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		   [IsBlocked] = 1
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END
GO

CREATE PROCEDURE [dbo].[FindDeletedUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	SELECT Count(*)
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm) AND
		   [IsDeleted] = 1
	SELECT [Id], 
		   [AccessFailedCount], 
		   [ConcurrencyStamp], 
		   [Email], 
		   [EmailConfirmed], 
		   [FirstName], 
		   [IsBlocked], 
		   [IsDeleted], 
		   [LastName], 
		   [LockoutEnabled], 
		   [LockoutEnd], 
		   [NormalizedEmail], 
		   [NormalizedFirstName], 
		   [NormalizedLastName], 
		   [NormalizedUserName], 
		   [PasswordHash], 
		   [PhoneNumber], 
		   [PhoneNumberConfirmed], 
		   [SecurityStamp], 
		   [TwoFactorEnabled], 
		   [UserName]
	FROM [AspNetUsers]
	WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		   [NormalizedEmail] LIKE @SearchTerm  OR 
		   [NormalizedFirstName] LIKE @SearchTerm  OR 
		   [NormalizedLastName] LIKE @SearchTerm)AND
		   [IsDeleted] = 1
	ORDER BY [UserName]
	OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
END
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171122162730_UserSearchOptimizationMigration', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE VIEW [dbo].[ActiveUsers]
WITH SCHEMABINDING 
AS
SELECT        Id, Email, FirstName, LastName, UserName, NormalizedFirstName, NormalizedLastName, NormalizedUserName, NormalizedEmail
FROM            dbo.AspNetUsers
WHERE        (IsBlocked = 0) AND (IsDeleted = 0)
GO

CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20190723-131653] ON [dbo].[ActiveUsers]
(
   [NormalizedFirstName] ASC,
   [NormalizedLastName] ASC,
   [NormalizedUserName] ASC,
   [NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AspNetUsers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ActiveUsers'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ActiveUsers'
GO

CREATE PROCEDURE [dbo].[FindActiveByRoleWithCount]
	@RoleId nvarchar(450),
	@SearchTerm nvarchar(256) = null, 
	@PageNumber int,
	@PageSize int
AS
BEGIN
/* Searchs for all Active (IsBlocked = 0 && IsDeleted = 0) Users within a role				  */
/* If @SearchTerm is given it will search for LIKE on Email, Username, firstname and lastname */
/* If no @SearchTerm is given it will return all Active Users in that Role					  */
	SET NOCOUNT ON;
	IF @SearchTerm IS null
		BEGIN
		 -- Select Count of all users within role
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
		--Select all users in role with SearchTerm
				SELECT  u.Id,
						u.[Email], 
						u.[FirstName], 
						u.[LastName], 	
						u.[UserName]
				FROM [AspNetUserRoles] ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId			
				WHERE (ur.[RoleId] = @RoleId) 
				ORDER BY u.[UserName]
				OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE --IF @SearchTerm is not Null
		BEGIN
			SET @SearchTerm = UPPER(@SearchTerm) + N'%'
		--Select Count With Search
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
			AND
				([NormalizedUserName] LIKE @SearchTerm  OR 
				[NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm  OR 
				[NormalizedLastName] LIKE @SearchTerm) 
		--Select all users in role with Search
			SELECT u.Id,
					u.[Email], 
					u.[FirstName], 
					u.[LastName], 	
					u.[UserName]
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
				AND
					([NormalizedUserName] LIKE @SearchTerm  OR 
					[NormalizedEmail] LIKE @SearchTerm  OR 
					[NormalizedFirstName] LIKE @SearchTerm  OR 
					[NormalizedLastName] LIKE @SearchTerm) 
			ORDER BY u.[UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

CREATE PROCEDURE [dbo].FindActiveUsersInRoleAndAllActiveUsersWithCount
	@RoleId nvarchar(450),
	@SearchTerm nvarchar(256) = null, 
	@PageNumber int,
	@PageSize int
AS
BEGIN
/* Searchs for all Active (IsBlocked = 0 && IsDeleted = 0) Users and if they are in the role  */
/* If @SearchTerm is given it will search for LIKE on Email, Username, firstname and lastname */
/* If no @SearchTerm is given it will return all Active Users in that Role					  */
	SET NOCOUNT ON;
	IF @SearchTerm IS null
		BEGIN
		  -- Select Count of all users within role
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
	--Get All UserRole Entries with RoleID
		;WITH UserRoles_CTE
		AS
		(
			SELECT ur.[RoleId],
				   ur.[UserId]
			FROM [AspNetUserRoles] ur
			WHERE ur.[RoleId] = @RoleId
		)
		SELECT  u.Id,
				u.[Email], 
				u.[FirstName], 
				u.[LastName], 	
				u.[UserName],
			    CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
		FROM UserRoles_CTE ur
		RIGHT JOIN [ActiveUsers] u
		ON u.Id = ur.UserId			
		ORDER BY u.[UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE -- IF @SearchTerm is not Null
		BEGIN
			SET @SearchTerm = UPPER(@SearchTerm) + N'%'
		--Select Count With Search
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE [NormalizedUserName] LIKE @SearchTerm  OR 
				[NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm  OR 
				[NormalizedLastName] LIKE @SearchTerm
		--Select users in result with Search
			;WITH UserRoles_CTE
			AS
			(
				SELECT ur.[RoleId],
					   ur.[UserId]
				FROM [AspNetUserRoles] ur
				WHERE ur.[RoleId] = @RoleId
			)
			SELECT u.Id,
					u.[Email], 
					u.[FirstName], 
					u.[LastName], 	
					u.[UserName],
					CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
			FROM UserRoles_CTE ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
				AND
					[NormalizedUserName] LIKE @SearchTerm  OR 
					[NormalizedEmail] LIKE @SearchTerm  OR 
					[NormalizedFirstName] LIKE @SearchTerm  OR 
					[NormalizedLastName] LIKE @SearchTerm
			ORDER BY u.[UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190723135545_RoleSearchOptimizationMigration', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER PROCEDURE [dbo].[FindAllUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR 
			       [Id] LIKE @SearchTermLower);
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindActiveUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 0 AND [IsDeleted] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName)  AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindActiveOrBlockedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
					AND [NormalizedLastName] LIKE @LastName) AND [IsDeleted] = 0
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindActiveOrDeletedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%';
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					[IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
				   AND [NormalizedLastName] LIKE @LastName)
				   AND  [IsBlocked] = 0
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)
				   AND [IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindBlockedOrDeletedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1);
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1)
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindBlockedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 1;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsBlocked] = 1
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindDeletedUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm  OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 1;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm  OR 
				   [NormalizedLastName] LIKE @SearchTerm   OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsDeleted] = 1
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200706104335_UserSearchOptimizationUpdateMigration', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER PROCEDURE [dbo].[FindActiveByRoleWithCount]
	@RoleId nvarchar(450),
	@SearchTerm nvarchar(256) = null, 
	@PageNumber int,
	@PageSize int
AS
BEGIN
/* Searchs for all Active (IsBlocked = 0 && IsDeleted = 0) Users within a role				  */
/* If @SearchTerm is given it will search for LIKE on Email, Username, firstname and lastname */
/* If no @SearchTerm is given it will return all Active Users in that Role					  */
	SET NOCOUNT ON;
	IF @SearchTerm IS null
		BEGIN
		 -- Select Count of all users within role
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
		--Select all users in role with SearchTerm
				SELECT  u.Id,
						u.[Email], 
						u.[FirstName], 
						u.[LastName], 	
						u.[UserName]
				FROM [AspNetUserRoles] ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId			
				WHERE (ur.[RoleId] = @RoleId) 
				ORDER BY u.[UserName]
				OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE --IF @SearchTerm is not Null
		BEGIN
            DECLARE @SearchTermLower nvarchar(256);
            SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
			SET @SearchTerm = UPPER(@SearchTerm) + N'%'
			DECLARE @NameSplitCount int;
			SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
			IF(@NameSplitCount = 0)
				BEGIN
								--Select Count With Search
					SELECT Count(*)
					FROM [AspNetUserRoles] ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE (ur.[RoleId] = @RoleId) 
					AND
						([NormalizedUserName] LIKE @SearchTerm  OR 
						[NormalizedEmail] LIKE @SearchTerm  OR 
						[NormalizedFirstName] LIKE @SearchTerm  OR
                         [NormalizedLastName] LIKE @SearchTerm OR
                         [Id] LIKE @SearchTermLower);
				--Select all users in role with Search
					SELECT u.Id,
							u.[Email], 
							u.[FirstName], 
							u.[LastName], 	
							u.[UserName]
					FROM [AspNetUserRoles] ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE (ur.[RoleId] = @RoleId) 
						AND
							([NormalizedUserName] LIKE @SearchTerm  OR 
							[NormalizedEmail] LIKE @SearchTerm  OR 
							[NormalizedFirstName] LIKE @SearchTerm  OR 
							[NormalizedLastName] LIKE @SearchTerm OR
                            [Id] LIKE @SearchTermLower) 
					ORDER BY u.[UserName]
					OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
				END
			ELSE
				BEGIN
					DECLARE @FirstName nvarchar(256);
					DECLARE @FirstNameCount int;
					DECLARE @LastName nvarchar(256);
					SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
					SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
					SELECT Count(*)
					FROM [AspNetUserRoles] ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE (ur.[RoleId] = @RoleId) 
					AND
					   ([NormalizedFirstName] LIKE @FirstName AND
					   [NormalizedLastName] LIKE @LastName)
				--Select all users in role with Search
					SELECT u.Id,
							u.[Email], 
							u.[FirstName], 
							u.[LastName], 	
							u.[UserName]
					FROM [AspNetUserRoles] ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE (ur.[RoleId] = @RoleId) 
					AND
					   ([NormalizedFirstName] LIKE @FirstName AND
					   [NormalizedLastName] LIKE @LastName)
					ORDER BY u.[UserName]
					OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
				END
		END
END
GO

ALTER PROCEDURE [dbo].FindActiveUsersInRoleAndAllActiveUsersWithCount
	@RoleId nvarchar(450),
	@SearchTerm nvarchar(256) = null, 
	@PageNumber int,
	@PageSize int
AS
BEGIN
/* Searchs for all Active (IsBlocked = 0 && IsDeleted = 0) Users and if they are in the role  */
/* If @SearchTerm is given it will search for LIKE on Email, Username, firstname and lastname */
/* If no @SearchTerm is given it will return all Active Users in that Role					  */
	SET NOCOUNT ON;
	IF @SearchTerm IS null
		BEGIN
		  -- Select Count of all users within role
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
	--Get All UserRole Entries with RoleID
		;WITH UserRoles_CTE
		AS
		(
			SELECT ur.[RoleId],
				   ur.[UserId]
			FROM [AspNetUserRoles] ur
			WHERE ur.[RoleId] = @RoleId
		)
		SELECT  u.Id,
				u.[Email], 
				u.[FirstName], 
				u.[LastName], 	
				u.[UserName],
			    CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
		FROM UserRoles_CTE ur
		RIGHT JOIN [ActiveUsers] u
		ON u.Id = ur.UserId			
		ORDER BY u.[UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE -- IF @SearchTerm is not Null
		BEGIN
            DECLARE @SearchTermLower nvarchar(256);
            SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
			SET @SearchTerm = UPPER(@SearchTerm) + N'%'
			DECLARE @NameSplitCount int;
			SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
			IF(@NameSplitCount = 0)
				BEGIN
			--Select Count With Search
					SELECT Count(*)
					FROM [AspNetUserRoles] ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE [NormalizedUserName] LIKE @SearchTerm  OR 
						[NormalizedEmail] LIKE @SearchTerm  OR 
						[NormalizedFirstName] LIKE @SearchTerm  OR 
						[NormalizedLastName] LIKE @SearchTerm OR 
					      [Id] LIKE @SearchTermLower
				--Select users in result with Search
					;WITH UserRoles_CTE
					AS
					(
						SELECT ur.[RoleId],
							   ur.[UserId]
						FROM [AspNetUserRoles] ur
						WHERE ur.[RoleId] = @RoleId
					)
					SELECT u.Id,
							u.[Email], 
							u.[FirstName], 
							u.[LastName], 	
							u.[UserName],
							CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
					FROM UserRoles_CTE ur
					RIGHT JOIN [ActiveUsers] u
					ON u.Id = ur.UserId
					WHERE (ur.[RoleId] = @RoleId) 
						AND
							[NormalizedUserName] LIKE @SearchTerm  OR 
							[NormalizedEmail] LIKE @SearchTerm  OR 
							[NormalizedFirstName] LIKE @SearchTerm  OR 
							[NormalizedLastName] LIKE @SearchTerm OR
					        [Id] LIKE @SearchTermLower
					ORDER BY u.[UserName]
					OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
				END
		ELSE
			BEGIN
				DECLARE @FirstName nvarchar(256);
				DECLARE @FirstNameCount int;
				DECLARE @LastName nvarchar(256);
				SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
				SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))	
				SELECT Count(*)
				FROM [AspNetUserRoles] ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId
				WHERE ([NormalizedFirstName] LIKE @FirstName AND
					   [NormalizedLastName] LIKE @LastName)
			--Select users in result with Search
				;WITH UserRoles_CTE
				AS
				(
					SELECT ur.[RoleId],
							ur.[UserId]
					FROM [AspNetUserRoles] ur
					WHERE ur.[RoleId] = @RoleId
				)
				SELECT u.Id,
						u.[Email], 
						u.[FirstName], 
						u.[LastName], 	
						u.[UserName],
						CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
				FROM UserRoles_CTE ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId
				WHERE ([NormalizedFirstName] LIKE @FirstName AND
					   [NormalizedLastName] LIKE @LastName)
				ORDER BY u.[UserName]
				OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
			END
	END
END
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200706104406_RoleSearchOptimizationUpdateMigration', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [EnumClaimTypeAllowedValues] (
    [ClaimTypeId] nvarchar(450) NOT NULL,
    [Value] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_EnumClaimTypeAllowedValues] PRIMARY KEY ([ClaimTypeId], [Value]),
    CONSTRAINT [FK_EnumClaimTypeAllowedValues_AspNetClaimTypes_ClaimTypeId] FOREIGN KEY ([ClaimTypeId]) REFERENCES [AspNetClaimTypes] ([Id]) ON DELETE CASCADE
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210430141851_EnumeratedClaimTypeMigration', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER PROCEDURE [dbo].[FindAllUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR 
			       [Id] LIKE @SearchTermLower);
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindActiveUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 0 AND [IsDeleted] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName)  AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindActiveOrBlockedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
					AND [NormalizedLastName] LIKE @LastName) AND [IsDeleted] = 0
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindActiveOrDeletedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%';
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 0;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					[IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
				   AND [NormalizedLastName] LIKE @LastName)
				   AND  [IsBlocked] = 0
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)
				   AND [IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindBlockedOrDeletedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1);
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1)
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindBlockedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 1;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsBlocked] = 1
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

ALTER PROCEDURE [dbo].[FindDeletedUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			SELECT Count(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm  OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 1;
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm  OR 
				   [NormalizedLastName] LIKE @SearchTerm   OR
                   [Id] LIKE @SearchTermLower) AND
				   [IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsDeleted] = 1
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20211209115717_AddingIdToStoredProceduresMigration', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [AspNetClaimTypes] ADD [DisplayName] nvarchar(max) NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220110161021_ClaimTypeDisplayNameMigration', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE PROCEDURE [dbo].[FindAllUsersWithCountWithClaimValueSearch] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
				SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
				FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR 
			       [AspNetUsers].[Id] LIKE @SearchTermLower OR
				   CTE_ClaimSearch.[UserId] IS NOT NULL);
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
				SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
				FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
			SELECT [AspNetUsers].[Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON
			CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id]
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [AspNetUsers].[Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

CREATE PROCEDURE [dbo].[FindActiveUsersWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsBlocked] = 0 AND [IsDeleted] = 0;
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   ([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName)  AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					([IsBlocked] = 0 AND [IsDeleted] = 0)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

CREATE PROCEDURE [dbo].[FindActiveOrBlockedWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsDeleted] = 0;
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR 
				CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
					AND [NormalizedLastName] LIKE @LastName) AND [IsDeleted] = 0
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
					[NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

CREATE PROCEDURE [dbo].[FindActiveOrDeletedUsersWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%';
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsBlocked] = 0;
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
					[IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName
				   AND [NormalizedLastName] LIKE @LastName)
				   AND  [IsBlocked] = 0
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)
				   AND [IsBlocked] = 0
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

CREATE PROCEDURE [dbo].[FindBlockedOrDeletedWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1);
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   ([IsDeleted] = 1 OR [IsBlocked] = 1)
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					([IsDeleted] = 1 OR [IsBlocked] = 1)
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

CREATE PROCEDURE [dbo].[FindBlockedUsersWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsBlocked] = 1;
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                   [NormalizedEmail] LIKE @SearchTerm  OR
                   [NormalizedFirstName] LIKE @SearchTerm OR
                   [NormalizedLastName] LIKE @SearchTerm OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsBlocked] = 1
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsBlocked] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

CREATE PROCEDURE [dbo].[FindDeletedUsersWithCountWithClaimValueSearch] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount = 0)
		BEGIN
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT Count(*)
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm OR 
				   [NormalizedLastName] LIKE @SearchTerm  OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsDeleted] = 1;
			WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
					SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
					FROM [AspNetUserClaims]
					WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
				)
			SELECT [Id], 
				   [AccessFailedCount], 
				   [ConcurrencyStamp], 
				   [Email], 
				   [EmailConfirmed], 
				   [FirstName], 
				   [IsBlocked], 
				   [IsDeleted], 
				   [LastName], 
				   [LockoutEnabled], 
				   [LockoutEnd], 
				   [NormalizedEmail], 
				   [NormalizedFirstName], 
				   [NormalizedLastName], 
				   [NormalizedUserName], 
				   [PasswordHash], 
				   [PhoneNumber], 
				   [PhoneNumberConfirmed], 
				   [SecurityStamp], 
				   [TwoFactorEnabled], 
				   [UserName]
			FROM [AspNetUsers]
			LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
			WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
				   [NormalizedEmail] LIKE @SearchTerm  OR 
				   [NormalizedFirstName] LIKE @SearchTerm  OR 
				   [NormalizedLastName] LIKE @SearchTerm   OR
                   [Id] LIKE @SearchTermLower OR 
				   CTE_ClaimSearch.[UserId] IS NOT NULL) AND
				   [IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE
		BEGIN
			DECLARE @FirstName nvarchar(256);
			DECLARE @FirstNameCount int;
			DECLARE @LastName nvarchar(256);
			SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
			SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
			SELECT COUNT(*)
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName)AND
				   [IsDeleted] = 1
			SELECT [Id],
					[AccessFailedCount], 
					[ConcurrencyStamp], 
					[Email], 
					[EmailConfirmed], 
					[FirstName], 
					[IsBlocked], 
					[IsDeleted], 
					[LastName], 
					[LockoutEnabled], 
					[LockoutEnd], 
					[NormalizedEmail], 
					[NormalizedFirstName], 
					[NormalizedLastName], 
					[NormalizedUserName], 
					[PasswordHash], 
					[PhoneNumber], 
					[PhoneNumberConfirmed], 
					[SecurityStamp], 
					[TwoFactorEnabled], 
					[UserName]
			FROM [AspNetUsers]
			WHERE ([NormalizedFirstName] LIKE @FirstName AND
				   [NormalizedLastName] LIKE @LastName) AND
					[IsDeleted] = 1
			ORDER BY [UserName]
			OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
END
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220225154308_ClaimValueSearchMigration', N'8.0.2');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER PROCEDURE [dbo].[FindActiveOrBlockedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
    DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount > 0)
        BEGIN
	        SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
    BEGIN
        SELECT Count(*)
        FROM [AspNetUsers]
        WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
            [IsDeleted] = 0;
        SELECT [Id],
            [AccessFailedCount],
            [ConcurrencyStamp],
            [Email],
            [EmailConfirmed],
            [FirstName],
            [IsBlocked],
            [IsDeleted],
            [LastName],
            [LockoutEnabled],
            [LockoutEnd],
            [NormalizedEmail],
            [NormalizedFirstName],
            [NormalizedLastName],
            [NormalizedUserName],
            [PasswordHash],
            [PhoneNumber],
            [PhoneNumberConfirmed],
            [SecurityStamp],
            [TwoFactorEnabled],
            [UserName]
        FROM [AspNetUsers]
        WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
            [IsDeleted] = 0
        ORDER BY [UserName]
        OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
    END
END
GO

ALTER PROCEDURE [dbo].[FindActiveOrBlockedWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
    DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount > 0)
        BEGIN
	        SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END	    
	BEGIN
		WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
				SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
				FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
		SELECT Count(*)
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		        [NormalizedEmail] LIKE @SearchTerm  OR 
			    [NormalizedFirstName] LIKE @SearchTerm OR 
		        [NormalizedLastName] LIKE @SearchTerm OR
		        [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
			    CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			[IsDeleted] = 0;
		WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
		    SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
			FROM [AspNetUserClaims]
			WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
		)
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
			[IsBlocked], 
		    [IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
			[LockoutEnd], 
			[NormalizedEmail], 
			[NormalizedFirstName], 
			[NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash], 
		    [PhoneNumber], 
			[PhoneNumberConfirmed], 
			[SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
		        [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
			    CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			[IsDeleted] = 0
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindActiveOrDeletedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%';
	DECLARE @NameSplitCount int;
	DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount > 0)
        BEGIN
	        SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
	BEGIN
		SELECT Count(*)
		FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		        [NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm OR 
		        [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
			[IsBlocked] = 0;
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
		    [FirstName], 
			[IsBlocked], 
			[IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
			[LockoutEnd], 
			[NormalizedEmail], 
			[NormalizedFirstName], 
			[NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash], 
			[PhoneNumber], 
			[PhoneNumberConfirmed], 
			[SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
			[IsBlocked] = 0
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindActiveOrDeletedUsersWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%';
	DECLARE @NameSplitCount int;
    DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount > 0)
        BEGIN
	        SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
	BEGIN
		WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
		    SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
				FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
		)
		SELECT Count(*)
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		        [NormalizedEmail] LIKE @SearchTerm  OR
		        [NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			[IsBlocked] = 0;
		WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
			SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
			FROM [AspNetUserClaims]
			WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
		)
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
			[IsBlocked], 
			[IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
			[LockoutEnd], 
			[NormalizedEmail], 
		    [NormalizedFirstName], 
	        [NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash], 
			[PhoneNumber], 
			[PhoneNumberConfirmed],
		    [SecurityStamp], 
		    [TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
		        [NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			[IsBlocked] = 0
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindActiveByRoleWithCount]
	@RoleId nvarchar(450),
	@SearchTerm nvarchar(256) = null, 
	@PageNumber int,
	@PageSize int
AS
BEGIN
-- Search for all Active (IsBlocked = 0 && IsDeleted = 0) Users within a role
-- If @SearchTerm is given it will search for LIKE on Email, Username, firstname and lastname
-- If no @SearchTerm is given it will return all Active Users in that Role
	SET NOCOUNT ON;
	IF @SearchTerm IS null
		BEGIN
		 -- Select Count of all users within role
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
		--Select all users in role with SearchTerm
				SELECT  u.Id,
						u.[Email], 
						u.[FirstName], 
						u.[LastName], 	
						u.[UserName]
				FROM [AspNetUserRoles] ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId			
				WHERE (ur.[RoleId] = @RoleId) 
				ORDER BY u.[UserName]
				OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE --IF @SearchTerm is not Null
		BEGIN
            DECLARE @SearchTermLower nvarchar(256);
            SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
			SET @SearchTerm = UPPER(@SearchTerm) + N'%'
			DECLARE @NameSplitCount int;
			DECLARE @FirstName nvarchar(256);
			DECLARE @LastName nvarchar(256);
			SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
			IF(@NameSplitCount > 0)
                BEGIN
    	            SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	                SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
                END
			BEGIN
				--Select Count With Search
				SELECT Count(*)
				FROM [AspNetUserRoles] ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId
				WHERE (ur.[RoleId] = @RoleId) 
				AND ([NormalizedUserName] LIKE @SearchTerm  OR 
				        [NormalizedEmail] LIKE @SearchTerm  OR 
						[NormalizedFirstName] LIKE @SearchTerm  OR
				        [NormalizedLastName] LIKE @SearchTerm OR
                        [Id] LIKE @SearchTermLower OR
                        (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
                );
                --Select all users in role with Search
				SELECT u.Id,
					u.[Email], 
					u.[FirstName], 
					u.[LastName], 	
					u.[UserName]
				FROM [AspNetUserRoles] ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId
				WHERE (ur.[RoleId] = @RoleId) AND
				    ([NormalizedUserName] LIKE @SearchTerm  OR 
				        [NormalizedEmail] LIKE @SearchTerm  OR 
				        [NormalizedFirstName] LIKE @SearchTerm  OR 
						[NormalizedLastName] LIKE @SearchTerm OR
                        [Id] LIKE @SearchTermLower OR
                        (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
                    ) 
				ORDER BY u.[UserName]
				OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
			END
		END
END
GO

ALTER PROCEDURE [dbo].FindActiveUsersInRoleAndAllActiveUsersWithCount
	@RoleId nvarchar(450),
	@SearchTerm nvarchar(256) = null, 
	@PageNumber int,
	@PageSize int
AS
BEGIN
-- Search for all Active (IsBlocked = 0 && IsDeleted = 0) Users and if they are in the role
-- If @SearchTerm is given it will search for LIKE on Email, Username, firstname and lastname
-- If no @SearchTerm is given it will return all Active Users in that Role
	SET NOCOUNT ON;
	IF @SearchTerm IS null
		BEGIN
		  -- Select Count of all users within role
			SELECT Count(*)
			FROM [AspNetUserRoles] ur
			RIGHT JOIN [ActiveUsers] u
			ON u.Id = ur.UserId
			WHERE (ur.[RoleId] = @RoleId) 
	--Get All UserRole Entries with RoleID
		;WITH UserRoles_CTE
		AS
		(
			SELECT ur.[RoleId],
				   ur.[UserId]
			FROM [AspNetUserRoles] ur
			WHERE ur.[RoleId] = @RoleId
		)
		SELECT  u.Id,
				u.[Email], 
				u.[FirstName], 
				u.[LastName], 	
				u.[UserName],
			    CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
		FROM UserRoles_CTE ur
		RIGHT JOIN [ActiveUsers] u
		ON u.Id = ur.UserId			
		ORDER BY u.[UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
		END
	ELSE -- IF @SearchTerm is not Null
		BEGIN
            DECLARE @SearchTermLower nvarchar(256);
            SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
			SET @SearchTerm = UPPER(@SearchTerm) + N'%'
			DECLARE @NameSplitCount int;
			DECLARE @FirstName nvarchar(256);
			DECLARE @LastName nvarchar(256);
			SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
			IF(@NameSplitCount > 0)
                BEGIN
    	            SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	                SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
                END
			BEGIN
			--Select Count With Search
			    SELECT Count(*)
				FROM [AspNetUserRoles] ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId
				WHERE [NormalizedUserName] LIKE @SearchTerm  OR 
					[NormalizedEmail] LIKE @SearchTerm  OR 
					[NormalizedFirstName] LIKE @SearchTerm  OR 
					[NormalizedLastName] LIKE @SearchTerm OR 
					[Id] LIKE @SearchTermLower OR
                    (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			--Select users in result with Search
				;WITH UserRoles_CTE
				AS (
				    SELECT ur.[RoleId],
					    ur.[UserId]
					FROM [AspNetUserRoles] ur
					WHERE ur.[RoleId] = @RoleId	
				)
				SELECT u.Id,
					u.[Email], 
					u.[FirstName], 
					u.[LastName], 	
					u.[UserName],
				CASE WHEN ur.[RoleId] IS NULL THEN CONVERT(bit, 0) ELSE CONVERT(bit, 1) END AS IsInRole
				FROM UserRoles_CTE ur
				RIGHT JOIN [ActiveUsers] u
				ON u.Id = ur.UserId
				WHERE (ur.[RoleId] = @RoleId) 
				AND
					[NormalizedUserName] LIKE @SearchTerm  OR 
					[NormalizedEmail] LIKE @SearchTerm  OR 
					[NormalizedFirstName] LIKE @SearchTerm  OR 
					[NormalizedLastName] LIKE @SearchTerm OR
					[Id] LIKE @SearchTermLower OR
                    (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
				ORDER BY u.[UserName]
				OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
			END
	    END
END
GO

ALTER PROCEDURE [dbo].[FindActiveUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
    DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount > 0)
        BEGIN
    	    SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
	BEGIN
		SELECT Count(*)
		FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		        [NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
        ) AND
			[IsBlocked] = 0 AND [IsDeleted] = 0;
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
			[IsBlocked], 
			[IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
		    [LockoutEnd], 
			[NormalizedEmail], 
			[NormalizedFirstName], 
			[NormalizedLastName], 
			[NormalizedUserName],
			[PasswordHash],
			[PhoneNumber],
			[PhoneNumberConfirmed],
			[SecurityStamp],
			[TwoFactorEnabled],
			[UserName]
		FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
		    ([IsBlocked] = 0 AND [IsDeleted] = 0)
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindActiveUsersWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount > 0)
        BEGIN
    	    SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
	BEGIN
	    WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
	            SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
				FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
		SELECT Count(*)
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		        [NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			[IsBlocked] = 0 AND [IsDeleted] = 0;
	    WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
	            SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
				FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
			[IsBlocked], 
			[IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
			[LockoutEnd], 
			[NormalizedEmail], 
		    [NormalizedFirstName], 
		    [NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash],
			[PhoneNumber], 
			[PhoneNumberConfirmed], 
			[SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			([IsBlocked] = 0 AND [IsDeleted] = 0)
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindAllUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount > 0)
        BEGIN
    	    SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
	BEGIN
	    SELECT Count(*)
	    FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		        [NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm OR 
			    [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
			);
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
			[IsBlocked], 
		    [IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
			[LockoutEnd], 
			[NormalizedEmail], 
			[NormalizedFirstName], 
			[NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash], 
			[PhoneNumber], 
			[PhoneNumberConfirmed], 
			[SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
		        [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            )
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindAllUsersWithCountWithClaimValueSearch] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
    IF(@NameSplitCount > 0)
        BEGIN
    	    SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
	BEGIN
	    WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
			SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
			FROM [AspNetUserClaims]
			WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
		)
		SELECT Count(*)
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		        [NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
			    [AspNetUsers].[Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			);
        WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
			SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
			    FROM [AspNetUserClaims]
			    WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
		)
		SELECT [AspNetUsers].[Id], 
			[AccessFailedCount], 
		    [ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
			[IsBlocked], 
			[IsDeleted], 
			[LastName],
		    [LockoutEnabled], 
		    [LockoutEnd],
		    [NormalizedEmail], 
		    [NormalizedFirstName],
		    [NormalizedLastName], 
			[NormalizedUserName], 
		    [PasswordHash], 
			[PhoneNumber], 
			[PhoneNumberConfirmed], 
			[SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON
		    CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
                [AspNetUsers].[Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			)
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindBlockedOrDeletedWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount > 0)
	    BEGIN
	        SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
	    END
	BEGIN
		SELECT Count(*)
		FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		        [NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
			([IsDeleted] = 1 OR [IsBlocked] = 1);
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
			[IsBlocked], 
			[IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
			[LockoutEnd], 
			[NormalizedEmail], 
			[NormalizedFirstName], 
			[NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash], 
			[PhoneNumber], 
			[PhoneNumberConfirmed], 
			[SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
			([IsDeleted] = 1 OR [IsBlocked] = 1)
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindBlockedOrDeletedWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
    IF(@NameSplitCount > 0)
        BEGIN
    	    SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
	BEGIN
	    WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
		        SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
        		FROM [AspNetUserClaims]
		        WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
		SELECT Count(*)
		FROM [AspNetUsers]
	    LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
			    [NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			([IsDeleted] = 1 OR [IsBlocked] = 1);
		WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
			    SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
				FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
		    [IsBlocked], 
			[IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
			[LockoutEnd], 
			[NormalizedEmail], 
			[NormalizedFirstName], 
			[NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash], 
			[PhoneNumber], 
			[PhoneNumberConfirmed], 
			[SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			([IsDeleted] = 1 OR [IsBlocked] = 1)
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindBlockedUsersWithCount]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount > 0)
        BEGIN
    	    SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
	BEGIN
	    SELECT Count(*)
	    FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
			    [NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
			[IsBlocked] = 1;
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
			[IsBlocked], 
			[IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
		    [LockoutEnd], 
			[NormalizedEmail], 
			[NormalizedFirstName], 
			[NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash], 
		    [PhoneNumber], 
			[PhoneNumberConfirmed], 
		    [SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
	    FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
			[IsBlocked] = 1
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindBlockedUsersWithCountWithClaimValueSearch]
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
    IF(@NameSplitCount > 0)
        BEGIN
    	    SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
	BEGIN
		WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
		        SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
			    FROM [AspNetUserClaims]
			    WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
		SELECT Count(*)
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		        [NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			[IsBlocked] = 1;
		WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
			    SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
				FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
		    [IsBlocked], 
			[IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
			[LockoutEnd], 
			[NormalizedEmail], 
			[NormalizedFirstName], 
			[NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash], 
			[PhoneNumber], 
			[PhoneNumberConfirmed], 
			[SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR
                [NormalizedEmail] LIKE @SearchTerm  OR
                [NormalizedFirstName] LIKE @SearchTerm OR
                [NormalizedLastName] LIKE @SearchTerm OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
		    [IsBlocked] = 1
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindDeletedUsersWithCount] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
	IF(@NameSplitCount > 0)
        BEGIN
    	    SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
    BEGIN
	    SELECT Count(*)
	    FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
			    [NormalizedEmail] LIKE @SearchTerm  OR 
		        [NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm  OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
			[IsDeleted] = 1;
		SELECT [Id], 
		    [AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
			[IsBlocked], 
			[IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
			[LockoutEnd], 
			[NormalizedEmail], 
		    [NormalizedFirstName], 
			[NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash], 
			[PhoneNumber], 
			[PhoneNumberConfirmed], 
			[SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
			    [NormalizedEmail] LIKE @SearchTerm  OR 
			    [NormalizedFirstName] LIKE @SearchTerm  OR 
				[NormalizedLastName] LIKE @SearchTerm   OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName)
            ) AND
			[IsDeleted] = 1
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

ALTER PROCEDURE [dbo].[FindDeletedUsersWithCountWithClaimValueSearch] 
	@SearchTerm nvarchar(256),
	@PageNumber int,
	@PageSize int
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @SearchTermLower nvarchar(256);
    SET @SearchTermLower = LOWER(@SearchTerm) + N'%'
	SET @SearchTerm = UPPER(@SearchTerm) + N'%'
	DECLARE @NameSplitCount int;
	DECLARE @FirstName nvarchar(256);
	DECLARE @LastName nvarchar(256);
	SET @NameSplitCount = (SELECT LEN(@SearchTerm) - LEN(REPLACE(@SearchTerm, ' ', '')))
    IF(@NameSplitCount > 0)
        BEGIN
    	    SET @FirstName = left(@SearchTerm, charindex(' ', @SearchTerm) - 1) + N'%'
	        SET @LastName = substring(@SearchTerm, charindex(' ', @SearchTerm) + 1, len(@SearchTerm))
        END
	BEGIN
		WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
		        SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
			    FROM [AspNetUserClaims]
			    WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
		SELECT Count(*)
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
		        [NormalizedEmail] LIKE @SearchTerm  OR 
				[NormalizedFirstName] LIKE @SearchTerm OR 
				[NormalizedLastName] LIKE @SearchTerm  OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			[IsDeleted] = 1;
        WITH CTE_ClaimSearch(UserId, ClaimValue) AS (
		        SELECT [AspNetUserClaims].[UserId], [AspNetUserClaims].[ClaimValue]
			    FROM [AspNetUserClaims]
				WHERE [AspNetUserClaims].[ClaimValue] LIKE @SearchTermLower
			)
		SELECT [Id], 
			[AccessFailedCount], 
			[ConcurrencyStamp], 
			[Email], 
			[EmailConfirmed], 
			[FirstName], 
			[IsBlocked], 
			[IsDeleted], 
			[LastName], 
			[LockoutEnabled], 
			[LockoutEnd], 
			[NormalizedEmail], 
			[NormalizedFirstName], 
			[NormalizedLastName], 
			[NormalizedUserName], 
			[PasswordHash], 
			[PhoneNumber], 
			[PhoneNumberConfirmed], 
			[SecurityStamp], 
			[TwoFactorEnabled], 
			[UserName]
		FROM [AspNetUsers]
		LEFT JOIN CTE_ClaimSearch ON CTE_ClaimSearch.[UserId] = [AspNetUsers].[Id] 
		WHERE ([NormalizedUserName] LIKE @SearchTerm  OR 
			    [NormalizedEmail] LIKE @SearchTerm  OR 
    			[NormalizedFirstName] LIKE @SearchTerm  OR 
			    [NormalizedLastName] LIKE @SearchTerm   OR
                [PhoneNumber] LIKE @SearchTerm OR
                [Id] LIKE @SearchTermLower OR
                (@NameSplitCount > 0 AND [NormalizedFirstName] LIKE @FirstName AND [NormalizedLastName] LIKE @LastName) OR
				CTE_ClaimSearch.[UserId] IS NOT NULL
			) AND
			[IsDeleted] = 1
		ORDER BY [UserName]
		OFFSET @PageSize * @PageNumber ROWS FETCH NEXT @PageSize ROWS ONLY
	END
END
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230901102018_ClaimValueSearchBugFixes', N'8.0.2');
GO

COMMIT;
GO

