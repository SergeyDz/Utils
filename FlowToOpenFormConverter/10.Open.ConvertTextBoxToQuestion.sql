GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[ConvertTextBoxToQuestion]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [Open].[ConvertTextBoxToQuestion]
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Set basic properties like Title and IDs>
-- =============================================
CREATE FUNCTION [Open].[ConvertTextBoxToQuestion]
(
	@question XML, 
	@elementId int
	
)
RETURNS XML
AS
BEGIN
	declare @maxlength varchar(max) 
	declare @linecount varchar(255)

	set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with "d5p1:TextInputQuestion"')	
	-- MAX LENGTH			  
	exec @maxlength =  [Open].[GetElementPropertyByCode] @elementId, 'MaxLength'
	if(@maxlength <> '' and @maxlength is not null)
	begin
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					 declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					 replace value of (//child::*:CharacterLimit/text()) [1]  with sql:variable("@maxlength")')	
	end		
	
	-- MULTY LINE		  
	exec @linecount =  [Open].[GetElementPropertyByCode] @elementId, 'LineCount'

	if(@linecount <> '' and @linecount is not null)
	begin

		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					 declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					 replace value of (//child::*:TextInputMode/text()) [1]  with "MultiLine"')	
	end		
	
					  			  
	return @question
END
GO

