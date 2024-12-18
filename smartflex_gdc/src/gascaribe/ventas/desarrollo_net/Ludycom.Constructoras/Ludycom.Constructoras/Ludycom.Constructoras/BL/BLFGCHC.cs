using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.Constructoras.DAL;
using Ludycom.Constructoras.ENTITIES;
using System.Data;

namespace Ludycom.Constructoras.BL
{
    class BLFGCHC
    {
        DALFGCHC dalFGCHC = new DALFGCHC();

        /// <summary>
        /// Se obtienen los cheques de un proyecto
        /// </summary>
        /// <param name="project">Id del proyecto</param>
        /// <returns>Retorna una lista con los cheques del proyecto</returns>               
        public List<Check> GetChecks(Int64 project)
        {
            List<Check> checksList = new List<Check>();

            DataTable dtChecks = dalFGCHC.GetChecks(project);

            foreach (DataRow item in dtChecks.Rows)
            {
                Check tmpCheck = new Check(item);
                checksList.Add(tmpCheck);
            }

            return checksList;
        }

        /// <summary>
        /// Se registra un cheque
        /// </summary>
        /// <param name="project">id del proyecto/param>
        /// <param name="check">Instancia de Check</param>
        public void RegisterCheck(Int64 project, Check check)
        {
            dalFGCHC.RegisterCheck(project, check);
        }

        /// <summary>
        /// Se actualiza un cheque
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="check">Instancia de Check</param>
        public void ModifyCheck(Int64 project, Check check)
        {
            dalFGCHC.ModifyCheck(project, check);
        }

        /// <summary>
        /// Método para generar cupón deL cheque
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="check">Instancia de Check</param>
        public Int64? GenerateCupon(Int64 project, Check check)
        {
            return dalFGCHC.GenerateCupon(project, check);
        }

        /// <summary>
        /// Método para imprimir el cupón del cheque seleccionado
        /// </summary>
        /// <param name="cupon">id del cupon</param>
        public void PrintCupon(Int64? cupon)
        {
            dalFGCHC.PrintCupon(cupon);
        }

        /// <summary>
        /// Método para devolver el cheque
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="check">Instancia de Check</param>
        public void ReturnCheck(Int64 project, Check check)
        {
            dalFGCHC.ReturnCheck(project, check);
        }

        /// <summary>
        /// Método para cambiar un cheque por otro, y anular el inicial
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="check">Instancia de Check</param>
        /// <param name="previousCheck">Cheque anterior</param>
        public void ChangeCheck(Int64 project, Check check, Int64 previousCheckConsecutive)
        {
            dalFGCHC.ChangeCheck(project, check, previousCheckConsecutive);
        }

        /// <summary>
        /// Método para liberar el cheque
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="check">Instancia de Check</param>
        public void LiberateCheck(Int64 project, Check check)
        {
            dalFGCHC.LiberateCheck(project, check);
        }

        /// <summary>
        /// Método para validar si de acuerdo al área el usuario está autorizado para realizar ciertas operaciones
        /// </summary>
        /// <param name="area">Área del usuario</param>
        public bool IsAuthorized(String area)
        {
            return dalFGCHC.IsAuthorized(area);
        }
    }
}
