using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.FNB.Entities;
using System.Data;
using SINCECOMP.FNB.DAL;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.BL
{
    class BLLDRVOUCHER_GDC
    {

        public static List<Datos_Adicional> FtrfAdicional(String FindRequest, Int64 CodeVoucher, out String edad, out String nombre, out String a0, out String a1, out String a2, out String a3, out String a4, out String a5, out String a6, out String a7, out String a8, out String a9, out String a10, out String a11, out String a12, out String a13, out String a14, out String a15, out String a16, out String a17, out String a18, out String a19, out String a20, out String a21, out String a22, out String a23)
        {
            edad = "0";
            nombre = "";
            a0 = "";
            a1 = "";
            a2 = "";
            a3 = "";
            a4 = "";
            a5 = "";
            a6 = "";
            a7 = "";
            a8 = "";
            a9 = "";
            a10 = "";
            a11 = "";
            a12 = "";
            a13 = "";
            a14 = "";
            a15 = "";
            a16 = "";
            a17 = "";
            a18 = "";
            a19 = "";
            a20 = "";
            a21 = "";
            a22 = "";
            a23 = "";
            List<Datos_Adicional> ListSaleFNB = new List<Datos_Adicional>();
            DataTable TBSaleFNB = DALLDRVOUCHER_GDC.FtrfAdicional(FindRequest, CodeVoucher);

            //for (int i = 0; i <= 23; i++)
            //{
            //    ExceptionHandler.DisplayMessage(2741, TBSaleFNB.Rows[0].ItemArray[i].ToString());
            //}

            if (TBSaleFNB != null)
            {
                edad = TBSaleFNB.Rows[0].ItemArray[23].ToString();
                nombre = TBSaleFNB.Rows[0].ItemArray[4].ToString();
                //
                a0 = TBSaleFNB.Rows[0].ItemArray[0].ToString();
                a1 = TBSaleFNB.Rows[0].ItemArray[1].ToString();
                a2 = TBSaleFNB.Rows[0].ItemArray[2].ToString();
                a3 = TBSaleFNB.Rows[0].ItemArray[3].ToString();
                a4 = TBSaleFNB.Rows[0].ItemArray[4].ToString();
                a5 = TBSaleFNB.Rows[0].ItemArray[5].ToString();
                a6 = TBSaleFNB.Rows[0].ItemArray[6].ToString();
                a7 = TBSaleFNB.Rows[0].ItemArray[7].ToString();
                a8 = TBSaleFNB.Rows[0].ItemArray[8].ToString();
                //formato miles sin decimal
                a9 = Convert.ToDouble(TBSaleFNB.Rows[0].ItemArray[9].ToString()).ToString("#,##0").Replace(",", ".");
                a10 = TBSaleFNB.Rows[0].ItemArray[10].ToString();
                //formato miles sin decimal
                a11 = Convert.ToDouble(TBSaleFNB.Rows[0].ItemArray[11].ToString()).ToString("#,##0").Replace(",", ".");
                //formato miles sin decimal
                a12 = Convert.ToDouble(TBSaleFNB.Rows[0].ItemArray[12].ToString()).ToString("#,##0").Replace(",", ".");
                a13 = TBSaleFNB.Rows[0].ItemArray[13].ToString();
                a14 = TBSaleFNB.Rows[0].ItemArray[14].ToString();
                a15 = TBSaleFNB.Rows[0].ItemArray[15].ToString();
                a16 = TBSaleFNB.Rows[0].ItemArray[16].ToString();
                a17 = TBSaleFNB.Rows[0].ItemArray[17].ToString();
                a18 = TBSaleFNB.Rows[0].ItemArray[18].ToString();
                a19 = TBSaleFNB.Rows[0].ItemArray[19].ToString();
                a20 = TBSaleFNB.Rows[0].ItemArray[20].ToString();
                //formato miles sin decimal
                a21 = Convert.ToDouble(TBSaleFNB.Rows[0].ItemArray[21].ToString()).ToString("#,##0").Replace(",", ".");
                //formato miles sin decimal
                a22 = Convert.ToDouble(TBSaleFNB.Rows[0].ItemArray[22].ToString()).ToString("#,##0").Replace(",", ".");
                a23 = TBSaleFNB.Rows[0].ItemArray[23].ToString();
                //
                foreach (DataRow row in TBSaleFNB.Rows)
                {
                    Datos_Adicional RowTBSaleFNB = new Datos_Adicional(row);
                    ListSaleFNB.Add(RowTBSaleFNB);
                }
            }
            return ListSaleFNB;
        }

        public static List<Datos_Comando> FtrfComando(String FindRequest, out String nombre, out String c0, out String c1, out String c2, out String c3)
        {
            nombre = "";
            c0 = "";
            c1 = "";
            c2 = "";
            c3 = "";
            List<Datos_Comando> ListSaleFNB = new List<Datos_Comando>();
            DataTable TBSaleFNB = DALLDRVOUCHER_GDC.FtrfComando(FindRequest);
            try
            {
                if (TBSaleFNB != null)
                {
                    nombre = TBSaleFNB.Rows[0].ItemArray[1].ToString();
                    c0 = TBSaleFNB.Rows[0].ItemArray[0].ToString();
                    c1 = TBSaleFNB.Rows[0].ItemArray[1].ToString();
                    c2 = TBSaleFNB.Rows[0].ItemArray[2].ToString();
                    c3 = TBSaleFNB.Rows[0].ItemArray[3].ToString();
                    foreach (DataRow row in TBSaleFNB.Rows)
                    {
                        Datos_Comando RowTBSaleFNB = new Datos_Comando(row);
                        ListSaleFNB.Add(RowTBSaleFNB);
                    }
                }
                else
                {
                    Datos_Comando RowTBSaleFNB = new Datos_Comando();
                    ListSaleFNB.Add(RowTBSaleFNB);
                }
            }
            catch(Exception error)
            {
                Datos_Comando RowTBSaleFNB = new Datos_Comando();
                ListSaleFNB.Add(RowTBSaleFNB);
            }
            return ListSaleFNB;
        }

    }
}
