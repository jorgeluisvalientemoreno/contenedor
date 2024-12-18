using System;
using System.Collections.Generic;
using System.Text;
// Librerías sistema
using System.Data;
using System.Data.Common;

// Librerías OpenSystems
using OpenSystems.Common.Data;
using SINCECOMP.CONSTRUCTIONUNITS.DAL;
using SINCECOMP.CONSTRUCTIONUNITS.Entity;

namespace SINCECOMP.CONSTRUCTIONUNITS.BL
{
    class BLLDBEX
    {

        /*Funciones que permiten extraer los datos de los metodos de DAL para 
         unidades constructivas agrupadas por localidad*/

        /*Funcion retorna las localidades agrupadas por unidad constructiva 
          presupuestadas con su respectiva cantidad legalizada*/
        public static List<ContructionUnitsLocationAmount> FlistCULEA(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationAmount> ListCULEA = new List<ContructionUnitsLocationAmount>();
            DataTable TBCULEA = DALLDBEX.ProConUniLocExecAmount(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBCULEA != null)
            {
                foreach (DataRow row in TBCULEA.Rows)
                {
                    ContructionUnitsLocationAmount RowTBCULEA = new ContructionUnitsLocationAmount(row);
                    ListCULEA.Add(RowTBCULEA);
                }
            }
            return ListCULEA;
        }

        /*Funcion retorna las localidades agrupadas por unidad constructiva 
          presupuestadas con su respectiva cantidad legalizada*/
        public static List<ContructionUnitsLocationValue> FlistCULEV(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationValue> ListCULEV = new List<ContructionUnitsLocationValue>();
            DataTable TBUCULEV = DALLDBEX.ProConUniLocExecValue(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBUCULEV != null)
            {
                foreach (DataRow row in TBUCULEV.Rows)
                {
                    ContructionUnitsLocationValue RowTBCULEV = new ContructionUnitsLocationValue(row);
                    ListCULEV.Add(RowTBCULEV);
                }
            }
            return ListCULEV;
        }

        /*Funcion retorna las localidades agrupadas por unidad constructiva 
          no presupuestadas con su respectiva cantidad legalizada*/
        public static List<ContructionUnitsLocationAmount> FlistCULENDA(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationAmount> ListCULENDA = new List<ContructionUnitsLocationAmount>();
            DataTable TBCULENDA = DALLDBEX.ProCoUnLoExNoDebugAm(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBCULENDA != null)
            {
                foreach (DataRow row in TBCULENDA.Rows)
                {
                    ContructionUnitsLocationAmount RowTBCULENDA = new ContructionUnitsLocationAmount(row);
                    ListCULENDA.Add(RowTBCULENDA);
                }
            }
            return ListCULENDA;
        }

        /*Funcion retorna las localidades agrupadas por unidad constructiva 
          no presupuestadas con su respectiva cantidad legalizada*/
        public static List<ContructionUnitsLocationValue> FlistCULENDV(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationValue> ListCULENDV = new List<ContructionUnitsLocationValue>();
            DataTable TBCULENDV = DALLDBEX.ProCoUnLoExNoDegubVal(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBCULENDV != null)
            {
                foreach (DataRow row in TBCULENDV.Rows)
                {
                    ContructionUnitsLocationValue RowTBCULEV = new ContructionUnitsLocationValue(row);
                    ListCULENDV.Add(RowTBCULEV);
                }
            }
            return ListCULENDV;
        }

        /*Detalle de la unidades constructivas agrupadas por una localidad seleccionada
          de la grilla de datos en la pestaña Unidad Constrcutiva por Localidad*/

