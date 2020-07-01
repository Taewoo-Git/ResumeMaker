USE [resume_maker_db]
GO

/****** Object:  Table [dbo].[Stars]    Script Date: 2020-06-23 오전 12:08:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Stars](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[recommender] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Stars] PRIMARY KEY CLUSTERED 
(
	[num] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Stars]  WITH CHECK ADD  CONSTRAINT [FK_Stars_Member1] FOREIGN KEY([email])
REFERENCES [dbo].[Member] ([email])
GO

ALTER TABLE [dbo].[Stars] CHECK CONSTRAINT [FK_Stars_Member1]
GO

