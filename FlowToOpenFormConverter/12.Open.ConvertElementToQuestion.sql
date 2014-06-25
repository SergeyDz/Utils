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

	if (@control = 'TextBox')
	begin
	
	exec @question = [Open].[ConvertTextBoxToQuestion] @question,  @elementId	
					  
	end
	
	if (@control = 'RadioList')
	begin
	
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with "d5p1:BooleanRadioButtonInputQuestion"')
					  
	end
	
	if (@control = 'ComboBox')
	begin
	
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with "d5p1:DropdownListInputQuestion"')
					  
	end
	
	if (@control = 'CheckBox')
	begin
	
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with "d5p1:BooleanCheckboxInputQuestion"')
					  
	end
	
	if (@control = 'DatePicker')
	begin
	
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with "d5p1:DateTimeInputQuestion"')
					  
	end
	
	if (@control = 'Label')
	begin
	
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with "d5p1:TextInputQuestion"')
					  
	end
	
	if (@control = 'NumberEditor' or @control = 'PercentEditor' or  @control = 'MoneyEditor')
	begin
	
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with "d5p1:NumericInputQuestion"')
					  
	end
	
	if (@control = 'Grid')
	begin
	
		declare @gridKeyId varchar(250) = cast(@elementId as varchar(250)) + '_gridId'
		declare @gridChildId varchar(250) = cast(@elementId as varchar(250)) + '_gridChildId'
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  replace value of (//@*:type) [1]  with "d5p1:MultiColumnListInputQuestion"')	
		
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					  declare namespace d6p1="http://schemas.microsoft.com/2003/10/Serialization/Arrays";
					  declare namespace i="http://www.w3.org/2001/XMLSchema-instance";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  insert 
					  <d6p1:KeyValueOfQuestionstringHQ4y65Wg>
						<d6p1:Key z:Id="i4" i:type="d5p1:TextInputQuestion">
							<ContainerSortOrder>0</ContainerSortOrder>
								<d5p1:DisplayCriteria>
									<HideConditions xmlns:d10p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Conditions">
										<AdvancedExpression xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
										<CollectionType xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions">All</CollectionType>
										<Conditions xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
									</HideConditions>
									<ReadOnlyConditions xmlns:d10p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Conditions">
										<AdvancedExpression xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
										<CollectionType xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions">All</CollectionType>
										<Conditions xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
									</ReadOnlyConditions>
								</d5p1:DisplayCriteria>
								<d5p1:DisplayWidth>Full</d5p1:DisplayWidth>
								<d5p1:HelpText i:nil="true" />
								<d5p1:Id>146cf0b6957-22f-13f601e040</d5p1:Id>
								<d5p1:Name />
								<d5p1:ParentQuestionId>146cf0ab1c5-22a-b7b85f842f</d5p1:ParentQuestionId>
								<d5p1:ReadOnly>false</d5p1:ReadOnly>
								<d5p1:RequestFieldType>None</d5p1:RequestFieldType>
								<d5p1:RequirementCriteria i:nil="true" />
								<d5p1:ShowRequiredIndicator>false</d5p1:ShowRequiredIndicator>
								<d5p1:Title>Test</d5p1:Title>
								<d5p1:ValueIntegrationDefinition xmlns:d9p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions.Integrations" i:nil="true" />
								<d5p1:DefaultValue i:nil="true" />
								<d5p1:DatasourceIntegrationDefinition xmlns:d9p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions.Integrations" i:nil="true" />
								<d5p1:DefaultDatasource />
								<d5p1:HintText />
						</d6p1:Key>
						<d6p1:Value>Name</d6p1:Value>
					  </d6p1:KeyValueOfQuestionstringHQ4y65Wg> 
					  into (//child::*:SubQuestionNames) [1]')	
					  
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions";
					  declare namespace d6p1="http://schemas.microsoft.com/2003/10/Serialization/Arrays";
					  declare namespace i="http://www.w3.org/2001/XMLSchema-instance";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  insert 
					  <d5p1:Question z:Ref="i4" />
					  into (//child::*:SubQuestions) [1]')		
					  
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  replace value of (//child::*:SubQuestionNames/*:KeyValueOfQuestionstringHQ4y65Wg/*:Key/@*:Id) [1]  with sql:variable("@gridKeyId")')	
					  
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					  replace value of (//child::*:SubQuestions/*:Question/@*:Ref) [1]  with sql:variable("@gridKeyId")')	
					  
		declare @question_guid uniqueidentifier = (select new_id from getNewID)	
		set @question.modify('declare default element namespace "http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms";
					  declare namespace z="http://schemas.microsoft.com/2003/10/Serialization/";
					   replace value of (//child::*:SubQuestionNames/*:KeyValueOfQuestionstringHQ4y65Wg/*:Key/*:Id/text()) [1]  with sql:variable("@question_guid")')	
					  
	end			  
	return @question
END
GO

