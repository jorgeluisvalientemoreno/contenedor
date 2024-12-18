using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using Ludycom.Constructoras.ENTITIES;

namespace Ludycom.Constructoras.DAL
{
    class DALFGCPC
    {
        /// <summary>
        /// Se obtienen las cuotas mensuales
        /// </summary>
        /// <param name="project">Id del proyecto</param>
        /// <returns>Retorna una tabla de datos con las cuotas mensuales</returns>               
        public DataTable GetMonthlyFees(Int64 project)
        {
            DataSet dsItems = new DataSet("CuotasMensuales");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.fcrCuotasMensuales"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsItems, "CuotasMensuales");
            }
            return dsItems.Tables["CuotasMensuales"];
        }

        /// <summary>
        /// Se registra la cuota mensual
        /// </summary>
        /// <param name="project">id del proyecto/param>
        /// <param name="monthlyFee">Instancia de MonthlyFee</param>
        public void RegisterMonthlyFee(Int64 project, MonthlyFee monthlyFee)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proCreaCuotasMensuales"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHACOBRO", DbType.DateTime, monthlyFee.BillingDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALOR", DbType.Double, monthlyFee.FeeValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHAALARMA", DbType.DateTime, monthlyFee.AlarmDate);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualiza la cuota mensual
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="monthlyFee">Instancia de MonthlyFee</param>
        public void ModifyMonthlyFee(Int64 project, MonthlyFee monthlyFee)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proModificaCuotaMensual"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCUOTA", DbType.Int64, monthlyFee.Id);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHACOBROPROGRAMADA", DbType.DateTime, monthlyFee.BillingDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALOR", DbType.Double, monthlyFee.FeeValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHAALARMA", DbType.DateTime, monthlyFee.AlarmDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOPERACION", DbType.String, monthlyFee.Operation);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para generar cupón de la cuota mensual
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="monthlyFee">Instancia de MonthlyFee</param>
        public Int64? GenerateCupon(Int64 project, MonthlyFee monthlyFee)
        {
            Int64? nullValue = null;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proGeneraCuponCuotaMensual"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCUOTA", DbType.Int64, monthlyFee.Id);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBPROGRAMA", DbType.String, "FGCPC");
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCUPONGENERADO", DbType.Int64, 15);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUPONGENERADO"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUPONGENERADO"));
            }
        }

        /// <summary>
        /// Método para imprimir el cupón de la cuota mensual seleccionada
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
        /// Método para obtener la deuda del proyecto
        /// </summary>
        /// <param name="project">id del proyecto</param>
        public Double GetProjectDebt(Int64 project)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.proDeudaProyecto"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUDEUDA", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUFINANCIACION", DbType.Int64, 15);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUDEUDA"));
            }
        }

    }
}

