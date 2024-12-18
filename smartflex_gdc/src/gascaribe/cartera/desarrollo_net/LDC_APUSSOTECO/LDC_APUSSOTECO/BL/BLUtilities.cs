using System;
using System.Collections.Generic;
using System.Text;
using LDC_APUSSOTECO.DAL;
using System.Data;

namespace LDC_APUSSOTECO.BL
{
    class BLUtilities
    {
        DALUtilities utilities = new DALUtilities();

        /// <summary>
        /// Se obtiene el resultado de una consulta para llenar un OpenCombo
        /// </summary>
        /// <param name="query">Consulta para obtener los datos necesarios para la LOV</param>
        /// <returns>Cursor con el resultado de la consulta(DataTable)</returns>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  MiguelBallesteros      1 - creación                   
        /// </changelog>
        public DataTable getListOfValue(String query)
        {   
            return utilities.GetListOfValue(query);
        }

        /// <summary>
        /// Despliega mensaje de error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void DisplayErrorMessage(String mesagge)
        {
            utilities.DisplayErrorMessage(mesagge);
        }

        /// <summary>
        /// Elevar Mensaje de Error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void RaiseERROR(String mesagge)
        {
            utilities.RaiseERROR(mesagge);
        }

        /// <summary>
        /// Despliega mensaje de Exito
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void DisplayInfoMessage(String mesagge)
        {
            utilities.DisplayInfoMessage(mesagge);
        }

        /// <summary>
        /// Hace Commit en la BD
        /// </summary>
        public void doCommit()
        {
            utilities.doCommit();
        }

        /// <summary>
        /// Hace Rollback en la BD
        /// </summary>
        public void doRollback()
        {
            utilities.doRollback();
        }

    }
}
