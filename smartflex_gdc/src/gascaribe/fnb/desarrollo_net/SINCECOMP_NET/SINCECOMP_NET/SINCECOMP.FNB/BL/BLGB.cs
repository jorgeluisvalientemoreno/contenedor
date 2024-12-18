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
    class BLGB
    {
        //consecutivo para marcas
        public static Int64 consBrand()
        {
            return DALGB.consBrand();
        }

        //eliminar marcas
        public static void deleteBrand(Int64 inubrand_id)
        {
            DALGB.deleteBrand(inubrand_id);
        }

        //modificar marcas
        public static void modifyBrand(Int64 inubrand_id, String inudescription, String inuapproved, String inucondition_approved)
        {
            DALGB.modifyBrand(inubrand_id, inudescription, inuapproved, inucondition_approved);
        }

        //guardar marcas
        public static void saveBrand(Int64 inubrand_id, String inudescription, String inuapproved, String inucondition_approved)
        {
            DALGB.saveBrand(inubrand_id, inudescription, inuapproved, inucondition_approved);
        }

        //Confirmar acciones
        //public static void Save()
        //{
        //    DALGEPBR.Save();
        //}

        //marcas
        public static List<BrandGB> FcuBrand()
        {
            List<BrandGB> ListBrand = new List<BrandGB>();
            DataTable TBBrand = DALGB.getBrand();
            //ordenar listado
            DataView VistaDatos = new DataView(TBBrand);
            VistaDatos.Sort = "brand_id";
            TBBrand = VistaDatos.ToTable();
            if (TBBrand != null)
            {
                foreach (DataRow row in TBBrand.Rows)
                {
                    BrandGB vBrand = new BrandGB(row);
                    ListBrand.Add(vBrand);
                }
            }
            return ListBrand;
        }

        public static BrandGB AddRowList()
        {
            DataTable tabla = new DataTable();
            DataRow datos;
            tabla.Columns.Add("brand_id");
            tabla.Columns.Add("description");
            tabla.Columns.Add("approved");
            tabla.Columns.Add("condition_approved");
            tabla.Columns.Add("CheckSave");
            tabla.Columns.Add("CheckModify");
            datos = tabla.NewRow();
            datos[0] = 0;
            datos[1] = "";
            datos[2] = "";
            datos[3] = "";
            datos[4] = 0;
            datos[5] = 0;
            BrandGB vBrand = new BrandGB(datos);
            return vBrand;
        }
    }
}