        /*Funcion retorna en detalle las unidad constructiva agrupadas por localidad
          presupuestadas con su respectiva cantidad legalizada
          Se utilizara la entidad ContructionUnitsAmount ya que para este caso el resultado 
          son unidades constrcutivas de la localidad seleccionada en la grilla
          de la pestaña unidades constructivas por localidad*/
        public static List<ContructionUnitsAmount> FlistCULDEA(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsAmount> ListCULDEA = new List<ContructionUnitsAmount>();
            DataTable TBCULDEA = DALLDBEX.ProConUniLocDetExeAmo(InitialYear, InitialMonth, FinalYear, FinalMonth, GeograpLocationId, RelevantMarketId);
            if (TBCULDEA != null)
            {
                foreach (DataRow row in TBCULDEA.Rows)
                {
                    ContructionUnitsAmount RowTBCULDEA = new ContructionUnitsAmount(row);
                    ListCULDEA.Add(RowTBCULDEA);
                }
            }
            return ListCULDEA;
        }

        /*Funcion retorna en detalle las unidad constructiva agrupadas por localidad
          presupuestadas con su respectivo valor legalizado
          Se utilizara la entidad ContructionUnitsValue ya que para este caso el resultado 
          son unidades constrcutivas de la localidad seleccionada en la grilla
          de la pestaña unidades constructivas por localidad*/
        public static List<ContructionUnitsValue> FlistCULDEV(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsValue> ListCULDEV = new List<ContructionUnitsValue>();
            DataTable TBCULDEV = DALLDBEX.ProConUniLocDetExeVal(InitialYear, InitialMonth, FinalYear, FinalMonth, GeograpLocationId, RelevantMarketId);
            if (TBCULDEV != null)
            {
                foreach (DataRow row in TBCULDEV.Rows)
                {
                    ContructionUnitsValue RowTBCULDEV = new ContructionUnitsValue(row);
                    ListCULDEV.Add(RowTBCULDEV);
                }
            }
            return ListCULDEV;
        }

        /*Funcion retorna en detalle las unidad constructiva agrupadas por localidad
          no presupuestadas con su respectiva cantidad legalizada
          Se utilizara la entidad ContructionUnitsAmount ya que para este caso el resultado 
          son unidades constrcutivas de la localidad seleccionada en la grilla
          de la pestaña unidades constructivas por localidad*/
        public static List<ContructionUnitsAmount> FlistCULDENDA(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsAmount> ListCULDENDA = new List<ContructionUnitsAmount>();
            DataTable TBCULDENDA = DALLDBEX.ProCoUnLoDeExeNoDebAmo(InitialYear, InitialMonth, FinalYear, FinalMonth, GeograpLocationId, RelevantMarketId);
            if (TBCULDENDA != null)
            {
                foreach (DataRow row in TBCULDENDA.Rows)
                {
                    ContructionUnitsAmount RowTBCULDENDA = new ContructionUnitsAmount(row);
                    ListCULDENDA.Add(RowTBCULDENDA);
                }
            }
            return ListCULDENDA;
        }

        /*Funcion retorna en detalle las unidad constructiva agrupadas por localidad
          no presupuestadas con su respectivo valor legalizado
          Se utilizara la entidad ContructionUnitsValue ya que para este caso el resultado 
          son unidades constrcutivas de la localidad seleccionada en la grilla
          de la pestaña unidades constructivas por localidad*/
        public static List<ContructionUnitsValue> FlistCULDENDV(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsValue> ListCULDENDV = new List<ContructionUnitsValue>();
            DataTable TBCULDENDV = DALLDBEX.ProCoUnLoDeExeNoDebVal(InitialYear, InitialMonth, FinalYear, FinalMonth, GeograpLocationId, RelevantMarketId);
            if (TBCULDENDV != null)
            {
                foreach (DataRow row in TBCULDENDV.Rows)
                {
                    ContructionUnitsValue RowTBCULDENDV = new ContructionUnitsValue(row);
                    ListCULDENDV.Add(RowTBCULDENDV);
                }
            }
            return ListCULDENDV;
        }



        /*Fin Funciones que permiten extraer los datos de los metodos de DAL para 
         unidades constructivas agrupadas por localidad*/

