GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[GetElementPropertyByCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [Open].[GetElementPropertyByCode]
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-19>
-- Description:	<Set basic properties like Title and IDs>
-- =============================================
CREATE FUNCTION [Open].[GetElementPropertyByCode]
(
	@elementId int,
	@propertyCode varchar(255)
)
RETURNS varchar(max)
AS
BEGIN

	declare @result varchar(max)
	
	set @result = (select top 1  epv.Value from UI.Element e
	inner join UI.Control c on c.Id = e.ControlId
	inner join UI.ElementPropertyValue epv on epv.ElementId = e.Id
	inner join UI.Property p on epv.PropertyId = p.id
	where e.Id = @elementId and p.Code = @propertyCode)
	
	return @result
		
END
GO

