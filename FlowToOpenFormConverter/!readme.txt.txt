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
	5.1 If form not exists - please create it. 
	5.2 Just to advise - please ensure Workflow Diagram are linked to this form, and request with this form can b created successfully. 
	5.3 Target Form will be overridden with new XML from Flow. All existed form content will be lost.

6. RUN "runme.bat" file 

7. Ensure err.log file do not content any error messages. It should contains only trace lines starting "------" for each of calling scripts 
8. Ensure "_OpenFormXmlDataOutput.sql" file was created. It contains XML for Intapp Open form.

9. Inside Intapp Open application
	9.1 Navigate to Forms 
	9.2 Open your "targetFormName"
	9.3 Save Form. 
	! Please, note - before You will not save Intapp Open form from application, changes will not APPLY to newly created requests. 
	9.4 Create new request. 
10. NEW !!! (1.0.2)
	10.1 Inside Administration\System\DataSources - "add new datasource"
	10.2 Name = "Flow" !!! WARNING !!! this mane should be equal to Flow !!!
	10.3 Add connection string to your Flow database
	
10. Enjoy
	
	
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

	