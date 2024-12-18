#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : LDBINEOLIMPICA
 * Descripcion   : Reporte bin
 * Autor         : 
 * Fecha         : 
 *
 * Fecha        SAO     Autor           Modificación
 * ===========  ======  ============    =====================================================================
 * 13-Sep-2013  212611  lfernandez      1 - Se elimina lógica porque no se usa
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
//
using SINCECOMP.FNB.BL;
using Microsoft.Reporting.WinForms;

namespace SINCECOMP.FNB.UI
{
    public partial class LDBINEOLIMPICA : Form
    {

        String FindRequest;

        public LDBINEOLIMPICA(String findRequest)
        {
            InitializeComponent();
        }

        private void LDBINEOLIMPICA_Load(object sender, EventArgs e)
        {
        }

    }
}