using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using SINCECOMP.FNB.DAL;
using SINCECOMP.FNB.Entities;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.BL
{
    class BLGEC
    {
        //consecutivo para Articulos
        //public static Int64 consCommission()
        //{
        //    return DALGEC.consCommission();
        //}

        //eliminar comision
        //public static void deleteComission(Int64 inucommission_id)
        //{
        //    DALGEC.deleteComission(inucommission_id);
        //}

        //modificar comisiones
        public static void modifyCommission(Int64 commisionid, String articleid, String salechanelid, String geograplocationid,
            String contratorid, Decimal recoverypercentage, Decimal pymentpercentage, DateTime initialdate, String incluvatpaycommi,
            String incluvatrecocommi, String lineid, String sublineid, String supplierid)
        {
            DALGEC.modifyCommission(commisionid, articleid, salechanelid, geograplocationid, contratorid, recoverypercentage, pymentpercentage, initialdate, incluvatpaycommi, incluvatrecocommi, lineid, sublineid, supplierid);
        }

        //guardar comisiones
        public static void saveCommission(Int64 commisionid, String articleid, String salechanelid, String geograplocationid,
            String contratorid, Decimal recoverypercentage, Decimal pymentpercentage, DateTime initialdate, String incluvatpaycommi,
            String incluvatrecocommi, String lineid, String sublineid, String supplierid)
        {
            DALGEC.saveCommission(commisionid, articleid, salechanelid, geograplocationid, contratorid, recoverypercentage, pymentpercentage, initialdate, incluvatpaycommi, incluvatrecocommi, lineid, sublineid, supplierid);
        }

        ////Confirmar acciones
        //public static void Save()
        //{
        //    DALGEPBR.Save();
        //}

        //Comisiones
        public static List<ComArtGEC> FcuCommission()
        {
            List<ComArtGEC> ListCommission = new List<ComArtGEC>();
            DataTable TBCommission = DALGEC.getCommission();
            //ordenar listado
            DataView VistaDatos = new DataView(TBCommission);
            VistaDatos.Sort = "commission_id";
            TBCommission = VistaDatos.ToTable();
            if (TBCommission != null)
            {
                foreach (DataRow row in TBCommission.Rows)
                {
                    ComArtGEC vCommission = new ComArtGEC(row);
                    ListCommission.Add(vCommission);
                }
            }
            return ListCommission;
        }

        public static ComArtGEC AddRowListc()
        {
            DataTable tabla = new DataTable();
            DataRow datos;
            tabla.Columns.Add("commission_id");
            tabla.Columns.Add("article_id");
            tabla.Columns.Add("line_id");
            tabla.Columns.Add("subline_id");
            tabla.Columns.Add("sale_chanel_id");
            tabla.Columns.Add("geograp_location_id");
            tabla.Columns.Add("contrator_id");
            tabla.Columns.Add("recovery_percentage");
            tabla.Columns.Add("pyment_percentage");
            tabla.Columns.Add("inclu_vat_reco_commi");
            tabla.Columns.Add("inclu_vat_pay_commi");
            tabla.Columns.Add("initial_date");
            tabla.Columns.Add("supplier_id");
            tabla.Columns.Add("CheckSave");
            tabla.Columns.Add("CheckModify");
            datos = tabla.NewRow();
            datos[0] = 0;
            datos[1] = " ";
            datos[2] = " ";
            datos[3] = " ";
            datos[4] = " ";
            datos[5] = " ";
            datos[6] = " ";
            datos[7] = 0;
            datos[8] = 0;
            datos[9] = "";
            datos[10] = "";
            datos[11] = "01/01/01";
            datos[12] = " ";
            datos[13] = 0;
            datos[14] = 0;
            ComArtGEC vCommission = new ComArtGEC(datos);
            return vCommission;
        }
    }
}
