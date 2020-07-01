USE [resume_maker_db]
GO

/****** Object:  Table [dbo].[Skills]    Script Date: 2020-06-23 오전 12:08:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Skills](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[value] [int] NOT NULL,
	[name] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[num] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Skills]  WITH CHECK ADD  CONSTRAINT [FK_Skills_Member] FOREIGN KEY([email])
REFERENCES [dbo].[Member] ([email])
GO

ALTER TABLE [dbo].[Skills] CHECK CONSTRAINT [FK_Skills_Member]
GO