        /*Funciones que permiten extraer los datos de los metodos de DAL para 
         unidades constructivas agrupadas por unidades constructivas */

        /*Funcion retorna las localidades agrupadas por unidad constructiva 
          presupuestadas con su respectiva cantidad legalizada*/
        public static List<ContructionUnitsAmount> FlistCUEA(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsAmount> ListCUEA = new List<ContructionUnitsAmount>();
            DataTable TBCUEA = DALLDBEX.ProConsUnitExeAmount(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBCUEA != null)
            {
                foreach (DataRow row in TBCUEA.Rows)
                {
                    ContructionUnitsAmount RowTBCUEA = new ContructionUnitsAmount(row);
                    ListCUEA.Add(RowTBCUEA);
                }
            }
            return ListCUEA;
        }

        /*Funcion retorna las localidades agrupadas por unidad constructiva 
          presupuestadas con su respectiva cantidad legalizada*/
        public static List<ContructionUnitsValue> FlistCUEV(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsValue> ListCUEV = new List<ContructionUnitsValue>();
            DataTable TBUCUEV = DALLDBEX.ProConsUnitExeValue(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBUCUEV != null)
            {
                foreach (DataRow row in TBUCUEV.Rows)
                {
                    ContructionUnitsValue RowTBCUEV = new ContructionUnitsValue(row);
                    ListCUEV.Add(RowTBCUEV);
                }
            }
            return ListCUEV;
        }

        /*Funcion retorna las localidades agrupadas por unidad constructiva 
          no presupuestadas con su respectiva cantidad legalizada*/
        public static List<ContructionUnitsAmount> FlistCUENDA(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsAmount> ListCUENDA = new List<ContructionUnitsAmount>();
            DataTable TBCUENDA = DALLDBEX.ProCoUnExNoDebugAm(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBCUENDA != null)
            {
                foreach (DataRow row in TBCUENDA.Rows)
                {
                    ContructionUnitsAmount RowTBCUENDA = new ContructionUnitsAmount(row);
                    ListCUENDA.Add(RowTBCUENDA);
                }
            }
            return ListCUENDA;
        }

        /*Funcion retorna las localidades agrupadas por unidad constructiva 
          no presupuestadas con su respectiva cantidad legalizada*/
        public static List<ContructionUnitsValue> FlistCUENDV(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsValue> ListCUENDV = new List<ContructionUnitsValue>();
            DataTable TBCUENDV = DALLDBEX.ProCoUnExNoDegubVal(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBCUENDV != null)
            {
                foreach (DataRow row in TBCUENDV.Rows)
                {
                    ContructionUnitsValue RowTBCUENDV = new ContructionUnitsValue(row);
                    ListCUENDV.Add(RowTBCUENDV);
                }
            }
            return ListCUENDV;
        }


        /*Funcion retorna en detalle las localidades agrupadas por una unidad constrcutiva
          presupuestadas con su respectiva cantidad legalizada
          Se utilizara la entidad ContructionUnitsAmount ya que para este caso el resultado 
          son unidades constrcutivas de la localidad seleccionada en la grilla
          de la pestaña unidades constructivas por localidad*/
        public static List<ContructionUnitsLocationAmount> FlistCUDEA(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationAmount> ListCUDEA = new List<ContructionUnitsLocationAmount>();
            DataTable TBCUDEA = DALLDBEX.ProConstUnitDetaExeAmo(InitialYear, InitialMonth, FinalYear, FinalMonth, ConUniBudgetId, RelevantMarketId);
            if (TBCUDEA != null)
            {
                foreach (DataRow row in TBCUDEA.Rows)
                {
                    ContructionUnitsLocationAmount RowTBCUDEA = new ContructionUnitsLocationAmount(row);
                    ListCUDEA.Add(RowTBCUDEA);
                }
            }
            return ListCUDEA;
        }
        /*Funcion retorna en detalle los valores agrupadas por una unidad constrcutiva
          presupuestadas con su respectiva cantidad legalizada
          Se utilizara la entidad ContructionUnitsAmount ya que para este caso el resultado 
          son unidades constrcutivas de la localidad seleccionada en la grilla
          de la pestaña unidades constructivas por localidad*/
        public static List<ContructionUnitsLocationValue> FlistCUDEV(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationValue> ListCUDEV = new List<ContructionUnitsLocationValue>();
            DataTable TBCUDEV = DALLDBEX.ProConstUnitDetaExeVal(InitialYear, InitialMonth, FinalYear, FinalMonth, ConUniBudgetId, RelevantMarketId);
            if (TBCUDEV != null)
            {
                foreach (DataRow row in TBCUDEV.Rows)
                {
                    ContructionUnitsLocationValue RowTBCUDEV = new ContructionUnitsLocationValue(row);
                    ListCUDEV.Add(RowTBCUDEV);
                }
            }
            return ListCUDEV;
        }

