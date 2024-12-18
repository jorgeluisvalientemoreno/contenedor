using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
//using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data;
using System.Data.OleDb;

namespace LDCDUPLIFACT
{
    class Importar
    {
        OleDbConnection conn;
        OleDbDataAdapter MyDataAdapter;
        DataTable dt;

        public String importarExcel(DataGridView dgv,String nombreHoja)
        {
            String ruta = "";
            try
            {
                OpenFileDialog openfile1 = new OpenFileDialog();
                openfile1.Filter = "Excel Files |*.xlsx";
                openfile1.Title = "Seleccione el archivo de Excel";
                if (openfile1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    if (openfile1.FileName.Equals("") == false)
                    {
                        ruta = openfile1.FileName;  
                    }
                    
                    //Validamos que el usuario ingrese el nombre de la hoja del archivo de excel a leer
                    if (string.IsNullOrEmpty(nombreHoja))
                    {
                        MessageBox.Show("No hay una hoja para leer");
                    }
                    else
                    {
                        conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;data source=" + ruta + ";Extended Properties='Excel 12.0 Xml;HDR=Yes'");
                        MyDataAdapter = new OleDbDataAdapter("Select CONTRATO, PERIODO, FACTURA from [" + nombreHoja + "$]", conn);
                        dt = new DataTable();
                        MyDataAdapter.Fill(dt);
                        dgv.DataSource = dt;
                    }
                }
                return ruta;                
            }
            catch(Exception ex)
            {                
                //en caso de haber una excepcion que nos mande un mensaje de error
                MessageBox.Show(ex.Message);
               // ruta = "Error, Verificar el archivo o el nombre de la hoja " + ex.Message.ToString();
                return ruta;
            }
        }
    }
}
