using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.EntityClient;
using System.Linq;
using System.Text;

namespace SD.XXX.DataAccess.DAL
{
    internal class ConnectionStringManager
    {
        public static string GetADONETConnectionString(string connectionsStringName)
        {
            string connectionString = ConfigurationManager.ConnectionStrings[connectionsStringName].ConnectionString;
            EntityConnectionStringBuilder connectionStringBuilder = new EntityConnectionStringBuilder(connectionString);
            return connectionStringBuilder.ProviderConnectionString;
        }

        public static string GetDefaultADONETConnectionString()
        {
            return GetADONETConnectionString(ConfigurationManager.AppSettings["XXXAPIEntitiesConnectionStringName"]);
        }
    }
}
