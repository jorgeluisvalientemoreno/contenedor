using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;
using System.Windows.Forms;
using System.IO;
using BSS.LineamientosPSPD.Entities;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace BSS.LineamientosPSPD.src
{
    class GPrint
    {

        public void FacturasDuplicadosPDF(String isbsource, String isbfilename, int fact, String marcaDuplicado)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKDUPLICADOSFACTURAEFG.PROPRINTFACT"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbsource", DbType.String, isbsource);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbfilename", DbType.String, isbfilename);
                OpenDataBase.db.AddInParameter(cmdCommand, "isFactura", DbType.Int64, fact);
                OpenDataBase.db.AddInParameter(cmdCommand, "isDuplicado", DbType.String, marcaDuplicado);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        public void ExecutableEXME()
        {
            Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
            OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
        }


        public void CreateMergedPDF(string targetPDF, string sourceDir)
        {
            using (FileStream stream = new FileStream(targetPDF, FileMode.Create))
            {
                Document pdfDoc = new Document(PageSize.A4);
                PdfCopy pdf = new PdfCopy(pdfDoc, stream);
                pdfDoc.Open();
                var files = Directory.GetFiles(sourceDir);
                Console.WriteLine("Merging files count: " + files.Length);
                int i = 1;
                PdfReader reader = null;
                foreach (string file in files)
                {
                    reader = new PdfReader(file);
                    Console.WriteLine(i + ". Adding: " + file);
                    pdf.AddDocument(reader);
                    i++;

                    pdf.FreeReader(reader);
                    reader.Close();
                    File.Delete(file);
                }

                if (pdfDoc != null)
                {
                    pdfDoc.Close();
                }
                Console.WriteLine("SpeedPASS PDF merge complete.");
            }
        }

        public void NewFolderSeq(String path)
        {
            if (Directory.Exists(path).Equals(false))
            {
                DirectoryInfo Dif = new DirectoryInfo(path);
                Dif.Create();
                //  Dif.Attributes = FileAttributes.Hidden;
            }
        }

        public void NewFolderHidden(String path)
        {

            if (System.IO.Directory.Exists(path))
            {
                deleteFolder(path);
            }

            if (Directory.Exists(path).Equals(false))
            {
                DirectoryInfo Dif = new DirectoryInfo(path);
                Dif.Create();
                Dif.Attributes = FileAttributes.Hidden;
            }
        }

        public void deleteFolder(String path)
        {
            System.IO.Directory.Delete(path, true);
        }


    }
}
