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
		
	
	DECLARE elementCursor CURSOR FOR
	select e.Id, e.Name, c.Name from UI.Element e 
	inner join UI.Control c on c.Id = e.ControlId 
	where e.ParentId = @SectionId
	order by e.Row, e.Id
	
	declare @elementId int 
	declare @elementName varchar(max) 
	declare @controlName varchar(255) 
	
	open elementCursor
	
	FETCH NEXT FROM elementCursor 
			INTO @elementId, @elementName, @controlName
	WHILE @@FETCH_STATUS = 0
		BEGIN

			declare @elementLabel varchar(max)= (select top 1 val.Value from UI.Element e
				inner join UI.ElementPropertyValue epv on e.Id = epv.ElementId
				inner join UI.Property p on p.Id = epv.PropertyId
				inner join UI.ElementPropertyValue val on val.ElementId = e.Id
				 where p.Name = 'Label' and e.Id = @elementId)
				 
			if (@elementLabel is null or @elementLabel = '') 
				set @elementLabel = @elementName 
			
			set @elementLabel = (select replace(@elementLabel, '''', '`'))
					  	 
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
				INTO @elementId, @elementName, @controlName
		END 
	CLOSE elementCursor;
	DEALLOCATE elementCursor;

	return @Section
    
END

GO


