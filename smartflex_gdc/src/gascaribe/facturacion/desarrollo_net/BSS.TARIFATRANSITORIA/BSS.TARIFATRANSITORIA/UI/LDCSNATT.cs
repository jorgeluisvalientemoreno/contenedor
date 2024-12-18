using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
//Libreiras OPEN
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Windows.Controls;
using BSS.TARIFATRANSITORIA.BL;
using BSS.TARIFATRANSITORIA.DAL;

namespace BSS.TARIFATRANSITORIA.UI
{
    public partial class LDCSNATT : OpenForm
    {
        BLGENERAL general = new BLGENERAL();
        DALGENERAL generalDAL = new DALGENERAL();

        //Columnas definidas para periodo
        String ca = "anno";
        String cb = "mes";
        String cc = "m3";

        //Columna definidas para ajustes
        String ca1 = "periodo";
        String cb1 = "m3fact";
        String cc1 = "factura";
        String cd1 = "cuentacobro";
        String ce1 = "consumo";
        String cf1 = "subsidio";
        String cg1 = "contribucion";
        String ch1 = "consumo048";
        String ci1 = "subsisio048";
        String cj1 = "contribucion048";
        String ck1 = "subadicional";
        String cl1 = "subadicionaltt";
        String cm1 = "total";

        public LDCSNATT()
        {
            InitializeComponent();
        }

        private void LDCSNATT_Load(object sender, EventArgs e)
        {
            DataTable causallegOT = general.getValueList("SELECT 70 CODIGO, 'NOTA DB' DESCRIPCION FROM DUAL UNION SELECT 71 CODIGO, 'NOTA CR' DESCRIPCION FROM DUAL");
            this.CbTipoNota.DataSource = causallegOT;
            this.CbTipoNota.DisplayMember = "DESCRIPCION";
            this.CbTipoNota.ValueMember = "CODIGO";

            //Configuracion Grilla Ajustes
            //No editar
            UgSimulacion.DisplayLayout.Bands[0].Columns[ca1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cb1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cc1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cd1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[ce1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cf1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cg1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[ch1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[ci1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cj1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[ck1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cl1].CellActivation = Activation.NoEdit;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cm1].CellActivation = Activation.NoEdit;
            //Alinaer a la derecha
            UgSimulacion.DisplayLayout.Bands[0].Columns[ce1].CellAppearance.TextHAlign = HAlign.Right;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cf1].CellAppearance.TextHAlign = HAlign.Right;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cg1].CellAppearance.TextHAlign = HAlign.Right;
            UgSimulacion.DisplayLayout.Bands[0].Columns[ch1].CellAppearance.TextHAlign = HAlign.Right;
            UgSimulacion.DisplayLayout.Bands[0].Columns[ci1].CellAppearance.TextHAlign = HAlign.Right;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cj1].CellAppearance.TextHAlign = HAlign.Right;
            UgSimulacion.DisplayLayout.Bands[0].Columns[ck1].CellAppearance.TextHAlign = HAlign.Right;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cl1].CellAppearance.TextHAlign = HAlign.Right;
            UgSimulacion.DisplayLayout.Bands[0].Columns[cm1].CellAppearance.TextHAlign = HAlign.Right;

            UgSimulacion.DisplayLayout.GroupByBox.Hidden = true;
            /////////////////////////////////////////////////////////////////////////////////////////

            //Girlla de perioso
            UgPeriodo.DisplayLayout.GroupByBox.Hidden = true;
            ///////////////////////////////

        }

