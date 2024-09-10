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
    public partial class valimp : OpenForm
    {
        //Tabla de Memoria Homologaacion
        DataTable DTHomologacion = new DataTable();
        /////////////////////////////////////////////////////////////////////////

        public valimp()
        {
            InitializeComponent();

            //Creacion de campos de la tabla de memoria Homologaacion
            DTHomologacion.Columns.Clear();
            DTHomologacion.Rows.Clear();
            DTHomologacion.Columns.Add("homologacion");
            DTHomologacion.Columns.Add("cantidad");
            DTHomologacion.Columns.Add("nuevo");
            /////////////////////////////////////////////////////

            dgvHomologacion.AutoResizeColumns();
            dgvHomologacion.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
        }

        private void valimp_Load(object sender, EventArgs e)
        {

        }

        private void btnCarpeta_Click(object sender, EventArgs e)
        {
            lbxArchivos.Items.Clear();
            lbxContenidoArchivo.Items.Clear();
            dgvHomologacion.Rows.Clear();
            dgvDependencia.Rows.Clear();

            try
            {
                FolderBrowserDialog fbdDirectory = new FolderBrowserDialog();
                fbdDirectory.ShowDialog();
                tbRutaArchivos.TextBoxValue = fbdDirectory.SelectedPath;
            }
            catch
            {
            }
            
            try
            {
                DirectoryInfo dir_info = new DirectoryInfo(tbRutaArchivos.TextBoxValue);
                foreach (FileInfo file_info in dir_info.GetFiles())
                {
                    lbxArchivos.Items.Add(file_info.FullName);
                }
            }
            catch
            {
            }

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


                if (!String.IsNullOrEmpty(tbRutaArchivos.TextBoxValue))
                {
                    //Pestaña Homologaciones
                    ////////////////////////////////////////////////////
                    BLGENERAL SQLObjetoHomologacion = new BLGENERAL();
                    DataTable datos = SQLObjetoHomologacion.SQLGeneral("select servicio_origen, servicio_destino from homologacion_servicios where servicio_origen is not null group by servicio_origen, servicio_destino");

                    //MessageBox.Show(datos.Rows.Count.ToString());

                    //Pass the file path and file name to the StreamReader constructor
                    //MessageBox.Show(lbxArchivos.Text);
                    StreamReader sr = new StreamReader(lbxArchivos.Text);

                    //Read the first line of text
                    line = sr.ReadLine();
                    //Continue to read until you reach end of file                    
                    while (line != null)
                    {

                        ExisteEsquemaOPEN = line.ToUpper().Contains(EsquemaOPEN.ToUpper());
                        if (ExisteEsquemaOPEN)
                        {
                            ContadorEsquemaOPEN = ContadorEsquemaOPEN + 1;
                        }

                        ExisteEsquemaADM_PERSON = line.ToUpper().Contains(EsquemaADM_PERSON.ToUpper());
                        if (ExisteEsquemaADM_PERSON)
                        {
                            ContadorEsquemaADM_PERSON = ContadorEsquemaADM_PERSON + 1;
                        }

                        ExisteEsquemaPERSONALIZACIONES = line.ToUpper().Contains(EsquemaPERSONALIZACIONES.ToUpper());
                        if (ExisteEsquemaPERSONALIZACIONES)
                        {
                            ContadorEsquemaPERSONALIZACIONES = ContadorEsquemaPERSONALIZACIONES + 1;
                        }

                        ExisteInterrogacion1 = line.Contains(CaracterInterrogacion1);
                        if (ExisteInterrogacion1)
                        {
                            ContadorInterrogacion1 = ContadorInterrogacion1 + 1;
                        }

                        foreach (DataRow row in datos.Rows)
                        {
                            ExisteHomologacion = line.ToLower().Contains(row["servicio_origen"].ToString().ToLower());
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

                        line = sr.ReadLine();
                    }
                    //close the file
                    sr.Close();

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

                    if (ContadorEsquemaPERSONALIZACIONES > 0)
                    {
                        //lbxContenidoArchivo.Items.Add("El caracter " + CaracterInterrogacion1 + " contiene " + ContadorInterrogacion1 + " caracter(es)");
                        // Agregar una nueva fila a la tabla de memoria homologacion.
                        DataRow NuevaFila = DTHomologacion.NewRow();
                        NuevaFila["homologacion"] = "PERSONALIZACIONES.";
                        NuevaFila["cantidad"] = ContadorEsquemaPERSONALIZACIONES;
                        NuevaFila["nuevo"] = "Retirar el esquema";
                        DTHomologacion.Rows.Add(NuevaFila);
                    }

                    if (ContadorEsquemaADM_PERSON > 0)
                    {
                        //lbxContenidoArchivo.Items.Add("El caracter " + CaracterInterrogacion1 + " contiene " + ContadorInterrogacion1 + " caracter(es)");
                        // Agregar una nueva fila a la tabla de memoria homologacion.
                        DataRow NuevaFila = DTHomologacion.NewRow();
                        NuevaFila["homologacion"] = "ADM_PERSON.";
                        NuevaFila["cantidad"] = ContadorEsquemaADM_PERSON;
                        NuevaFila["nuevo"] = "Retirar el esquema";
                        DTHomologacion.Rows.Add(NuevaFila);
                    }

                    if (ContadorEsquemaOPEN > 0)
                    {
                        //lbxContenidoArchivo.Items.Add("El caracter " + CaracterInterrogacion1 + " contiene " + ContadorInterrogacion1 + " caracter(es)");
                        // Agregar una nueva fila a la tabla de memoria homologacion.
                        DataRow NuevaFila = DTHomologacion.NewRow();
                        NuevaFila["homologacion"] = "OPEN.";
                        NuevaFila["cantidad"] = ContadorEsquemaOPEN;
                        NuevaFila["nuevo"] = "Retirar el esquema";
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

                    //Pestaña Objetos Dendendientes
                    ////////////////////////////////////////////////////
                    Int64 nuRuta;
                    String sbObjeto;
                    String sbObjetoSinExtension;
                    nuRuta = tbRutaArchivos.TextBoxValue.Length;

                    sbObjeto = lbxArchivos.Text.Substring(tbRutaArchivos.TextBoxValue.Length + 1);

                    string[] subcadenas = sbObjeto.Split('.');

                    sbObjetoSinExtension = subcadenas[0];

                    //MessageBox.Show("Objeto: " + sbObjetoSinExtension);

                    BLGENERAL SQLObjetoDependiente = new BLGENERAL();
                    DataTable DATAObjetoDependiente = SQLObjetoDependiente.SQLGeneral("select oh.owner propietario, oh.OBJECT_NAME dependencia from public_dependency pd, dba_objects oh where pd.referenced_object_id in (select o.object_id from dba_objects o where upper(o.object_name) like upper('" + sbObjetoSinExtension + "')) and pd.object_id = oh.object_id and upper(oh.object_name) not in  upper('" + sbObjetoSinExtension + "')");
                    //("with objeto as (select o.object_id, o.object_name, o.owner, o.object_type from dba_objects o where upper(o.object_name) like upper('" + sbObjetoSinExtension + "')) select p.owner propietario,  oh.OBJECT_NAME dependencia from public_dependency pd, objeto p, dba_objects oh where pd.referenced_object_id = p.object_id and pd.object_id = oh.object_id group by p.owner, oh.OBJECT_NAME  order by p.owner, oh.OBJECT_NAME");

                    //MessageBox.Show(datos.Rows.Count.ToString());

                    foreach (DataRow row in DATAObjetoDependiente.Rows)
                    {
                        int fila = dgvDependencia.Rows.Add();
                        dgvDependencia.Rows[fila].Cells[0].Value = row["propietario"].ToString();
                        dgvDependencia.Rows[fila].Cells[1].Value = row["dependencia"].ToString();
                    }
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////

                }
                else
                {

                    String sbObjeto;

                    sbObjeto = tbObjeto.TextBoxValue;

                    //Pestaña Homologaciones
                    ////////////////////////////////////////////////////
                    BLGENERAL SQLObjetoHomologacion = new BLGENERAL();
                    DataTable datos = SQLObjetoHomologacion.SQLGeneral("select servicio_origen, servicio_destino  from homologacion_servicios where servicio_origen is not null group by servicio_origen, servicio_destino");

                    BLGENERAL SQLFuenteObjeto = new BLGENERAL();
                    DataTable DTCodigoFuente = SQLObjetoHomologacion.SQLGeneral("select ds.TEXT from dba_source ds where upper(ds.name) = upper('" + sbObjeto + "')");


                    //MessageBox.Show(datos.Rows.Count.ToString());
                    foreach (DataRow rowCodigoFuente in DTCodigoFuente.Rows)
                    {
                        foreach (DataRow row in datos.Rows)
                        {

                            ExisteInterrogacion1 = rowCodigoFuente["TEXT"].ToString().ToLower().Contains(CaracterInterrogacion1); ;
                            if (ExisteInterrogacion1)
                            {
                                ContadorInterrogacion1 = ContadorInterrogacion1 + 1;
                            }

                            //MessageBox.Show("1 - " + rowCodigoFuente.ToString());
                            //MessageBox.Show("2 - " + row["servicio_origen"].ToString());
                            ExisteHomologacion = rowCodigoFuente["TEXT"].ToString().ToLower().Contains(row["servicio_origen"].ToString().ToLower());
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


                    //Pestaña Objetos Dendendientes
                    ////////////////////////////////////////////////////
                    //MessageBox.Show("Objeto: " + sbObjetoSinExtension);

                    BLGENERAL SQLObjetoDependiente = new BLGENERAL();
                    DataTable DATAObjetoDependiente = SQLObjetoDependiente.SQLGeneral("select oh.owner propietario, oh.OBJECT_NAME dependencia from public_dependency pd, dba_objects oh where pd.referenced_object_id in (select o.object_id from dba_objects o where upper(o.object_name) like upper('" + sbObjeto + "')) and pd.object_id = oh.object_id and upper(oh.object_name) not in  upper('" + sbObjeto + "')");
                    //("with objeto as (select o.object_id, o.object_name, o.owner, o.object_type from dba_objects o where upper(o.object_name) like upper('" + sbObjetoSinExtension + "')) select p.owner propietario,  oh.OBJECT_NAME dependencia from public_dependency pd, objeto p, dba_objects oh where pd.referenced_object_id = p.object_id and pd.object_id = oh.object_id group by p.owner, oh.OBJECT_NAME  order by p.owner, oh.OBJECT_NAME");

                    //MessageBox.Show(datos.Rows.Count.ToString());

                    foreach (DataRow row in DATAObjetoDependiente.Rows)
                    {
                        int fila = dgvDependencia.Rows.Add();
                        dgvDependencia.Rows[fila].Cells[0].Value = row["propietario"].ToString();
                        dgvDependencia.Rows[fila].Cells[1].Value = row["dependencia"].ToString();
                    }
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////

                }


            }
            catch (IOException ex)
            {
                Console.WriteLine("Error: " + ex.Message);

                //obReemplazarTodo.Enabled = false;
                //MessageBox.Show("Error");
                //Cursor.Current = Cursors.Default;
            }

            Cursor.Current = Cursors.Default;
        }

        private void dgvHomologacion_CellClick(object sender, DataGridViewCellEventArgs e)
        {

            if (e.ColumnIndex == 3)
            {
                String line;
                String servicioorigen = dgvHomologacion.Rows[e.RowIndex].Cells[0].Value.ToString();
                String serviciohomologado = dgvHomologacion.Rows[e.RowIndex].Cells[2].Value.ToString();
                bool ExisteServicio;
                using (StreamReader sr = new StreamReader(lbxArchivos.Text))
                {
                    using (StreamWriter sw = new StreamWriter(@"C:\Users\Jorge Valiente\Desktop\OBJETOS_OSF\TESTA.txt"))//r(lbxArchivos.Text))
                    {
                        while ((line = sr.ReadLine()) != null)
                        {
                            ExisteServicio = line.ToLower().Contains(servicioorigen.ToLower());
                            if (ExisteServicio)
                            {
                                //MessageBox.Show("Antes ...." + line);
                                sw.WriteLine(line.Replace(servicioorigen, serviciohomologado));
                                //MessageBox.Show("Despues ...." + line.Replace(servicioorigen, serviciohomologado));
                            }
                            else 
                            {
                                sw.WriteLine(line);
                            }
                        }
                    }
                }                

                //String line;
                //StreamReader sr = new StreamReader(lbxArchivos.Text, true);
                //bool ExisteServicio;

                ////Read the first line of text
                //line = sr.ReadLine();
                ////Continue to read until you reach end of file
                //String servicioorigen = dgvHomologacion.Rows[e.RowIndex].Cells[0].Value.ToString();
                //String serviciohomologado = dgvHomologacion.Rows[e.RowIndex].Cells[2].Value.ToString();
                ////MessageBox.Show(servicioorigen);
                //while (line != null)
                //{

                //    ExisteServicio = line.Contains(servicioorigen);
                //    if (ExisteServicio)
                //    {
                //        MessageBox.Show("Antes ...." + line);
                //        line = line.Replace(servicioorigen, serviciohomologado);
                //        MessageBox.Show("Despues ...." + line);

                //    }

                //    line = sr.ReadLine();
                //}
                ////close the file
                //sr.Close();
            }
        }

        private void obReemplazarTodo_Click(object sender, EventArgs e)
        {
            String line;
            Int64 Reemplazo = 0;            

            DataRow[] DRExisteHomologacion;

            try
            {
                Cursor.Current = Cursors.WaitCursor;

                DataRow[] DRFilasHomologacion;

                bool ExisteServicio;
                using (StreamReader sr = new StreamReader(lbxArchivos.Text))
                {
                    using (StreamWriter sw = new StreamWriter(@"C:\Users\Jorge Valiente\Desktop\OBJETOS_OSF\TESTA.txt"))//r(lbxArchivos.Text))
                    {
                        while ((line = sr.ReadLine()) != null)
                        {
                            //Usa el filtro sobre la tabal para seleccionar datos relacionados.
                            DRFilasHomologacion = DTHomologacion.Select();

                            if (DRFilasHomologacion.Length > 0)
                            {
                                for (int i = 0; i < DRFilasHomologacion.Length; i++)
                                {
                                    ExisteServicio = line.ToLower().Contains(DRFilasHomologacion[i][0].ToString().ToLower());
                                    //dgvHomologacion.Rows[fila].Cells[0].Value = DRFilasHomologacion[i][0].ToString();
                                    //dgvHomologacion.Rows[fila].Cells[1].Value = DRFilasHomologacion[i][1].ToString();
                                    //dgvHomologacion.Rows[fila].Cells[2].Value = DRFilasHomologacion[i][2].ToString();
                                    if (ExisteServicio)
                                    {
                                        Reemplazo = 1;
                                        //MessageBox.Show("Antes ...." + line);
                                        sw.WriteLine(line.Replace(DRFilasHomologacion[i][0].ToString().ToLower(), DRFilasHomologacion[i][2].ToString().ToLower()));
                                        //MessageBox.Show("Despues ...." + line.Replace(servicioorigen, serviciohomologado));
                                    }
                                }
                            }
                            if (Reemplazo == 0)
                            {
                                sw.WriteLine(line);
                            }
                            else
                            {
                                Reemplazo = 0;
                            }
                        }
                    }
                }   

                Cursor.Current = Cursors.Default;

            }
            catch
            {
                obReemplazarTodo.Enabled = false;
                MessageBox.Show("Error Reemplazando Homologaciones en el nuevo archivo.");
                Cursor.Current = Cursors.Default;
            }
        }

        private void tbRutaArchivos_Leave(object sender, EventArgs e)
        {
            lbxArchivos.Items.Clear();
            lbxContenidoArchivo.Items.Clear();
            DTHomologacion.Clear();
            dgvHomologacion.Rows.Clear();            
            try
            {
                DirectoryInfo dir_info = new DirectoryInfo(tbRutaArchivos.TextBoxValue);
                foreach (FileInfo file_info in dir_info.GetFiles())
                {
                    lbxArchivos.Items.Add(file_info.FullName);
                }
            }
            catch
            {
            }
        }

        private void tbObjeto_Leave(object sender, EventArgs e)
        {
            lbxArchivos.Items.Clear();
            lbxContenidoArchivo.Items.Clear();
            DTHomologacion.Clear();
            dgvHomologacion.Rows.Clear();
        }
    }
}
