using System;
using System.Collections.Generic;
using System.Text;

//Librerias
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace CONTROLDESARROLLO.DAL
{
    class DAGENERAL
    {
        //Homologaciones
        static String sentenciahomologaciones = "adm_person.frfSentence";

        //Servicio General
        public DataTable SQLGeneral(String Query)
        {
            DataSet dsValueList = new DataSet("Homologacion");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(sentenciahomologaciones))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbselect", DbType.String, Query);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsValueList, "Homologacion");
            }            
            return dsValueList.Tables["Homologacion"];
        }

    }
}
