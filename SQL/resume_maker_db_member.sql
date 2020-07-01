USE [resume_maker_db]
GO

/****** Object:  Table [dbo].[Member]    Script Date: 2020-06-23 오전 12:08:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Member](
	[email] [varchar](50) NOT NULL,
	[pwd] [varchar](32) NOT NULL,
	[name] [varchar](10) NOT NULL,
	[phone] [varchar](15) NOT NULL,
	[zip] [smallint] NOT NULL,
	[addr] [text] NOT NULL,
	[job] [varchar](10) NOT NULL,
	[github] [text] NULL,
	[viewer] [int] NOT NULL,
	[shared] [varchar](1) NOT NULL,
	[img] [varchar](max) NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

