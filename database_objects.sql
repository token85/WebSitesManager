/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.1000)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Target Database Engine Type : Standalone SQL Server
*/

CREATE DATABASE [websitesManagerDB]
go


/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.1000)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [websitesManagerDB]
GO

/****** Object:  Table [dbo].[tbWebsites]    Script Date: 16.08.2018 12:07:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbWebsites](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[websiteUrl] [nvarchar](255) NULL,
	[websiteServer] [nvarchar](255) NULL,
	[websiteDatabase] [nvarchar](255) NULL,
	[websitePrefix] [nvarchar](255) NULL,
	[websiteDbUser] [nvarchar](255) NULL,
	[websiteDbPass] [nvarchar](255) NULL,
	[websiteIsActive] [int] NULL,
	[websiteLanguage] [nvarchar](255) NULL,
	[websiteDloadDriver] [nvarchar](255) NULL,
	[websiteDbTech] [nvarchar](255) NULL,
	[websiteDownloadDate] [datetime2](7) NULL,
	[websiteDbProvider] [nvarchar](255) NULL
) ON [PRIMARY]
GO


/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.1000)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [websitesManagerDB]
GO

/****** Object:  Table [dbo].[tbTermTaxonomy]    Script Date: 16.08.2018 12:07:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbTermTaxonomy](
	[term_taxonomy_id] [numeric](20, 0) NULL,
	[term_id] [numeric](20, 0) NULL,
	[taxonomy] [nvarchar](32) NULL,
	[description] [ntext] NULL,
	[parent] [numeric](20, 0) NULL,
	[count] [bigint] NULL,
	[website_domain] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.1000)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [websitesManagerDB]
GO

/****** Object:  Table [dbo].[tbTerms]    Script Date: 16.08.2018 12:07:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbTerms](
	[term_id] [numeric](20, 0) NULL,
	[name] [nvarchar](200) NULL,
	[slug] [nvarchar](200) NULL,
	[term_group] [bigint] NULL,
	[website_domain] [nvarchar](255) NULL
) ON [PRIMARY]
GO


/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.1000)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [websitesManagerDB]
GO

/****** Object:  Table [dbo].[tbTermRelationships]    Script Date: 16.08.2018 12:07:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbTermRelationships](
	[object_id] [numeric](20, 0) NULL,
	[term_taxonomy_id] [numeric](20, 0) NULL,
	[term_order] [int] NULL,
	[website_domain] [nvarchar](255) NULL
) ON [PRIMARY]
GO


/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.1000)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [websitesManagerDB]
GO

/****** Object:  Table [dbo].[tbPosts]    Script Date: 16.08.2018 12:07:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbPosts](
	[ID] [numeric](20, 0) NULL,
	[post_author] [numeric](20, 0) NULL,
	[post_date] [datetime2](7) NULL,
	[post_content] [ntext] NULL,
	[post_title] [ntext] NULL,
	[post_excerpt] [ntext] NULL,
	[post_status] [nvarchar](20) NULL,
	[comment_status] [nvarchar](20) NULL,
	[ping_status] [nvarchar](20) NULL,
	[post_password] [nvarchar](255) NULL,
	[post_name] [nvarchar](200) NULL,
	[to_ping] [ntext] NULL,
	[pinged] [ntext] NULL,
	[post_modified] [datetime2](7) NULL,
	[post_content_filtered] [ntext] NULL,
	[post_parent] [numeric](20, 0) NULL,
	[guid] [nvarchar](255) NULL,
	[menu_order] [int] NULL,
	[post_type] [nvarchar](20) NULL,
	[post_mime_type] [nvarchar](100) NULL,
	[comment_count] [bigint] NULL,
	[website_domain] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


USE [websitesManagerDB]
GO

CREATE PROCEDURE [dbo].[prcWpImport] AS
begin

--DELETE FROM TABLES
delete from [tbPosts];
delete from [tbTermRelationships];
delete from [tbTermTaxonomy];
delete from [tbTerms];


--select * from dbo.tbWebsites


--SET NULL AS DOWNLOAD DATE
UPDATE dbo.tbWebsites
SET websiteDownloadDate=NULL

--variables declare
declare @nvWebsiteUrl  nvarchar(255);
declare @nvWebsiteServer nvarchar(255);
declare @nvWebsiteDatabase nvarchar(255);
declare @nvWebsitePrefix nvarchar(255);
declare @nvWebDbUser nvarchar(255);
declare @nvWebsiteDbPass nvarchar(255);
declare @nvWebsiteDloadDriver nvarchar(255);
declare @nvWebsiteDbProvider nvarchar(255);
declare @intId as int;


while (SELECT TOP 1 id FROM dbo.tbWebsites where websiteDownloadDate is null) is not null
begin
--assigning values ​​to variables
SELECT top 1
    @intId = [id], 
	@nvWebsiteUrl = [websiteUrl],
	@nvWebsiteServer = [websiteServer],
	@nvWebsiteDatabase = [websiteDatabase],
	@nvWebsitePrefix = [websitePrefix],
	@nvWebDbUser = [websiteDbUser],
	@nvWebsiteDbPass = [websiteDbPass],
	@nvWebsiteDloadDriver = [websiteDloadDriver],
	@nvWebsiteDbProvider = [WebsiteDbProvider]
FROM [dbo].[tbWebsites] where id=(SELECT TOP 1 id FROM dbo.tbWebsites where websiteDownloadDate is null)

--data download from wordpress sites
--wp_posts
exec('INSERT INTO [dbo].[tbPosts] SELECT a.*, '''+ @nvWebsiteUrl +''' 
FROM 
OPENROWSET(	'''+@nvWebsiteDbProvider+''',
       ''Driver={'+@nvWebsiteDloadDriver+'};  Server='+@nvWebsiteServer+'; Database=information_schema; USER='+@nvWebDbUser+'; PASSWORD='+@nvWebsiteDbPass+''',
''SELECT ID, post_author, post_date, post_content, post_title, post_excerpt, post_status, comment_status, ping_status, post_password, post_name, to_ping, pinged, post_modified, post_content_filtered, post_parent, guid, menu_order, post_type, post_mime_type, comment_count  FROM '+@nvWebsiteDatabase+'.'+@nvWebsitePrefix+'_posts'') a')

--wp_terms
exec('INSERT INTO [dbo].[tbTerms] SELECT a.*, '''+ @nvWebsiteUrl +''' 
FROM 
OPENROWSET(	'''+@nvWebsiteDbProvider+''',
       ''Driver={'+@nvWebsiteDloadDriver+'};  Server='+@nvWebsiteServer+'; Database=information_schema; USER='+@nvWebDbUser+'; PASSWORD='+@nvWebsiteDbPass+''',
''SELECT * FROM '+@nvWebsiteDatabase+'.'+@nvWebsitePrefix+'_terms'') a')

--wp_term_relationships
--exec('INSERT INTO [dbo].[tbTermRelationships] SELECT a.*, '''+ @nvWebsiteUrl +''' FROM openquery('+@nvWebsiteServer+', ''SELECT * FROM '+@nvWebsiteDatabase+'.wp_term_relationships'') a')

exec('INSERT INTO [dbo].[tbTermRelationships] SELECT a.*, '''+ @nvWebsiteUrl +''' 
FROM 
OPENROWSET(	'''+@nvWebsiteDbProvider+''',
       ''Driver={'+@nvWebsiteDloadDriver+'};  Server='+@nvWebsiteServer+'; Database=information_schema; USER='+@nvWebDbUser+'; PASSWORD='+@nvWebsiteDbPass+''',
''SELECT * FROM '+@nvWebsiteDatabase+'.'+@nvWebsitePrefix+'_term_relationships'') a')


--wp_term_taxonomy
--exec('INSERT INTO [dbo].[tbTermTaxonomy] SELECT a.*, '''+ @nvWebsiteUrl +''' FROM openquery('+@nvWebsiteServer+', ''SELECT * FROM '+@nvWebsiteDatabase+'.wp_term_taxonomy'') a')
exec('INSERT INTO [dbo].[tbTermTaxonomy] SELECT a.*, '''+ @nvWebsiteUrl +''' 
FROM 
OPENROWSET(	'''+@nvWebsiteDbProvider+''',
       ''Driver={'+@nvWebsiteDloadDriver+'};  Server='+@nvWebsiteServer+'; Database=information_schema; USER='+@nvWebDbUser+'; PASSWORD='+@nvWebsiteDbPass+''',
''SELECT * FROM '+@nvWebsiteDatabase+'.'+@nvWebsitePrefix+'_term_taxonomy'') a')



--DOWNLOADDATE UPDATE
--SET NULL AS DOWNLOAD DATE
UPDATE dbo.tbWebsites
SET websiteDownloadDate=GETDATE()
where id = @intId

end --end while loop
end --end proc
;