        private void BtMas_Click(object sender, EventArgs e)
        {
            //Agregar una nueva fila en la grilla
            BsPeriodo.AddNew();
            //var valueList = new ValueList();
            //valueList.ValueListItems.Add("2020", "2020");
            //valueList.ValueListItems.Add("2021", "2021");
            //valueList.ValueListItems.Add("2022", "2022");
            //valueList.ValueListItems.Add("2023", "2023");
            //valueList.ValueListItems.Add("2024", "2024");
            //UgPeriodo.DisplayLayout.Bands[0].Columns[ca].ValueList = valueList;
            var valueListMes = new ValueList();
            valueListMes.ValueListItems.Add("1", "ENERO");
            valueListMes.ValueListItems.Add("2", "FEBRERO");
            valueListMes.ValueListItems.Add("3", "MARZO");
            valueListMes.ValueListItems.Add("4", "ABRIL");
            valueListMes.ValueListItems.Add("5", "MAYO");
            valueListMes.ValueListItems.Add("6", "JUNIO");
            valueListMes.ValueListItems.Add("7", "JULIO");
            valueListMes.ValueListItems.Add("8", "AGOSTO");
            valueListMes.ValueListItems.Add("9", "SEPTIEMBRE");
            valueListMes.ValueListItems.Add("10", "OCTUBRE");
            valueListMes.ValueListItems.Add("11", "NOVIEMBRE");
            valueListMes.ValueListItems.Add("12", "DICIEMBRE");
            UgPeriodo.DisplayLayout.Bands[0].Columns[cb].ValueList = valueListMes;
        }

        private void BtMenos_Click(object sender, EventArgs e)
        {
            if (BsPeriodo.Count > 0)
            {
                try
                {
                    int FilaSeleccionada = Convert.ToInt16(UgPeriodo.ActiveRow.Index.ToString());
                    UgPeriodo.Rows[FilaSeleccionada].Delete(false);
                }
                catch
                {
                    MessageBox.Show("Debe seleccionar una fila para eliminar.");
                }
            }
        }

