using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;

namespace LDCGESTTA.Metodos
{
    class ArchivoPlano
    {

        public void CrearTXT(String sbRuta, String Linea)
        {
           // MessageBox.Show(sbRuta);
            //string sbSplit = ;
            string fileName = sbRuta;

            try
            {
                // se valida si existe el archivo, si existe se elimina y se vuelve a crear
                /*if (File.Exists(fileName))
                {
                    File.Delete(fileName);
                }*/

                // Se crea el archivo y se escribe sobre él
                using (StreamWriter sw = File.CreateText(fileName))
                {
                    sw.WriteLine("Hora de la Prueba", DateTime.Now.ToString());
                }

                // Write file contents on console.     
                using (StreamReader sr = File.OpenText(fileName))
                {
                    string s = "";
                    while ((s = sr.ReadLine()) != null)
                    {
                        Console.WriteLine(s);
                    }
                }
            }
            catch (Exception Ex)
            {
                Console.WriteLine(Ex.ToString());
            }
        }

    }
}
