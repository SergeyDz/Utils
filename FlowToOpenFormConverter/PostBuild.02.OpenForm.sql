GO
SET QUOTED_IDENTIFIER ON
GO

declare @xml xml = (select top 1 d.DevelopmentDefinitionXml from FormDefinitions d where Name = '$(formname)')
declare @integrationId int
declare @integrationQuery xml
declare @integrationName varchar(255)
declare integrationCursor cursor for 
SELECT  (cast(n.query('./text()') as varchar(255)))  AS EntityTypes
FROM  @xml.nodes('(//*:DatasourceIntegrationDefinition/*:IntegrationId)') AS C(n);

open integrationCursor

FETCH NEXT FROM integrationCursor 
			INTO @integrationName
	WHILE @@FETCH_STATUS = 0
		BEGIN	
			select top 1 @integrationId = id, @integrationQuery =  DevelopmentDefinitionXml 
			from dbo.QueryIntegrations where Name = @integrationName
				  	 
			set @xml.modify('replace value of (//*:DatasourceIntegrationDefinition/*:IntegrationId[text()=sql:variable("@integrationName")]/text()) [1] with sql:variable("@integrationId")') 	
			set @xml.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
				 declare namespace d2p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Integrations";
				
				 insert sql:variable("@integrationQuery") into (/*:FormDefinition/*:QueryIntegrations) [1]')
				 	 
			FETCH NEXT FROM integrationCursor 
			INTO @integrationName
		END 
	CLOSE integrationCursor;
	DEALLOCATE integrationCursor;

update  FormDefinitions 
	set DevelopmentDefinitionXml = cast(@xml as varchar(max)) 
where Name = '$(formname)'

