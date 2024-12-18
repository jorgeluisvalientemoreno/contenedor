using System;
using System.Data;
using System.Data.Common;
using System.Text;
using OpenSystems.Common.Data;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.SUBSIDYS.DAL
{
    class DALGENERAL
    {
        static String functionQuery = "ld_bosubsidy.Fnusetdataandgettemplate"; //funcion para conocer plantilla
        static String procedurePDF = "Ld_BoSubsidy.ProcExportToPDFFromMem"; //procedimiento para almacenamiento en memoria
        //static String functionSesion = "Ld_BoSubsidy.Fnugetglobalsesion";
        static String functionSesion = "ut_session.getsessionid";        
        static String SbFcldupbillclob = "Ld_BcSubsidy.Fcldupbillclob";
        static String SbProcgenLetters = "Ld_Bosubsidy.ProcgenLetters";
        static String PrcDuplicadofacturaPDF = "LD_BOSUBSIDY.ProcExportBillDuplicateToPDF";
        static String Deleteremainsub = "LD_BOSUBSIDY.deleteremainsub";


        public String getConstantValue(string cName)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" BEGIN");
            sb.Append(" SELECT " + cName + " constante INTO :1 FROM dual;");
            sb.Append(" END;");
            using (DbCommand cmdCommand = OpenDataBase.db.GetSqlStringCommand(sb.ToString()))
            {
                OpenDataBase.db.AddParameter(cmdCommand, ":1", DbType.String, ParameterDirection.Output, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return (string)(OpenDataBase.db.GetParameterValue(cmdCommand, ":1"));
            }

        }

        //public void generatePDF(String isbOutPathFile, String inuTemplateId, String isbOutNameFile)
        public void generatePDF(String isbOutPathFile, String isbOutNameFile)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(procedurePDF))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbsource", DbType.String, isbOutPathFile);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbfilename", DbType.String, isbOutNameFile);
                //OpenDataBase.db.AddInParameter(cmdCommand, "isbtemplate", DbType.String, inuTemplateId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        public String setandgetQuery(Int64 inucoempadi)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(functionQuery))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inucoempadi", DbType.Int64, inucoempadi);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        public void standardProcedure(String Procedure, int numField, String[] Type, String[] Campos, String[] Values)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                for (int i = 0; i <= numField - 1; i++)
                {
                    if (Type[i] == "String")
                        OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, Values[i]);
                    if (Type[i] == "Int64")
                        OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, Convert.ToInt64(Values[i]));
                }
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        public DataTable cursorProcedure(String Procedure, int numField, String[] Type, String[] Campos, String[] Values)
        {
            DataSet dsgeneral = new DataSet("LDSolution");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                for (int i = 0; i <= numField - 1; i++)
                {
                    if (Type[i] == "String")
                        OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, Values[i]);
                    if (Type[i] == "Int64")
                        OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, Convert.ToInt64(Values[i]));
                }
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, "LDSolution");
            }
            return dsgeneral.Tables["LDSolution"];
        }

        public DataTable cursorProcedure(String Procedure, String Nombre, int numField, String[] Type, String[] Campos, String[] Values)
        {
            DataSet dsgeneral = new DataSet(Nombre);
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                for (int i = 0; i <= numField - 1; i++)
                {
                    if (Type[i] == "String")
                        OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, Values[i]);
                    if (Type[i] == "Int64")
                        OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, Convert.ToInt64(Values[i]));
                }
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, Nombre);
            }
            return dsgeneral.Tables[Nombre];
        }

        //public void generatePDF(String isbOutPathFile, String inuTemplateId)
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("id_bogeneralprinting.ExportToPDFFromMem"))
        //    {
        //        String isbOutNameFile = "\\Carta_Asignación_Retroactivo_" + DateTime.Now.ToString("dd.MM.yyyy.hh.mm.ss") + ".pdf";
        //        Object sbLineFile = getClob();
        //        OpenDataBase.db.AddInParameter(cmdCommand, "isbOutPathFile", DbType.String, isbOutPathFile);
        //        OpenDataBase.db.AddInParameter(cmdCommand, "isbOutNameFile", DbType.String, isbOutNameFile);
        //        OpenDataBase.db.AddInParameter(cmdCommand, "inuTemplateId", DbType.String, inuTemplateId);
        //        OpenDataBase.db.AddInParameter(cmdCommand, "isbLiinuDataneFile", DbType.Binary, sbLineFile);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //    }
        //}

        //public Object getClob()
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("Ld_Bosubsidy.fclgetglobalclob"))
        //    {
        //        OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Binary, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //        return Convert.ToByte(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
        //    }
        //}

        public void mensaje(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(2741, msj);
        }

        public void mensajeOk(String mesagge)
        {
            ExceptionHandler.DisplayMessage(2741, mesagge);
        }

        //OBTENER LA SESION DEL USUARIO    
        public String GetfunctionSesion()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(functionSesion))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        public void deleteremainsub(String nuStateDelivery)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Deleteremainsub))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbremaintype", DbType.String, nuStateDelivery);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);                
            }
        }

        //retorna curosr referenciado 
        public String GetFcldupbillclob(Int64 inuSesion)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(SbFcldupbillclob))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inucoempadi", DbType.Int64, inuSesion);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }


        public static DataTable FclgenLetters(Int64 inuSesion)//, String isbOutPathFile, String isbOutNameFile)
        {

            DataSet DScartaspotenciales = new DataSet("cartaspotenciales");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(SbFcldupbillclob))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inusession", DbType.Int64, inuSesion);
                //OpenDataBase.db.AddInParameter(cmdCommand, "isbsource", DbType.String, isbOutPathFile);
                //OpenDataBase.db.AddInParameter(cmdCommand, "isbfilename", DbType.String, isbOutNameFile);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DScartaspotenciales, "cartaspotenciales");
            }
            return DScartaspotenciales.Tables["cartaspotenciales"];
        }

        public void CartasPotencialesPDF(String isbsource, String isbfilename, String iclclob)
        //public void generatePDF(String isbOutPathFile, String isbOutNameFile)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(procedurePDF))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbsource", DbType.String, isbsource);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbfilename", DbType.String, isbfilename);
                OpenDataBase.db.AddInParameter(cmdCommand, "iclclob", DbType.String, iclclob);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        public void FacturasDuplicadosPDF(String isbsource, String isbfilename, String iclclob)
        //public void generatePDF(String isbOutPathFile, String isbOutNameFile)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(PrcDuplicadofacturaPDF))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbsource", DbType.String, isbsource);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbfilename", DbType.String, isbfilename);
                OpenDataBase.db.AddInParameter(cmdCommand, "iclclob", DbType.String, iclclob);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }
        
        public void DALProcgenLetters(Int64 inuSesion, String isbsource, String isbfilename)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(SbProcgenLetters))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inusession", DbType.Int64, inuSesion);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbsource", DbType.String, isbsource);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbfilename", DbType.String, isbfilename);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }


    }
}
