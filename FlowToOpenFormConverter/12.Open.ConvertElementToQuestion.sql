GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[ConvertElementToQuestion]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [Open].[ConvertElementToQuestion]
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Set basic properties like Title and IDs>
-- =============================================
CREATE FUNCTION [Open].[ConvertElementToQuestion]
(
	@question XML, 
	@elementId int
	
)
RETURNS XML
AS
BEGIN
			
	declare @control varchar(255) = (select top 1 c.Code from UI.Element e inner join UI.Control c on e.ControlId = c.id where e.Id = @elementId)
	declare @controlTypeDefinition varchar(255) = 'd5p1:TextInputQuestion'

	if (@control = 'TextBox')
	begin
		set @controlTypeDefinition  = 'd5p1:TextInputQuestion'
		exec @question = [Open].[ConvertTextBoxToQuestion] @question,  @elementId				  
	end
	
	if (@control = 'RadioList')
	begin
		set @controlTypeDefinition  = 'd5p1:BooleanRadioButtonInputQuestion'
			  
	end
	
	if (@control = 'ComboBox')
	begin	 
	 	set @controlTypeDefinition  = 'd5p1:DropdownListInputQuestion'

	end
	
	if (@control = 'CheckBox')
	begin
		set @controlTypeDefinition  = 'd5p1:BooleanCheckboxInputQuestion'
			  
	end
	
	if (@control = 'DatePicker')
	begin
		set @controlTypeDefinition  = 'd5p1:DateTimeInputQuestion'
			  
	end
	
	if (@control = 'Label')
	begin
		set @controlTypeDefinition  = 'd5p1:TextInputQuestion'
			  
	end
	
	if (@control = 'NumberEditor' or @control = 'PercentEditor' or  @control = 'MoneyEditor')
	begin
		set @controlTypeDefinition  = 'd5p1:TextInputQuestion'
			  
	end
	
	if (@control = 'Grid')
	begin
		set @controlTypeDefinition  = 'd5p1:MultiColumnListInputQuestion'
		exec @question = [Open].[ConvertGridToQuestion] @question,  @elementId	

	end	
	
	if(@control in ( 'RadioList','DatePicker','Label', 'ComboBox', 'NumberEditor' , 'PercentEditor' ,'MoneyEditor'))	
	begin
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with sql:variable("@controlTypeDefinition") ')
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//*:Key/@*:type) [1]  with sql:variable("@controlTypeDefinition") ')
	end	  
	return @question
END
GO

