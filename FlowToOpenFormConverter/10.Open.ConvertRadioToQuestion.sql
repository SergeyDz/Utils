GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[ConvertRadioToQuestion]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [Open].[ConvertRadioToQuestion]
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Set basic properties like Title and IDs>
-- =============================================
CREATE FUNCTION [Open].[ConvertRadioToQuestion]
(
	@question XML, 
	@elementId int
	
)
RETURNS XML
AS
BEGIN
		declare @controlTypeDefinition varchar(255) = 'd5p1:BooleanRadioButtonInputQuestion'
		declare @dataSourceIntegrationDefinition xml = '<d5p1:DatasourceIntegrationDefinition xmlns:d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions" xmlns:d6p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions.Integrations">
						<d6p1:IntegrationId>100</d6p1:IntegrationId>
						<d6p1:ParameterMappings />
					</d5p1:DatasourceIntegrationDefinition>'

		declare @entityName varchar(255) = (select top 1 SourceIntegration from [Open].[FlowFormNormalized] where ElementId = @elementId)
			
		if(@entityName <> '' and @entityName is not null)
		begin
		
			set @controlTypeDefinition  = 'd5p1:RadioButtonListInputQuestion'
			--declare @integrationId int = (select Id from [dbo].[QueryIntegrations] where Name = @entityName )
		
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					 declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					 insert sql:variable("@dataSourceIntegrationDefinition") into (/*:Question) [1]')	
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					 declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					 declare namespace d6p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions.Integrations";
					 replace value of (//child::*:DatasourceIntegrationDefinition/*:IntegrationId/text()) [1]  with sql:variable("@entityName")')
					  
			declare @repeatCount xml = ' <d5p1:RepeatCount xmlns:d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions">0</d5p1:RepeatCount>'
			declare @repeatDirection xml = '<d5p1:RepeatDirection xmlns:d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions">Horizontal</d5p1:RepeatDirection>'
			declare @defaultDataSource xml = '<d5p1:DefaultDatasource xmlns:d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions" xmlns:d8p1="http://schemas.microsoft.com/2003/10/Serialization/Arrays" />'
								 
			declare @orientation varchar(255)
			exec @orientation = [Open].[GetElementPropertyByCode] @elementId, 'Orientation'
			if(@orientation <> '' and @orientation is not null)
			begin
				set @repeatDirection.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
						 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
						 replace value of (/d5p1:RepeatDirection/text()) [1]  with sql:variable("@orientation")')
				end
			
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					 declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					 insert sql:variable("@repeatCount") into (/*:Question) [1]')	
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					 declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					 insert sql:variable("@defaultDataSource") into (/*:Question) [1]')	
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					 declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					 insert sql:variable("@repeatDirection") into (/*:Question) [1]')
		
		end
		
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with sql:variable("@controlTypeDefinition") ')
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//*:Key/@*:type) [1]  with sql:variable("@controlTypeDefinition") ')
					  			  
	return @question
END
GO

