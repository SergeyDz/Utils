GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[SetQuestionBasicProperties]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [Open].[SetQuestionBasicProperties]
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Set basic properties like Title and IDs>
-- =============================================
CREATE FUNCTION [Open].[SetQuestionBasicProperties]
(
	@question XML, 
	@elementLabel varchar(max),
	@elementId int
	
)
RETURNS XML
AS
BEGIN
			declare @question_guid uniqueidentifier = (select new_id from getNewID)		

			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					  replace value of (//child::*:Title/text()) [1]  with sql:variable("@elementLabel")') 
					
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					 declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					  replace value of (//child::*:Id/text()) [1]  with sql:variable("@question_guid")')
					  	  
			set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  replace value of (//@*:Id) [1]  with sql:variable("@elementId")') 
  
			return @question

END
GO

