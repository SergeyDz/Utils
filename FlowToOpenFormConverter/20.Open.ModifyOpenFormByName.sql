GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[ModifyOpenFormByName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Open].[ModifyOpenFormByName]
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Mofify existing form / or / create new one>
-- =============================================
CREATE PROCEDURE [Open].[ModifyOpenFormByName] 
	@FormName varchar(255)
AS
BEGIN
	
	declare @form XML
	declare  @i int = 0

	select @form = Value from [Open].[Form] where Code = 'EmptyFormTemplate';
	set @form.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (/FormDefinition/Name/text()) [1]  with sql:variable("@FormName")')
	
	
	DECLARE sectionCursor CURSOR FOR
	select e.id from UI.Form f
	inner join UI.Element e on e.FormId = f.Id 
	inner join UI.Control c on c.Id = e.ControlId 
	where f.Name like '%Request%Editor%' and c.Name = 'Section'  
	order by e.Row, e.Id
	
	declare @elementId int 
	
	open sectionCursor
	
	FETCH NEXT FROM sectionCursor 
			INTO @elementId
	WHILE @@FETCH_STATUS = 0
		BEGIN
	    
			declare @elementName varchar(255) = (select top 1 Name from UI.Element where Id = @elementId)
			declare @elementLabel varchar(max)= (select top 1 val.Value from UI.Element e
				inner join UI.ElementPropertyValue epv on e.Id = epv.ElementId
				inner join UI.Property p on p.Id = epv.PropertyId
				inner join UI.ElementPropertyValue val on val.ElementId = e.Id
				 where p.Name = 'Label' and e.Id = @elementId)
			
			declare @section XML =  (select Value from [Open].[Form] where Code = 'EmptySectionTemplate')
			set @section.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (/Page/Title/text()) [1]  with sql:variable("@elementLabel")')  
					  
			declare @guid uniqueidentifier = (select NEWID())
			set @section.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (/Page/Id/text()) [1]  with sql:variable("@guid")') 
					  
			set @section.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  replace value of (/Page[1]/@z:Id)  with sql:variable("@elementName")') 
			
			-- Looks for questions inside section  	 
			exec @section = [Open].FetchOpenElelmentsBySectionId @elementId, @section, 0
			
			--FORM
			set @form.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  insert sql:variable("@section") into (/FormDefinition/Pages) [1]')
			
			FETCH NEXT FROM sectionCursor 
			INTO @elementId
		END 
	CLOSE sectionCursor;
	DEALLOCATE sectionCursor;

	select @form
    
END
GO
