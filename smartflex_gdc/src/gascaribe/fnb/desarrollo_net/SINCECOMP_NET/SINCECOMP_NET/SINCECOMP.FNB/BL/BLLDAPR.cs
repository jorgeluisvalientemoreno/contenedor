using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.DAL;
using System.Data;

namespace SINCECOMP.FNB.BL
{
    class BLLDAPR
    {
        //public static Int64 consPropert()
        //{
        //    return DALLDAPR.consPropert();
        //}

        //public static void deleteProperty(Int64 inuproperty_id)
        //{
        //    DALLDAPR.deleteProperty(inuproperty_id);
        //}

        //public static void Save()
        //{
        //    DALFIACE.Save();
        //}

        public static void modifyProperty(Int64 inuproperty_id, String isbdescription)
        {
            DALLDAPR.modifyProperty(inuproperty_id, isbdescription);
        }

        public static void saveProperty(Int64 inuproperty_id, String isbdescription)
        {
            DALLDAPR.saveProperty(inuproperty_id, isbdescription);
        }

        public static List<PropLDAPR> FcuProperty()
        {
            List<PropLDAPR> ListProperty = new List<PropLDAPR>();
            DataTable TBProperty = DALLDAPR.getProperty();
            //ordenar listado
            DataView VistaDatos = new DataView(TBProperty);
            VistaDatos.Sort = "property_id";
            TBProperty = VistaDatos.ToTable();
            if (TBProperty != null)
            {
                foreach (DataRow row in TBProperty.Rows)
                {
                    PropLDAPR vProperty = new PropLDAPR(row);
                    ListProperty.Add(vProperty);
                }
            }
            return ListProperty;
        }

        public static PropLDAPR AddRowList()
        {
            DataTable tabla = new DataTable();
            DataRow datos;
            tabla.Columns.Add("property_id");
            tabla.Columns.Add("description");
            tabla.Columns.Add("CheckSave");
            tabla.Columns.Add("CheckModify");
            datos = tabla.NewRow();
            datos[0] = 0;
            datos[1] = "";
            datos[2] = 0;
            datos[3] = 0;
            PropLDAPR vProperty = new PropLDAPR(datos);
            return vProperty;
        }
    }
}
