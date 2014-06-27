set nocount on
declare @formTempTable table (value XML)
insert into @formTempTable
EXEC	 [Open].[ModifyOpenFormByName] @FormName = N'RequestEditor'

declare @script nvarchar(max)
declare @form nvarchar(max) = (select top 1 cast(value as nvarchar(MAX)) from @formTempTable)
delete @formTempTable
set @script = 'update FormDefinitions set DevelopmentDefinitionXml = '''+@form+''' where Name = ''$(formname)'''

insert into [Open].[FormDefinitions] (Code, Name, Value, CreatedOn) values ('OpenForm', 'Open Form', @script, GETDATE())