using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Data;
using System.Data.Common;
using System.Data;
using Ludycom.Constructoras.ENTITIES;


namespace Ludycom.Constructoras.DAL
{
    class DALFGCHC
    {
        /// <summary>
        /// Se obtienen los cheques de un proyecto
        /// </summary>
        /// <param name="project">Id del proyecto</param>
        /// <returns>Retorna una tabla de datos con los cheques</returns>               
        public DataTable GetChecks(Int64 project)
        {
            DataSet dsItems = new DataSet("Cheques");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.fcrCheques"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsItems, "Cheques");
            }
            return dsItems.Tables["Cheques"];
        }

        /// <summary>
        /// Se registra un cheque
        /// </summary>
        /// <param name="project">id del proyecto/param>
        /// <param name="check">Instancia de Check</param>
        public void RegisterCheck(Int64 project, Check check)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proCreaCheques"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNUMEROCHEQUE", DbType.String, check.CheckNumber);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUENTIDADBANCARIA", DbType.Int64, check.Bank);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHA", DbType.DateTime, check.CheckDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHAALARMA", DbType.DateTime, check.AlarmDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALOR", DbType.Double, check.CheckValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBCUENTA", DbType.String, check.Account);
                              
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualiza un cheque
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="check">Instancia de Check</param>
        public void ModifyCheck(Int64 project, Check check)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proModificaCheque"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCHEQUE", DbType.Int64, check.Consecutive);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUENTIDAD", DbType.Int64, check.Bank);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBCUENTA", DbType.String, check.Account);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNUMERO_CHEQUE", DbType.String, check.CheckNumber);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHA", DbType.DateTime, check.CheckDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHAALARMA", DbType.DateTime, check.AlarmDate); 
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALOR", DbType.Double, check.CheckValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOPERACION", DbType.String, check.Operation);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para generar cupón del cheque
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="check">Instancia de Check</param>
        public Int64? GenerateCupon(Int64 project, Check check)
        {
            Int64? nullValue = null;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proGeneraCuponCuotaCheque"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCHEQUE", DbType.Int64, check.Consecutive);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBPROGRAMA", DbType.String, "FGCHC");
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCUPONGENERADO", DbType.Int64, 15);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUPONGENERADO"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUPONGENERADO"));
            }
        }

        /// <summary>
        /// Método para imprimir el cupón del cheque seleccionado
        /// </summary>
        /// <param name="cupon">id del cupon</param>
        public void PrintCupon(Int64? cupon)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proImprimeCupon"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCUPON", DbType.Int64, cupon);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para devolver el cheque
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="check">Instancia de Check</param>
        public void ReturnCheck(Int64 project, Check check)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proDevolverCheque"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCHEQUE", DbType.Int64, check.Consecutive);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para cambiar un cheque por otro, y anular el inicial
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="check">Instancia de Check</param>
        /// <param name="previousCheck">Cheque anterior</param>
        public void ChangeCheck(Int64 project, Check check, Int64 previousCheckConsecutive)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proCambiarCheque"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNUMEROCHEQUE", DbType.String, check.CheckNumber);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUENTIDADBANCARIA", DbType.Int64, check.Bank);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHA", DbType.DateTime, check.CheckDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHAALARMA", DbType.DateTime, check.AlarmDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALOR", DbType.Double, check.CheckValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBCUENTA", DbType.String, check.Account);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBCHEQUEANTERIOR", DbType.Int64, previousCheckConsecutive);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para liberar el cheque
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="check">Instancia de Check</param>
        public void LiberateCheck(Int64 project, Check check)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proLiberarCheque"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCHEQUE", DbType.Int64, check.Consecutive);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para validar si de acuerdo al área el usuario está autorizado para realizar ciertas operaciones
        /// </summary>
        /// <param name="area">Área del usuario</param>
        public bool IsAuthorized(String area)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.fblUsuarioConectPerteneceAArea"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBAREA", DbType.String, area);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }
    }
}
