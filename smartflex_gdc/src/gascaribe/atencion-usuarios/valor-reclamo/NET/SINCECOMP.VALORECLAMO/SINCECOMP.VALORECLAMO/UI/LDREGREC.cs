using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

//LIBRERIAS DE OPEN
using OpenSystems.Windows.Controls;
using Infragistics.Win.UltraWinGrid;

//
using SINCECOMP.VALORECLAMO.BL;
using SINCECOMP.VALORECLAMO.Entities;

namespace SINCECOMP.VALORECLAMO.UI
{
    public partial class LDREGREC : OpenForm
    {

        BLGENERAL general = new BLGENERAL();
        public List<dataLDREGREC> lista = new List<dataLDREGREC>();

        public LDREGREC(Int64 PackageId)
        {
            InitializeComponent();
            //MessageBox.Show("holaaa");
            //llenado de grilla
            String[] tipos = { "Int64" };
            String[] campos = { "inuPackageId" };
            object[] valores = { PackageId };
            DataTable Datos = general.cursorProcedure(BLConsultas.reclamosCursor, 1, tipos, campos, valores);
            //
            if (Datos.Rows.Count > 0)
            {
                for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                {
                    dataLDREGREC fila = new dataLDREGREC
                    {
                        Solicitud = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[0].ToString()) ? 0 : Int64.Parse(Datos.Rows[x].ItemArray[0].ToString()),
                        Reclamo = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[1].ToString()) ? 0 : Int64.Parse(Datos.Rows[x].ItemArray[1].ToString()),
                        Factcodi = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[2].ToString()) ? 0 : Int64.Parse(Datos.Rows[x].ItemArray[2].ToString()) ,
                        Cucocodi = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[3].ToString()) ? 0 : Int64.Parse(Datos.Rows[x].ItemArray[3].ToString()),
                        Date_Gencodi = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[4].ToString()) ? DateTime.Parse("01/01/0001") : DateTime.Parse(Datos.Rows[x].ItemArray[4].ToString()),
                        Reconcep = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[5].ToString()) ? "" : Datos.Rows[x].ItemArray[5].ToString(),
                        Resbsig = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[6].ToString()) ? "" : Datos.Rows[x].ItemArray[6].ToString(),
                        Renucausal = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[7].ToString()) ? "" : Datos.Rows[x].ItemArray[7].ToString(),
                        Redocsop = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[8].ToString()) ? "" : Datos.Rows[x].ItemArray[8].ToString(),
                        Recaucar = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[9].ToString()) ? "" : Datos.Rows[x].ItemArray[9].ToString(),
                        ValorCargo = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[10].ToString()) ? 0 : Double.Parse(Datos.Rows[x].ItemArray[10].ToString()),
                        Remes = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[11].ToString()) ? 0 : Int64.Parse(Datos.Rows[x].ItemArray[11].ToString()),
                        Reano = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[12].ToString()) ? 0 : Int64.Parse(Datos.Rows[x].ItemArray[12].ToString()),
                        ReValTotal = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[13].ToString()) ? 0 : Double.Parse(Datos.Rows[x].ItemArray[13].ToString()),
                        ReSalPen = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[14].ToString()) ? 0 : Convert.ToDouble(Datos.Rows[x].ItemArray[14].ToString()),
                        ReValoReca = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[15].ToString()) ? 0 : Double.Parse(Datos.Rows[x].ItemArray[15].ToString()),
                        Subscription_Id = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[16].ToString()) ? 0 : Int64.Parse(Datos.Rows[x].ItemArray[16].ToString()),
                        ReCargUni = string.IsNullOrEmpty(Datos.Rows[x].ItemArray[17].ToString()) ? 0 : Double.Parse(Datos.Rows[x].ItemArray[17].ToString())
                    };
                    //AGREGO EL VALOR
                    this.lista.Add(fila);
                }
                dataLDREGRECBindingSource.DataSource = this.lista;
                //
                //for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                //{
                //    dataLDREGRECBindingSource.AddNew();
                //    //MessageBox.Show(Datos.Rows[0].ItemArray[6].ToString());
                //    //og_cargos.Rows[x].Cells[0].Value = Int64.Parse(Datos.Rows[x].ItemArray[0].ToString());//0
                //    //og_cargos.Rows[x].Cells[1].Value = Int64.Parse(Datos.Rows[x].ItemArray[1].ToString());//--
                //    //og_cargos.Rows[x].Cells[2].Value = Int64.Parse(Datos.Rows[x].ItemArray[2].ToString());//1
                //    //og_cargos.Rows[x].Cells[3].Value = Int64.Parse(Datos.Rows[x].ItemArray[3].ToString());//2
                //    //og_cargos.Rows[x].Cells[4].Value = DateTime.Parse(Datos.Rows[x].ItemArray[4].ToString());//3
                //    //og_cargos.Rows[x].Cells[5].Value = Int64.Parse(Datos.Rows[x].ItemArray[5].ToString());//4
                //    //og_cargos.Rows[x].Cells[6].Value = Datos.Rows[x].ItemArray[6].ToString();//5
                //    //og_cargos.Rows[x].Cells[7].Value = Int64.Parse(Datos.Rows[x].ItemArray[7].ToString());//6
                //    //og_cargos.Rows[x].Cells[8].Value = Datos.Rows[x].ItemArray[8].ToString();//7
                //    //og_cargos.Rows[x].Cells[9].Value = Int64.Parse(Datos.Rows[x].ItemArray[9].ToString());//8
                //    //og_cargos.Rows[x].Cells[10].Value = Double.Parse(Datos.Rows[x].ItemArray[10].ToString());//9
                //    //og_cargos.Rows[x].Cells[11].Value = Int64.Parse(Datos.Rows[x].ItemArray[11].ToString());//10
                //    //og_cargos.Rows[x].Cells[12].Value = Int64.Parse(Datos.Rows[x].ItemArray[12].ToString());//11
                //    //og_cargos.Rows[x].Cells[13].Value = Double.Parse(Datos.Rows[x].ItemArray[13].ToString());//12
                //    //og_cargos.Rows[x].Cells[14].Value = Double.Parse(Datos.Rows[x].ItemArray[14].ToString());//13
                //    //og_cargos.Rows[x].Cells[15].Value = Double.Parse(Datos.Rows[x].ItemArray[15].ToString());//14
                //    //og_cargos.Rows[x].Cells[16].Value = Int64.Parse(Datos.Rows[x].ItemArray[16].ToString());//15
                //    //og_cargos.Rows[x].Cells[17].Value = Double.Parse(Datos.Rows[x].ItemArray[17].ToString());//16
                //}
                //bloqueo celdas
                for (int i = 0; i <= og_cargos.DisplayLayout.Bands[0].Columns.Count - 1; i++)
                {
                    og_cargos.DisplayLayout.Bands[0].Columns[i].CellActivation = Activation.NoEdit;
                }
            }
        }
    }
}
