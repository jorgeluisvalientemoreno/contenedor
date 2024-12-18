using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using OpenSystems.Common.Util;
//
using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.UI
{
    public partial class CCPU : OpenForm
    {
        public CCPU(Int64 packageId)
        {
            InitializeComponent();
            DataTable DataBasica = BL.BLCCPU.FtrfChanges(packageId);
            List<DataPUModificada> ListChanges = new List<DataPUModificada>();
            foreach (DataRow row in DataBasica.Rows)
            {
                DataPUModificada vChanges = new DataPUModificada(row);
                ListChanges.Add(vChanges);
            }
            BindingSource changesbinding = new BindingSource();
            changesbinding.DataSource = ListChanges;
            ug_datos.DataSource = changesbinding;
        }
    }
}
