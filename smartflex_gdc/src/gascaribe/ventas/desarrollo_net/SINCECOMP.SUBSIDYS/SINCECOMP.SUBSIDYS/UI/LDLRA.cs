using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.SUBSIDYS.BL;
using OpenSystems.ExtractAndMix.Api;
using OpenSystems.Report;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDLRA : OpenForm
    {
        public LDLRA()
        {
            InitializeComponent();
        }

        //Int64 nuErrorCode;
        //String sbMessage, sbDirectory, sbPath;
        BLGENERAL general = new BLGENERAL();
        //BLLDLTP queryBL = new BLLDLTP();

        private void btnProcess_Click(object sender, EventArgs e)
        {
            btnProcess.Enabled = false;
            if (general.validarPath(tbPathFile.TextBoxValue))
            {
                try
                {
                    //modificacion albeyro
                    //Int64 numberConstant = Convert.ToInt64(general.getConstantValue("ld_boconstans.cnuExtract_Retroactive"));
                    //String inuTemplateId = general.setandgetQuery(numberConstant);
                    String isbOutNameFile = "Carta_Asignación_Retroactivo_";
                    //general.generatePDF(tbPathFile.TextBoxValue, inuTemplateId, isbOutNameFile);
                    general.generatePDF(tbPathFile.TextBoxValue, isbOutNameFile);
                    
                    Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                    bool exito = OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);

                    if (exito)
                    {
                        general.mensajeOk("Carta(s) Generada(s) con Exito");
                    } 
                    
                    
                }
                catch (Exception error)
                {
                    general.mensajeError(error);
                }
                //id_bogeneralprinting.ExportToPDFFromMem(RUTA LOCAL,NOMBRE DE ARCHIVO,sbTemplate,clClobData);

                //String sbDirectory = tbPathFile.TextBoxValue;
                //String sbPath = "";
                //String[] dataParams = { "pkBOED_DocumentMem.Get_PrintDoc" };
                //Int64 numberConstant = Convert.ToInt64(general.getConstantValue("ld_boconstans.cnuExtract_Retroactive"));//("LD_BOConstans.cnuExtract_Potential"));
                //String[] designParams = { "" + queryBL.setandgetQuery(numberConstant) }; //{ "RPTPOTENTIAL" }; //{ "" + template };
                //String[] mixerParams = { };
                //try
                //{
                //    Control viewer = OpenSystems.ExtractAndMix.Api.MainApi.Execute(3, dataParams, designParams, mixerParams);
                //    sbPath = sbDirectory + "\\Carta_Asignación_Retroactivo_" + DateTime.Now.ToString("dd.MM.yyyy.hh.mm.ss") + ".pdf"; 
                //    (viewer as OpenReportViewer).Export_PDF(sbPath);
                //    general.mensajeOk("Reporte Generado con Exito");
                //}
                //catch (Exception error)
                //{
                //    general.mensajeError(error);
                //}
            }
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog foldDialog = new FolderBrowserDialog();
            foldDialog.Description = "Seleccione el directorio destino donde desea que se almacenen los archivos.";
            foldDialog.ShowDialog();
            tbPathFile .TextBoxValue  = foldDialog.SelectedPath;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}