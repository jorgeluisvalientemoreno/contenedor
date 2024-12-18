using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

//librerias Open
using SINCECOMP.GESTIONORDENES.BL;
using SINCECOMP.GESTIONORDENES.DAL;
using OpenSystems.Windows.Controls;
using SINCECOMP.GESTIONORDENES;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;
using SINCECOMP.GESTIONORDENES.Control;

namespace SINCECOMP.GESTIONORDENES.UI
{
    public partial class LEGO : OpenForm
    {

        LDCGESTION oLDCGESTION;
        LDCCONFIRMACION oLDCCONFIRMACION;
        LDCGESTIONEXCEL oLDCGESTIONEXCEL;
        //LDCHISTORIAL oLDCHISTORIAL;
        DALLEGO oDALLEGO = new DALLEGO();
        Int64 formaOpen;


        public LEGO()
        {
            InitializeComponent();
            //oDALLEGO.PrDesgestionarOT();
        }

        private void LDCGESORD_Load(object sender, EventArgs e)
        {
            this.Location = Screen.PrimaryScreen.WorkingArea.Location;
            this.Size = Screen.PrimaryScreen.WorkingArea.Size;

            //MessageBox.Show("Ancho ["+ this.Width.ToString() + "]");
            //MessageBox.Show("Alto [" + this.Height.ToString() + "]");

            //oLDCHISTORIAL = new LDCHISTORIAL();
            //oLDCHISTORIAL.Location = new Point(0, 0);
            //opPpal.Controls.Add(oLDCHISTORIAL);
            //oLDCHISTORIAL.Dock = System.Windows.Forms.DockStyle.Fill;
            //
            //30.11.18 DANVAL
            //PRUEBAS
            //oLDCGESTION = new LDCGESTION();
            //oLDCGESTION.Location = new Point(0, 0);
            //opPpal.Controls.Add(oLDCGESTION);
            //oLDCGESTION.Dock = System.Windows.Forms.DockStyle.Fill;
            //formaOpen = 0;
            //
            
        }

        private void tvOptions_AfterSelect(object sender, Infragistics.Win.UltraWinTree.SelectEventArgs e)
        {
            System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

            //MessageBox.Show("Nodo Index[" + tvOptions.ActiveNode.Index.ToString() + "]");
            //MessageBox.Show("Nodo Key[" + tvOptions.ActiveNode.Key.ToString() + "]");
            //MessageBox.Show("Nodo Level[" + tvOptions.ActiveNode.Level.ToString() + "]");                        
            //MessageBox.Show("Nodo RootNode[" + tvOptions.ActiveNode.RootNode.ToString() + "]");
            //MessageBox.Show("Nodo Text[" + tvOptions.ActiveNode.Text.ToString() + "]");
            //MessageBox.Show("Nodo Nodes.Tag[" + tvOptions.ActiveNode..ToString() + "]");

            if (opPpal.Controls.Count > 0)
                opPpal.Controls.RemoveAt(0);

            formaOpen = -1;

            switch (tvOptions.ActiveNode.Level)
            {

                case 1:
                    {
                        #region Ordenes_Trabajo

                        //if (opPpal.Controls.Count > 0)
                        //    opPpal.Controls.RemoveAt(0);

                        //MessageBox.Show("Nodo Text[" + tvOptions.ActiveNode.Text.ToString() + "] == Gestion");
                        if (tvOptions.ActiveNode.Text.ToString() == "Gestion")
                        {
                            oLDCGESTION = new LDCGESTION();
                            oLDCGESTION.Location = new Point(0, 0);
                            opPpal.Controls.Add(oLDCGESTION);
                            oLDCGESTION.Dock = System.Windows.Forms.DockStyle.Fill;
                            formaOpen = 0;
                        }
                        //MessageBox.Show("Nodo Text[" + tvOptions.ActiveNode.Text.ToString() + "] == Gestion");
                        if (tvOptions.ActiveNode.Text.ToString() == "Confirmacion")
                        {
                            oLDCCONFIRMACION = new LDCCONFIRMACION();
                            oLDCCONFIRMACION.Location = new Point(0, 0);
                            opPpal.Controls.Add(oLDCCONFIRMACION);
                            oLDCCONFIRMACION.Dock = System.Windows.Forms.DockStyle.Fill;
                            formaOpen = 1;                            
                        }

                        if (tvOptions.ActiveNode.Text.ToString() == "Ordenes Gestionadas")
                        {
                            oLDCGESTIONEXCEL = new LDCGESTIONEXCEL();
                            oLDCGESTIONEXCEL.Location = new Point(0, 0);
                            opPpal.Controls.Add(oLDCGESTIONEXCEL);
                            oLDCGESTIONEXCEL.Dock = System.Windows.Forms.DockStyle.Fill;
                            formaOpen = 2;                            
                        }
                        #endregion Ordenes_Trabajo
                    }
                    break;
            }
            System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
        }

        private void LEGO_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (opPpal.Controls.Count > 0)
                opPpal.Controls.RemoveAt(0);
        }

        private void LEGO_KeyDown(object sender, KeyEventArgs e)
        {
            //Gurdar mediante tecla de acceso rapido
            if (e.KeyCode == Keys.F3)
            {
                if (formaOpen == 0)
                {
                    //MessageBox.Show("Keys.F3");                    
                    oLDCGESTION.PrGuardarDatos();
                    if (oLDCGESTION.nuControlGuardado == 0)
                    {
                        opPpal.Controls.RemoveAt(0);
                        oLDCGESTION = new LDCGESTION();
                        oLDCGESTION.Location = new Point(0, 0);
                        opPpal.Controls.Add(oLDCGESTION);
                        oLDCGESTION.Dock = System.Windows.Forms.DockStyle.Fill;
                        //formaOpen = 0;
                        formaOpen = 0;
                    }                    
                }
                if (formaOpen == 1)
                {
                    //MessageBox.Show("Keys.F3");
                    oLDCCONFIRMACION.PrGuardarDatos();
                    if (oLDCCONFIRMACION.nuControlGuardado == 0)
                    {
                        opPpal.Controls.RemoveAt(0);
                        oLDCCONFIRMACION = new LDCCONFIRMACION();
                        oLDCCONFIRMACION.Location = new Point(0, 0);
                        opPpal.Controls.Add(oLDCCONFIRMACION);
                        oLDCCONFIRMACION.Dock = System.Windows.Forms.DockStyle.Fill;
                        formaOpen = 1; 
                    }                    
                }
            }
        }

    }
}
