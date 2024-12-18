using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;
using System.Windows.Forms;
using Oracle.DataAccess.Client;

namespace BSS.LineamientosPSPD.src
{
    class ServiceLDC_CARGINFO
    {
        public DataSet consultaContrato(String Procedure, Object[] Values)
        {
            DataSet dsgeneral = new DataSet();
            String[] tablas = { "contratos" };
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContrato", DbType.Int64, string.IsNullOrEmpty(Values[0].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[0]));
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orCursorResult");
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 255);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, tablas);

            }
            return dsgeneral;
        }

        public void ValidaCampos(String Procedure, Object[] Values, out int onuErrorCode, out String  osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "inuCausalProceso", DbType.String, string.IsNullOrEmpty(Values[0].ToString()) ? (Object)DBNull.Value : Values[0]);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbTipoCargue  ", DbType.String, string.IsNullOrEmpty(Values[1].ToString()) ? (Object)DBNull.Value : Values[1]);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbOrigenCargue", DbType.String, string.IsNullOrEmpty(Values[2].ToString()) ? (Object)DBNull.Value : Values[2]);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDocSoporte  ", DbType.String, string.IsNullOrEmpty(Values[3].ToString()) ? (Object)DBNull.Value : Values[3]);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbObsCargue", DbType.String, string.IsNullOrEmpty(Values[4].ToString()) ? (Object)DBNull.Value : Values[4]);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContrato", DbType.Int64, string.IsNullOrEmpty(Values[5].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[5]));
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 255);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                onuErrorCode = Convert.ToInt32(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));

            }
        }

        public Int64? registraCargo(String Procedure, Object[] Values)
        {
            Int64? nullValue = null;
            //DataSet dsgeneral = new DataSet();
            String[] tablas = { "contratos" };
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "iseqCarguePro", DbType.String, string.IsNullOrEmpty(Values[0].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[0]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCausalProceso", DbType.String, string.IsNullOrEmpty(Values[1].ToString()) ? (Object)DBNull.Value : Values[1]);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbTipoCargue  ", DbType.String, string.IsNullOrEmpty(Values[2].ToString()) ? (Object)DBNull.Value : Values[2]);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbOrigenCargue", DbType.String, string.IsNullOrEmpty(Values[3].ToString()) ? (Object)DBNull.Value : Values[3]);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDocSoporte  ", DbType.String, string.IsNullOrEmpty(Values[4].ToString()) ? (Object)DBNull.Value : Values[4]);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbObsCargue", DbType.String, string.IsNullOrEmpty(Values[5].ToString()) ? (Object)DBNull.Value : Values[5]);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContrato", DbType.Int64, string.IsNullOrEmpty(Values[6].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[6]));
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDirReportada", DbType.String, string.IsNullOrEmpty(Values[7].ToString()) ? (Object)DBNull.Value : Values[7]);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDirOsf", DbType.String, string.IsNullOrEmpty(Values[8].ToString()) ? (Object)DBNull.Value : Values[8]);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSuscriptorId", DbType.Int64, string.IsNullOrEmpty(Values[9].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[9]));
                OpenDataBase.db.AddInParameter(cmdCommand, "isbMotivoInclusion", DbType.String, string.IsNullOrEmpty(Values[10].ToString()) ? (Object)DBNull.Value : Values[10]);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
               /* OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orCursorResult");
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 255);*/
                //OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, tablas);

            }                    
        }

        public void registraLog(String Procedure, Object[] Values)
        {
            //Int64? nullValue = null;
            //DataSet dsgeneral = new DataSet();
            String[] tablas = { "contratos" };
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "iseqCarguePro", DbType.String, string.IsNullOrEmpty(Values[0].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[0]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCountCarg", DbType.String, string.IsNullOrEmpty(Values[1].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[1]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCountPro  ", DbType.String, string.IsNullOrEmpty(Values[2].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[2]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCountNoPro", DbType.String, string.IsNullOrEmpty(Values[3].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[3]));
                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

            }

        }

        public DataSet GetTEMP(String Procedure)
        {
            DataSet dsgeneral = new DataSet();
            String[] tablas = { "contratos" };
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                //OpenDataBase.db.AddInParameter(cmdCommand, "inuContrato", DbType.Int64, string.IsNullOrEmpty(Values[0].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[0]));
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orCursorResult");
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, tablas);

            }
            return dsgeneral;
        }

        public void SentenceTEMP(String instance)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetSqlStringCommand(instance))
            {
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

            }
        }
    }
}
