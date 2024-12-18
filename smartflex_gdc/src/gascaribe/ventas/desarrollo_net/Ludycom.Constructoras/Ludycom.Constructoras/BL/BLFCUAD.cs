using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.Constructoras.DAL;
using Ludycom.Constructoras.ENTITIES;
using System.Data;

namespace Ludycom.Constructoras.BL
{
    class BLFCUAD
    {
        DALFCUAD dalFCUAD = new DALFCUAD();
        
        /// <summary>
        /// Se obtiene el detalle del acta para cuota adicional por avance de obra
        /// </summary>
        /// <param name="project">Id del proyecto</param>
        /// <returns>Retorna una tabla de datos con el detalle del acta</returns>               
        public List<WorkProgressFee> GetActDetail(Int64 project)
        {
            List<WorkProgressFee> workProgressFeeList = new List<WorkProgressFee>();
            DataTable dtWorkProgressFee = dalFCUAD.GetActDetail(project);

            foreach (DataRow item in dtWorkProgressFee.Rows)
            {
                WorkProgressFee tmpWorkProgressFee = new WorkProgressFee(item);
                workProgressFeeList.Add(tmpWorkProgressFee);
            }

            return workProgressFeeList;
        }

        /// <summary>
        /// Método para generar el cupón
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="cuponValue">valor del cupón</param>
        /// <param name="feeType">tipo de cuota adicional</param>
        /// <returns>Retorna un diccionario con los datos del cupon y la cuota generada</returns>   
        public IDictionary<String, Int64?> GenerateCupon(Int64 project, Double cuponValue, String feeType)
        {
            return dalFCUAD.GenerateCupon(project, cuponValue, feeType);
        }

        /// <summary>
        /// Método para registrar el detalle del acta para cuota adicional por avance de obra
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="feeId">id de la cuota</param>
        /// <param name="workProgFee">Instancia de WorkProgressFee</param>
        public void RegisterActDetail(Int64 project, Int64 feeId, WorkProgressFee workProgFee)
        {
            dalFCUAD.RegisterActDetail(project, feeId, workProgFee);
        }

        /// <summary>
        /// Método para imprimir el cupón
        /// </summary>
        /// <param name="cupon">cupón</param>
        public void PrintCupon(Int64 cupon)
        {
            dalFCUAD.PrintCupon(cupon);
        }

        /// <summary>
        /// Método para imprimir el acta
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="feeId">id de la cuota</param>
        public void PrintWorkProgressAct(Int64 project, Int64 feeId, String path)
        {
            dalFCUAD.PrintWorkProgressAct(project, feeId, path);
        }
    }
}
