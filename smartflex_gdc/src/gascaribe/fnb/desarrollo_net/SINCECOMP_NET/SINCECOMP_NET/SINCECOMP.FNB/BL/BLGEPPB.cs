using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using SINCECOMP.FNB.DAL;
using SINCECOMP.FNB.Entities ;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.BL
{
    class BLGEPPB
    {
        //soporte de insercion o actualizacion de detalle
        public static void procSaveChanges(Int64 inuprice_list_id, String operation)
        {
            DALGEPPB.procSaveChanges(inuprice_list_id, operation);
        }

        //soporte de la actuallizacion de aprobacion
        public static void procApprovedList(Int64 inuprice_list_id)
        {
            DALGEPPB.procApprovedList(inuprice_list_id);
        }

        //consecutivo para lista de precios
        //public static Int64 consPriceList()
        //{
        //    return DALGEPPB.consPriceList();
        //}

        //consecutivo para detalle de lista
        //public static Int64 consPriceListDetail()
        //{
        //    return DALGEPPB.consPriceListDetail();
        //}

        //modificar detalle lista de precios
        public static void modifyPriceListDetail(Int64 inuprice_list_deta_id, Int64 inuprice_list_id, String inuarticle_id, Decimal inuprice, Decimal inuprice_aproved,
            String inusale_chanel_id, String inugeograp_location_id, Int64 inuversion)
        {
            DALGEPPB.modifyPriceListDetail(inuprice_list_deta_id, inuprice_list_id, inuarticle_id, inuprice, inuprice_aproved, inusale_chanel_id, inugeograp_location_id, inuversion);
        }

        //guardar detalle lista de precios
        public static void savePriceListDetail(Int64 inuprice_list_deta_id, Int64 inuprice_list_id, String inuarticle_id, Decimal inuprice, Decimal inuprice_aproved,
            String inusale_chanel_id, String inugeograp_location_id, Int64 inuversion)
        {
            DALGEPPB.savePriceListDetail(inuprice_list_deta_id, inuprice_list_id, inuarticle_id, inuprice, inuprice_aproved, inusale_chanel_id, inugeograp_location_id, inuversion);
        }

        //eliminar detalle de lista de precios
        //public static void deletePriceListDetail(Int64 inuprice_list_deta_id)
        //{
        //    DALGEPPB.deletePriceListDetail(inuprice_list_deta_id);
        //}

        //eliminar lista de precios
        //public static void deletePriceList(Int64 inuprice_list_id)
        //{
        //    DALGEPPB.deletePriceList(inuprice_list_id);
        //}

        //modificar lista de precios
        public static void modifyPriceList(Int64 inuprice_list_id, String inudescription, String inusupplier_id, DateTime inuinitial_date,
            DateTime inufinal_date, String inuapproved, DateTime inucreation_date, Int64 inuversion, String inucondition_approved)
        {
            DALGEPPB.modifyPriceList(inuprice_list_id, inudescription, inusupplier_id, inuinitial_date, inufinal_date, inuapproved, inucreation_date, inuversion, inucondition_approved);
        }

        //Confirmar acciones
        //public static void Save()
        //{
        //    DALGEPPB.Save();
        //}

        //guardar lista de precios
        public static void savePriceList(Int64 inuprice_list_id, String inudescription, String inusupplier_id, DateTime inuinitial_date,
            DateTime inufinal_date, String inuapproved, DateTime inucreation_date, Int64 inuversion, String inucondition_approved)
        {
            DALGEPPB.savePriceList(inuprice_list_id, inudescription, inusupplier_id, inuinitial_date, inufinal_date, inuapproved, inucreation_date, inuversion, inucondition_approved);
        }

        //detalles de lista de precios
        public static List<DetailPrLstGEPPB> FcuDetailPriceList(Int64 inuprice_list_id)
        {
            List<DetailPrLstGEPPB> ListDetailPriceList = new List<DetailPrLstGEPPB>();
            DataTable TBDetailPriceList = DALGEPPB.getDetailPriceList(inuprice_list_id);
            //ordenar listado
            DataView VistaDatos = new DataView(TBDetailPriceList);
            VistaDatos.Sort = "Price_List_Deta_Id";
            TBDetailPriceList = VistaDatos.ToTable();
            if (TBDetailPriceList != null)
            {
                foreach (DataRow row in TBDetailPriceList.Rows)
                {
                    DetailPrLstGEPPB vDetailPriceList = new DetailPrLstGEPPB(row);
                    ListDetailPriceList.Add(vDetailPriceList);
                }
            }
            return ListDetailPriceList;
        }

        public static List<PriceListGEPPB> FcuPriceList(String userId, String typeUser)
        {
            List<PriceListGEPPB> ListPriceList = new List<PriceListGEPPB>();
            DataTable TBPriceList = DALGEPPB.getPriceList();
            //ordenar listado
            DataView VistaDatos = new DataView(TBPriceList);
            VistaDatos.Sort = "Price_List_Id";
            TBPriceList = VistaDatos.ToTable();
            String condition = "supplier_id=" + userId;
            if (TBPriceList != null)
            {
                if (typeUser == "F")
                {
                    foreach (DataRow row in TBPriceList.Rows)
                    {
                        PriceListGEPPB vPriceList = new PriceListGEPPB(row);
                        ListPriceList.Add(vPriceList);
                    }
                }
                else
                {
                    foreach (DataRow row in TBPriceList.Select(condition))
                    {
                        PriceListGEPPB vPriceList = new PriceListGEPPB(row);
                        ListPriceList.Add(vPriceList);
                    }
                }
            }
            return ListPriceList;
        }

        public static PriceListGEPPB AddRowList()
        {
            DataTable tabla = new DataTable();
            BLGENERAL general = new BLGENERAL();

            DataRow datos;
            tabla.Columns.Add("Price_List_Id");
            tabla.Columns.Add("description");
            tabla.Columns.Add("Supplier_Id");
            tabla.Columns.Add("Initial_Date");
            tabla.Columns.Add("Final_Date");
            tabla.Columns.Add("Approved");
            tabla.Columns.Add("Creation_Date");
            tabla.Columns.Add("Last_Date_Approved");
            tabla.Columns.Add("Version");
            tabla.Columns.Add("Condition_Approved");
            tabla.Columns.Add("CheckSave");
            tabla.Columns.Add("CheckModify");
            tabla.Columns.Add("ApprovedT");
            tabla.Columns.Add("AMOUNT_PRINTOUTS");
            datos = tabla.NewRow();
            datos[0] = 0;
            datos[1] = "";
            datos[2] = " ";
            datos[3] = DateTime.Now;
            datos[4] = DateTime.Now;
            //datos[5] = "";
            datos[6] = DateTime.Now;
            //datos[7] = "01/01/0001";
            //datos[8] = 0;
            datos[9] = "";
            datos[10] = 0;
            datos[11] = 0;
            datos[12] = "N";
            datos[13] = "0";
            PriceListGEPPB vPriceList = new PriceListGEPPB(datos);
            return vPriceList;
        }

        public static DetailPrLstGEPPB AddRowDetailList() 
        {
            DataTable tabla = new DataTable();
            DataRow datos;
            tabla.Columns.Add("Article_Id");
            tabla.Columns.Add("Price");
            tabla.Columns.Add("Price_Aproved");
            tabla.Columns.Add("Geograp_Location_Id");
            tabla.Columns.Add("Sale_Chanel_Id");
            tabla.Columns.Add("Price_List_Id");
            tabla.Columns.Add("Price_List_Deta_Id");
            tabla.Columns.Add("Version");
            tabla.Columns.Add("CheckSave");
            tabla.Columns.Add("CheckModify");
            datos = tabla.NewRow();
            datos[0] = " ";
            datos[1] = 1;
            datos[2] = 0;
            datos[3] = " ";
            datos[4] = " ";
            datos[5] = 0;
            datos[6] = 0;
            datos[7] = 0;
            datos[8] = 0;
            datos[9] = 0;
            DetailPrLstGEPPB vDetailPriceList = new DetailPrLstGEPPB(datos);
            return vDetailPriceList;
        }
    }
}
