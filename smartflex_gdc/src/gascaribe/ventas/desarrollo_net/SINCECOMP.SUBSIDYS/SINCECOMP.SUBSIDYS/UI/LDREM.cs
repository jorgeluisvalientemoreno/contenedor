using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.Data;
using OpenSystems.Windows.Controls;
using SINCECOMP.SUBSIDYS.BL;
using SINCECOMP.SUBSIDYS.DAL;
using SINCECOMP.SUBSIDYS.Entities;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDREM : OpenForm
    {
        #region Atributos

        BLGENERAL general = new BLGENERAL();
        blLDREM BLLDREM = new blLDREM();

        long poblacion = 0;

        #endregion

        #region Carga de Datos

        public LDREM()
        {
            InitializeComponent();
        }

        private void LDREM_Load(object sender, EventArgs e)
        {
            //general.deleteremainsub("S");
            //OpenDataBase.Transaction.Commit();

            List<subsidy> Listsubsidy = new List<subsidy>();
            Listsubsidy = blLDREM.fcuSubsidy();
            subsidyBindingSource.DataSource = Listsubsidy;

            // Definicion de columnas de subsidios para manejo de formulas 
            String sbColumnSubsidyId = "SubsidyId";
            String sbColumnDescription = "Description";
            String sbColumnAgreement = "Agreement";
            String sbColumnDescriptionagreement = "Descriptionagreement";
            String sbColumnAuthorizedvalue = "Authorizedvalue";
            String sbColumnRemainingValue = "remainingvalue";

            //Grilla de Subsidio
            dgSubsidy.DisplayLayout.Bands[0].Columns[sbColumnSubsidyId].CellActivation = Activation.NoEdit;
            dgSubsidy.DisplayLayout.Bands[0].Columns[sbColumnDescription].CellActivation = Activation.NoEdit;
            dgSubsidy.DisplayLayout.Bands[0].Columns[sbColumnAgreement].CellActivation = Activation.NoEdit;
            dgSubsidy.DisplayLayout.Bands[0].Columns[sbColumnDescriptionagreement].CellActivation = Activation.NoEdit;
            dgSubsidy.DisplayLayout.Bands[0].Columns[sbColumnAuthorizedvalue].CellActivation = Activation.NoEdit;
            dgSubsidy.DisplayLayout.Bands[0].Columns[sbColumnRemainingValue].CellActivation = Activation.NoEdit;
        }

        #endregion

        #region Eventos

        #region Grid

        private void dgSubsidy_AfterCellActivate(object sender, EventArgs e)
        {
            subsidy subsidio = dgSubsidy.ActiveRow.ListObject as subsidy;

            tbEarmarked.TextBoxValue = Convert.ToString(dalLDREM.Fnugetsubtotaldelivery(subsidio.SubsidyId));
            tbRemainder.TextBoxValue = Convert.ToString(subsidio.Remainingvalue);
            tbState1.TextBoxValue = dalLDREM.fsbGetRemainder_Status(subsidio.SubsidyId);

            if (tbState1.TextBoxValue.Equals("AB"))
            {
                tbState2.TextBoxValue = "Abierto";
            }
            else if (tbState1.TextBoxValue.Equals("SI"))
            {
                tbState2.TextBoxValue = "Simulado";
            }
            else if (tbState1.TextBoxValue.Equals("DI"))
            {
                tbState2.TextBoxValue = "Distribuido";
            }
            else if (tbState1.TextBoxValue.Equals("AP"))
            {
                tbState2.TextBoxValue = "Aplicado";
            }
            else if (tbState1.TextBoxValue.Equals("CE"))
            {
                tbState2.TextBoxValue = "Cerrado";
            }
            else if (tbState1.TextBoxValue.Equals("0"))
            {
                tbState1.TextBoxValue = "AB";
                tbState2.TextBoxValue = "Abierto";
            }
        }

        private void dgSubsidy_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            if (e.NewValue.GetType() != typeof(Int64))
            {
                e.Cancel = true;
            }

            subsidy subsidio = e.Cell.Row.ListObject as subsidy;

            if (Convert.ToInt64(e.NewValue) > subsidio.Remainingvalue)
            {
                e.Cancel = true;
            }

            btnDistribute.Enabled = false;
        }

        #endregion

        #region Botones

        private void btnReport_Click(object sender, EventArgs e)
        {
            simulate();
            btnDistribute.Enabled = true;
            subsidyBindingSource.DataSource = blLDREM.fcuSubsidy();
        }

        private void btnDistribute_Click(object sender, EventArgs e)
        {
            BLLDREM.persistSimulation();
            MessageBox.Show("Se ha almacenado la información de la simulación");
            subsidyBindingSource.DataSource = blLDREM.fcuSubsidy();
        }

        private void btnApply_Click(object sender, EventArgs e)
        {
            ApplyRemaining();
            subsidyBindingSource.DataSource = blLDREM.fcuSubsidy();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            DialogResult dialogResult = MessageBox.Show("¿Desea realizar el proceso de Cierre de Subsidios?", "Cierre de Subsidios", MessageBoxButtons.YesNo);

            if (dialogResult == System.Windows.Forms.DialogResult.Yes)
            {
                subsidy subsidio = dgSubsidy.ActiveRow.ListObject as subsidy;

                String[] p1 = new string[] { "Int64", "String" };
                String[] p2 = new string[] { "inuSUBSIDY_Id", "isbRemainder_Status$" };
                String[] p3 = new string[] { Convert.ToString(subsidio.SubsidyId), "CE" };

                general.standardProcedure("dald_subsidy.updRemainder_Status", 2, p1, p2, p3);
                OpenDataBase.Transaction.Commit();
                MessageBox.Show("El remanente del subsidio " + subsidio.SubsidyId + " ha sido cerrado.");
                subsidyBindingSource.DataSource = blLDREM.fcuSubsidy();
            }
        }

        #endregion

        #endregion

        #region Procesos

        /// <summary>
        /// Registra la simulación de la distribución de remanentes
        /// </summary>
        private void simulate()
        {
            bool blRemanente;
            string nuStateDelivery = "S";
            Int64 onuErrorCode = 0;
            string osbErrorMessage = string.Empty;
            Int64 INUSesion = Convert.ToInt64(general.GetfunctionSesion());

            bool flag = false;

            //Se elimina la última simulación
            OpenDataBase.Transaction.Rollback();

            StringBuilder sb = new StringBuilder("Se realizó la simulación de distribución del remanente para:");

            sb.AppendLine();

            foreach (UltraGridRow irow in dgSubsidy.Rows)
            {
                subsidy subsidio = irow.ListObject as subsidy;

                if (subsidio.Distributingvalue > 0)
                {
                    flag = true;

                    blRemanente = BLLDREM.FblDistrRemainSubsidy(subsidio.SubsidyId, subsidio.Distributingvalue, nuStateDelivery, onuErrorCode, osbErrorMessage);

                    sb.AppendLine("Subsidio: " + subsidio.SubsidyId);
                }
            }

            if (flag)
            {
                MessageBox.Show(sb.ToString());
                Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("LDRSU", parametersTemp, true);
            }
            else
            {
                MessageBox.Show("No se especificó valor a distribuir en ningún subsidio");
            }
        }

        /// <summary>
        /// Proceso encargado de aplicar la distribución de remanentes
        /// </summary>
        private void ApplyRemaining()
        {
            dalLDREM.ProcRemainingApplies();
            OpenDataBase.Transaction.Commit();
        }

        #endregion

    }
}