using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Windows.Forms;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.VALORECLAMO.DAL
{
    class DALLDCAVR
    {
        //Servicio para ejecutar servicios y retornar DATA de cursor
        public DataTable cursorProcedure(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            DataSet dsgeneral = new DataSet("Tabla");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                for (int i = 0; i <= numField - 1; i++)
                {

                    switch (Type[i])
                    {
                        case "String":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, Convert.ToString(Values[i]));
                            break;
                        case "Int64":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, string.IsNullOrEmpty(Values[i].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[i]));
                            break;
                        default:
                            break;
                    }
                }
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, "Tabla");
            }
            return dsgeneral.Tables["Tabla"];
        }

        public void prApplyValorReclamo(Int64 InuTipo, Int64 InuSolicitud, String IsbComentario, Int64 Inureclamosid, Double Inuvalorreclamo, out Int64 OnuErrorCode, out  String OsbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("Ldc_PkValoresReclamo.prApplyValorReclamo"))
            {

                //Parametro Entrada
                OpenDataBase.db.AddInParameter(cmdCommand, "InuTipo", DbType.Int64, InuTipo);
                OpenDataBase.db.AddInParameter(cmdCommand, "InuSolicitud", DbType.Int64, InuSolicitud);
                OpenDataBase.db.AddInParameter(cmdCommand, "IsbComentario", DbType.String, IsbComentario);
                OpenDataBase.db.AddInParameter(cmdCommand, "Inureclamosid", DbType.Int64, Inureclamosid);
                OpenDataBase.db.AddInParameter(cmdCommand, "Inuvalorreclamo", DbType.Double, Inuvalorreclamo);
                
                //paraemtro de salida
                OpenDataBase.db.AddOutParameter(cmdCommand, "OnuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OsbErrorMessage", DbType.String, 4000);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                if (String.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "OnuErrorCode").ToString()))
                {
                    OnuErrorCode = 0;
                }
                else
                {
                    OnuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "OnuErrorCode"));
                }
                if (String.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "OsbErrorMessage").ToString()))
                {
                    OsbErrorMessage = null;
                }
                else
                {
                    OsbErrorMessage = OpenDataBase.db.GetParameterValue(cmdCommand, "OsbErrorMessage").ToString();
                }
            }
        }

    }
}
