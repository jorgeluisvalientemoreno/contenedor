using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
//using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data;
using System.Data.OleDb;

namespace BSS.LineamientosPSPD
{
    class Importar
    {
        OleDbConnection conn;
        OleDbDataAdapter MyDataAdapter;
        //DataTable dt;

        public String importarExcel(DataTable dt, String nombreHoja)
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
                        try
                        {
                            conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;data source=" + ruta + ";Extended Properties='Excel 12.0 Xml;HDR=No;IMEX=3;MAXSCANROWS=0'");
                            MyDataAdapter = new OleDbDataAdapter("Select * from [" + nombreHoja + "$]", conn);
                            //dt = new DataTable();
                            MyDataAdapter.Fill(dt);
                        }
                        catch (Exception ex)
                        {
                            //en caso de haber una excepcion que nos mande un mensaje de error
                            MessageBox.Show("Error, Documento no valido ", ex.Message);
                            ruta = "";
                        }

                    }
                }
                return ruta;                
            }
            catch(Exception ex)
            {                
                //en caso de haber una excepcion que nos mande un mensaje de error
                MessageBox.Show(ex.Message);
               // ruta = "Error, Verificar el archivo o el nombre de la hoja " + ex.Message.ToString();
                ruta = "";
            }
            return ruta;
        }
    }
}
