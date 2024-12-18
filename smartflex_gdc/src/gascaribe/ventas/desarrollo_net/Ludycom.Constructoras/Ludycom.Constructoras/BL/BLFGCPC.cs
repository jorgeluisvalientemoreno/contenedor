using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.Constructoras.ENTITIES;
using Ludycom.Constructoras.DAL;
using System.Data;

namespace Ludycom.Constructoras.BL
{
    class BLFGCPC
    {
        DALFGCPC dalFGCPC = new DALFGCPC();

        /// <summary>
        /// Se obtienen las cuotas mensuales
        /// </summary>
        /// <param name="project">Id del proyecto</param>
        /// <returns>Retorna una lista con las cuotas mensuales</returns>               
        public List<MonthlyFee> GetMonthlyFees(Int64 project)
        {
            List<MonthlyFee> monthlyFeeList = new List<MonthlyFee>();

            DataTable dtMonthlyFee = dalFGCPC.GetMonthlyFees(project);

            foreach (DataRow item in dtMonthlyFee.Rows)
            {
                MonthlyFee tmpMonthlyFee = new MonthlyFee(item);
                monthlyFeeList.Add(tmpMonthlyFee);
            }

            return monthlyFeeList;
        }

        /// <summary>
        /// Se registra la cuota mensual
        /// </summary>
        /// <param name="project">id del proyecto/param>
        /// <param name="monthlyFee">Instancia de MonthlyFee</param>
        public void RegisterMonthlyFee(Int64 project, MonthlyFee monthlyFee)
        {
            dalFGCPC.RegisterMonthlyFee(project, monthlyFee);
        }

        /// <summary>
        /// Se actualiza la cuota mensual
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="monthlyFee">Instancia de MonthlyFee</param>
        public void ModifyMonthlyFee(Int64 project, MonthlyFee monthlyFee)
        {
            dalFGCPC.ModifyMonthlyFee(project, monthlyFee);
        }

        /// <summary>
        /// Método para generar cupón de la cuota mensual
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="monthlyFee">Instancia de MonthlyFee</param>
        public Int64? GenerateCupon(Int64 project, MonthlyFee monthlyFee)
        {
            return dalFGCPC.GenerateCupon(project, monthlyFee);
        }

        /// <summary>
        /// Método para imprimir el cupón de la cuota mensual seleccionada
        /// </summary>
        /// <param name="cupon">id del cupon</param>
        public void PrintCupon(Int64? cupon)
        {
            dalFGCPC.PrintCupon(cupon);
        }

        /// <summary>
        /// Método para obtener la deuda del proyecto
        /// </summary>
        /// <param name="project">id del proyecto</param>
        public Double GetProjectDebt(Int64 project)
        {
            return dalFGCPC.GetProjectDebt(project);
        }
    }
}
