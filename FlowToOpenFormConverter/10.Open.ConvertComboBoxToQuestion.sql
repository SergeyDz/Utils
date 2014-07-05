GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[ConvertComboBoxToQuestion]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [Open].[ConvertComboBoxToQuestion]
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Set basic properties like Title and IDs>
-- =============================================
CREATE FUNCTION [Open].[ConvertComboBoxToQuestion]
(
	@question XML, 
	@elementId int
	
)
RETURNS XML
AS
BEGIN
		declare @controlTypeDefinition varchar(255) = 'd5p1:DropdownListInputQuestion'
		
		declare @dataSourceIntegrationDefinition xml = '<d5p1:DatasourceIntegrationDefinition xmlns:d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions" xmlns:d6p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions.Integrations">
						<d6p1:IntegrationId>100</d6p1:IntegrationId>
						<d6p1:ParameterMappings />
					</d5p1:DatasourceIntegrationDefinition>'

		declare @sourceIntegration varchar(255)
		declare @entityCode varchar(255)
		
		select top 1 @sourceIntegration = SourceIntegration, @entityCode = EntityCode 
			from [Open].[FlowFormNormalized] where ElementId = @elementId
		if(@entityCode = 'PublicUser')
			begin
				set @sourceIntegration = 'User'
				set @controlTypeDefinition =  'd5p1:AutoCompleteSingleValueInputQuestion'
			end
				
		if(@sourceIntegration <> '' and @sourceIntegration is not null)
		begin
			--declare @integrationId int = (select Id from [dbo].[QueryIntegrations] where Name = @sourceIntegration )
			
		
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					 declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					 insert sql:variable("@dataSourceIntegrationDefinition") into (/*:Question) [1]')	
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					 declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					 insert sql:variable("@dataSourceIntegrationDefinition") into (/*:KeyValueOfQuestionstringHQ4y65Wg/*:Key) [1]')
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					 declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					 declare namespace d6p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions.Integrations";
					  replace value of (//child::*:DatasourceIntegrationDefinition/*:IntegrationId/text()) [1]  with sql:variable("@sourceIntegration")')
		end
		
		
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with sql:variable("@controlTypeDefinition") ')
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//*:Key/@*:type) [1]  with sql:variable("@controlTypeDefinition") ')
					  			  
	return @question
END
GO

