USE [resume_maker_db]
GO

/****** Object:  Table [dbo].[Certificate]    Script Date: 2020-06-23 오전 12:07:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Certificate](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[date] [varchar](10) NOT NULL,
	[name] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Certificate] PRIMARY KEY CLUSTERED 
(
	[email] ASC,
	[num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Certificate]  WITH CHECK ADD  CONSTRAINT [FK_Certificate_Member] FOREIGN KEY([email])
REFERENCES [dbo].[Member] ([email])
GO

ALTER TABLE [dbo].[Certificate] CHECK CONSTRAINT [FK_Certificate_Member]
GO

