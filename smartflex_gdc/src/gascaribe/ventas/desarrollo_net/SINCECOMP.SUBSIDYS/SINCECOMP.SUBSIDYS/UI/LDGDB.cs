using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.SUBSIDYS.BL;
using SINCECOMP.SUBSIDYS.Entities;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDGDB : OpenForm
    {
        public LDGDB()
        {
            InitializeComponent();
        }

        BLGENERAL general = new BLGENERAL();

        private void tbProcess_Click(object sender, EventArgs e)
        {
            if (general.validarPath(tbArchiveubication.TextBoxValue))
            {
                //
                //if (blLDGDB.FnugetError() == 0)
                //{


                    Int64 inuSesion = Convert.ToInt64(general.GetfunctionSesion());

                    Int64 inuControl = 0;

                    /*
                    String isbOutNameFile = "Cartas_a_Potenciales_";
                    general.BLProcgenLetters(inuSesion, tbPathFile.TextBoxValue, isbOutNameFile);
                    Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                    OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
                    */


                    if (general.validarPath(tbArchiveubication.TextBoxValue))
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

                            String isbOutNameFile = "Duplicado_Factura_";
                            //general.generatePDF(tbPathFile.TextBoxValue, inuTemplateId, isbOutNameFile);
                            //MessageBox.Show(Convert.ToString(inuSesion));
                            //MessageBox.Show(tbPathFile.TextBoxValue);
                            //MessageBox.Show(isbOutNameFile); 

                            //sesión de usuario --joncon
                            //MessageBox.Show(Convert.ToString(inuSesion));

                            List<cartaspotenciales> listcartaspotenciales = new List<cartaspotenciales>();
                            listcartaspotenciales = BLGENERAL.FcuFacturasDuplicadas(inuSesion);//, tbPathFile.TextBoxValue, isbOutNameFile);


                            
                            foreach (cartaspotenciales row in listcartaspotenciales)
                            {
                                general.FacturasDuplicadosPDF(tbArchiveubication.TextBoxValue, isbOutNameFile, row.Docudocu);
                                Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                                OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
                                inuControl = 1;
                            }

                            //Borrar los registros de la tabla ld_temp_clob_fact ->inuSesion
                            //Ld_BoSubsidy.deletetemp_clob_fact(inusesion)
                            blLDGDB.deletetemp_clob_fact(inuSesion);

                            if (inuControl == 0)
                            {
                                MessageBox.Show("No se generaron duplicados de facturas");
                            }
                            else
                            {
                                MessageBox.Show("Se generaron los duplicados de facturas");
                                this.tbProcess.Enabled = false;
                            }

                        }
                        catch (Exception error)
                        {
                            //Borrar los registros de la tabla ld_temp_clob_fact ->inuSesion
                            //Ld_BoSubsidy.deletetemp_clob_fact(inusesion)
                            blLDGDB.deletetemp_clob_fact(inuSesion);

                            general.mensajeError(error);
                        }
                    }

                    /*
                    String[] p1 = new string[] { "String", "String" };
                    String[] p2 = new string[] { "isbsource", "isbfilename" };
                    String[] p3 = new string[] { tbArchiveubication.TextBoxValue, "Duplicado de Factura" };
                    general.standardProcedure("LD_BOSUBSIDY.ProcExportBillDuplicateToPDF", 2, p1, p2, p3);
                    //
                    /*
                    Control viewer = OpenSystems.Printing.AccountStatusRQ.ProcessEM.Process();
                    (viewer as OpenSystems.Report.OpenReportViewer).Export_PDF(tbArchiveubication.TextBoxValue.ToString() + @"\Duplicado de Factura" + ".pdf");
                    //*
                    Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                    OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
                    general.mensajeOk("Duplicado(s) generado(s) con exito");
                    */

                //}
            }
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            fbdDirectory.ShowDialog();
            tbArchiveubication.TextBoxValue = fbdDirectory.SelectedPath;
        }




    }
}