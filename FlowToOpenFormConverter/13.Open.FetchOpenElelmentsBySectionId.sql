GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[FetchOpenElelmentsBySectionId]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [Open].[FetchOpenElelmentsBySectionId]
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Get existing form elements by Section>
-- =============================================
CREATE function [Open].[FetchOpenElelmentsBySectionId] 
	(@SectionId int,
	@Section XML,
	@isFieldsetContent bit)
	Returns XML
AS 
BEGIN
	
	declare @form XML
	declare  @i int = 0
	declare @elementLabel varchar(max)
		
	
	DECLARE elementCursor CURSOR FOR
	select ElementId, ElementName, ElementLabel, Control from [Open].[FlowFormNormalized] 
	where ParentId = @SectionId 
	--DEBUG
	--and ElementId in( 270, 237) 
	--GEBUG
	order by id
	
	declare @elementId int 
	declare @elementName varchar(max) 
	declare @controlName varchar(255) 
	
	open elementCursor
	
	FETCH NEXT FROM elementCursor 
			INTO @elementId, @elementName, @elementLabel, @controlName
	WHILE @@FETCH_STATUS = 0
		BEGIN		  	 
			--QUESTION	
			declare @question_guid uniqueidentifier = (select new_id from getNewID)		
			  
			declare @question XML 
			if(@controlName = 'Fieldset' OR @controlName = 'Panel')
				begin
					set @question = (select Value from [Open].[Form] where Code = 'EmptyGroupTemplate')
					exec @question = [Open].SetQuestionBasicProperties @question,  @elementLabel, @elementId
					exec @question = [Open].ConvertElementToQuestion @question,  @elementId
					exec @question = [Open].FetchOpenElelmentsBySectionId @elementId, @question, 1
				end
			else
				begin
					if(@isFieldsetContent = 1)
						begin
							set @question = (select Value from [Open].[Form] where Code = 'EmptyGrouppedQuestionTemplate')
						end
					else
						begin
							set @question = (select Value from [Open].[Form] where Code = 'EmptyQuestionTemplate')
						end
						
					exec @question = [Open].SetQuestionBasicProperties @question,  @elementLabel, @elementId	
					exec @question = [Open].ConvertElementToQuestion @question,  @elementId
					
				end
	
			-- ATTACH QUESTION TO PARENT
				
				if(@isFieldsetContent = 1)
						begin
							set @section.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
							 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
							 insert sql:variable("@question") into (/FormComponentItem/Questions) [1]')
						end
					else
						begin
							set @section.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
							 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
							 insert sql:variable("@question") into (/Page/Items) [1]')
						end	  
			
			
			FETCH NEXT FROM elementCursor 
				INTO @elementId, @elementName, @elementLabel, @controlName
		END 
	CLOSE elementCursor;
	DEALLOCATE elementCursor;

	return @Section
    
END

GO


