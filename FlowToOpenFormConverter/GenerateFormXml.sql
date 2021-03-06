set nocount on
declare @formTempTable table (value XML)
insert into @formTempTable
EXEC	 [Open].[ModifyOpenFormByName] @FormName = N'RequestEditor'

declare @script nvarchar(max)
declare @form nvarchar(max) = (select top 1 cast(value as nvarchar(MAX)) from @formTempTable)

set @script  = '
declare @formName varchar(255) = ''$(formname)''
declare @form varchar(max) = '''+ @form +'''

IF EXISTS (select * from FormDefinitions where Name = @formName)
	UPDATE FormDefinitions  SET DevelopmentDefinitionXml = @form, ModifiedOn = GetDate(), ModifiedBy_Id = 1
	WHERE Name = @formName
ELSE
	INSERT into FormDefinitions (Name, [Description], DevelopmentDefinitionXml, ProductionDefinitionXml, TestDefinitionXml, CreatedOn, ModifiedOn, CreatedBy_Id, ModifiedBy_id)
    VALUES (@formName, ''Auto-generated by FlowToOpenFormConverter'', @form, @form, @form, GetDate(), GetDate(), 1, 1)
'
delete @formTempTable
insert into [Open].[FormDefinitions] (Code, Name, Value, CreatedOn) values ('OpenForm', 'Open Form', @script, GETDATE())