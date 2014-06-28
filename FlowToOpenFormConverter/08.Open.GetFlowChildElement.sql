GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[GetFlowChildElement]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Open].[GetFlowChildElement]
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-24>
-- Description:	<Normalize UI form to include only 1 nested level. Open don't support child-nesting levels>
-- =============================================
CREATE PROCEDURE [Open].[GetFlowChildElement]
(
	@parentElementId int,
	@newParentElementId int,
	@level int
)
AS
BEGIN

	set @level = @level + 1
	
	declare @elementId int
	declare @elementName nvarchar(2000)
	declare @controlName nvarchar(250)
	declare @elementLabel nvarchar(max) 
	
	declare childrenCursor cursor LOCAL  for 
	select e.id, e.Name, c.Code from UI.Element e 
	inner join UI.Form f on f.Id = e.FormId
	inner join UI.Control c on c.ID = e.ControlId
	where e.ParentId = @parentElementId
	order by e.Row, e.Id 
	
	open childrenCursor
	
	FETCH NEXT FROM childrenCursor 
			INTO @elementId, @elementName, @controlName
			
	WHILE @@FETCH_STATUS = 0
		BEGIN

		if((@level > 1 and @controlName = 'Panel') OR (@level > 2 and @controlName = 'Fieldset'))
		begin
			exec  [Open].[GetFlowChildElement] @elementId, @newParentElementId, @level
		end
		else
		begin
			exec @elementLabel = [Open].[GetElementPropertyByCode] @elementId, 'Label'
				 
			if (@elementLabel is null or @elementLabel = '') 
			begin
				set @elementLabel = @elementName 
			end
			
			set @elementLabel = (select replace(@elementLabel, N'’', '`'))
			set @elementLabel = (select replace(@elementLabel, N'''', '`'))
			 
			exec @elementLabel = [Open].[StripLowAscii] @string = @elementLabel
			 
			insert into [Open].[FlowFormNormalized] (ElementId, ElementName, ElementLabel, ParentId, Control) 
			values 
			(@elementId, @elementName, @elementLabel, @newParentElementId, @controlName)	
			
			exec  [Open].[GetFlowChildElement] @elementId, @elementId, @level
		end
		FETCH NEXT FROM childrenCursor 
				INTO @elementId, @elementName, @controlName
		END 
	CLOSE childrenCursor;
	DEALLOCATE childrenCursor;	
END
GO

