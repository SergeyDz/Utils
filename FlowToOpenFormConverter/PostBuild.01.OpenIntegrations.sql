GO
SET QUOTED_IDENTIFIER ON
GO

declare @xml xml 
declare @queryId int
declare @sourceId int
declare @queryName varchar(255)

declare integrationQueryCursor cursor for 
select Id, Name, DevelopmentDefinitionXml, DataSource_Id from QueryIntegrations i 
	where i.QueryIntegrationType = 'KeyValue' 
	AND DataSource_Id = (select top 1 Id from DataSources where Name = 'Flow')
	
open integrationQueryCursor

FETCH NEXT FROM integrationQueryCursor 
			INTO @queryId, @queryName, @xml, @sourceId
	WHILE @@FETCH_STATUS = 0
		BEGIN	
			
			set @xml.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
			declare namespace d2p1 = "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Integrations";
					declare namespace i="http://www.w3.org/2001/XMLSchema-instance";
					replace value of (/*:QueryIntegration/*:Id/text()) [1]  with sql:variable("@queryId")') 
					
			set @xml.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
			declare namespace d2p1 = "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Integrations";
					declare namespace i="http://www.w3.org/2001/XMLSchema-instance";
					replace value of (/*:QueryIntegration/*:DatasourceId/text()) [1]  with sql:variable("@sourceId")')
			
			update QueryIntegrations
				set 
					DevelopmentDefinitionXml = cast(@xml as varchar(max)),
					TestDefinitionXml =  cast(@xml as varchar(max)),
					ProductionDefinitionXml = cast(@xml as varchar(max))
				WHERE Id = @queryId
			
			FETCH NEXT FROM integrationQueryCursor 
			INTO @queryId, @queryName, @xml, @sourceId
		END 
	CLOSE integrationQueryCursor;
	DEALLOCATE integrationQueryCursor;


