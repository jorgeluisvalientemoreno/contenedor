using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.FNB.DAL;
using System.Data;

namespace SINCECOMP.FNB.BL
{
    class BLDCPU_GDC
    {

        public static String[] FtrfDeudor(String FindRequest)
        {
            
            String[] D = new String[40];

            for(int i = 1;i <= 30; i++)
            {
                D[i] = "";
            }

            DataTable TBSaleFNB = DALLDCPU_CDC.FtrfDeudor(FindRequest);
            if (TBSaleFNB != null)
            {
                D[1] = TBSaleFNB.Rows[0].ItemArray[8].ToString().Trim();
                D[2] = TBSaleFNB.Rows[0].ItemArray[9].ToString().Trim();
                D[3] = TBSaleFNB.Rows[0].ItemArray[10].ToString().Trim();
                D[4] = TBSaleFNB.Rows[0].ItemArray[11].ToString().Trim();
                D[5] = TBSaleFNB.Rows[0].ItemArray[12].ToString().Trim();
                D[6] = TBSaleFNB.Rows[0].ItemArray[13].ToString().Trim();
                D[7] = TBSaleFNB.Rows[0].ItemArray[14].ToString().Trim();
                D[8] = TBSaleFNB.Rows[0].ItemArray[15].ToString().Trim();
                D[9] = TBSaleFNB.Rows[0].ItemArray[16].ToString().Trim();
                D[10] = TBSaleFNB.Rows[0].ItemArray[17].ToString().Trim();
                D[11] = TBSaleFNB.Rows[0].ItemArray[18].ToString().Trim();
                D[12] = TBSaleFNB.Rows[0].ItemArray[19].ToString().Trim();
                D[13] = TBSaleFNB.Rows[0].ItemArray[20].ToString().Trim();
                D[14] = TBSaleFNB.Rows[0].ItemArray[21].ToString().Trim();
                D[15] = TBSaleFNB.Rows[0].ItemArray[22].ToString().Trim();
                D[16] = TBSaleFNB.Rows[0].ItemArray[23].ToString().Trim();
                D[17] = TBSaleFNB.Rows[0].ItemArray[24].ToString().Trim();
                D[18] = TBSaleFNB.Rows[0].ItemArray[25].ToString().Trim();
                D[19] = TBSaleFNB.Rows[0].ItemArray[26].ToString().Trim();
                D[20] = TBSaleFNB.Rows[0].ItemArray[27].ToString().Trim();
                D[21] = TBSaleFNB.Rows[0].ItemArray[28].ToString().Trim();
                D[22] = TBSaleFNB.Rows[0].ItemArray[30].ToString().Trim();
                D[23] = TBSaleFNB.Rows[0].ItemArray[31].ToString().Trim();
                D[24] = TBSaleFNB.Rows[0].ItemArray[36].ToString().Trim();
                D[25] = TBSaleFNB.Rows[0].ItemArray[38].ToString().Trim();
                D[26] = TBSaleFNB.Rows[0].ItemArray[43].ToString().Trim();
                D[27] = TBSaleFNB.Rows[0].ItemArray[52].ToString().Trim();
                D[28] = TBSaleFNB.Rows[0].ItemArray[55].ToString().Trim();
                D[29] = TBSaleFNB.Rows[0].ItemArray[64].ToString().Trim();
                D[30] = TBSaleFNB.Rows[0].ItemArray[65].ToString().Trim();
            }

            return D;
        }

        public static String[] FtrfCodeudor(String FindRequest)
        {
            String[] C = new String[30];

            for(int i = 1;i <= 24; i++)
            {
                C[i] = "";
            }
            DataTable TBSaleFNB = DALLDCPU_CDC.FtrfCodeudor(FindRequest);
            try
            {
                if (TBSaleFNB != null)
                {
                    C[1] = TBSaleFNB.Rows[0].ItemArray[12].ToString().Trim();
                    C[2] = TBSaleFNB.Rows[0].ItemArray[13].ToString().Trim();
                    C[3] = TBSaleFNB.Rows[0].ItemArray[14].ToString().Trim();
                    C[4] = TBSaleFNB.Rows[0].ItemArray[15].ToString().Trim();
                    C[5] = TBSaleFNB.Rows[0].ItemArray[16].ToString().Trim();
                    C[6] = TBSaleFNB.Rows[0].ItemArray[17].ToString().Trim();
                    C[7] = TBSaleFNB.Rows[0].ItemArray[18].ToString().Trim();
                    C[8] = TBSaleFNB.Rows[0].ItemArray[19].ToString().Trim();
                    C[9] = TBSaleFNB.Rows[0].ItemArray[20].ToString().Trim();
                    C[10] = TBSaleFNB.Rows[0].ItemArray[21].ToString().Trim();
                    C[11] = TBSaleFNB.Rows[0].ItemArray[22].ToString().Trim();
                    C[12] = TBSaleFNB.Rows[0].ItemArray[23].ToString().Trim();
                    C[13] = TBSaleFNB.Rows[0].ItemArray[24].ToString().Trim();
                    C[14] = TBSaleFNB.Rows[0].ItemArray[25].ToString().Trim();
                    C[15] = TBSaleFNB.Rows[0].ItemArray[26].ToString().Trim();
                    C[16] = TBSaleFNB.Rows[0].ItemArray[27].ToString().Trim();
                    C[17] = TBSaleFNB.Rows[0].ItemArray[28].ToString().Trim();
                    C[18] = TBSaleFNB.Rows[0].ItemArray[30].ToString().Trim();
                    C[19] = TBSaleFNB.Rows[0].ItemArray[31].ToString().Trim();
                    C[20] = TBSaleFNB.Rows[0].ItemArray[36].ToString().Trim();
                    C[21] = TBSaleFNB.Rows[0].ItemArray[38].ToString().Trim();
                    C[22] = TBSaleFNB.Rows[0].ItemArray[43].ToString().Trim();
                    C[23] = TBSaleFNB.Rows[0].ItemArray[52].ToString().Trim();
                    C[24] = TBSaleFNB.Rows[0].ItemArray[55].ToString().Trim();
                }
            }
            catch(Exception error)
            {
            }
            return C;
        }

    }
}