        /*Funcion retorna en detalle las localidades agrupadas por una unidad constrcutiva
          NO presupuestadas con su respectiva cantidad legalizada
          Se utilizara la entidad ContructionUnitsAmount ya que para este caso el resultado 
          son unidades constrcutivas de la localidad seleccionada en la grilla
          de la pestaña unidades constructivas por localidad*/
        public static List<ContructionUnitsLocationAmount> FlistCUDENDA(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationAmount> ListCUDENDA = new List<ContructionUnitsLocationAmount>();
            DataTable TBCUDENDA = DALLDBEX.ProConUniDeExeNoDebAmo(InitialYear, InitialMonth, FinalYear, FinalMonth, ConUniBudgetId, RelevantMarketId);
            if (TBCUDENDA != null)
            {
                foreach (DataRow row in TBCUDENDA.Rows)
                {
                    ContructionUnitsLocationAmount RowTBCUDENDA = new ContructionUnitsLocationAmount(row);
                    ListCUDENDA.Add(RowTBCUDENDA);
                }
            }
            return ListCUDENDA;
        }

        /*Funcion retorna en detalle los valores agrupadas por una unidad constrcutiva
          NO presupuestadas con su respectiva cantidad legalizada
          Se utilizara la entidad ContructionUnitsAmount ya que para este caso el resultado 
          son unidades constrcutivas de la localidad seleccionada en la grilla
          de la pestaña unidades constructivas por localidad*/
        public static List<ContructionUnitsLocationValue> FlistCUDENDV(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationValue> ListCUDENDV = new List<ContructionUnitsLocationValue>();
            DataTable TBCUDENDV = DALLDBEX.ProConUniDeExeNoDebVal(InitialYear, InitialMonth, FinalYear, FinalMonth, ConUniBudgetId, RelevantMarketId);
            if (TBCUDENDV != null)
            {
                foreach (DataRow row in TBCUDENDV.Rows)
                {
                    ContructionUnitsLocationValue RowTBCUDENDV = new ContructionUnitsLocationValue(row);
                    ListCUDENDV.Add(RowTBCUDENDV);
                }
            }
            return ListCUDENDV;
        }

        /*Fin Funciones que permiten extraer los datos de los metodos de DAL para 
         unidades constructivas agrupadas por unidades constructivas*/

        /*Demanda de Gas*/
        public static List<GasDemandService> FlistGDE(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<GasDemandService> ListGDE = new List<GasDemandService>();
            DataTable TBGDE = DALLDBEX.ProGasDemandExe(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBGDE != null)
            {
                foreach (DataRow row in TBGDE.Rows)
                {
                    GasDemandService RowTBGDE = new GasDemandService(row);
                    ListGDE.Add(RowTBGDE);
                }
            }
            return ListGDE;
        }
        /*Fin Demanda de Gas*/

