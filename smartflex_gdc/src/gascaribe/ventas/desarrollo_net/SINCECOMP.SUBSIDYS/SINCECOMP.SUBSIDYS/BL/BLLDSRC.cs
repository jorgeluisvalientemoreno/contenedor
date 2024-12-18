using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.SUBSIDYS.Entities;
using System.Data;
using SINCECOMP.SUBSIDYS.DAL;


namespace SINCECOMP.SUBSIDYS.BL
{
    class BLLDSRC
    {
        DALGENERAL general = new DALGENERAL();

        public List<acta> FcuSubsidy(String Procedure, int numField, String[] Type, String[] Campos, String[] Values, out Int64 total)
        {
            List<acta> ListSubsidy = new List<acta>();
            DataTable TBSubsidy = general.cursorProcedure (Procedure, numField, Type, Campos, Values);
            total = 0;
            if (TBSubsidy != null)
            {
                int contador = 1;
                foreach (DataRow row in TBSubsidy.Rows)
                {
                    acta vSubsidy = new acta(row, contador++);
                    ListSubsidy.Add(vSubsidy);
                    if (Convert.IsDBNull(row["Subsidy_Value"]) != true)
                        total = total + Convert.ToInt64(row["Subsidy_Value"]);
                }
            }
            return ListSubsidy;
        }

      

    }
}
