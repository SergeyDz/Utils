set nocount on
declare @t table (v XML)
insert into @t
EXEC	 [Open].[ModifyOpenFormByName] @FormName = N'RequestEditor'
declare @script nvarchar(max)
declare @form nvarchar(max) = (select top 1 cast(v as nvarchar(MAX)) from @t)
set @script = 'update FormDefinitions set DevelopmentDefinitionXml = '''+@form+''' where Name = ''$(formname)'''
select @script