        /*Detalle Demanda de Gas*/
        public static List<GasDemandServiceDetails> FlistGDDE(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId, Int64 CateCodi, Int64 SuCaCodi)
        {
            List<GasDemandServiceDetails> ListGDDE = new List<GasDemandServiceDetails>();
            DataTable TBGDDE = DALLDBEX.ProGasDemandDetaExe(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId, CateCodi, SuCaCodi);
            if (TBGDDE != null)
            {
                foreach (DataRow row in TBGDDE.Rows)
                {
                    GasDemandServiceDetails RowTBGDDE = new GasDemandServiceDetails(row);
                    ListGDDE.Add(RowTBGDDE);
                }
            }
            return ListGDDE;
        }
        /*Fin Detalle Demanda de Gas*/


        /*Servicio de Gas*/
        public static List<GasDemandService> FlistGSE(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<GasDemandService> ListGSE = new List<GasDemandService>();
            DataTable TBGSE = DALLDBEX.ProGasServiceExe(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBGSE != null)
            {
                foreach (DataRow row in TBGSE.Rows)
                {
                    GasDemandService RowTBGSE = new GasDemandService(row);
                    ListGSE.Add(RowTBGSE);
                }
            }
            return ListGSE;
        }
        /*Fin Servicio de Gas*/

        /*Detalle Servicio de Gas*/
        public static List<GasDemandServiceDetails> FlistGSDE(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId, Int64 CateCodi, Int64 SuCaCodi)
        {
            List<GasDemandServiceDetails> ListGSDE = new List<GasDemandServiceDetails>();
            DataTable TBGSDE = DALLDBEX.ProGasServiceDetaExe(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId, CateCodi, SuCaCodi);
            if (TBGSDE != null)
            {
                foreach (DataRow row in TBGSDE.Rows)
                {
                    GasDemandServiceDetails RowTBGSDE = new GasDemandServiceDetails(row);
                    ListGSDE.Add(RowTBGSDE);
                }
            }
            return ListGSDE;
        }
        /*Fin Detalle Servicio de Gas*/

        /*GASTOS DE COMERCIALIZACION*/
        public static List<MarketingDistributionExpenses> FlistMEB(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<MarketingDistributionExpenses> ListMEB = new List<MarketingDistributionExpenses>();
            DataTable TBMEB = DALLDBEX.ProMarExpBudget(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBMEB != null)
            {
                foreach (DataRow row in TBMEB.Rows)
                {
                    MarketingDistributionExpenses RowTBMEB = new MarketingDistributionExpenses(row);
                    ListMEB.Add(RowTBMEB);
                }
            }
            return ListMEB;
        }
        /*FIN GASTOS DE COMERCIALIZACION*/

        /*GASTOS DE DISTRIBUCION*/
        public static List<MarketingDistributionExpenses> FlistDEB(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 RelevantMarketId)
        {
            List<MarketingDistributionExpenses> ListDEB = new List<MarketingDistributionExpenses>();
            DataTable TBDEB = DALLDBEX.ProDisExpBudget(InitialYear, InitialMonth, FinalYear, FinalMonth, RelevantMarketId);
            if (TBDEB != null)
            {
                foreach (DataRow row in TBDEB.Rows)
                {
                    MarketingDistributionExpenses RowTBDEB = new MarketingDistributionExpenses(row);
                    ListDEB.Add(RowTBDEB);
                }
            }
            return ListDEB;
        }
        /*FIN GASTOS DE DISTRIBUCION*/

