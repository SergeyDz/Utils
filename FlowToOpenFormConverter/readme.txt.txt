               CompliGuard Flow UI Form to Intapp Open Form CONVERTER 
                              Version 1.0.2
                              June 27, 2014

----------------------------------------------------------------------------
Overview
----------------------------------------------------------------------------

This simple SQL based script will convert your source Flow UI form to Intapp Open UI form. 
						!For demo purposes only!

----------------------------------------------------------------------------
INSTALL and RUN
----------------------------------------------------------------------------
1. Unzip to folder on disk
2. Open for editing "runme.bat" file
3. Set "sourceServer" \ "sourceDB" connection settings to your Flow database. Note: only Windows authentication to DB supported
4. Set "targetServer" \ "targetDB" connection settings to your Open database. Note: only Windows authentication to DB supported
5. Set "targetFormName" to existed Open Form.Name. 
	5.1. If form with such name not exists - it will be created.
	5.2. If form with such name is exists - it will be overridden with new data.
	WARNING: Target Form will be overridden with new XML from Flow. All existed form content will be lost.

6. RUN "runme.bat" file 

7. Ensure err.log file do not content any error messages. It should contains only trace lines starting "------" for each of calling scripts 
8. Ensure "_OpenFormXmlDataOutput.sql" file was created. It contains XML for Intapp Open form.

9. 	new -(1.0.3)(If UI Form is new and never used before) - inside Intapp Open application
	9.1 Navigate Workflows
	9.2 Open actual Workflow diagram
	9.3 Open Deployment tab
	9.4 Under "Form Definition" - select your form name.  
	
10. Inside Intapp Open application
	10.1 Navigate to Forms 
	10.2 Open your "targetFormName"
	10.3 Save Form. 
	! Please, note - before You will not save Intapp Open form from application, changes will not APPLY to newly created requests. 
	10.4 Create new request. 
11. new -(1.0.2) Add data source to source Flow database. 
	11.1 Inside Administration\System\DataSources - "add new datasource"
	11.2 Name = "Flow" 
	!!! WARNING !!! this mane should be always equal to "Flow" !!!
	11.3 Add connection string to your Flow database
	
12. Enjoy
	
	
----------------------------------------------------------------------------
Version 1.0.3 01/07/2014 (stable)
----------------------------------------------------------------------------	
New Features:
- Added ability to add new Form by name automatically. 
- Integration Query script optimized
- Form Definitions script optimized

Features are coming soon:
- Radio List with list name options
- "User" lookups 
- static Required property
- static Lock property


----------------------------------------------------------------------------
Version 1.0.2 27/06/2014 (stable)
----------------------------------------------------------------------------	
New Features:
- Grid columns with corresponding types
- Skipped deleted sections and elements
- Combo Box content from Flow using Integrations
	
	
----------------------------------------------------------------------------
Version 1.0.1 25/06/2014 (stable)
----------------------------------------------------------------------------
Supported Features:
- Convert Elements layout. (Please, note - all nested layers deeper than 2 will be moved to higher layer.)
- Convert Elements labels
- Convert basic Element types:
	Text Box 
	Number Editor
	Combo Box
	Radio (Y/N)
	Date Picker
	Text Area
- Convert Max Length for Text Box 
- Convert grid (mock only, without internal columns and editor)


Features are coming soon:
- Grid columns
- Combo Box content from Flow (static tables)

Features are coming later:
- Intapp Open 'known' fields (like Client.Name, RequestType, etc.)
- Combo Box for Users
- Static Required

Not planned to support:
 - Hide (dynamic)
 - Lock (dynamic)
 - Required (dynamic)
 - Integration related Combo Boxes (ExecuteMethod participants)
 - Multi Column layout
 - Request Summary
 - Admin UI 

	