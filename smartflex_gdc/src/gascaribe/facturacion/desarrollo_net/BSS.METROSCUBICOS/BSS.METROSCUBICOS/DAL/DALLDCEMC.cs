using System;
using System.Collections.Generic;
using System.Text;

//Libreria OPEN
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Windows.Forms;
using OpenSystems.Common.ExceptionHandler;

namespace BSS.METROSCUBICOS.DAL
{
    class DALLDCEMC
    {

        //Servicio para ejecutar servicios y retornar DATA de cursor tipo funcion
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

        //Servicio para ejecutar servicios tipo procedimiento
        public void executeService(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
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
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

    }
}
