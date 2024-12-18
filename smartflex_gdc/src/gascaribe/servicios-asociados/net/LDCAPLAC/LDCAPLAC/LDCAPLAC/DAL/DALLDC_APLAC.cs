using System;
using System.Collections.Generic;
using System.Text;
using LDCAPLAC.Entities;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;
using OpenSystems.Common.ExceptionHandler;

using System.Windows.Forms;
using OpenSystems.Common.Util;

namespace LDCAPLAC.DAL
{
    class DALLDC_APLAC
    {

        /// <summary>
        /// Se obtienen los datos de los medidores
        /// </summary>
        /// <returns>Se obtienen los datos de los medidores</returns>     
        public DataTable GetDatosMedidor(Int64 nuMulti)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosMedidor"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "Nivel", DbType.Int64, nuMulti);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }


        /// <summary>
        /// Tabla para datos de orden de trabajo
        /// </summary>
        /// <returns>Tabla para datos de orden de trabajo</returns> 
        public static DataTable FrfOrdenTrabajo(Int64 OrdenTrabajo)
        {   
            DataSet DSDatosOrdenTrabajo = new DataSet("DatosOrdenTrabajo");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.FrfOrdenTrabajo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, OrdenTrabajo);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosOrdenTrabajo, "DatosOrdenTrabajo");
            }
            return DSDatosOrdenTrabajo.Tables["DatosOrdenTrabajo"];
        }



        /// <summary>
        /// Se consulta la orden de trabajo para validar si existe en la base de datos
        /// </summary>
        /// <returns>Se consulta la orden de trabajo para validar si existe en la base de datos</returns> 
        public static DataTable getOrderExist(Int64 OrdenTrabajo)
        {
            DataSet DSDatosOrdenTrabajo = new DataSet("DatosOrdenTrabajo");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.FsbGetInfoOrden"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, OrdenTrabajo);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosOrdenTrabajo, "DatosOrdenTrabajo");
            }
            return DSDatosOrdenTrabajo.Tables["DatosOrdenTrabajo"];
        }



        /// <summary>
        /// Se obtienen los items Normales es decir, los que no son cotizados
        /// </summary>
        /// <returns>Se obtienen items normales</returns>     
        public DataTable getItemsNorm(Int64 OrdenTrabajo)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosItems"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, OrdenTrabajo);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }


        /// <summary>
        /// Se obtienen los items Cotizados
        /// </summary>
        /// <returns>Se obtienen items cotizados</returns>     
        public DataTable getItemsCoti(Int64 OrdenTrabajo)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosItemsCoti"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, OrdenTrabajo);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }




        /// <summary>
        /// Se obtienen los items Normales es decir, los que no son cotizados
        /// </summary>
        /// <returns>Se obtienen items normales</returns>     
        public static DataTable getItemsNormValidate(Int64 OrdenTrabajo)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosItems"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, OrdenTrabajo);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }


        /// <summary>
        /// Se obtienen los items Cotizados
        /// </summary>
        /// <returns>Se obtienen items cotizados</returns>     
        public static DataTable getItemsCotiValidate(Int64 OrdenTrabajo)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosItemsCoti"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, OrdenTrabajo);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }




        /// <summary>
        /// Se consulta el precio del Item
        /// </summary>
        /// <param name="quotationId">Precio del Item</param>
        /// <returns>Retorna un entero con el precio del items</returns>
        public Int64 getItemPrecio(Int64 nuOrden, Int64 nuItem, DateTime FechaExeOrd)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetPriceItems"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, nuOrden);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuItems", DbType.Int64, nuItem);
                OpenDataBase.db.AddInParameter(cmdCommand, "FechaExeOrd", DbType.DateTime, FechaExeOrd);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }



        /// <summary>
        /// Se obtiene el usuario que esta conectado en la base de datos
        /// </summary>
        /// <param name="quotationId">Usuario Conectado</param>
        /// <returns>Retorna el nombre del usuario que esta conectado</returns>
        public String getUserConect()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.FsbGetUserConect"))
            {
               // OpenDataBase.db.AddInParameter(cmdCommand, "nuItems", DbType.Int64, nuItem);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se Actualiza la informacion de la orden a legalizar
        /// </summary>
        /// <param name="newItem">Actualiza la lista de costos</param>
        public void SaveDatosOrdenCont(Int64 nuOrder, Int64 nuContrato, Int64 nuProducto, Int64 Responsable, 
                                       String OsbContratista, Int64 nuCausal, String StatusOrder, String OsbFuncionario, DateTime FechaIni,
                                       DateTime FechaFin, Int64 nuMultifam, out Int64 onuErrorCode, out String osbErrorMessage)
       
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.LDC_PRGESTORDERCOM"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, nuOrder);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuCONTRATO", DbType.Int64, nuContrato);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuPRODUCTO", DbType.Int64, nuProducto);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuRESPONSABLE", DbType.Int64, Responsable);
                OpenDataBase.db.AddInParameter(cmdCommand, "OSB_CONTRATISTA", DbType.String, OsbContratista);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuCAUSAL", DbType.Int64, nuCausal);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbStatus", DbType.String, StatusOrder);
                OpenDataBase.db.AddInParameter(cmdCommand, "OBS_FUNCIONARIO", DbType.String, OsbFuncionario);
                OpenDataBase.db.AddInParameter(cmdCommand, "FechaIni", DbType.DateTime, FechaIni);
                OpenDataBase.db.AddInParameter(cmdCommand, "FechaFin", DbType.DateTime, FechaFin);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuMultifam", DbType.Int64, nuMultifam);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);


                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }



        /// <summary>
        /// Se Guarda información de los medidores
        /// </summary>
        /// <param name="newItem">Actualiza informacion de medidores</param>
        public void SaveDatosMedidores(Int64 nuOrder, String sbMedidor, Int64 nuContrato, String sbDireccion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.LDC_PRINSERTMEDIDOR"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, nuOrder);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbMedidor", DbType.String, sbMedidor);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuContrato", DbType.Int64, nuContrato);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuDireccion", DbType.String, sbDireccion);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }


        /// <summary>
        /// Se Guarda información de los items
        /// </summary>
        /// <param name="newItem">Actualiza informacion de items</param>
        public void SaveDatosItems(Int64 nuOrder, Int64 Item, String Descripcion, String TypeItems, Double Cantidad,
                                   Int64 Valor, Int64 ValorTotal, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.LDC_PRINSERITEMS"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, nuOrder);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuItem", DbType.Int64, Item);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbDescripcion", DbType.String, Descripcion);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbType", DbType.String, TypeItems);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuCantidad", DbType.Double, Cantidad);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuValor", DbType.Int64, Valor);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuValorTotal", DbType.Int64, ValorTotal);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }



        /// <summary>
        /// Tabla para datos de orden de trabajo
        /// </summary>
        /// <returns>Tabla para datos de orden de trabajo</returns> 
        public static DataTable FrfOrdenTrabNew(Int64 OrdenTrabajo)
        {
            DataSet DSDatosOrdenTrabajo = new DataSet("DatosOrdenTrabajo");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.frGerOrdenTotal"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, OrdenTrabajo);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosOrdenTrabajo, "DatosOrdenTrabajo");
            }
            return DSDatosOrdenTrabajo.Tables["DatosOrdenTrabajo"];
        }




        /// <summary>
        /// Se obtiene el estado de la orden en la tabla LDC_LEGAORACO
        /// </summary>
        /// <param name="quotationId">Estado de la orden en la tabla LDC_LEGAORACO</param>
        /// <returns>Estado de la orden en la tabla LDC_LEGAORACO</returns>
        public static DataTable getEstadoOrder(Int64 nuOrden)
        {
            DataSet DSDatosOrdenTrabajo = new DataSet("DatosOrdenTrabajoRechazada");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.FsbGetEstadoOraco"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuOrder", DbType.Int64, nuOrden);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosOrdenTrabajo, "DatosOrdenTrabajoRechazada");
            }
            return DSDatosOrdenTrabajo.Tables["DatosOrdenTrabajoRechazada"];
        }




        /// <summary>
        /// Se obtienen los medidores en la nueva tablas creadas
        /// </summary>
        /// <returns>Se obtienen los medidores en la nueva tablas creadas</returns>     
        public DataTable GetDatosMediNew(Int64 Order_id)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosMediNew"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "Nivel", DbType.Int64, Order_id);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }


        /// <summary>
        /// Se obtienen los medidores en la nueva tablas creadas
        /// </summary>
        /// <returns>Se obtienen los medidores en la nueva tablas creadas</returns>     
        public static DataTable GetDatosMediValidate(Int64 Order_id)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosMediNew"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "Nivel", DbType.Int64, Order_id);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }



        /// <summary>
        /// Se obtienen los items Normales de la nueva tabla creada
        /// </summary>
        /// <returns>Se obtienen los items Normales de la nueva tabla creada</returns>     
        public DataTable GetDatosItemsNew(Int64 Order_id)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosItemsNew"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "Nivel", DbType.Int64, Order_id);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }


        /// <summary>
        /// Se obtienen los items Cotizados de la nueva tabla creada
        /// </summary>
        /// <returns>Se obtienen los items Cotizados de la nueva tabla creada</returns>     
        public DataTable GetDatosItemsNewCoti(Int64 Order_id)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosItemsNewCoti"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "Nivel", DbType.Int64, Order_id);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }



        public void AprobarRechazOrden_click(Int64 nuOrder, String isbEstado, String sbObservacion,DateTime inuFechaIni, 
                                             DateTime inuFechaFinal, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PGK_LDCAUTO1.LDC_PRRECHA_APRUE"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrdenId", DbType.Int64, nuOrder);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuEstado", DbType.String, isbEstado);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbObservacion", DbType.String, sbObservacion);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFechaInicio", DbType.DateTime, inuFechaIni);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFechaFin", DbType.DateTime, inuFechaFinal);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);


                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }


        /// <summary>
        /// Se valida la clase de causal seleccionada en la forma
        /// </summary>
        /// <param name="quotationId">Calse de Causal</param>
        /// <returns>Retorna la calse de causal seleccionada</returns>
        public Int64 getClassCausal(Int64 nuCausal)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.FsbGetClassCausal"))
            {                                                                   
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCausalId", DbType.Int64, nuCausal);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se envia notificacion por email
        /// </summary>
        /// <param name="quotationId">Calse de Causal</param>      
        public void sendNotificationEmail(Int64 orderId, Int64 flagMess, String useParam)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.SendMailNotif"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrderId", DbType.Int64, orderId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFlagMess", DbType.Int64, flagMess);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbUseParam", DbType.String, useParam);                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);                
            }
        }

        /// <summary>
        /// Valida si el estado de corte es facturable
        /// </summary>
        /// <param name="quotationId">Calse de Causal</param> 
        public String fsbEsFacturable(Int64 estadoCorte)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.fsbEsFacturable"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuEstacorte", DbType.Int64, estadoCorte);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Obtiene la cantidad total de contratos multifamiliar y cantidad contratos seleccionados
        /// </summary>
        /// <param name="nuOrder"></param>
        /// <param name="multi"></param>
        /// <param name="cantidad"></param>
        /// <param name="total"></param>
        public void getContratosMulti(Int64 nuOrder, Int64 multi, out Int64 cantidad, out Int64 total)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.GetContratosMulti"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrderId", DbType.Int64, nuOrder);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuMultivivi", DbType.Int64, multi);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuCantContMult", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuTotaContMult", DbType.Int64, 500);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                cantidad = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuCantContMult"));
                total = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuTotaContMult"));
            }
        }

        /// <summary>
        /// Proceso para obtener las garantías a partir de la orden
        /// </summary>
        /// <param name="orderId"></param>
        /// <returns></returns>
        public DataTable getWarrantyByProduct(Int64 orderId)
        {
            DataSet dsWarranties = new DataSet("warranties");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.getWarrantyByProduct"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrderId", DbType.Int64, orderId);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orcDatos");
                OpenDataBase.db.LoadDataSet(cmdCommand, dsWarranties, "warranties");                              
            }
            return dsWarranties.Tables["warranties"];
        }

        /// <summary>
        /// Crea las ordenes de garantías
        /// </summary>
        /// <param name="orderId"></param>
        /// <param name="flag"></param>
        public void processWarranty(Int64 orderId, String flag)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.CreateOrderWarranty"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrderId", DbType.Int64, orderId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbFlag", DbType.String, flag);                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }
             
        /// <summary>
        /// Se obtienen los items Cotizados de la nueva tabla creada
        /// </summary>
        /// <returns>Se obtienen los items Cotizados de la nueva tabla creada</returns>     
        public DataTable GetDatosItemsNewCoti(Int64 Order_id, String flag)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosItemsNewCoti"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "Nivel", DbType.Int64, Order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbFlag", DbType.String, flag);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }

        /// <summary>
        /// Se obtienen los items Normales de la nueva tabla creada
        /// </summary>
        /// <returns>Se obtienen los items Normales de la nueva tabla creada</returns>     
        public DataTable GetDatosItemsNew(Int64 Order_id, String flag)
        {
            DataSet dsNivelListCost = new DataSet("ListasVigentes");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.prGetDatosItemsNew"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "Nivel", DbType.Int64, Order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbFlag", DbType.String, flag);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsNivelListCost, "ListasVigentes");
            }
            return dsNivelListCost.Tables["ListasVigentes"];
        }

        /// <summary>
        /// Obtiene el flag de garantía para la orden
        /// </summary>
        /// <param name="Order_id"></param>
        /// <returns></returns>
        public String GetFlagByOrder(Int64 Order_id)
        {
            String flag = null;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.GetFlagByOrder"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrderId", DbType.Int64, Order_id);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbFlag", DbType.String, 2);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                flag = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbFlag"));
            }
            return flag;
        }
        /// <summary>
        /// Inserta o actualiza la garantía para una orden
        /// </summary>
        /// <param name="Order_id"></param>
        /// <param name="flag"></param>
        public void InsOrUpdByOrderWarranty(Int64 Order_id, String flag)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("PKG_LDCGRIDLDCAPLAC.InsOrUpdByOrder"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrderId", DbType.Int64, Order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbFlag", DbType.String, flag);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }
    }
}
