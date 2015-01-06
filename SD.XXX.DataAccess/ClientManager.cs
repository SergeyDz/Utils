using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using SD.XXX.DataAccess.DAL;

namespace SD.XXX.DataAccess
{
    public class ClientManager
    {
        public string GetMaxUnusedNumber()
        {
            string code = string.Empty;
            DataSetManager manager = new DataSetManager();
            var result =  manager.FillByQueryName("Client.GetMaxUnusedNumber.select.sql");
            return GetCodeString(result);
        }
        
        public string GetNextUnusedNumber()
        {
            string code = string.Empty;
            DataSetManager manager = new DataSetManager();
            var result =  manager.FillByQueryName("Client.GetNextUnusedNumber.select.sql");
            return GetCodeString(result);
        }

        private static string GetCodeString(DataSet result)
        {
            string code = string.Empty;
            if (result != null)
            {
                code = result.Tables[0].Rows[0]["Code"].ToString();
            }
            return code;
        }
    }
}
