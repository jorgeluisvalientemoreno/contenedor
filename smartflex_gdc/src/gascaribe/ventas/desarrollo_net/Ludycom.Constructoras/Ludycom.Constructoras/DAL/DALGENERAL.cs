using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Windows.Forms;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.DAL
{
    class DALGENERAL
    {

        //nombre de funciones y procedimentos
        static String listavalores = "ld_boconstans.frfSentence";

        //Sentencia para generar la lista de valores
        public DataTable getValueListNumberId(String Query, String valueCodigo)
        {
            DataSet dsValueList = new DataSet("ValueList");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(listavalores))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbselect", DbType.String, Query);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsValueList, "ValueList");
            }
            DataRow blanItem = dsValueList.Tables["ValueList"].NewRow();

            dsValueList.Tables["ValueList"].Rows.InsertAt(blanItem, 0);
            return dsValueList.Tables["ValueList"];
        }

        //Tabla para datos de orden de trabajo
        public static DataTable FrfOrdenTrabajo(Int64 OrdenTrabajo)
        {
            DataSet DSDatosOrdenTrabajo = new DataSet("DatosOrdenTrabajo");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfOrdenTrabajo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "OrdenTrabajo", DbType.Int64, OrdenTrabajo);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosOrdenTrabajo, "DatosOrdenTrabajo");
            }
            return DSDatosOrdenTrabajo.Tables["DatosOrdenTrabajo"];
        }

        //Tabla para datos basicos de orden de trabajo a confirmar
        public static DataTable FrfDatosBasicos(Int64 OrdenTrabajo)
        {
            DataSet DSDatosOrdenTrabajo = new DataSet("DatosBasicosOrden");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfDatosBasicos"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "OrdenTrabajo", DbType.Int64, OrdenTrabajo);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosOrdenTrabajo, "DatosBasicosOrden");
            }
            return DSDatosOrdenTrabajo.Tables["DatosBasicosOrden"];
        }


        public DataTable getValueList(String Query)
        {
            DataSet dsValueList = new DataSet("ValueList");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(listavalores))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbselect", DbType.String, Query);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsValueList, "ValueList");
            }

            return dsValueList.Tables["ValueList"];
        }


        public double getIva(Int64 idconcepto)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.funCalculaIva"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "isbConcepto", DbType.Int64, idconcepto);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));



            }
        }

        /// <summary>
        /// Se valida la entrega
        /// </summary>
        /// <param name="nomEntrega">Nombre de la entrega</param>
        public Int64 AplicaEntrega(String nomEntrega)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_FNU_APLICAENTREGA"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNOMBRE_ENTREGA", DbType.String, nomEntrega);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se valida la entrega
        /// </summary>
        /// <param name="nomEntrega">Nombre de la entrega</param>
        public bool AplicaEntregaxCAso(String nomEntrega)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("FBLAPLICAENTREGAXCASO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNUMEROCASO", DbType.String, nomEntrega);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToBoolean(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }



        //Mostrar mensages
        public void mensajeERROR(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(2741, msj);
        }

    }
}
