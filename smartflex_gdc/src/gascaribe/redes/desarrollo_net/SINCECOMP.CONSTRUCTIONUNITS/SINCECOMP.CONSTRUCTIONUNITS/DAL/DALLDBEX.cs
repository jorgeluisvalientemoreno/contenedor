using System;
using System.Collections.Generic;
using System.Text;
// Librerías sistema
using System.Data;
using System.Data.Common;

// Librerías OpenSystems
using OpenSystems.Common.Data;

using SINCECOMP.CONSTRUCTIONUNITS.Entity;

namespace SINCECOMP.CONSTRUCTIONUNITS.DAL
{
    class DALLDBEX
    {
        /*Pesos Corrientes a Rango de Fechas*/
        
        /*LLAMADO DE LOS METODOS DEL PAQUETE LD_BCExecutedBudge
         PARA OBTENER DATOS DE LOS EJECUTADO DE LO PRESUPUESTADO*/

        /*METODO PARA OBTENER TODOS LOS MERCADO RELEVANTES*/
        public static DataTable DSLdRelevantMarket()
        {

            DataSet DSLdRelevantMarket = new DataSet("LdRelevantMarket");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProLdRelevantMarket"))
            {
                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSLdRelevantMarket, "LdRelevantMarket");
            }
            return DSLdRelevantMarket.Tables["LdRelevantMarket"];
        }

        /*Unidades Constrcutivas con y sin presupuesto agrupadas por localidad*/
        