        /*Pesos Constantes*/
        /*METODO PARA OBTENER EL VALOR EJECUTADO DE LOCALIDADES 
          AGRUPADAS POR UBICACION GEOGRAFICA PRESUPUESTADA*/
        public static List<ContructionUnitsLocationValue> FlistCULVCP(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationValue> ListCULVCP = new List<ContructionUnitsLocationValue>();
            DataTable TBCULVCP = DALLDBEX.ProConUniLocValConsPes(InitialYear, InitialMonth, FinalYear, FinalMonth, ConstantPesosYear,ConstantPesosMonth, RelevantMarketId);
            if (TBCULVCP != null)
            {
                foreach (DataRow row in TBCULVCP.Rows)
                {
                    ContructionUnitsLocationValue RowTBCULVCP = new ContructionUnitsLocationValue(row);
                    ListCULVCP.Add(RowTBCULVCP);
                }
            }
            return ListCULVCP;
        }
        /*METODO PARA OBTENER EL VALOR EJECUTADO DE UNIDAD CONSTRCUTIVA
         AGRUPADAS POR UNIDAD CONSTRCUTIVA DE CADA UBICACION GEOGRAFICA 
         SELECCIONADA DE LA GRILLA*/
        public static List<ContructionUnitsValue> FlistCULDVCP(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsValue> ListCULDVCP = new List<ContructionUnitsValue>();
            DataTable TBCULDVCP = DALLDBEX.ProCoUnLoDetValConsPes(InitialYear, InitialMonth, FinalYear, FinalMonth, ConstantPesosYear, ConstantPesosMonth, GeograpLocationId, RelevantMarketId);
            if (TBCULDVCP != null)
            {
                foreach (DataRow row in TBCULDVCP.Rows)
                {
                    ContructionUnitsValue RowTBCULDVCP = new ContructionUnitsValue(row);
                    ListCULDVCP.Add(RowTBCULDVCP);
                }
            }
            return ListCULDVCP;
        }
        /*METODO PARA OBTENER EL VALOR EJECUTADO DE LOCALIDADES 
          AGRUPADAS POR UBICACION GEOGRAFICA NO PRESUPUESTADA*/
        public static List<ContructionUnitsLocationValue> FlistCULVNDCP(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationValue> ListCULVNDCP = new List<ContructionUnitsLocationValue>();
            DataTable TBCULVNDCP = DALLDBEX.ProCoUnLocValNoDebCoPe(InitialYear, InitialMonth, FinalYear, FinalMonth, ConstantPesosYear, ConstantPesosMonth, RelevantMarketId);
            if (TBCULVNDCP != null)
            {
                foreach (DataRow row in TBCULVNDCP.Rows)
                {
                    ContructionUnitsLocationValue RowTBCULVNDCP = new ContructionUnitsLocationValue(row);
                    ListCULVNDCP.Add(RowTBCULVNDCP);
                }
            }
            return ListCULVNDCP;
        }

        /*METODO PARA OBTENER EL VALOR EJECUTADO DE UNIDAD CONSTRCUTIVA
         AGRUPADAS POR UNIDAD CONSTRCUTIVA DE CADA UBICACION GEOGRAFICA 
         SELECCIONADA DE LA GRILLA NO PRESUPUESTADA*/
        public static List<ContructionUnitsValue> FlistCULDVNDCP(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 GeograpLocationId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsValue> ListCULDVNDCP = new List<ContructionUnitsValue>();
            DataTable TBCULDVNDCP = DALLDBEX.ProCoUnLoDeVaNoDeCoPe(InitialYear, InitialMonth, FinalYear, FinalMonth, ConstantPesosYear, ConstantPesosMonth, GeograpLocationId, RelevantMarketId);
            if (TBCULDVNDCP != null)
            {
                foreach (DataRow row in TBCULDVNDCP.Rows)
                {
                    ContructionUnitsValue RowTBCULDVNDCP = new ContructionUnitsValue(row);
                    ListCULDVNDCP.Add(RowTBCULDVNDCP);
                }
            }
            return ListCULDVNDCP;
        }        
  
