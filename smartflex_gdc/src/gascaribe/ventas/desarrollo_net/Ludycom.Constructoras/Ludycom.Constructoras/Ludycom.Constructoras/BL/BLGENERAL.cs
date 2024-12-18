using System;

//librerias adicionales
using System.Data;
//
using OpenSystems.Windows.Controls;
using Ludycom.Constructoras.DAL;
namespace Ludycom.Constructoras.BL
{
    class BLGENERAL
    {
        DALGENERAL general = new DALGENERAL();

        public DataTable getValueListNumberId(String Query, String valueCodigo)
        {
            return general.getValueListNumberId(Query, valueCodigo);
        }

        public double ObtenerIvaConcepto(Int64 IdConcepto)
        {
           
            return  general.getIva(IdConcepto);
        }


        public OpenGridDropDown valuelistNumberId(String query, String display, String value)
        {
            DataTable tbDetail;

            if (query != string.Empty)
                tbDetail = getValueListNumberId(query, value);
            else
            {

                tbDetail = new DataTable();

                tbDetail.Columns.Add(value);
                tbDetail.Columns.Add(display);


                DataRow blanItem = tbDetail.NewRow();

                tbDetail.Rows.Add(blanItem);

            }

            OpenGridDropDown dropDowntb = new OpenGridDropDown();

            dropDowntb.DataSource = tbDetail;
            dropDowntb.ValueMember = value;
            dropDowntb.DisplayMember = display;
            dropDowntb.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;

            return dropDowntb;
        }

        public DataTable getValueList(String Query)
        {
            return general.getValueList(Query);
        }


        //Caso 200-2022
        public Int64 AplicaEntrega(String nomEntrega)
        {
            Int64 val = 0;
            if (general.AplicaEntregaxCAso(nomEntrega))
            {
                val = 1;
            }
            return val;
        }

     
    }
}
