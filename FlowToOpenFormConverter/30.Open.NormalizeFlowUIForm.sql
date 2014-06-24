	--PREPARE FLOW UI FORM 
	delete [Open].[FlowFormNormalized]
	declare @sectionContainerId int = (
			select top 1 e.id from UI.Element e 
			inner join UI.Form f on f.Id = e.FormId
			inner join UI.Control c on c.ID = e.ControlId
			where f.Name = 'Request Editor' and c.code = 'SectionContainer'
			order by e.Row, e.Id)
			
	exec [Open].[GetFlowChildElement] @sectionContainerId, @sectionContainerId, 0

	--