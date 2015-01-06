using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.EntityClient;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SD.XXX.DataAccess.DAL;

namespace SD.XXX.DataAccess
{
    public class EntityManager
    {

        public DataSet GetFeeSchedule()
        {
            DataSetManager manager = new DataSetManager();
            return manager.FillByQueryName("FeeSchedule.select.sql");
        }

        public DataSet GetExpenseSchedule()
        {
            DataSetManager manager = new DataSetManager();
            return manager.FillByQueryName("ExpenseSchedule.select.sql");
        }

        public DataSet GetBillingAgrement()
        {
            DataSetManager manager = new DataSetManager();
            return manager.FillByQueryName("BillingAgrement.select.sql");
        }

        public DataSet GetBillFrequency()
        {
            DataSetManager manager = new DataSetManager();
            return manager.FillByQueryName("BillFrequency.select.sql");
        }

    }
}
