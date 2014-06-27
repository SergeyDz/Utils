@echo off

::Here is source connection information - Flow Database
set sourceServer=fgsqlkiev-02.fg.local\dev
set sourceDB=Flow_OMM_Dev

::Here is target connection information - Open Database
set targetServer=fgsqlkiev-02.fg.local\dev
set targetDB=opendb_sdzyuban

:: !Form with such name should exists in Open Database!
:: !Form will be overridden with new meta data. 
:: WARNING: All configuration inside existing Open form will be LOST !
set targetFormName="Test Form 2"


set rootDirectory=%~dp0


set isql=C:\Program Files\Microsoft SQL Server\100\Tools\Binn\SQLCMD.EXE

rem echo %isql%
::del err.txt log.txt

DATE /T 
DATE /T >log.txt
DATE /T >err.txt

TIME /T 
TIME /T >>log.txt
TIME /T >>err.txt
                                                                   

for  %%f IN ("%rootDirectory%??.Open.*.sql") do (echo %%f 
echo ----- %%f ----- >>log.txt
echo ----- %%f ----- >>err.txt
IF %%~zf GTR 2 "%isql%" -S %sourceServer%  -d %sourceDB% -r1 -e  -i "%%f" >>log.txt  2>>err.txt)
if not "%errorlevel%" == "0" set BatchExitCode=%errorlevel%
::pause

for  %%f IN ("%rootDirectory%*QueryIntegrations.sql") do (echo %%f 
echo ----- %%f ----- >>log.txt
echo ----- %%f ----- >>err.txt
IF %%~zf GTR 2 "%isql%"  -S %sourceServer%  -d %sourceDB% -v formname=%targetFormName%  -i "%%f" -h-1 -y0 -o "%rootDirectory%_QueryIntegrationsDataOutput.sql" >>log.txt  2>>err.txt)
if not "%errorlevel%" == "0" set BatchExitCode=%errorlevel%
::pause

for  %%f IN ("%rootDirectory%_*IntegrationsDataOutput.sql") do (echo %%f 
echo ----- %%f ----- >>log.txt
echo ----- %%f ----- >>err.txt
IF %%~zf GTR 2 "%isql%"  -S %targetServer%  -d %targetDB% -r1 -e -i "%%f">>log.txt  2>>err.txt)
if not "%errorlevel%" == "0" set BatchExitCode=%errorlevel%
::pause

for  %%f IN ("%rootDirectory%*FormXml.sql") do (echo %%f 
echo ----- %%f ----- >>log.txt
echo ----- %%f ----- >>err.txt
IF %%~zf GTR 2 "%isql%"  -S %sourceServer%  -d %sourceDB% -v formname=%targetFormName%  -i "%%f"  >>log.txt  2>>err.txt)
if not "%errorlevel%" == "0" set BatchExitCode=%errorlevel%
::pause

echo ----- "select Value from [Open].[FormDefinitions]" ----- >>log.txt
echo ----- "select Value from [Open].[FormDefinitions]" ----- >>err.txt
bcp.exe "select top 1 Value from [Open].[FormDefinitions] order by CreatedOn desc" queryout "%rootDirectory%_OpenFormXmlDataOutput.sql" -S %sourceServer%  -d %sourceDB%  -T -c
::pause

for  %%f IN ("%rootDirectory%_*XmlDataOutput.sql") do (echo %%f 
echo ----- %%f ----- >>log.txt
echo ----- %%f ----- >>err.txt
IF %%~zf GTR 2 "%isql%"  -S %targetServer%  -d %targetDB% -r1 -e -i "%%f">>log.txt  2>>err.txt)
if not "%errorlevel%" == "0" set BatchExitCode=%errorlevel%
::pause

for  %%f IN ("%rootDirectory%PostBuild.*.sql") do (echo %%f 
echo ----- %%f ----- >>log.txt
echo ----- %%f ----- >>err.txt
IF %%~zf GTR 2 "%isql%"  -S %targetServer%  -d %targetDB% -v formname=%targetFormName%  -i "%%f"  >>log.txt  2>>err.txt)
if not "%errorlevel%" == "0" set BatchExitCode=%errorlevel%
::pause


exit /b %BatchExitCode%

start err.txt

goto :EOF

:Usage
echo "Usage: CreateDB <sql sourceServer> <database name>"
echo "All parameters are required."

