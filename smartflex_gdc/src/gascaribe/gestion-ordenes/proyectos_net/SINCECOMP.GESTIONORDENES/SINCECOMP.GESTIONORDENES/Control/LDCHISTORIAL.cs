using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
//
using SINCECOMP.GESTIONORDENES.BL;
using SINCECOMP.GESTIONORDENES.DAL;
using SINCECOMP.GESTIONORDENES.Entities;
using SINCECOMP.GESTIONORDENES.UI;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;

namespace SINCECOMP.GESTIONORDENES.Control
{
    public partial class LDCHISTORIAL : UserControl
    {

        DALLEGO oDALLEGO = new DALLEGO();

        public LDCHISTORIAL()
        {
            InitializeComponent();

            Int64 onuOTRegistradas;
            Int64 onuOTAsignadas;
            Int64 onuOTSinFinalizar;

            oDALLEGO.PrHistorialTTLEG(out  onuOTRegistradas, out  onuOTAsignadas, out onuOTSinFinalizar);
            LblCantidadOTResgistradas.Text = onuOTRegistradas.ToString();
            LblCantidadOTAsignadas.Text = onuOTAsignadas.ToString();
            LblCantidadOTSinFinalizar.Text = onuOTSinFinalizar.ToString();


        }
    }
}
