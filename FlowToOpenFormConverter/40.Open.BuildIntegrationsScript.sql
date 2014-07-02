GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[BuildIntegrationsScript]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Open].[BuildIntegrationsScript]
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Mofify existing form / or / create new one>
-- =============================================
CREATE PROCEDURE [Open].[BuildIntegrationsScript] 
AS
BEGIN
declare @elementId int
declare @tableName varchar(255)
declare @entityCode varchar(max)
declare @bindingPath varchar(max)
declare @query XML
declare @selectScript varchar(255)
declare @finalProcedureScript varchar(max)


declare domainEntityCursor cursor FOR
select e.Id, s.name + '.' + t.name as Value ,
mph.DomainEntityCode as EntityCode,
e.BindingPath as BindingPath
from UI.Element e 
inner join UI.Control c on c.Id = e.ControlId 
inner join UI.Form f on e.FormId = f.Id
inner join Common.ModelPropertyHierarchy mph on mph.CodePath = e.BindingPath
full outer join sys.tables t on t.name = mph.DomainEntityCode
full outer join sys.schemas s on s.schema_id = t.schema_id
where 
f.Name = 'Request Editor' AND
e.IsDeleted >= 0 and c.Name in ('ComboBox', 'Radio List')

	select '
		declare @xml varchar(max)
		declare @datasourceId int = (select Id from Datasources where Name = ''Flow'')
		declare @queryName varchar(255)	
	'
	set @finalProcedureScript = ''
	
	open domainEntityCursor
	
	FETCH NEXT FROM domainEntityCursor 
			INTO @elementId, @tableName, @entityCode, @bindingPath
	WHILE @@FETCH_STATUS = 0
		BEGIN		
				IF(@tableName is not NULL)
				BEGIN
					set @query = (select top 1 Value from [Open].[Form] where Code = 'QueryIntegrationTemplate')
					
					set @query.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
						declare namespace d2p1 = "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Integrations";
						replace value of (/*:QueryIntegration/*:Name/text()) [1]  with sql:variable("@tableName")')
					
					set @selectScript = ('select Code As [Key], Name as [Value] from ' + @tableName)
					set @query.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
						declare namespace d2p1 = "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Integrations";
						replace value of (/*:QueryIntegration/*:QueryBuilder/*:Expression/text()) [1]  with sql:variable("@selectScript")')
					
					set @finalProcedureScript = @finalProcedureScript +  '
						set @xml = ''' + Convert(nvarchar(MAX), @query) + '''
						set @queryName = '''+@tableName+'''
						if EXISTS (select Id from  [dbo].[QueryIntegrations] where Name = @queryName)
							update [dbo].[QueryIntegrations] 
							set DevelopmentDefinitionXml = @xml, TestDefinitionXml = @xml, ProductionDefinitionXml = @xml, Datasource_Id = @datasourceId, ModifiedBy_Id = 1, ModifiedOn = GETDATE()
							WHERE Name = @queryName
						ELSE
							INSERT INTO [dbo].[QueryIntegrations] 
							(QueryIntegrationType, Name, DevelopmentDefinitionXml, TestDefinitionXml, ProductionDefinitionXml, Datasource_Id, ModifiedBy_Id, ModifiedOn, CreatedBy_Id, CreatedOn)
							 VALUES 
							(''KeyValue'', @queryName , @xml, @xml, @xml, @datasourceId, 1, Getdate(), 1, GetDate())
					'
					
					select  @finalProcedureScript
				END
				update [Open].[FlowFormNormalized] 
					set 
						SourceIntegration = @tableName, 
						EntityCode = @entityCode,
						BindingPath = @bindingPath
					where ElementId = @elementId
					 
				FETCH NEXT FROM domainEntityCursor 
				INTO @elementId, @tableName, @entityCode, @bindingPath
		END 
	CLOSE domainEntityCursor;
	DEALLOCATE domainEntityCursor;
	
END