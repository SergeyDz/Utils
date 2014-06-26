GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[ConvertGridToQuestion]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [Open].[ConvertGridToQuestion]
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Set Grid properties and children elements>
-- =============================================
CREATE FUNCTION [Open].[ConvertGridToQuestion]
(
	@question XML, 
	@elementId int
)
RETURNS XML
AS
BEGIN
		declare @childElementId int 
		declare @elementName varchar(max) 
		declare @controlName varchar(255) 
		
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					  replace value of (//@*:type) [1]  with "d5p1:MultiColumnListInputQuestion"')	
			
		declare @parentGuid uniqueidentifier = (select @question.value('(//child::*:Id/text()) [1]', 'uniqueidentifier'))
		
		  	
		
		declare @gridNestedElement XML 
		declare @gridNestedQuestion xml
		declare @gridEditorId int = (select top 1 ElementId from [Open].[FlowFormNormalized] where ParentId = @elementId and Control = 'GridColumns' ) 
		
		DECLARE gridItemsCursor CURSOR FOR
		select ElementId, ElementName, Control from [Open].[FlowFormNormalized] 
		where ParentId = @gridEditorId
		order by Id
		
			open gridItemsCursor
	
	FETCH NEXT FROM gridItemsCursor 
			INTO @childElementId, @elementName, @controlName
	WHILE @@FETCH_STATUS = 0
		BEGIN
			set @gridNestedElement = (select Value from [Open].[Form] where Code = 'GridQuestionTemplate')
			
	  
			set @gridNestedElement.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  replace value of (//child::*:Key/@*:Id) [1]  with sql:variable("@childElementId")')
					  	
			set @gridNestedElement.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  replace value of (//child::*:Key/*:ParentQuestionId/text()) [1]  with sql:variable("@parentGuid")')	
					  	  
			declare @question_guid uniqueidentifier = (select new_id from getNewID)	
			
			set @gridNestedElement.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  replace value of (//child::*:Key/*:Id/text()) [1]  with sql:variable("@question_guid")')	
			
			
					  
			exec @gridNestedElement = [Open].[ConvertElementToQuestion] @gridNestedElement, @childElementId
			
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					  declare namespace d6p1="http://schemas.microsoft.com/2003/10/Serialization/Arrays";
					  declare namespace i="http://www.w3.org/2001/XMLSchema-instance";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  insert (sql:variable("@gridNestedElement")) into (//child::*:SubQuestionNames) [1]')	
					  
			--QUESTION 	  
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					  declare namespace d6p1="http://schemas.microsoft.com/2003/10/Serialization/Arrays";
					  declare namespace i="http://www.w3.org/2001/XMLSchema-instance";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  insert <d5p1:Question z:Ref="i4" />   into (//child::*:SubQuestions) [1]')	
					  
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					  declare namespace d6p1="http://schemas.microsoft.com/2003/10/Serialization/Arrays";
					  declare namespace i="http://www.w3.org/2001/XMLSchema-instance";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  replace value of (//child::*:Question[@*:Ref="i4"]/@*:Ref) [1]  with sql:variable("@childElementId")')	  
			
				  
			FETCH NEXT FROM gridItemsCursor 
				INTO @childElementId, @elementName, @controlName
		END 
	CLOSE gridItemsCursor;
	DEALLOCATE gridItemsCursor;
		  			  
	return @question
END
GO

