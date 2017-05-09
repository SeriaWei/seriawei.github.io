SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BreadcrumbWidget](
	[ID] [nvarchar](100) NOT NULL,
	[IsLinkAble] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[BreadcrumbWidget]  WITH CHECK ADD  CONSTRAINT [FK_BreadcrumbWidget_CMS_WidgetBase] FOREIGN KEY([ID])
REFERENCES [dbo].[CMS_WidgetBase] ([ID])
GO
ALTER TABLE [dbo].[BreadcrumbWidget] CHECK CONSTRAINT [FK_BreadcrumbWidget_CMS_WidgetBase]
GO
INSERT INTO dbo.CMS_WidgetTemplate
        ( Title ,
          GroupName ,
          PartialView ,
          AssemblyName ,
          ServiceTypeName ,
          ViewModelTypeName ,
          Thumbnail ,
          [Order] ,
          Status
        )
VALUES  ( N'·������' ,
          N'1.ͨ��' , 
          N'Widget.Breadcrumb' ,
          N'Easy.CMS.Breadcrumb' , 
          N'Easy.CMS.Breadcrumb.Service.BreadcrumbWidgetService' , 
          N'Easy.CMS.Breadcrumb.Models.BreadcrumbWidget' , 
          N'~/Modules/Breadcrumb/Content/breadcrumb.png' , 
          6 , 
          1
        )

GO

INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@ActionType', 2052, N'ActionType', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@AssemblyName', 2052, N'AssemblyName', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@CreateBy', 2052, N'CreateBy', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@CreatebyName', 2052, N'������', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@CreateDate', 2052, N'��������', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@CustomClass', 2052, N'CustomClass', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@CustomStyle', 2052, N'CustomStyle', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@Description', 2052, N'����', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@FormView', 2052, N'FormView', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@ID', 2052, N'ID', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@IsLinkAble', 2052, N'IsLinkAble', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@IsSystem', 2052, N'IsSystem', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@IsTemplate', 2052, N'����Ϊģ��', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@LastUpdateBy', 2052, N'LastUpdateBy', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@LastUpdateByName', 2052, N'������', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@LastUpdateDate', 2052, N'��������', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@LayoutID', 2052, N'����', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@PageID', 2052, N'ҳ��', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@PartialView', 2052, N'ģ��', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@Position', 2052, N'����', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@ServiceTypeName', 2052, N'ServiceTypeName', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@Status', 2052, N'״̬', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@StyleClass', 2052, N'�Զ�����ʽ', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@Thumbnail', 2052, N'ģ������ͼ', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@Title', 2052, N'����', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@ViewModelTypeName', 2052, N'ViewModelTypeName', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@WidgetName', 2052, N'�������', N'BreadcrumbWidget', N'EntityProperty')
INSERT [dbo].[Language] ([LanKey], [LanID], [LanValue], [Module], [LanType]) VALUES (N'BreadcrumbWidget@ZoneID', 2052, N'����', N'BreadcrumbWidget', N'EntityProperty')
GO
