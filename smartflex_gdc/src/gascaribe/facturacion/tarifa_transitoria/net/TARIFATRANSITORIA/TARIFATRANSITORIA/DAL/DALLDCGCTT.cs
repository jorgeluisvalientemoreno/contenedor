using System;
using System.Collections.Generic;
using System.Text;

//CASO 415
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Windows.Forms;
using OpenSystems.Common.ExceptionHandler;

namespace TARIFATRANSITORIA.DAL
{
    class DALLDCGCTT
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


        public void PRGENTRAMCANTT(Int64 inuProducto, Int64 inuMedioRecep, String isObservacion, Double inuCliente, DateTime idtFecha, out Int64 OnuPackage_id, out  Int64 onuError, out  String osbError)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONTARITRAN.PRGENTRAMCANTT"))
            {
                //Parametro Entrada
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProducto", DbType.Int64, inuProducto);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuMedioRecep", DbType.Int64, inuMedioRecep);
                OpenDataBase.db.AddInParameter(cmdCommand, "isObservacion", DbType.String, isObservacion);
                OpenDataBase.db.AddInParameter(cmdCommand, "isObservacion", DbType.Double, inuCliente);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtFecha", DbType.DateTime, idtFecha);

                //paraemtro de salida
                OpenDataBase.db.AddOutParameter(cmdCommand, "OnuPackage_id", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuError", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbError", DbType.String, 4000);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                if (String.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "OnuPackage_id").ToString()))
                {
                    OnuPackage_id = 0;
                }
                else
                {
                    OnuPackage_id = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "OnuPackage_id"));
                }
                if (OnuPackage_id > 0)
                {
                    onuError = 0;
                    osbError = null;
                }
                else
                {
                    onuError = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuError"));
                    osbError = OpenDataBase.db.GetParameterValue(cmdCommand, "osbError").ToString();
                }
            }
        }

        public static Int64 GetValidaDocumento(Int64 Inutipodoc, String Inudoc)
        {
            Int64 nuRetornaValor = 0;

            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKTARIFATRANSITORIA.GetValidaDocumento"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "Inutipodoc", DbType.Int64, Inutipodoc);
                    OpenDataBase.db.AddInParameter(cmdCommand, "Inudoc", DbType.String, Inudoc);
                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                    nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
                };
            }
            catch
            {
            }

            return nuRetornaValor;
        }

    }
}