        private void TbContrato_Leave(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(TbContrato.Text))
            //{
            //    MessageBox.Show("Debe digitar un contrato.");
            //    TbContrato.Focus();
            //}
            //else
            {
                //MessageBox.Show(TxtContrato.Text);
                UlNombreContrato.Text = generalDAL.Prvalicontt(Convert.ToInt64(TbContrato.Text));
                if (BsPeriodo.Count > 0)
                {
                    BsPeriodo.Clear();
                }
                if (BsSimulacion.Count > 0)
                {
                    BsSimulacion.Clear();
                }
            }
        }

        private void BtnCalcular_Click(object sender, EventArgs e)
        {
            Int64 inucontrato = 0;
            Int64 inutiponota = 0;
            Int64 inuanio;
            Int64 inumes;
            Int64 inumetros;
            Int64 nuPRCALCSITT = 0;

            String StPeriodo1;
            String StPeriodo2;

            if (String.IsNullOrEmpty(TbContrato.Text))
            {
                MessageBox.Show("Debe Digitar un contrato.");
                nuPRCALCSITT = 1;
            }
            else
            {
                inucontrato = Convert.ToInt64(TbContrato.Text);
            }

            if (String.IsNullOrEmpty(CbTipoNota.Text.ToString()))
            {
                MessageBox.Show("Debe Seleccionar Tipo de Nota.");
                nuPRCALCSITT = 1;
            }
            else
            {
                inutiponota = Convert.ToInt64(CbTipoNota.Value.ToString());
            }

            if (UgPeriodo.Rows.Count <= 0)
            {
                MessageBox.Show("Debe Configurar minumo un periodo.");
                nuPRCALCSITT = 1;
            }

            //Recorre Periodo Valida Periodo
            for (int x = 0; x <= UgPeriodo.Rows.Count - 1; x++)
            {
                StPeriodo1 = UgPeriodo.Rows[x].Cells[ca].Value.ToString() + UgPeriodo.Rows[x].Cells[cb].Value.ToString();
                //Recorre Periodo Valida Periodo
                for (int j = x+1; j <= UgPeriodo.Rows.Count - 1; j++)
                {
                    StPeriodo2 = UgPeriodo.Rows[j].Cells[ca].Value.ToString() + UgPeriodo.Rows[j].Cells[cb].Value.ToString();
                    if (StPeriodo1 == StPeriodo2)
                    {
                        MessageBox.Show("No pueden haber periodos simulares.");
                        nuPRCALCSITT = 1;
                    }
                }
            }

            if (nuPRCALCSITT == 0)
            {
                //Recorre Periodo
                for (int x = 0; x <= UgPeriodo.Rows.Count - 1; x++)
                {

                    inuanio = Convert.ToInt64(UgPeriodo.Rows[x].Cells[ca].Value.ToString());
                    inumes = Convert.ToInt64(UgPeriodo.Rows[x].Cells[cb].Value.ToString());
                    inumetros = Convert.ToInt64(UgPeriodo.Rows[x].Cells[cc].Value.ToString());


                    //procedimiento que genera simulacion de tarifa transitoria
                    if (nuPRCALCSITT == 0)
                    {
                        nuPRCALCSITT = generalDAL.PRCALCSITT(inucontrato, inutiponota, inuanio, inumes, inumetros);
                    }
                }

                if (nuPRCALCSITT == 0)
                {

                    if (BsSimulacion.Count > 0)
                    {
                        BsSimulacion.Clear();
                    }

                    int totalFila = UgSimulacion.Rows.Count;

                    DataTable Datos = generalDAL.frfgetsimulacion(Convert.ToInt64(TbContrato.Text));

                    if (Datos.Rows.Count > 0)
                    {
                        Int64 Nuce1 = 0;
                        Int64 Nucf1 = 0;
                        Int64 Nucg1 = 0;
                        Int64 Nuch1 = 0;
                        Int64 Nuci1 = 0;
                        Int64 Nucj1 = 0;
                        Int64 Nuck1 = 0;
                        Int64 Nucl1 = 0;
                        Int64 Nucm1 = 0;


                        //for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                        //{

                        //    MessageBox.Show(ca1 + ": " + Datos.Rows[x].ItemArray[0].ToString());
                        //    MessageBox.Show(cb1 + ": " + Datos.Rows[x].ItemArray[1].ToString());
                        //    MessageBox.Show(cc1 + ": " + Datos.Rows[x].ItemArray[2].ToString());
                        //    MessageBox.Show(cd1 + ": " + Datos.Rows[x].ItemArray[3].ToString());
                        //    MessageBox.Show(ce1 + ": " + Datos.Rows[x].ItemArray[4].ToString());
                        //    MessageBox.Show(cf1 + ": " + Datos.Rows[x].ItemArray[5].ToString());
                        //    MessageBox.Show(cg1 + ": " + Datos.Rows[x].ItemArray[6].ToString());
                        //    MessageBox.Show(ch1 + ": " + Datos.Rows[x].ItemArray[7].ToString());
                        //    MessageBox.Show(ci1 + ": " + Datos.Rows[x].ItemArray[8].ToString());
                        //    MessageBox.Show(cj1 + ": " + Datos.Rows[x].ItemArray[9].ToString());
                        //    MessageBox.Show(ck1 + ": " + Datos.Rows[x].ItemArray[10].ToString());
                        //    MessageBox.Show(cl1 + ": " + Datos.Rows[x].ItemArray[11].ToString());
                        //    MessageBox.Show(cm1 + ": " + Datos.Rows[x].ItemArray[12].ToString());
                        //}


                        for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                        {
                            BsSimulacion.AddNew();

                            UgSimulacion.Rows[totalFila].Cells[ca1].Value = Datos.Rows[x].ItemArray[0].ToString();
                            UgSimulacion.Rows[totalFila].Cells[cb1].Value = Datos.Rows[x].ItemArray[1].ToString();
                            UgSimulacion.Rows[totalFila].Cells[cc1].Value = Datos.Rows[x].ItemArray[2].ToString();
                            UgSimulacion.Rows[totalFila].Cells[cd1].Value = Datos.Rows[x].ItemArray[3].ToString();
                            UgSimulacion.Rows[totalFila].Cells[ce1].Value = Convert.ToInt64(Datos.Rows[x].ItemArray[4].ToString());
                            UgSimulacion.Rows[totalFila].Cells[cf1].Value = Convert.ToInt64(Datos.Rows[x].ItemArray[5].ToString());
                            UgSimulacion.Rows[totalFila].Cells[cg1].Value = Convert.ToInt64(Datos.Rows[x].ItemArray[6].ToString());
                            UgSimulacion.Rows[totalFila].Cells[ch1].Value = Convert.ToInt64(Datos.Rows[x].ItemArray[7].ToString());
                            UgSimulacion.Rows[totalFila].Cells[ci1].Value = Convert.ToInt64(Datos.Rows[x].ItemArray[8].ToString());
                            UgSimulacion.Rows[totalFila].Cells[cj1].Value = Convert.ToInt64(Datos.Rows[x].ItemArray[9].ToString());
                            UgSimulacion.Rows[totalFila].Cells[ck1].Value = Convert.ToInt64(Datos.Rows[x].ItemArray[10].ToString());
                            UgSimulacion.Rows[totalFila].Cells[cl1].Value = Convert.ToInt64(Datos.Rows[x].ItemArray[11].ToString());
                            UgSimulacion.Rows[totalFila].Cells[cm1].Value = Convert.ToInt64(Datos.Rows[x].ItemArray[12].ToString());

                            //Sumatoria
                            Nuce1 = Nuce1 + Convert.ToInt64(Datos.Rows[x].ItemArray[4].ToString());
                            Nucf1 = Nucf1 + Convert.ToInt64(Datos.Rows[x].ItemArray[5].ToString());
                            Nucg1 = Nucg1 + Convert.ToInt64(Datos.Rows[x].ItemArray[6].ToString());
                            Nuch1 = Nuch1 + Convert.ToInt64(Datos.Rows[x].ItemArray[7].ToString());
                            Nuci1 = Nuci1 + Convert.ToInt64(Datos.Rows[x].ItemArray[8].ToString());
                            Nucj1 = Nucj1 + Convert.ToInt64(Datos.Rows[x].ItemArray[9].ToString());
                            Nuck1 = Nuck1 + Convert.ToInt64(Datos.Rows[x].ItemArray[10].ToString());
                            Nucl1 = Nucl1 + Convert.ToInt64(Datos.Rows[x].ItemArray[11].ToString());
                            Nucm1 = Nucm1 + Convert.ToInt64(Datos.Rows[x].ItemArray[12].ToString());
                            ///////////////////////////////////////////

                            totalFila++;

                        }

                        ////Fila Suamtoria
                        BsSimulacion.AddNew();

                        UgSimulacion.Rows[totalFila].Cells[ca1].Value = "TOTAL";
                        //UgSimulacion.Rows[totalFila].Cells[cb1].Value = Datos.Rows[x].ItemArray[1].ToString();
                        //UgSimulacion.Rows[totalFila].Cells[cc1].Value = Datos.Rows[x].ItemArray[2].ToString();
                        //UgSimulacion.Rows[totalFila].Cells[cd1].Value = Convert.ToInt64(Datos.Rows[x].ItemArray[3].ToString());
                        UgSimulacion.Rows[totalFila].Cells[ce1].Value = Nuce1;
                        UgSimulacion.Rows[totalFila].Cells[cf1].Value = Nucf1;
                        UgSimulacion.Rows[totalFila].Cells[cg1].Value = Nucg1;
                        UgSimulacion.Rows[totalFila].Cells[ch1].Value = Nuch1;
                        UgSimulacion.Rows[totalFila].Cells[ci1].Value = Nuci1;
                        UgSimulacion.Rows[totalFila].Cells[cj1].Value = Nucj1;
                        UgSimulacion.Rows[totalFila].Cells[ck1].Value = Nuck1;
                        UgSimulacion.Rows[totalFila].Cells[cl1].Value = Nucl1;
                        UgSimulacion.Rows[totalFila].Cells[cm1].Value = Nucm1;
                        ///////////////////////////////////////////////////////////
                    }
                }
                else
                {
                    BsSimulacion.Clear();
                }
            }
        }

        private void BtnCancelar_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
