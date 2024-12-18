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
using SINCECOMP.SUBSIDYS.Entities;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDLTP : OpenForm
    {
        public LDLTP()
        {
            InitializeComponent();
        }

        //Int64 nuErrorCode;
        //String sbMessage, sbDirectory, sbPath;
        BLGENERAL general = new BLGENERAL();
        //BLLDLTP queryBL = new BLLDLTP();

        private void btnProcess_Click(object sender, EventArgs e)
        {
            Int64 inuSesion = Convert.ToInt64(general.GetfunctionSesion());

            Int64 inuControl = 0;

            /*
            String isbOutNameFile = "Cartas_a_Potenciales_";
            general.BLProcgenLetters(inuSesion, tbPathFile.TextBoxValue, isbOutNameFile);
            Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
            OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
            */


            if (general.validarPath(tbPathFile.TextBoxValue))
            {
                try
                {
                    //modificacion albeyro
                    //String numberConstant = general.getConstantValue("ld_boconstans.cnuExtract_Potential");
                    //String inuTemplateId = general.setandgetQuery(numberConstant);
                    //String[] p1 = new string[] { "Int64" };
                    //String[] p2 = new string[] { "inucoempadi" };
                    //String[] p3 = new string[] { numberConstant };
                    //general.standardProcedure("Ld_BoSubsidy.Procloadtemplateandclob", 1, p1, p2, p3);

                    String isbOutNameFile = "Cartas_a_Potenciales_";
                    //general.generatePDF(tbPathFile.TextBoxValue, inuTemplateId, isbOutNameFile);
                    //MessageBox.Show(Convert.ToString(inuSesion));
                    //MessageBox.Show(tbPathFile.TextBoxValue);
                    //MessageBox.Show(isbOutNameFile); 

                    List<cartaspotenciales> listcartaspotenciales = new List<cartaspotenciales>();
                    listcartaspotenciales = BLGENERAL.Fcucartaspotenciales(inuSesion);//, tbPathFile.TextBoxValue, isbOutNameFile);
                    foreach (cartaspotenciales row in listcartaspotenciales)
                    {
                        general.CartasPotencialesPDF(tbPathFile.TextBoxValue, isbOutNameFile, row.Docudocu);
                        Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                        OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
                        inuControl = 1;
                    }

                    if (inuControl == 0)
                    {
                        MessageBox.Show("No se generaron cartas a potenciales");
                    }
                    else
                    {
                        MessageBox.Show("Se generaron las cartas a potenciales");
                        this.btnProcess.Enabled = false;
                    }

                }
                catch (Exception error)
                {
                    general.mensajeError(error);
                }



                //String sbDirectory = tbPathFile.TextBoxValue;
                //String sbPath = "";
                //String[] dataParams = { "pkBOED_DocumentMem.Get_PrintDoc" };
                //Int64 numberConstant = Convert.ToInt64(general.getConstantValue("LD_BOConstans.cnuExtract_Potential"));
                //String[] designParams = { "" + queryBL.setandgetQuery(numberConstant) }; //{ "RPTPOTENTIAL" }; //{ "" + template };
                //String[] mixerParams = { };
                //try
                //{
                //    Control viewer = OpenSystems.ExtractAndMix.Api.MainApi.Execute(3, dataParams, designParams, mixerParams);
                //    sbPath = sbDirectory + "\\Cartas_a_Potenciales_" + DateTime.Now.ToString("dd.MM.yyyy.hh.mm.ss") + ".pdf";
                //    (viewer as OpenReportViewer).Export_PDF(sbPath);
                //    general.mensajeOk("Reporte Generado con Exito");
                //}
                //catch (Exception error)
                //{
                //    general.mensajeError(error);
                //}
                //String sbDirectory = tbPathFile.TextBoxValue;
                //String sbPath = "";
                //String[] dataParams = { "pkBOED_DocumentMem.Get_PrintDoc" };
                //Int64 numberConstant = Convert.ToInt64(general.getConstantValue("LD_BOConstans.cnuExtract_Potential"));
                //String[] designParams = { "" + queryBL.setandgetQuery(numberConstant) }; //{ "RPTPOTENTIAL" }; //{ "" + template };
                //String[] mixerParams = { };
                //try
                //{
                //    Control viewer = OpenSystems.ExtractAndMix.Api.MainApi.Execute(3, dataParams, designParams, mixerParams);
                //    sbPath = sbDirectory + "\\Cartas_a_Potenciales_" + DateTime.Now.ToString("dd.MM.yyyy.hh.mm.ss") + ".pdf";
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
            tbPathFile.TextBoxValue = foldDialog.SelectedPath;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}