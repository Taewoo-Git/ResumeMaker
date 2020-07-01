USE [resume_maker_db]
GO

/****** Object:  Table [dbo].[Type]    Script Date: 2020-06-23 오전 12:09:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Type](
	[typeNo] [tinyint] NOT NULL,
	[typeName] [varchar](10) NOT NULL,
 CONSTRAINT [PK_BoardType] PRIMARY KEY CLUSTERED 
(
	[typeNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

