GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[GetFlowChildElement]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Open].[GetFlowChildElement]
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Set basic properties like Title and IDs>
-- =============================================
CREATE PROCEDURE [Open].[GetFlowChildElement]
(
	@parentElementId int,
	@level int
)
AS
BEGIN
	
	declare @elementId int
	declare @elementName varchar(2000)
	declare @controlName varchar(250)
	
	declare childrenCursor cursor LOCAL  for 
	select e.id, e.Name, c.Code from UI.Element e 
	inner join UI.Form f on f.Id = e.FormId
	inner join UI.Control c on c.ID = e.ControlId
	where e.ParentId = @parentElementId
	
	open childrenCursor
	
	FETCH NEXT FROM childrenCursor 
			INTO @elementId, @elementName, @controlName
			
	WHILE @@FETCH_STATUS = 0
		BEGIN
		
		insert into [Open].[FlowFormNormalized] (ElementId, ElementName, ParentId, Control) 
		values 
		(@elementId, @elementName, @parentElementId, @controlName)	
		
		exec  [Open].[GetFlowChildElement] @elementId, @level
		
		FETCH NEXT FROM childrenCursor 
				INTO @elementId, @elementName, @controlName
		END 
	CLOSE childrenCursor;
	DEALLOCATE childrenCursor;	
END
GO

