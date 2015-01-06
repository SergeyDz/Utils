using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SD.XXX.DataAccess.DAL
{
    public class DataSetManager
    {
        public DataSetManager()
        {
        }

        public DataSet FillByQueryName(string name)
        {
            string query = EmbeddedSQLQueryManager.GetSQLStatement(name);
            return FillByQueryContent(query);
        }

        public DataSet FillByQueryContent(string query)
        {
            DataSet result = new DataSet();
            using(SqlConnection connection = new SqlConnection(ConnectionStringManager.GetDefaultADONETConnectionString()))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(result);
            }
            return result;  
        }

        public DataSet FillByQueryNametWithParameters(string name, Dictionary<string, string> parameters)
        {
            DataSet result = new DataSet();
            string query = EmbeddedSQLQueryManager.GetSQLStatement(name);
            using (SqlConnection connection = new SqlConnection(ConnectionStringManager.GetDefaultADONETConnectionString()))
            {
                SqlCommand command = new SqlCommand(query, connection);
                foreach (var parameter in parameters)
                {
                    command.Parameters.Add(new SqlParameter() { 
                        ParameterName = string.Format("@{0}", parameter.Key),
                        Value = parameter.Value
                    });
                }
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(result);
            }
            return result;
        }

    }
}
