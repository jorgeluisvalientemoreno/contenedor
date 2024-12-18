using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.ExceptionHandler;
using SINCECOMP.SUBSIDYS.DAL;
using System.Data;
using SINCECOMP.SUBSIDYS.Entities;

namespace SINCECOMP.SUBSIDYS.BL
{
    class BLGENERAL
    {

        DALGENERAL general = new DALGENERAL();

        public void mensaje(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(2741, msj);
        }

        public void mensaje(Int64 nuError, String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(nuError, msj);
        }

        public void mensajeOk(String mesagge)
        {
            ExceptionHandler.DisplayMessage(2741, mesagge);
        }

        public void mensajeOk(Int64 nuError, String mesagge)
        {
            ExceptionHandler.DisplayMessage(nuError, mesagge);
        }

        public void mensajeError(Exception message)
        {
            GlobalExceptionProcessing.ShowErrorException(message);
        }

        public Boolean validarPath(String vObjeto)
        {
            if (vObjeto.Trim().ToString() == "")
            {
                mensaje("No ha ingresado una Ruta u Archivo Valido");
                return false;
            }
            return true;
        }

        public String getConstantValue(String cName)
        {
            return general.getConstantValue(cName);
        }

        //public void generatePDF(String isbOutPathFile, String inuTemplateId, String isbOutNameFile)
        public void generatePDF(String isbOutPathFile, String isbOutNameFile)
        {
            //general.generatePDF(isbOutPathFile, inuTemplateId, isbOutNameFile);
            general.generatePDF(isbOutPathFile, isbOutNameFile);
        }

        public String setandgetQuery(Int64 inucoempadi)
        {
            return general.setandgetQuery(inucoempadi);
        }

        public void standardProcedure(String Procedure, int numField, String[] Type, String[] Campos, String[] Values)
        {
            general.standardProcedure(Procedure, numField, Type, Campos, Values);
        }

        public DataTable cursorProcedure(String Procedure, int numField, String[] Type, String[] Campos, String[] Values)
        {
            return general.cursorProcedure(Procedure, numField, Type, Campos, Values);
        }

        public DataTable cursorProcedure(String Procedure, String Nombre, int numField, String[] Type, String[] Campos, String[] Values)
        {
            return general.cursorProcedure(Procedure, Nombre, numField, Type, Campos, Values);
        }

        //OBTENER LA SESION DEL SISTEMA
        public String GetfunctionSesion()
        {
            return general.GetfunctionSesion();
        }

        public void deleteremainsub(string nuStateDelivery)
        {
            general.deleteremainsub(nuStateDelivery);
        }

        //obtener informacion cusor referenciado
        public String GetfunctionSesion(Int64 inuSesion)
        {
            return general.GetFcldupbillclob(inuSesion);
        }

        public static List<cartaspotenciales> Fcucartaspotenciales(Int64 inuSesion)//, String isbOutPathFile, String isbOutNameFile)
        {
            List<cartaspotenciales> ListArticle = new List<cartaspotenciales>();
            DataTable TBcartaspotenciales = DALGENERAL.FclgenLetters(inuSesion);//, isbOutPathFile, isbOutNameFile);
            if (TBcartaspotenciales != null)
            {
                foreach (DataRow row in TBcartaspotenciales.Rows)
                {
                    cartaspotenciales vArticle = new cartaspotenciales(row);
                    ListArticle.Add(vArticle);
                }
            }
            return ListArticle;
        }

        public static List<cartaspotenciales> FcuFacturasDuplicadas(Int64 inuSesion)//, String isbOutPathFile, String isbOutNameFile)
        {
            List<cartaspotenciales> ListArticle = new List<cartaspotenciales>();
            DataTable TBcartaspotenciales = DALGENERAL.FclgenLetters(inuSesion);//, isbOutPathFile, isbOutNameFile);
            if (TBcartaspotenciales != null)
            {
                foreach (DataRow row in TBcartaspotenciales.Rows)
                {
                    cartaspotenciales vArticle = new cartaspotenciales(row);
                    ListArticle.Add(vArticle);
                }
            }
            return ListArticle;
        }

        public void CartasPotencialesPDF(String isbsource, String isbfilename, String iclclob)
        //public void generatePDF(String isbOutPathFile, String isbOutNameFile)
        {
            general.CartasPotencialesPDF(isbsource, isbfilename, iclclob);
            //general.generatePDF(isbOutPathFile, isbOutNameFile);
        }

        public void FacturasDuplicadosPDF(String isbsource, String isbfilename, String iclclob)
        //public void generatePDF(String isbOutPathFile, String isbOutNameFile)
        {
            general.FacturasDuplicadosPDF(isbsource, isbfilename, iclclob);
            //general.generatePDF(isbOutPathFile, isbOutNameFile);
        }

        
        public void BLProcgenLetters(Int64 inuSesion, String isbsource, String isbfilename)
        {
            general.DALProcgenLetters(inuSesion, isbsource, isbfilename);
        }
    
    }
}
