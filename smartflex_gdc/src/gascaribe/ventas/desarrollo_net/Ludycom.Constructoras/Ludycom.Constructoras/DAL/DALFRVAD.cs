using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Data;
using Ludycom.Constructoras.ENTITIES;
using System.Data.Common;
using System.Data;
using System.Windows.Forms;

namespace Ludycom.Constructoras.DAL
{
    class DALFRVAD
    {
        /// <summary>
        /// Método para registrar el valor adicional
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="Value">valor del cupón</param>
        /// <param name="feeType">tipo de cuota adicional</param>
        /// <returns>Retorna el número del cupón generado</returns>   
        public Int64? RegisterAdditionalValue(Int64 project, Double Value, Double Cost, String Comment, Int64? concepto)
        {
            Int64? nullValue = null;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proRegistraValorAdicional"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALOR", DbType.Double, Value);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOSTO", DbType.Double, Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOBSERVACION", DbType.String, Comment);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBCONCEPTO", DbType.Int64, concepto);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCUPON", DbType.Int64, 15);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        

                return String.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUPON"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUPON"));
            }
        }

    }
}
