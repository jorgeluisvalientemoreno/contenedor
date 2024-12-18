using System;
using System.Collections.Generic;
using System.Text;

//librerias adicionales
using SINCECOMP.GESTIONORDENES.DAL;
using SINCECOMP.GESTIONORDENES.Entities;
using SINCECOMP.GESTIONORDENES.UI;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;
using Infragistics.Win;
using System.Data.OleDb;
using System.Windows.Forms;
//
using System.Reflection;
using OpenSystems.Windows.Controls;

namespace SINCECOMP.GESTIONORDENES.BL
{
    class BLGENERAL
    {
        DALGENERAL general = new DALGENERAL();

        public DataTable getValueListNumberId(String Query, String valueCodigo)
        {
            return general.getValueListNumberId(Query, valueCodigo);
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

    }
}
