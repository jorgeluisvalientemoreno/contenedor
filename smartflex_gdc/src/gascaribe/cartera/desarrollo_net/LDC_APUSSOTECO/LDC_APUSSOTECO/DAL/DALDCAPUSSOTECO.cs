using System;
using System.Collections.Generic;
using System.Text;
using LDC_APUSSOTECO.Entities;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;
using OpenSystems.Common.ExceptionHandler;

using System.Windows.Forms;
using OpenSystems.Common.Util;

namespace LDC_APUSSOTECO.DAL
{
    class DALDCAPUSSOTECO
    {

        /// <summary>
        /// Se obtienen los datos de los medidores
        /// </summary>
        /// <returns>Se obtienen los datos de los medidores</returns>     
        public DataTable GetDatosContratos()
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGAPUSSOTECO.fnGetDatosContrato"))
            {
                //OpenDataBase.db.AddInParameter(cmdCommand, "Nivel", DbType.Int64, nuMulti);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }


        /// <summary>
        /// Se obtiene el usuario que esta conectado en la base de datos
        /// </summary>
        /// <param name="quotationId">Usuario Conectado</param>
        /// <returns>Retorna el nombre del usuario que esta conectado</returns>
        public String getUserConect()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGAPUSSOTECO.FsbGetUserPermit"))
            {
               // OpenDataBase.db.AddInParameter(cmdCommand, "nuItems", DbType.Int64, nuItem);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se Guarda información de los medidores
        /// </summary>
        /// <param name="newItem">Actualiza informacion de medidores</param>
        public void ActualizaDatosContratos(Int64 nuContrato, String sbEstado, String sbObservacion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGAPUSSOTECO.Ldc_UpdateContratos"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, nuContrato);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbMedidor", DbType.String, sbEstado);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuDireccion", DbType.String, sbObservacion);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

    }
}
