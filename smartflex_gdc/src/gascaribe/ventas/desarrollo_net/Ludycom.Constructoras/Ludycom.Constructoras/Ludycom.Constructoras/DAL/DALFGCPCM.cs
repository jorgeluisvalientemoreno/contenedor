using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;

using Ludycom.Constructoras.ENTITIES;

namespace Ludycom.Constructoras.DAL
{
    class DALFGCPCM
    {


        public DataSet consultaCupones(String Procedure, Object[] Values)
        {
            DataSet dsgeneral = new DataSet();
            String[] tablas = { "cupones" };
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                Int64? proyecto = null;
                if (Values[2] != null)
                {
                    proyecto = Convert.ToInt64(Values[2]);
                }
                //  OpenDataBase.db.AddInParameter(cmdCommand, "inucodcliente", DbType.Int64, string.IsNullOrEmpty(Values[0].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[0]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inufechai", DbType.String, Convert.ToString(Values[0]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inufechaf", DbType.String, Convert.ToString(Values[1]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, proyecto);
               // OpenDataBase.db.AddInParameter(cmdCommand, "inuplancom", DbType.String, Convert.ToString(Values[4]));
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orcupones");
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 255);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, tablas);
            }
            return dsgeneral;
        }

        public Int64? GenerateCupon(Int64 project, Int64 consecutivo)
        {
            Int64? nullValue = null;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proGeneraCuponCuotaMensual"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCUOTA", DbType.Int64, consecutivo);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBPROGRAMA", DbType.String, "FGCPC");
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCUPONGENERADO", DbType.Int64, 15);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUPONGENERADO"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUPONGENERADO"));
            }
        }

        /// <summary>
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="numField">Número de Campos que seran enviados al Procedimiento</param>
        /// <param name="Type">Listado de Tipos de los Campos enviados. Deben ser enviados en el mismo orden de los Campos</param>
        /// <param name="Campos">Listado de Parametros o Campos enviados ha ser ejecutados por el Procedimiento</param>
        /// <param name="Values">Listado de Valores que seran asignados a los Campos</param>
        public void executeMethod(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                for (int i = 0; i <= numField - 1; i++)
                {
                    switch (Type[i])
                    {
                        case "String":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, string.IsNullOrEmpty(Values[i].ToString()) ? null : Convert.ToString(Values[i]));
                            break;
                        case "Int64":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, string.IsNullOrEmpty(Values[i].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[i]));
                            break;
                        case "DateTime":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.DateTime, string.IsNullOrEmpty(Values[i].ToString()) ? (Object)DBNull.Value : Convert.ToDateTime(Values[i]));
                            break;
                        default:
                            break;
                    }
                }
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

    }
}
