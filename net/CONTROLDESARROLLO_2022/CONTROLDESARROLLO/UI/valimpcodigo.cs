using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

///Librerias OPEN
using OpenSystems.Windows.Controls;
using OpenSystems.Security.ExecutableMgr;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;

//Librerias BL
using CONTROLDESARROLLO.BL;

//Manejo Archivo
using System.IO;

namespace CONTROLDESARROLLO.UI
{
    public partial class valimpcodigo : OpenForm
    {
        //Tabla de Memoria Homologaacion
        DataTable DTHomologacion = new DataTable();
        /////////////////////////////////////////////////////////////////////////
        ///
        public valimpcodigo()
        {
            InitializeComponent();

            //Creacion de campos de la tabla de memoria Homologaacion
            DTHomologacion.Columns.Clear();
            DTHomologacion.Rows.Clear();
            DTHomologacion.Columns.Add("homologacion");
            DTHomologacion.Columns.Add("cantidad");
            DTHomologacion.Columns.Add("nuevo");
            /////////////////////////////////////////////////////
        }

        private void obValidar_Click(object sender, EventArgs e)
        {

            String line;

            String EsquemaOPEN = "OPEN.";
            Int64 ContadorEsquemaOPEN = 0;
            bool ExisteEsquemaOPEN;

            String EsquemaADM_PERSON = "ADM_PERSON.";
            Int64 ContadorEsquemaADM_PERSON = 0;
            bool ExisteEsquemaADM_PERSON;

            String EsquemaPERSONALIZACIONES = "PERSONALIZACIONES.";
            Int64 ContadorEsquemaPERSONALIZACIONES = 0;
            bool ExisteEsquemaPERSONALIZACIONES;

            String CaracterInterrogacion1 = "?";
            Int64 ContadorInterrogacion1 = 0;
            bool ExisteInterrogacion1;

            String CadenaHomologacion;
            Int64 ContadorHomologacion = 0;
            bool ExisteHomologacion;

            lbxContenidoArchivo.Items.Clear();
            DTHomologacion.Clear();
            dgvHomologacion.Rows.Clear();
            dgvDependencia.Rows.Clear();

            DataRow[] DRExisteHomologacion;

            Cursor.Current = Cursors.WaitCursor;

            try
            {

                //Pestaña Homologaciones
                ////////////////////////////////////////////////////
                BLGENERAL SQLObjetoHomologacion = new BLGENERAL();
                DataTable datos = SQLObjetoHomologacion.SQLGeneral("select servicio_origen, servicio_destino  from homologacion_servicios where servicio_origen is not null group by servicio_origen, servicio_destino");

                BLGENERAL SQLFuenteObjeto = new BLGENERAL();

                //MessageBox.Show(datos.Rows.Count.ToString());
                foreach (string rowCodigoFuente in TxtCodigo.Lines)
                {
                    foreach (DataRow row in datos.Rows)
                    {

                        ExisteInterrogacion1 = rowCodigoFuente.ToString().ToLower().Contains(CaracterInterrogacion1); ;
                        if (ExisteInterrogacion1)
                        {
                            ContadorInterrogacion1 = ContadorInterrogacion1 + 1;
                        }

                        //MessageBox.Show("1 - " + rowCodigoFuente.ToString());
                        //MessageBox.Show("2 - " + row["servicio_origen"].ToString());
                        ExisteHomologacion = rowCodigoFuente.ToString().ToLower().Contains(row["servicio_origen"].ToString().ToLower());
                        if (ExisteHomologacion)
                        {
                            String Busqueda = "homologacion = '" + row["servicio_origen"].ToString() + "'";
                            DRExisteHomologacion = DTHomologacion.Select(Busqueda);

                            if (DRExisteHomologacion.Length > 0)
                            {
                                foreach (var updaterow in DRExisteHomologacion)
                                {
                                    updaterow["cantidad"] = Convert.ToInt64(updaterow["cantidad"].ToString()) + 1;
                                }
                            }
                            else
                            {
                                // Agregar una nueva fila a la tabla de memoria homologacion.
                                DataRow NuevaFila = DTHomologacion.NewRow();
                                NuevaFila["homologacion"] = row["servicio_origen"].ToString();
                                NuevaFila["cantidad"] = 1;
                                NuevaFila["nuevo"] = row["servicio_destino"].ToString();
                                DTHomologacion.Rows.Add(NuevaFila);
                            }
                        }
                    }
                }


                if (ContadorInterrogacion1 > 0)
                {
                    //lbxContenidoArchivo.Items.Add("El caracter " + CaracterInterrogacion1 + " contiene " + ContadorInterrogacion1 + " caracter(es)");
                    // Agregar una nueva fila a la tabla de memoria homologacion.
                    DataRow NuevaFila = DTHomologacion.NewRow();
                    NuevaFila["homologacion"] = "?";
                    NuevaFila["cantidad"] = ContadorInterrogacion1;
                    NuevaFila["nuevo"] = "Cambiar por Letra o caracter correcto";
                    DTHomologacion.Rows.Add(NuevaFila);
                }
                if (ContadorHomologacion > 0)
                {
                    lbxContenidoArchivo.Items.Add("Existe(n) " + ContadorHomologacion + " homologacion(es)");
                }

                DataRow[] DRFilasHomologacion;

                //Usa el filtro sobre la tabal para seleccionar datos relacionados.
                DRFilasHomologacion = DTHomologacion.Select();

                if (DRFilasHomologacion.Length > 0)
                {
                    obReemplazarTodo.Enabled = true;
                    for (int i = 0; i < DRFilasHomologacion.Length; i++)
                    {

                        //lbxContenidoArchivo.Items.Add("OPEN " + DRFilasHomologacion[i][0].ToString() + " - cantidad " + DRFilasHomologacion[i][1].ToString() + " - Nuevo " + DRFilasHomologacion[i][2].ToString());
                        int fila = dgvHomologacion.Rows.Add();

                        dgvHomologacion.Rows[fila].Cells[0].Value = DRFilasHomologacion[i][0].ToString();
                        dgvHomologacion.Rows[fila].Cells[1].Value = DRFilasHomologacion[i][1].ToString();
                        dgvHomologacion.Rows[fila].Cells[2].Value = DRFilasHomologacion[i][2].ToString();

                    }
                }
                ////////////////////////////////////////////////////////////////////////////////////////////////////////


                ////Pestaña Objetos Dendendientes
                //////////////////////////////////////////////////////
                ////MessageBox.Show("Objeto: " + sbObjetoSinExtension);

                //BLGENERAL SQLObjetoDependiente = new BLGENERAL();
                //DataTable DATAObjetoDependiente = SQLObjetoDependiente.SQLGeneral("select oh.owner propietario, oh.OBJECT_NAME dependencia from public_dependency pd, dba_objects oh where pd.referenced_object_id in (select o.object_id from dba_objects o where upper(o.object_name) like upper('" + sbObjeto + "')) and pd.object_id = oh.object_id and upper(oh.object_name) not in  upper('" + sbObjeto + "')");
                ////("with objeto as (select o.object_id, o.object_name, o.owner, o.object_type from dba_objects o where upper(o.object_name) like upper('" + sbObjetoSinExtension + "')) select p.owner propietario,  oh.OBJECT_NAME dependencia from public_dependency pd, objeto p, dba_objects oh where pd.referenced_object_id = p.object_id and pd.object_id = oh.object_id group by p.owner, oh.OBJECT_NAME  order by p.owner, oh.OBJECT_NAME");

                ////MessageBox.Show(datos.Rows.Count.ToString());

                //foreach (DataRow row in DATAObjetoDependiente.Rows)
                //{
                //    int fila = dgvDependencia.Rows.Add();
                //    dgvDependencia.Rows[fila].Cells[0].Value = row["propietario"].ToString();
                //    dgvDependencia.Rows[fila].Cells[1].Value = row["dependencia"].ToString();
                //}
                //////////////////////////////////////////////////////////////////////////////////////////////////////////




            }
            catch (IOException ex)
            {
                Console.WriteLine("Error: " + ex.Message);

                //obReemplazarTodo.Enabled = false;
                //MessageBox.Show("Error");
                //Cursor.Current = Cursors.Default;
            }

            Cursor.Current = Cursors.Default;

            foreach (string linea in TxtCodigo.Lines)
            {
                // Puedes hacer lo que necesites con cada línea
                Console.WriteLine(linea); // Por ejemplo, imprimirla en la consola
            }

        }
    }
}