        /*METODO PARA OBTENER CANTIDAD EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS PRO UBICACION GEOGRAFICA*/
        public static DataTable ProConUniLocExecAmount(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSCULEA = new DataSet("CULEA");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConUniLocExecAmount"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULEA, "CULEA");
            }
            return DSCULEA.Tables["CULEA"];

        }

        /*METODO PARA OBTENER EL VALOR EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS PRO UBICACION GEOGRAFICA*/
        public static DataTable ProConUniLocExecValue(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSCULEV = new DataSet("CULEV");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConUniLocExecValue"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULEV, "CULEV");
            }
            return DSCULEV.Tables["CULEV"];

        }

        /*METODO PARA OBTENER CANTIDAD EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS POR UBICACION GEOGRAFICA NO PRESUPUESTADAS*/
        public static DataTable ProCoUnLoExNoDebugAm(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSCUENDA = new DataSet("CUENDA");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnLoExNoDebugAm"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUENDA, "CUENDA");
            }
            return DSCUENDA.Tables["CUENDA"];

        }

        /*METODO PARA OBTENER EL VALOR EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS POR UBICACION GEOGRAFICA NO PRESUPUESTADAS*/
        public static DataTable ProCoUnLoExNoDegubVal(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSCULENDV = new DataSet("CULENDV");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnLoExNoDegubVal"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULENDV, "CULENDV");
            }
            return DSCULENDV.Tables["CULENDV"];
        }

        /*METODO PARA OBTENER LA CANTIDAD EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS POR UNA UBICACION GEOGRAFICA DE LA PESTAÑA UNIDAD CONSTRCUTIVA
         POR LOCALIDAD*/

        public static DataTable ProConUniLocDetExeAmo(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {

            DataSet DSCULDEA = new DataSet("CULDEA");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConUniLocDetExeAmo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuGeograpLocationId", DbType.Int64, GeograpLocationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULDEA, "CULDEA");
            }
            return DSCULDEA.Tables["CULDEA"];
        }


        /*METODO PARA OBTENER EL DETALLE DEL VALOR EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS POR UNA UBICACION GEOGRAFICA DE LA PESTAÑA UNIDAD CONSTRCUTIVA
         POR LOCALIDAD FILTRADA POR UNA LOCALIDAD*/
        public static DataTable ProConUniLocDetExeVal(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {

            DataSet DSCULDEV = new DataSet("CULDEV");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConUniLocDetExeVal"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuGeograpLocationId", DbType.Int64, GeograpLocationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULDEV, "CULDEV");
            }
            return DSCULDEV.Tables["CULDEV"];
        }

        /*METODO PARA OBTENER EL DETALLE DE LA CANTIDAD EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS POR UNA UBICACION GEOGRAFICA NO PRESUPUESTADA DE LA PESTAÑA UNIDAD CONSTRCUTIVA
         POR LOCALIDAD FILTRADA POR UNA LOCALIDAD*/
        public static DataTable ProCoUnLoDeExeNoDebAmo(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {

            DataSet DSCULDENDA = new DataSet("CULDENDA");

            using ( DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnLoDeExeNoDebAmo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuGeograpLocationId", DbType.Int64, GeograpLocationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULDENDA, "CULDENDA");
            }
            return DSCULDENDA.Tables["CULDENDA"];

        }

        /*METODO PARA OBTENER EL DETALLE DE LA CANTIDAD EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS POR UNA UBICACION GEOGRAFICA NO PRESUPUESTADA DE LA PESTAÑA UNIDAD CONSTRCUTIVA
         POR LOCALIDAD FILTRADA POR UNA LOCALIDAD*/
        public static DataTable ProCoUnLoDeExeNoDebVal(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {

            DataSet DSCULDENDV = new DataSet("CULDENDV");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnLoDeExeNoDebVal"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuGeograpLocationId", DbType.Int64, GeograpLocationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULDENDV, "CULDENDV");
            }
            return DSCULDENDV.Tables["CULDENDV"];

        }
      
        /*Fin Unidades Constrcutivas con y sin presupuesto agrupadas por localidad*/

        /*Unidades Constrcutivas con y sin presupuesto agrupadas por unidades construtivas*/

        /*METODO PARA OBTENER CANTIDAD EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS POR UNIDAD CONSTRUCTIVA*/
        public static DataTable ProConsUnitExeAmount(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSCUEA = new DataSet("CUEA");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConsUnitExeAmount"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUEA, "CUEA");
            }
            return DSCUEA.Tables["CUEA"];

        }

        /*METODO PARA OBTENER EL VALOR EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS POR UNIDAD CONSTRUCTIVA*/
        public static DataTable ProConsUnitExeValue(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSCUEV = new DataSet("CUEV");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConsUnitExeValue"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUEV, "CUEV");
            }
            return DSCUEV.Tables["CUEV"];

        }

        /*METODO PARA OBTENER CANTIDAD EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS POR UNIDAD CONSTRUCTIVA NO PRESUPUESTADAS*/
        public static DataTable ProCoUnExNoDebugAm(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSCUENDA = new DataSet("CUENDA");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnExNoDebugAm"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUENDA, "CUENDA");
            }
            return DSCUENDA.Tables["CUENDA"];

        }

        /*METODO PARA OBTENER EL VALOR EJECUTADA DE UNIDADES CONSTRCUTIVAS
         AGRUPADAS POR UNIDAD CONSTRUCTIVA NO PRESUPUESTADAS*/
        public static DataTable ProCoUnExNoDegubVal(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSCUENDV = new DataSet("CUENDV");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnExNoDegubVal"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUENDV, "CUENDV");
            }
            return DSCUENDV.Tables["CUENDV"];
        }

        /*METODO PARA OBTENER EL DETALLE DE LA CANTIDAD EJECUTADA DE LAS LOLCALIDADES
         AGRUPADAS POR UNA UNIDAD CONSTRCUTIVA PRESUPUESTADA DE LA PESTAÑA UNIDAD CONSTRCUTIVA*/
        public static DataTable ProConstUnitDetaExeAmo(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {

            DataSet DSCUDEA = new DataSet("CUDEA");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConstUnitDetaExeAmo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConUniBudgetId", DbType.Int64, ConUniBudgetId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUDEA, "CUDEA");
            }
            return DSCUDEA.Tables["CUDEA"];

        }

        /*METODO PARA OBTENER EL DETALLE DEL VALOR EJECUTADA DE LAS LOLCALIDADES
         AGRUPADAS POR UNA UNIDAD CONSTRCUTIVA PRESUPUESTADA DE LA PESTAÑA UNIDAD CONSTRCUTIVA*/
        public static DataTable ProConstUnitDetaExeVal(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {

            DataSet DSCUDEV = new DataSet("CUDEV");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConstUnitDetaExeVal"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConUniBudgetId", DbType.Int64, ConUniBudgetId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUDEV, "CUDEV");
            }
            return DSCUDEV.Tables["CUDEV"];

        }

        /*METODO PARA OBTENER EL DETALLE DE LA CANTIDAD EJECUTADA DE LAS LOLCALIDADES
         AGRUPADAS POR UNA UNIDAD CONSTRCUTIVA NO PRESUPUESTADA DE LA PESTAÑA UNIDAD CONSTRCUTIVA*/
        public static DataTable ProConUniDeExeNoDebAmo(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {

            DataSet DSCUDENDA = new DataSet("CUDENDA");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConUniDeExeNoDebAmo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConUniBudgetId", DbType.Int64, ConUniBudgetId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUDENDA, "CUDENDA");
            }
            return DSCUDENDA.Tables["CUDENDA"];

        }

        /*METODO PARA OBTENER EL DETALLE DEL VALOR EJECUTADA DE LAS LOLCALIDADES
         AGRUPADAS POR UNA UNIDAD CONSTRCUTIVA NO PRESUPUESTADA DE LA PESTAÑA UNIDAD CONSTRCUTIVA*/
        public static DataTable ProConUniDeExeNoDebVal(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {

            DataSet DSCUDENDV = new DataSet("CUDENDV");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConUniDeExeNoDebVal"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConUniBudgetId", DbType.Int64, ConUniBudgetId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUDENDV, "CUDENDV");
            }
            return DSCUDENDV.Tables["CUDENDV"];

        }

        /*Fin Unidades Constrcutivas con y sin presupuesto agrupadas por localidad*/
        
        /*Fin Pesos Corrientes a Rango de Fechas*/

        /*Demanda de Gas*/
        public static DataTable ProGasDemandExe(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSGDE = new DataSet("GDE");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProGasDemandExe"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSGDE, "GDE");
            }
            return DSGDE.Tables["GDE"];
        }
        /*Fin Demanda de Gas*/

        /*Detalle Demanda de Gas*/
        public static DataTable ProGasDemandDetaExe(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId, Int64 CateCodi, Int64 SuCaCodi)
        {

            DataSet DSGDDE = new DataSet("GDDE");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProGasDemandDetaExe"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCateCodi", DbType.Int64, CateCodi);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSuCaCodi", DbType.Int64, SuCaCodi);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSGDDE, "GDDE");
            }
            return DSGDDE.Tables["GDDE"];
        }
        /*Fin Detalle Demanda de Gas*/

        /*Servicio de Gas*/
        public static DataTable ProGasServiceExe(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSGSE = new DataSet("GSE");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProGasServiceExe"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSGSE, "GSE");
            }
            return DSGSE.Tables["GSE"];
        }
        /*Fin Servicio de Gas*/

        /*Detalle Servicio de Gas*/
        public static DataTable ProGasServiceDetaExe(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId, Int64 CateCodi, Int64 SuCaCodi)
        {

            DataSet DSGSDE = new DataSet("GSDE");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProGasServiceDetaExe"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCateCodi", DbType.Int64, CateCodi);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSuCaCodi", DbType.Int64, SuCaCodi);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSGSDE, "GSDE");
            }
            return DSGSDE.Tables["GSDE"];
        }
        /*Fin Detalle Servicio de Gas*/

        /*GASTOS DE COMERCIALIZACION*/
        /*METODO PARA OBTENER EL TOTAL EJECUTADO DE GASTOS DE COMERCIALIZACION*/
        public static DataTable ProMarExpBudget(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSMEB = new DataSet("MEB");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProMarExpBudget"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSMEB, "MEB");
            }
            return DSMEB.Tables["MEB"];

        }
        /*FIN DE GASTOS DE COMERCIALIZACION*/
        /*GASTOS DE DISTRIBUCION*/
        /*METODO PARA OBTENER EL TOTAL EJECUTADO DE GASTOS DE DISTRIBUCION*/
        public static DataTable ProDisExpBudget(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {

            DataSet DSDEB = new DataSet("DEB");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProDisExpBudget"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSDEB, "DEB");
            }
            return DSDEB.Tables["DEB"];

        }
        /*FIN DE GASTOS DE COMERCIALIZACION*/

        /*METODO PARA OBTENER EL PRIMER AÑO Y MES DE REGISTRO DE TARIFA*/
        public static string FsbRelMarRateYearMonth()
        {
            string RelMarketRate = String.Empty;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.FsbRelMarRateYearMonth"))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }        
        /*FIN METODO PARA OBTENER EL PRIMER AÑO Y MES DE REGISTRO DE TARIFA*/

        /*METODO PARA OBTENER EL  AÑO Y MES BASE DE TARIFA*/
        public static Int64 FsbRelMarkRateBaseYear(Int64 RelevantMarketId)
        {
            string RelMarketRate = String.Empty;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.FsbRelMarkRateBaseYear"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);
                
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }
        /*FIN METODO PARA OBTENER EL  AÑO Y MES BASE DE TARIFA*/

        /*Pesos Pesos Constantes de un periodo*/

        /*METODO PARA OBTENER EL VALOR EJECUTADO DE LOCALIDADES 
          AGRUPADAS POR UBICACION GEOGRAFICA PRESUPUESTADAS*/
        public static DataTable ProConUniLocValConsPes(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 RelevantMarketId)
        {

            DataSet DSCULVCP = new DataSet("CULVCP");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConUniLocValConsPes"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosYear", DbType.Int64, ConstantPesosYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosMonth", DbType.Int64, ConstantPesosMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULVCP, "CULVCP");
            }
            return DSCULVCP.Tables["CULVCP"];

        }

         /*METODO PARA OBTENER EL VALOR EJECUTADO DE UNIDAD CONSTRCUTIVA
          AGRUPADAS POR UNIDAD CONSTRCUTIVA DE CADA UBICACION GEOGRAFICA 
          SELECCIONADA DE LA GRILLA*/
        public static DataTable ProCoUnLoDetValConsPes(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {

            DataSet DSCULDVCP = new DataSet("CULDVCP");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnLoDetValConsPes"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosYear", DbType.Int64, ConstantPesosYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosMonth", DbType.Int64, ConstantPesosMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuGeograpLocationId", DbType.Int64, GeograpLocationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULDVCP, "CULDVCP");
            }
            return DSCULDVCP.Tables["CULDVCP"];

        }   
    
        /*METODO PARA OBTENER EL VALOR EJECUTADO DE LOCALIDADES 
          AGRUPADAS POR UBICACION GEOGRAFICA NO PRESUPUESTADAS*/
        public static DataTable ProCoUnLocValNoDebCoPe(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 RelevantMarketId)
        {

            DataSet DSCULVNDCP = new DataSet("CULVNDCP");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnLocValNoDebCoPe"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosYear", DbType.Int64, ConstantPesosYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosMonth", DbType.Int64, ConstantPesosMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULVNDCP, "CULVNDCP");
            }
            return DSCULVNDCP.Tables["CULVNDCP"];

        }

        /*METODO PARA OBTENER EL VALOR EJECUTADO DE LOCALIDADES 
          AGRUPADAS POR UBICACION GEOGRAFICA NO PRESUPUESTADAS*/
        public static DataTable ProCoUnLoDeVaNoDeCoPe(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {

            DataSet DSCULDVNDCP = new DataSet("CULDVNDCP");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnLoDeVaNoDeCoPe"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosYear", DbType.Int64, ConstantPesosYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosMonth", DbType.Int64, ConstantPesosMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuGeograpLocationId", DbType.Int64, GeograpLocationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCULDVNDCP, "CULDVNDCP");
            }
            return DSCULDVNDCP.Tables["CULDVNDCP"];

        }   
    
        /*METODO PARA OBTENER EL VALOR EJECUTADO DE LOCALIDADES 
          AGRUPADAS POR UNIDADES CONSTRCTUVAS PRESUPUESTADAS*/
        public static DataTable ProConUnitValueConsPes(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 RelevantMarketId)
        {

            DataSet DSCUVCP = new DataSet("CUVCP");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConUnitValueConsPes"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosYear", DbType.Int64, ConstantPesosYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosMonth", DbType.Int64, ConstantPesosMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUVCP, "CUVCP");
            }
            return DSCUVCP.Tables["CUVCP"];

        }

        /*METODO PARA OBTENER EL DETALLE DEL VALOR EJECUTADO DE CADA UBICACION GEOGRAFICA
          AGRUPADAS POR UNIDAD CONSTRCUTIVA SELECCIONADA DE LA GRILLA*/
        public static DataTable ProConUniDetValConsPes(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {

            DataSet DSCUDVCP = new DataSet("CUDVCP");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProConUniDetValConsPes"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosYear", DbType.Int64, ConstantPesosYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosMonth", DbType.Int64, ConstantPesosMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConUniBudgetId", DbType.Int64, ConUniBudgetId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUDVCP, "CUDVCP");
            }
            return DSCUDVCP.Tables["CUDVCP"];

        }

        /*METODO PARA OBTENER EL VALOR EJECUTADO DE LOCALIDADES 
          AGRUPADAS POR UBICACION GEOGRAFICA NO PRESUPUESTADAS*/
        public static DataTable ProCoUnValueNoDebCoPe(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 RelevantMarketId)
        {

            DataSet DSCUVNDCP = new DataSet("CUVNDCP");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnValueNoDebCoPe"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosYear", DbType.Int64, ConstantPesosYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosMonth", DbType.Int64, ConstantPesosMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUVNDCP, "CUVNDCP");
            }
            return DSCUVNDCP.Tables["CUVNDCP"];

        }

        /*METODO PARA OBTENER DETALLE DEL VALOR EJECUTADO DE LAS UNIDADES CONSTRCUTIVAS
          AGRUPADAS POR CADA UBICACION GEOGRAFICA NO PRESUPUESTADAS*/
        public static DataTable ProCoUnDeValNoDebCoPe(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {

            DataSet DSCUDVNDCP = new DataSet("CUDVNDCP");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedBudge.ProCoUnDeValNoDebCoPe"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosYear", DbType.Int64, ConstantPesosYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConstantPesosMonth", DbType.Int64, ConstantPesosMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConUniBudgetId", DbType.Int64, ConUniBudgetId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRelevantMarketId", DbType.Int64, RelevantMarketId);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCUDVNDCP, "CUDVNDCP");
            }
            return DSCUDVNDCP.Tables["CUDVNDCP"];

        }   
       
        
        /*Fin Pesos Pesos Constantes de un periodo*/


    }
}
