IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Open')
begin
	exec ('create schema [Open]')
end
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[Open].[Form]'))
	create table [Open].[Form] 
	(
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[Code] [varchar](255) NOT NULL,
		[Name] [varchar](255) NULL,
		[Value] [xml] 
	)

IF NOT EXISTS(select * FROM sys.views where name = 'getNewID')
begin
	exec ('create view getNewID as select newid() as new_id')
end

delete [Open].[Form] 
--inject default template
insert into [Open].[Form] (Code, Name, Value) 
	values
	('EmptyFormTemplate',
	'EmptyFormTemplate',
	'<FormDefinition xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms">
	<Id xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model">3</Id>
	<SchemaVersion xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model">5</SchemaVersion>
	<CancelSectionId i:nil="true" />
	<DisplayDefaultCommentFieldOnCancel>true</DisplayDefaultCommentFieldOnCancel>
	<Header>
		<HeaderItems />
		<ItemsPerColumn>1</ItemsPerColumn>
	</Header>
	<Name>Form Name</Name>
	<Pages />
	<QueryIntegrations xmlns:d2p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Integrations" i:nil="true" />
	<RequestNameQuestion xmlns:d2p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions" i:nil="true" />
	<Subtitle>Subtitle</Subtitle>
	<Title i:nil="true" />
	<Variables />
</FormDefinition>')

--inject default template
insert into [Open].[Form] (Code, Name, Value) 
	values
	('EmptySectionTemplate',
	'EmptySectionTemplate',
	'<Page z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms">
			<ContainerSortOrder>0</ContainerSortOrder>
			<DisplayCriteria>
				<HideConditions xmlns:d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Conditions">
					<AdvancedExpression xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
					<CollectionType xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions">All</CollectionType>
					<Conditions xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
				</HideConditions>
				<ReadOnlyConditions xmlns:d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Conditions">
					<AdvancedExpression xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
					<CollectionType xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions">All</CollectionType>
					<Conditions xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
				</ReadOnlyConditions>
			</DisplayCriteria>
			<Id>146b3ca93d7-228-b80da0cf60</Id>
			<Items />
			<Title>Section Name</Title>
		</Page>')
		
		
		--inject default template
insert into [Open].[Form] (Code, Name, Value) 
	values
	('EmptyQuestionTemplate',
	'EmptyQuestionTemplate',
	'<FormComponentItem z:Id="i2" 
	xmlns:d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions" 
	i:type="d5p1:NumericInputQuestion"  
	xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms"
	xmlns:i="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/">
					<ContainerSortOrder>0</ContainerSortOrder>
					<d5p1:DisplayCriteria>
						<HideConditions xmlns:d7p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Conditions">
							<AdvancedExpression i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
							<CollectionType xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions">All</CollectionType>
							<Conditions xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
						</HideConditions>
						<ReadOnlyConditions xmlns:d7p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Conditions">
							<AdvancedExpression i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
							<CollectionType xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions">All</CollectionType>
							<Conditions xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
						</ReadOnlyConditions>
					</d5p1:DisplayCriteria>
					<d5p1:DisplayWidth>Half</d5p1:DisplayWidth>
					<d5p1:HelpText i:nil="true" />
					<d5p1:Id>146b4387d5b-229-6017b3477f</d5p1:Id>
					<d5p1:Name />
					<d5p1:ParentQuestionId i:nil="true" />
					<d5p1:ReadOnly>false</d5p1:ReadOnly>
					<d5p1:RequestFieldType>None</d5p1:RequestFieldType>
					<d5p1:RequirementCriteria i:nil="true" />
					<d5p1:ShowRequiredIndicator>false</d5p1:ShowRequiredIndicator>
					<d5p1:Title>Test Question</d5p1:Title>
					<d5p1:ValueIntegrationDefinition xmlns:d6p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions.Integrations" i:nil="true" />
					<d5p1:DefaultValue i:nil="true" />
					<d5p1:AllowDecimals>true</d5p1:AllowDecimals>
					<d5p1:MaxValue i:nil="true" />
					<d5p1:MinValue i:nil="true" />
				</FormComponentItem>')
		
		
				--inject default template
insert into [Open].[Form] (Code, Name, Value) 
	values
	('EmptyGroupTemplate',
	'EmptyGroupTemplate',
		'<FormComponentItem z:Id="i4" i:type="Section"
			xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms"
			xmlns:i="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/">
					<ContainerSortOrder>0</ContainerSortOrder>
					<DisplayCriteria>
						<HideConditions xmlns:d7p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Conditions">
							<AdvancedExpression xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
							<CollectionType xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions">All</CollectionType>
							<Conditions xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
						</HideConditions>
						<ReadOnlyConditions xmlns:d7p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Conditions">
							<AdvancedExpression xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
							<CollectionType xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions">All</CollectionType>
							<Conditions xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
						</ReadOnlyConditions>
					</DisplayCriteria>
					<HideSectionOutline>false</HideSectionOutline>
					<Id>146b4aee623-22b-13d8bce394f</Id>
					<Questions xmlns:d6p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions">
					</Questions>
					<Title>Group 01</Title>
				</FormComponentItem>')
											
--inject default template
insert into [Open].[Form] (Code, Name, Value) 
	values
	('EmptyGrouppedQuestionTemplate',
	'EmptyGrouppedQuestionTemplate',
		'<d5p1:Question z:Id="i5" 
		i:type="d5p1:TextInputQuestion"
		xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms"
		xmlns:i="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/"
		xmlns:d5p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions"
		>
							<ContainerSortOrder>0</ContainerSortOrder>
							<d5p1:DisplayCriteria>
								<HideConditions xmlns:d9p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Conditions">
									<AdvancedExpression i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
									<CollectionType xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions">All</CollectionType>
									<Conditions xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
								</HideConditions>
								<ReadOnlyConditions xmlns:d9p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Conditions">
									<AdvancedExpression i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
									<CollectionType xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions">All</CollectionType>
									<Conditions xmlns="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Expressions" />
								</ReadOnlyConditions>
							</d5p1:DisplayCriteria>
							<d5p1:DisplayWidth>Half</d5p1:DisplayWidth>
							<d5p1:HelpText i:nil="true" />
							<d5p1:Id>146b4b054b1-235-11db57855b5</d5p1:Id>
							<d5p1:Name />
							<d5p1:ParentQuestionId i:nil="true" />
							<d5p1:ReadOnly>false</d5p1:ReadOnly>
							<d5p1:RequestFieldType>None</d5p1:RequestFieldType>
							<d5p1:RequirementCriteria i:nil="true" />
							<d5p1:ShowRequiredIndicator>false</d5p1:ShowRequiredIndicator>
							<d5p1:Title>Untitled question</d5p1:Title>
							<d5p1:ValueIntegrationDefinition xmlns:d8p1="http://schemas.datacontract.org/2004/07/IntApp.Wilco.Model.Forms.Questions.Integrations" i:nil="true" />
							<d5p1:DefaultValue i:nil="true" />
							<d5p1:AllowDecimals>true</d5p1:AllowDecimals>
							<d5p1:MaxValue i:nil="true" />
							<d5p1:MinValue i:nil="true" />
						</d5p1:Question>')
								
		