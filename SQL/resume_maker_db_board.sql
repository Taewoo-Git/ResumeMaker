USE [resume_maker_db]
GO

/****** Object:  Table [dbo].[Board]    Script Date: 2020-06-23 오전 12:07:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Board](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[title] [varchar](30) NOT NULL,
	[joindate] [varchar](15) NOT NULL,
	[leavedate] [varchar](15) NOT NULL,
	[contents] [ntext] NULL,
	[type] [tinyint] NOT NULL,
 CONSTRAINT [PK_Board] PRIMARY KEY CLUSTERED 
(
	[num] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Board]  WITH CHECK ADD  CONSTRAINT [FK_Board_Member] FOREIGN KEY([email])
REFERENCES [dbo].[Member] ([email])
GO

ALTER TABLE [dbo].[Board] CHECK CONSTRAINT [FK_Board_Member]
GO

ALTER TABLE [dbo].[Board]  WITH CHECK ADD  CONSTRAINT [FK_Board_Type] FOREIGN KEY([type])
REFERENCES [dbo].[Type] ([typeNo])
GO

ALTER TABLE [dbo].[Board] CHECK CONSTRAINT [FK_Board_Type]
GO

