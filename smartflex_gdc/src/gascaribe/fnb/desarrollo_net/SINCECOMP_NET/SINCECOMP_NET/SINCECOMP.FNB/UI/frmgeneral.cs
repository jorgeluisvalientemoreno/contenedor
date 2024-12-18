#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : frmgeneral
 * Descripcion   : Información General
 * Autor         : Sidecom
 * Fecha         : -
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 29-Ago-2013  214417  jaricapa       1 - Se actualiza el tamaño de los campos.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
//agregar libreria
using OpenSystems.Windows.Controls;

namespace SINCECOMP.FNB.UI
{
    //cambiar Form por OpenForm
    public partial class frmgeneral : OpenForm
    {
        public frmgeneral()
        {
            InitializeComponent();
        }
    }
}