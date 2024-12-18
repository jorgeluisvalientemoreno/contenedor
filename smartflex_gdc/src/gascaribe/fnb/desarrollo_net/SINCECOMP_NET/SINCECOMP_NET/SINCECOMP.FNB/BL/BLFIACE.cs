using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.DAL;
using System.Data;

namespace SINCECOMP.FNB.BL
{
    class BLFIACE
    {
        public static Int64 consExtraQuota()
        {
            return DALFIACE.consExtraQuota();
        }

        public static void deleteExtraQuota(Int64 inuextra_quota_id)
        {
            DALFIACE.deleteExtraQuota(inuextra_quota_id);
        }

        public static void Save()
        {
            DALFIACE.Save();
        }

        public static void modifyExtraQuota(Int64 inuextra_quota_id, String inusupplier_id, String inucategory_id, String inusubcategory_id,
            String inugeograp_location_id, String inusale_chanel_id, String inuquota_option, Decimal inuvalue, String inuline_id,
            String inusubline_id, DateTime inuinitial_date, DateTime inufinal_date, String inuobservation, String inudocument, Object ruta, String td)
        {
            DALFIACE.modifyExtraQuota(inuextra_quota_id, inusupplier_id, inucategory_id, inusubcategory_id, inugeograp_location_id, inusale_chanel_id, inuquota_option, inuvalue, inuline_id, inusubline_id, inuinitial_date, inufinal_date, inuobservation, inudocument, ruta, td);
        }

        public static void saveExtraQuota(Int64 inuextra_quota_id, String inusupplier_id, String inucategory_id, String inusubcategory_id,
            String inugeograp_location_id, String inusale_chanel_id, String inuquota_option, Decimal inuvalue, String inuline_id,
            String inusubline_id, DateTime inuinitial_date, DateTime inufinal_date, String inuobservation, String inudocument, Object ruta, String td)
        {
            DALFIACE.saveExtraQuota(inuextra_quota_id, inusupplier_id, inucategory_id, inusubcategory_id, inugeograp_location_id, inusale_chanel_id, inuquota_option, inuvalue, inuline_id, inusubline_id, inuinitial_date, inufinal_date, inuobservation, inudocument, ruta, td);
        }

        public static List<ExtraFIACE> FcuExtraQuota()
        {
            List<ExtraFIACE> ListExtraQuota = new List<ExtraFIACE>();
            DataTable TBExtraQuota = DALFIACE.getExtraQuota();
            //ordenar listado
            DataView VistaDatos = new DataView(TBExtraQuota);
            VistaDatos.Sort = "Extra_Quota_Id";
            TBExtraQuota = VistaDatos.ToTable();
            if (TBExtraQuota != null)
            {
                foreach (DataRow row in TBExtraQuota.Rows)
                {
                    ExtraFIACE vExtraQuota = new ExtraFIACE(row);
                    ListExtraQuota.Add(vExtraQuota);
                }
            }
            return ListExtraQuota;
        }

        public static ExtraFIACE AddRowList()
        {
            DataTable tabla = new DataTable();
            DataRow datos;
            tabla.Columns.Add("extra_quota_id");
            tabla.Columns.Add("supplier_id");
            tabla.Columns.Add("category_id");
            tabla.Columns.Add("subcategory_id");
            tabla.Columns.Add("geograp_location_id");
            tabla.Columns.Add("sale_chanel_id");
            tabla.Columns.Add("quota_option");
            tabla.Columns.Add("value");
            tabla.Columns.Add("line_id");
            tabla.Columns.Add("subline_id");
            tabla.Columns.Add("initial_date");
            tabla.Columns.Add("final_date");
            tabla.Columns.Add("observation");
            tabla.Columns.Add("document");
            tabla.Columns.Add("CheckSave");
            tabla.Columns.Add("CheckModify");
            datos = tabla.NewRow();
            datos[0] = 0;
            datos[1] = " ";
            datos[2] = " ";
            datos[3] = " ";
            datos[4] = " ";
            datos[5] = " ";
            datos[6] = "";
            datos[7] = 1;
            datos[8] = " ";
            datos[9] = " ";
            datos[10] = System.DateTime.Now;
            datos[11] = System.DateTime.Now;
            datos[12] = "";
            datos[13] = "";
            datos[14] = 0;
            datos[15] = 0;
            ExtraFIACE vExtraQuota = new ExtraFIACE(datos);
            return vExtraQuota;
        }



    }
}
