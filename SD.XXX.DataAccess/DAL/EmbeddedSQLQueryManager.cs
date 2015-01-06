using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;

namespace SD.XXX.DataAccess.DAL
{
    public class EmbeddedSQLQueryManager
    {
        private static Dictionary<string, string> content = new Dictionary<string, string>(); 

        public static string GetSQLStatement(string name)
        {
            string sqlStatement = string.Empty;

            if(content.ContainsKey(name))
            {
                return content[name];
            }
            lock (content)
            {
                string namespacePart = "SD.XXX.DataAccess";
                string folder = "SQL";
                string resourceName = string.Format("{0}.{1}.{2}", namespacePart, folder, name);

                using (Stream stm = Assembly.GetExecutingAssembly().GetManifestResourceStream(resourceName))
                {
                    if (stm != null)
                    {
                        sqlStatement = new StreamReader(stm).ReadToEnd();
                    }
                }

                if (!content.ContainsKey(name))
                    content.Add(name, sqlStatement);
            }

            return sqlStatement;
        }
    }
}
