using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using OpenSystems.Common.Data;
using System.Data.Common;
using OpenSystems.Common.ExceptionHandler;

using System.Windows.Forms;



namespace LDCGESTTA.DAL
{
    class DALUtilities
    {
        /// <summary>
        /// Se obtiene el resultado de una consulta para llenar un OpenCombo
        /// </summary>
        /// <param name="query">Consulta para obtener los datos requeridos</param>
        /// <returns>Cursor con el resultado de la consulta</returns>
        public DataTable GetListOfValue(String query)
        {
            DataSet dsLOV = new DataSet("ListOfValues");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boconstans.frfSentence"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbselect", DbType.String, query); 
                OpenDataBase.db.AddReturnRefCursor(cmdCommand); 
                OpenDataBase.db.LoadDataSet(cmdCommand, dsLOV, "ListOfValues"); 
            }

            return dsLOV.Tables["ListOfValues"];
        }

        /// <summary>
        /// Despliega mensaje de error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void DisplayErrorMessage(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(2741, msj);
        }

        /// <summary>
        /// Elevar Mensaje de Error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void RaiseERROR(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.Raise(2741, msj);
        }

        /// <summary>
        /// Despliega mensaje de Exito
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void DisplayInfoMessage(String mesagge)
        {
            ExceptionHandler.DisplayMessage(2741, mesagge);
        }

        /// <summary>
        /// Hace Commit en la BD
        /// </summary>
        public void doCommit()
        {
            OpenDataBase.Transaction.Commit();
        }

        /// <summary>
        /// Hace Rollback en la BD
        /// </summary>
        public void doRollback()
        {
            OpenDataBase.Transaction.Rollback();
        }
    }
}
