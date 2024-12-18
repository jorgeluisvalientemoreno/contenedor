#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : DALLDBINEOLIMPICA
 * Descripcion   : Acceso a la base de datos para la generación del bin de olimpica
 * Autor         : 
 * Fecha         : 
 *
 * Fecha        SAO     Autor           Modificación
 * ===========  ======  ============    =====================================================================
 * 13-Sep-2013  212611  lfernandez      1 - <FtrfBineOlimpica> Se modifica para que en lugar de devolver el
 *                                          dataTable devuelva un DataSet
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.DAL
{
    class DALLDBINEOLIMPICA
    {

        public static DataSet FtrfBineOlimpica(String FindRequest)
        {

            DataSet DSineOlimpica = new DataSet("BineOlimpica");
            
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boportafolio.frfGetBineOlimpica"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inufindvalue", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSineOlimpica, "BineOlimpica");
            }

            return DSineOlimpica;
        }

        public static String FrfGetOrderEnt(String inuPackageId)
        {
            //Se busca orden de venta
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCNONBANKFINANCING.FrfGetOrderEnt"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage", DbType.Int64, Convert.ToInt64(inuPackageId));
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int64 seq;
                Int64.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out seq);
                return seq.ToString();
            }
        }

        public static String FrfGetOrderEntBinEan(String inuPackageId)
        {
            //Se busca orden de entrega en estado asignada KCienfuegos.NC1557 14/08/2014
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCNONBANKFINANCING.FrfGetOrderEntBinEan"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage", DbType.Int64, Convert.ToInt64(inuPackageId));
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int64 seq;
                Int64.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out seq);
                return seq.ToString();
            }
        }

    }
}
