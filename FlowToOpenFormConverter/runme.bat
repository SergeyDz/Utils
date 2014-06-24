@echo off

set sourceServer=fgsqlkiev-02.fg.local\dev
set sourceDB=_CCNet_Dev_RopesGray

set targetServer=fgsqlkiev-02.fg.local\dev
set targetDB=opendb_sdzyuban
set targetFormName="Test Form"


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
                                                                   

for  %%f IN ("%rootDirectory%*.*.sql") do (echo %%f 
echo ----- %%f ----- >>log.txt
echo ----- %%f ----- >>err.txt
IF %%~zf GTR 2 "%isql%" -S %sourceServer%  -d %sourceDB% -r1 -e  -i "%%f" >>log.txt  2>>err.txt)
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
bcp.exe "select Value from [Open].[FormDefinitions]" queryout "%rootDirectory%_OpenFormXmlDataOutput.sql" -S %sourceServer%  -d %sourceDB%  -T -c
::pause

for  %%f IN ("%rootDirectory%_*XmlDataOutput.sql") do (echo %%f 
echo ----- %%f ----- >>log.txt
echo ----- %%f ----- >>err.txt
IF %%~zf GTR 2 "%isql%"  -S %targetServer%  -d %targetDB% -r1 -e -i "%%f">>log.txt  2>>err.txt)
if not "%errorlevel%" == "0" set BatchExitCode=%errorlevel%
::pause

exit /b %BatchExitCode%

start err.txt

goto :EOF

:Usage
echo "Usage: CreateDB <sql sourceServer> <database name>"
echo "All parameters are required."

