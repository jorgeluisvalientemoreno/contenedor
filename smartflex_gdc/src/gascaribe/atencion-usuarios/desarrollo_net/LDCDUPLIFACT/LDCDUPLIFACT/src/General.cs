using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;
using System.Windows.Forms;
using LDCDUPLIFACT.Entities;

namespace LDCDUPLIFACT.src
{
    class General
    {

        Int64? nullIntValue = null;

        public DataSet consultaEstadoCuentas(String Procedure, Object[] Values)
        {
            DataSet dsgeneral = new DataSet();
            String[] tablas = { "estacuenta" };
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContrato", DbType.Int64, string.IsNullOrEmpty(Values[0].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[0]));
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orServicios");
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 255);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, tablas);
            }
            return dsgeneral;
        }

        public Int64 GetSeq()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKDUPLIFACT.OBTSEQLOTEFACT"))
            {
                OpenDataBase.db.AddOutParameter(cmdCommand, "SEQ", DbType.Int64, 4);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Int64 seq = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "SEQ").ToString());
                return seq;
            }
        }
    }
}
