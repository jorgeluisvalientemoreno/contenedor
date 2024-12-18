using System;
using System.Collections.Generic;
using System.Text;
//
using SINCECOMP.FNB.Entities;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.DAL
{
    class DALLDINS
    {

        //nombre de funciones y procedimentos
        static String searchN = "ld_bogassubscription.procsearchcertificates"; //busqueda
        
        //buscar notificaciones
        public static DataTable searchNotification(Decimal inuseller, Decimal inupackage, Decimal inustatus, DateTime idtregisterdate, 
            Decimal inunotificationid, Decimal inupackagetype)
        {
            DataSet dsNotification = new DataSet("LDSearchNotification");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(searchN))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuseller", DbType.Decimal, inuseller);
                OpenDataBase.db.AddInParameter(cmdCommand, "inupackage", DbType.Decimal, inupackage);
                OpenDataBase.db.AddInParameter(cmdCommand, "inustatus", DbType.Int64, inustatus);

                if (DateTime.MinValue < idtregisterdate)
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtregisterdate", DbType.String, idtregisterdate.ToString("dd/MM/yyyy"));
                }
                else 
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtregisterdate", DbType.DateTime, null);                
                }
                
                OpenDataBase.db.AddInParameter(cmdCommand, "inunotificationid", DbType.Decimal, inunotificationid);
                OpenDataBase.db.AddInParameter(cmdCommand, "inupackagetype", DbType.Decimal, inupackagetype);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orfprodbypack");
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNotification, "LDSearchNotification");
            }
            
            
            return dsNotification.Tables["LDSearchNotification"];
        }

    }
}
