Working project for call different SQL queries on DB side (void or get DataSet results back).

Tasks that were resolved: 
1. Take 'ADO.NET' connections string from Entity Framework connection declaration: ConnectionStringManager.cs
2. Store SQL code separate from C# code. 
(SQL files with queries stored as embedded resources, and retrieves by C# code by file names)
3. Dynamic number and names for SQL Parameters: see DataSetManager.cs
4. Managers for different entities provided as end-business modules