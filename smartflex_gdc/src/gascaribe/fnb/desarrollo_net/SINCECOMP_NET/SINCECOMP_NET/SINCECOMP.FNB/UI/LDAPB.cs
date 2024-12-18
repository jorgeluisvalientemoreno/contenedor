#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : LDAPB                                                                      
 * Descripcion   : Administración de productos Brilla                                                      
 * Autor         : Angelo Nieto Triana(anieto)
 * Fecha         :                                                                                
 *                                                                                                           
 * Fecha        SAO     Autor                 Modificación                                                          
 * ===========  ======  ===================   ==============================================================
 * 22-Nov-2013  223890  anieto                1 - Se modifica el cargo inicial del formulario de los artículos
 *                                                para menejar la percepción del formulario listo para trabajar.
 *                                                <<LDAPB_Load>>
 *                                            2 - Se elimina código comentados y se agregan regiones para el 
 *                                                orden del código.
 *=========================================================================================================*/
#endregion Documentación
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.FNB.Controls;
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.Entities;
//NameSpace
namespace SINCECOMP.FNB.UI
{
    /// <summary>
    /// 
    /// </summary>
    public partial class LDAPB : OpenForm
    {
        #region Campos
        String typeUser;
        Int64 userId;
        BLGENERAL general = new BLGENERAL();
        //
        ctrlGEPBR oControl0;
        ctrlGEPPB oControl1;
        ctrlGELPPB oControl2;
        ctrlGEPLPB oControl3;
        ctrlLDAPR oControl4;// = new ctrlLDAPR();
        ctrlGEC oControl5;
        //
        String formaOpen;
        #endregion Campos
        //
        /// <summary>
        /// 
        /// </summary>
        public LDAPB()
        {
            InitializeComponent();
            #region Extracciòn valores comunes al formulario
            //validacion del tipo de usuario
            userId = general.userConnect();
            typeUser = Convert.ToString(general.valueReturn(BLConsultas.TipoUsuarioConectado, "String"));
            #endregion Extracciòn valores comunes al formulario
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void LDAPB_Load(object sender, EventArgs e)
        {
            tvOptions.ActiveNode = tvOptions.Nodes[0];
            //nodo marca
            tvOptions.Nodes[6].Visible = false;

            //Contratista de Venta
            if (typeUser == "CV")
            {
                #region Visualizaciòn Atributos
                tvOptions.Nodes[0].Visible = false;
                tvOptions.Nodes[1].Visible = false;
                tvOptions.Nodes[2].Visible = false;
                tvOptions.Nodes[4].Visible = false;
                tvOptions.Nodes[5].Visible = false;
                tvOptions.ActiveNode = tvOptions.Nodes[3];
                #endregion Visualizaciòn Atributos
            }

            //Contratista 
            if (typeUser == "C")
                tvOptions.Nodes[5].Visible = false;

        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tvOptions_AfterSelect(object sender, Infragistics.Win.UltraWinTree.SelectEventArgs e)
        {
            System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
            switch (tvOptions.ActiveNode.Index)
            {
                case 0:
                    {
                        #region Articulos

                        if (opPpal.Controls.Count > 0)
                            opPpal.Controls.RemoveAt(0);

                        oControl0 = new ctrlGEPBR(typeUser, userId);
                        oControl0.Location = new Point(0, 0);
                        opPpal.Controls.Add(oControl0);
                        oControl0.Dock = System.Windows.Forms.DockStyle.Fill;
                        #endregion Articulos
                        formaOpen = "0";
                    }
                    break;
                case 1:
                    {
                        #region Lista de precios

                        if (opPpal.Controls.Count > 0)
                            opPpal.Controls.RemoveAt(0);

                        oControl1 = new ctrlGEPPB(typeUser, userId);
                        oControl1.Location = new Point(0, 0);
                        opPpal.Controls.Add(oControl1);
                        oControl1.Dock = System.Windows.Forms.DockStyle.Fill;
                        #endregion Lista de precios
                        formaOpen = "1";
                    }
                    break;
                case 2:
                    {
                        #region lista a partir de una existente
                        if (opPpal.Controls.Count > 0)
                            opPpal.Controls.RemoveAt(0);

                        oControl2 = new ctrlGELPPB(typeUser, userId);
                        oControl2.Location = new Point(0, 0);
                        opPpal.Controls.Add(oControl2);
                        oControl2.Dock = System.Windows.Forms.DockStyle.Fill;
                        #endregion lista a partir de una existente
                        formaOpen = "2";
                    }
                    break;
                case 3:
                    {
                        #region Impresion Listas
                        if (opPpal.Controls.Count > 0)
                            opPpal.Controls.RemoveAt(0);

                        //impresion  de listas 
                        oControl3 = new ctrlGEPLPB(typeUser, userId);
                        oControl3.Location = new Point(0, 0);
                        opPpal.Controls.Add(oControl3);
                        oControl3.Dock = System.Windows.Forms.DockStyle.Fill;
                        #endregion Impresion Listas
                        formaOpen = "3";
                    }
                    break;
                case 4:
                    {
                        #region Adm propiedades de artículo
                        if (opPpal.Controls.Count > 0)
                            opPpal.Controls.RemoveAt(0);

                        oControl4 = new ctrlLDAPR();
                        oControl4.Location = new Point(0, 0);
                        opPpal.Controls.Add(oControl4);
                        oControl4.Dock = System.Windows.Forms.DockStyle.Fill;
                        #endregion Adm propiedades de artículo
                        formaOpen = "4";
                    }
                    break;
                case 5:
                    {
                        #region definición de comisiones
                        if (opPpal.Controls.Count > 0)
                            opPpal.Controls.RemoveAt(0);

                        oControl5 = new ctrlGEC();
                        oControl5.Location = new Point(0, 0);
                        opPpal.Controls.Add(oControl5);
                        oControl5.PopulateData(typeUser, userId);
                        oControl5.Dock = System.Windows.Forms.DockStyle.Fill;
                        #endregion definición de comisiones
                        formaOpen = "5";
                    }
                    break;
            }
            System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public Boolean validate()
        {
            if (opPpal.Controls.Count > 0)
            {
                switch (formaOpen)
                {
                    case "0":
                        if (oControl0.operPendientes)
                            return oControl0.validandoC();
                        break;
                    case "1":
                        if (oControl1.operPendientes)
                            return oControl1.validandoC();
                        break;
                    case "2":
                        break;
                    case "3":
                        break;
                    case "4":
                        if (oControl4.operPendientes)
                            return oControl4.validandoC();
                        break;
                    case "5":
                        if (oControl5.operPendientes)
                            return oControl5.validandoC();
                        break;
                }
            }
            return true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void LDAPB_FormClosing(object sender, FormClosingEventArgs e)
        {
            //Int64 answer;

            if (!validate())
                e.Cancel = true;

            if (MessageBox.Show("¿Desea salir de LDAPB?", "LDAPB", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) == System.Windows.Forms.DialogResult.Yes)
            {
                e.Cancel = false;
                ContainerCollections.GetInstance().Destroy();
            }
            else
                e.Cancel = true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tvOptions_BeforeSelect(object sender, Infragistics.Win.UltraWinTree.BeforeSelectEventArgs e)
        {
            if (!validate())
                e.Cancel = true;
        }
    }
}