        /*METODO PARA OBTENER EL VALOR EJECUTADO DE LOCALIDADES 
          AGRUPADAS POR UBICACION GEOGRAFICA PRESUPUESTADA*/
        public static List<ContructionUnitsValue> FlistCUVCP(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsValue> ListCUVCP = new List<ContructionUnitsValue>();
            DataTable TBCUVCP = DALLDBEX.ProConUnitValueConsPes(InitialYear, InitialMonth, FinalYear, FinalMonth, ConstantPesosYear, ConstantPesosMonth, RelevantMarketId);
            if (TBCUVCP != null)
            {
                foreach (DataRow row in TBCUVCP.Rows)
                {
                    ContructionUnitsValue RowTBCUVCP = new ContructionUnitsValue(row);
                    ListCUVCP.Add(RowTBCUVCP);
                }
            }
            return ListCUVCP;
        }
        /*METODO PARA OBTENER EL DETALLE DEL VALOR EJECUTADO DE UBICACION GEOGRAFICA
         AGRUPADAS POR UNIDAD CONSTRCUTIVA SELECCIONADA DE LA GRILLA*/
        public static List<ContructionUnitsLocationValue> FlistCUDVCP(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationValue> ListCUDVCP = new List<ContructionUnitsLocationValue>();
            DataTable TBCUDVCP = DALLDBEX.ProConUniDetValConsPes(InitialYear, InitialMonth, FinalYear, FinalMonth, ConstantPesosYear, ConstantPesosMonth, ConUniBudgetId, RelevantMarketId);
            if (TBCUDVCP != null)
            {
                foreach (DataRow row in TBCUDVCP.Rows)
                {
                    ContructionUnitsLocationValue RowTBCUDVCP = new ContructionUnitsLocationValue(row);
                    ListCUDVCP.Add(RowTBCUDVCP);
                }
            }
            return ListCUDVCP;
        }
        /*METODO PARA OBTENER EL VALOR EJECUTADO DE LAS UNIDADES CONSTRCUTIVAS 
          AGRUPADAS NO PRESUPUESTADA*/
        public static List<ContructionUnitsValue> FlistCUVNDCP(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 RelevantMarketId)
        {
            List<ContructionUnitsValue> ListCUVNDCP = new List<ContructionUnitsValue>();
            DataTable TBCUVNDCP = DALLDBEX.ProCoUnValueNoDebCoPe(InitialYear, InitialMonth, FinalYear, FinalMonth, ConstantPesosYear, ConstantPesosMonth, RelevantMarketId);
            if (TBCUVNDCP != null)
            {
                foreach (DataRow row in TBCUVNDCP.Rows)
                {
                    ContructionUnitsValue RowTBCUVNDCP = new ContructionUnitsValue(row);
                    ListCUVNDCP.Add(RowTBCUVNDCP);
                }
            }
            return ListCUVNDCP;
        }

        /*METODO PARA OBTENER EL VALOR EJECUTADO DE UNIDAD CONSTRCUTIVA
         AGRUPADAS POR UNIDAD CONSTRCUTIVA DE CADA UBICACION GEOGRAFICA 
         SELECCIONADA DE LA GRILLA NO PRESUPUESTADA*/
        public static List<ContructionUnitsLocationValue> FlistCUDVNDCP(Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth, Int64 ConstantPesosYear, Int64 ConstantPesosMonth, Int64 ConUniBudgetId, Int64 RelevantMarketId)
        {
            List<ContructionUnitsLocationValue> ListCUDVNDCP = new List<ContructionUnitsLocationValue>();
            DataTable TBCUDVNDCP = DALLDBEX.ProCoUnDeValNoDebCoPe(InitialYear, InitialMonth, FinalYear, FinalMonth, ConstantPesosYear, ConstantPesosMonth, ConUniBudgetId, RelevantMarketId);
            if (TBCUDVNDCP != null)
            {
                foreach (DataRow row in TBCUDVNDCP.Rows)
                {
                    ContructionUnitsLocationValue RowTBCUDVNDCP = new ContructionUnitsLocationValue(row);
                    ListCUDVNDCP.Add(RowTBCUDVNDCP);
                }
            }
            return ListCUDVNDCP;
        }  
        
        /*Fin Pesos Constantes*/
    
    }
}
