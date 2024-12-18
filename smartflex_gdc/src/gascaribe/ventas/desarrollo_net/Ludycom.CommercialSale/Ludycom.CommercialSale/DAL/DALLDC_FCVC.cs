using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.CommercialSale.Entities;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;

namespace Ludycom.CommercialSale.DAL
{
    class DALLDC_FCVC
    {
        short? nullShortValue = null;
        long? nullLongValue = null;
        Decimal? nullValueDecimal = null;
        DateTime? nullDate = null;
        Int64? nullIntValue = null;

        /// <summary>
        /// Se obtienen los datos básicos del cliente
        /// </summary>
        /// <param name="subscriber">Código del Cliente</param>
        /// <returns>Retorna una instancia de CustomerBasicData con los datos básicos del cliente</returns>
        public CustomerBasicData GetCustomerBasicData(Int64 subscriber)
        {
            CustomerBasicData customerBasicData = new CustomerBasicData();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacioncomercial.proObtieneDatosCliente"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCLIENTE", DbType.Int64, subscriber);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUTIPOID", DbType.Int64, 4);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBIDENTIFICACION", DbType.String, 500);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBNOMBRE", DbType.String, 500);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUPRODUCTO", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCONTRATO", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBCLIENTEESPECIAL", DbType.String, 10);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                customerBasicData.Id = subscriber;
                customerBasicData.IdentificationType = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUTIPOID"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUTIPOID"));
                customerBasicData.Identification = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBIDENTIFICACION"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBIDENTIFICACION"));
                customerBasicData.CustomerName = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBNOMBRE"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBNOMBRE"));
                customerBasicData.SpecialCustomer = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBCLIENTEESPECIAL")) == "S" ? true : false;
                customerBasicData.Product = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPRODUCTO"))) ? nullLongValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPRODUCTO").ToString());
                customerBasicData.Contract = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCONTRATO"))) ? nullLongValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCONTRATO").ToString());
                
                return customerBasicData;
            }
        }

        /// <summary>
        /// Se obtienen los datos básicos de la cotización
        /// </summary>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna una instancia de QuotationBasicData con los datos básicos de la cotización</returns>
        public QuotationBasicData GetQuotationBasicData(Int64 quotationId)
        {
            QuotationBasicData quotationBasicData = new QuotationBasicData();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacioncomercial.proObtieneDatosCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, quotationId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBESTADO", DbType.String, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUDIRECCION", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTFECHAVIGENCIA", DbType.DateTime, 80);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUSOLICITUDCOT", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUVENTA", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUPRODUCTO", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCONTRATO", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUVALORCOTIZADO", DbType.Double, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUDESCUENTO", DbType.Double, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBOBSERVACION", DbType.String, 4000);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTFECHAREGISTRO", DbType.DateTime, 80);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTFECHAMODIF", DbType.DateTime, 80);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTSECTORCOMERCI", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTNUMFORMULARIO", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTUNIDADOPERATI", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTSOLICITUD", DbType.Int64, 50);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                quotationBasicData.Consecutive = quotationId;
                quotationBasicData.Status = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBESTADO"));
                quotationBasicData.AddressId = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUDIRECCION"))) ? nullLongValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUDIRECCION").ToString());
                quotationBasicData.ValidityDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAVIGENCIA").ToString()) ? nullDate : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAVIGENCIA").ToString());
                quotationBasicData.QuotationRequestId = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUSOLICITUDCOT"))) ? nullLongValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUSOLICITUDCOT").ToString());
                quotationBasicData.SaleRequestId = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUVENTA"))) ? nullLongValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUVENTA").ToString());
                quotationBasicData.QuotedValue = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUVALORCOTIZADO"))) ? nullValueDecimal : Convert.ToDecimal(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUVALORCOTIZADO").ToString());
                quotationBasicData.Discount = Convert.ToDecimal(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUDESCUENTO"));
                quotationBasicData.Comment = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBOBSERVACION"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBOBSERVACION"));
                quotationBasicData.RegisterDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAREGISTRO").ToString()) ? nullDate : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAREGISTRO").ToString());
                quotationBasicData.LastModDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAMODIF").ToString()) ? nullDate : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAMODIF").ToString());
                quotationBasicData.OperatingSector = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTSECTORCOMERCI"))) ? nullLongValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTSECTORCOMERCI").ToString());
                quotationBasicData.NuFormulario = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTNUMFORMULARIO"))) ? nullIntValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTNUMFORMULARIO").ToString());
                quotationBasicData.OperatingUnit = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTUNIDADOPERATI"))) ? nullLongValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTUNIDADOPERATI").ToString());
                quotationBasicData.SolicitudRed = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTSOLICITUD"))) ? nullIntValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTSOLICITUD").ToString());

                return quotationBasicData;
            }
        }

        /// <summary>
        /// Se obtiene el código del cliente dada la cotización
        /// </summary>
        /// <param name="quotationId">Código de la cotización</param>
        /// <returns>Retorna el id del cliente</returns>
        public Int64 GetQuotationCustomer(Int64? quotationId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("daldc_cotizacion_comercial.fnuGetcliente"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUID_COT_COMERCIAL", DbType.Int64, quotationId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "INURAISEERROR", DbType.Int16, 0);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se valida si la cotización existe
        /// </summary>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna un valor booleano indicando la existencia de la cotización</returns>
        public Boolean QuotationExists(Int64 quotationId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("daldc_cotizacion_comercial.fblExist"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUID_COT_COMERCIAL", DbType.Int64, quotationId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }


        /// <summary>
        /// Se obtiene la categoría de la dirección
        /// </summary>
        /// <param name="addressId">Id de la dirección</param>
        /// <returns>Retorna la categoría de la dirección</returns>
        public Int16? GetCategory(Int64 addressId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ab_boaddress.fnugetcategory"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUADDRESSID", DbType.Int64, addressId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return String.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"))) ? nullShortValue : Convert.ToInt16(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se obtiene la subcategoría de la dirección
        /// </summary>
        /// <param name="addressId">Id de la dirección</param>
        /// <returns>Retorna la subcategoría de la dirección</returns>
        public Int16? GetSubcategory(Int64 addressId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ab_boaddress.fnugetsubcategory"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUADDRESSID", DbType.Int64, addressId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int16, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return String.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"))) ? nullShortValue : Convert.ToInt16(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se obtiene la localidad de la dirección
        /// </summary>
        /// <param name="addressId">Id de la dirección</param>
        /// <returns>Retorna la localidad de la dirección</returns>
        public Int64 GetAdressLocation(Int64 addressId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("daab_address.fnugetgeograp_location_id"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUADDRESSID", DbType.Int64, addressId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INURAISEERROR", DbType.Int64, 0);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se obtiene la localidad padre
        /// </summary>
        /// <param name="locationId">Id de la localidad</param>
        /// <returns>Retorna la localidad padre</returns>
        public Int64 GetFatherLocation(Int64 locationId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dage_geogra_location.fnugetgeo_loca_father_id"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUGEOGRAP_LOCATION_ID", DbType.Int64, locationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INURAISEERROR", DbType.Int64, 0);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se obtienen los tipos de trabajo cotizados
        /// </summary>
        /// <param name="quotationId">id de la cotización</param>
        /// <returns>Retorna los tipos de trabajo de la cotización</returns>               
        public DataTable GetQuotedTaskType(Int64? quotationId)
        {
            DataSet dsQuotedTaskType = new DataSet("TrabajosCotizados");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacioncomercial.fcrTiposTrabajo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, quotationId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsQuotedTaskType, "TrabajosCotizados");
            }
            return dsQuotedTaskType.Tables["TrabajosCotizados"];
        }

        /// <summary>
        /// Se obtienen los items por tipos de trabajo
        /// </summary>
        /// <param name="quotationId">id de la cotización</param>
        /// <param name="taskTypeClass">id del tipo de trabajo</param>
        /// <returns>Retorna los tipos de trabajo de la cotización</returns>               
        public DataTable GetItemsByTaskTypeClass(Int64? quotationId, String taskTypeClass)
        {
            DataSet dsItems = new DataSet("ItemsCotizados");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacioncomercial.fcrItemsPorTipoTrabajo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, quotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRABAJO", DbType.String, taskTypeClass);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsItems, "ItemsCotizados");
            }
            return dsItems.Tables["ItemsCotizados"];
        }

        /// <summary>
        /// Se obtienen las actividades válidas para cotizar
        /// </summary>
        /// <returns>Retorna los tipos de trabajo de la cotización</returns>               
        public DataTable GetActivities()
        {
            DataSet dsActivities = new DataSet("Actividades");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacioncomercial.fcrActividadesPorTipoTrabajo"))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsActivities, "Actividades");
            }
            return dsActivities.Tables["Actividades"];
        }

        /// <summary>
        /// Se obtienen los items vigentes
        /// </summary>
        /// <returns>Retorna los items vigentes</returns>     
        /// Caso 200-1640: Se modifica el paquete
        public DataTable getValidItems(Int64 costList)
        {
            DataSet dsQuotedTaskType = new DataSet("ItemsVigentes");

            //caso 200-1640
            //using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacioncomercial.fcrItemsVigentes"))
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BCCOTIZACIONCOMERCIAL.fcrItemsVigentesPorUnidad"))
            {
                //Caso 200-1640
                //OpenDataBase.db.AddInParameter(cmdCommand, "INULISTA", DbType.Int64, costList);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOperUnit", DbType.Int64, costList);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsQuotedTaskType, "ItemsVigentes");
            }
            return dsQuotedTaskType.Tables["ItemsVigentes"];
        }

        /// <summary>
        /// Se registran los datos básicos de la cotización
        /// </summary>
        /// <param name="quotationBasicData">Instancia de la clase QuotationBasicData</param>
        public Int64 registerQuotationBasicData(QuotationBasicData quotationBasicData, Int64 customerId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacioncomercial.proCreaCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCLIENTE", DbType.Int64, customerId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUDIRECCION", DbType.Int64, quotationBasicData.AddressId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALORCOTIZADO", DbType.Decimal, quotationBasicData.QuotedValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUDESCUENTO", DbType.Double, quotationBasicData.Discount);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOBSERVACION", DbType.String, quotationBasicData.Comment);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHAVIGENCIA", DbType.DateTime, quotationBasicData.ValidityDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTSECTORCOMERCI", DbType.Int64, quotationBasicData.OperatingSector);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTNUMFORMULARIO", DbType.Int64, quotationBasicData.NuFormulario);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTUNIDADOPERATI", DbType.Int64, quotationBasicData.OperatingUnit);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTSOLICITUD", DbType.Int64, quotationBasicData.SolicitudRed);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCOTIZACION", DbType.Int64, 20);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCOTIZACION"))) ? 0 : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCOTIZACION"));
            }
        }

        /// <summary>
        /// Se registran los tipos de trabajo por cotización
        /// </summary>
        /// <param name="quotationTaskType">instancia de QuotationTaskType</param>
        public void registerQuotationTaskType(QuotationTaskType quotationTaskType)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacioncomercial.proCreaTipoTrabajo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, quotationTaskType.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBABREVIATURA", DbType.String, quotationTaskType.TaskTypeClassif);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRABAJO", DbType.Int64, quotationTaskType.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUACTIVIDAD", DbType.Int64, quotationTaskType.Activity);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUIVA", DbType.Double, quotationTaskType.Iva);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBAPLICADESC", DbType.String, quotationTaskType.ApplyDiscount? "S":"N");
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se registra el nuevo item
        /// </summary>
        /// <param name="newItem">nuevo registro de ítem</param>
        public void registerItem(QuotationItem newItem)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacioncomercial.proCreaItem"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, newItem.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, newItem.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUACTIVIDAD", DbType.Int64, newItem.ActivityId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULISTA", DbType.Int64, newItem.ListId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEM", DbType.Int64, newItem.ItemId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOSTO", DbType.Decimal, newItem.SaleCost);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUAIU", DbType.Decimal, newItem.Aiu);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTIDAD", DbType.Double, newItem.Amount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUDESCUENTO", DbType.Decimal, newItem.Discount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPRECIOTOTAL", DbType.Decimal, newItem.TotalPrice);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUIVA", DbType.Decimal, newItem.IvaValue);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se modifican datos básicos de la cotización
        /// </summary>
        /// <param name="quotationBasicData">Cotización a modificar</param>
        public void modifyQuotationBasicData(QuotationBasicData quotationBasicData)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacioncomercial.proModificaCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, quotationBasicData.Consecutive);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUDIRECCION", DbType.Int64, quotationBasicData.AddressId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALORCOTIZADO", DbType.Decimal, quotationBasicData.QuotedValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUDESCUENTO", DbType.Double, quotationBasicData.Discount);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOBSERVACION", DbType.String, quotationBasicData.Comment);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHAVIGENCIA", DbType.DateTime, quotationBasicData.ValidityDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTSECTORCOMERCI", DbType.Int64, quotationBasicData.OperatingSector);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTNUMFORMULARIO", DbType.Int64, quotationBasicData.NuFormulario);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTUNIDADOPERATI", DbType.Int64, quotationBasicData.OperatingUnit);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTSOLICITUD", DbType.Int64, quotationBasicData.SolicitudRed);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se modifican los tipos de trabajo de la cotizacion
        /// </summary>
        /// <param name="quotationTaskType">Instancia de la clase QuotationTaskType</param>
        public void modifyQuotationTaskType(QuotationTaskType quotationTaskType)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacioncomercial.proModificaTipoTrabajo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, quotationTaskType.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBABREVIATURA", DbType.String, quotationTaskType.TaskTypeClassif);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRABAJO", DbType.Int64, quotationTaskType.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUACTIVIDAD", DbType.Int64, quotationTaskType.Activity);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUIVA", DbType.Double, quotationTaskType.Iva);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBAPLICADESC", DbType.String, quotationTaskType.ApplyDiscount ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOPERACION", DbType.String, quotationTaskType.Option);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se modifica el item
        /// </summary>
        /// <param name="item">item a modificar</param>
        public void modifyItem(QuotationItem item)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacioncomercial.proModificaItem"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCONSECUTIVO", DbType.Int64, item.Consecutive);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, item.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, item.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUACTIVIDAD", DbType.Int64, item.ActivityId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULISTA", DbType.Int64, item.ListId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEM", DbType.Int64, item.ItemId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOSTO", DbType.Decimal, item.SaleCost);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUAIU", DbType.Decimal, item.Aiu);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTIDAD", DbType.Double, item.Amount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUDESCUENTO", DbType.Decimal, item.Discount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPRECIOTOTAL", DbType.Decimal, item.TotalPrice);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUIVA", DbType.Decimal, item.IvaValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOPERACION", DbType.String, item.Option);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se envía cotización a OSF
        /// </summary>
        /// <param name="cotizacion">item a modificar</param>
        public void sendToOSF(QuotationBasicData cotizacion)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacioncomercial.proEnviaACotizadorOSF"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, cotizacion.Consecutive);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se valida si el item existe
        /// </summary>
        /// <param name="itemId">Consecutivo del ítem</param>
        /// <returns>Retorna un valor booleano indicando si existe el ítem</returns>
        public Boolean ItemExists(Int64 itemId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("daldc_items_cotizacion_com.fblExist"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCONSECUTIVO", DbType.Int64, itemId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        /// <summary>
        /// Se marca el cliente especial
        /// </summary>
        /// <param name="customer">cliente</param>
        public void MarkSpecialCustomer(CustomerBasicData customer)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacioncomercial.proMarcaClienteEspecial"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCLIENTE", DbType.Int64, customer.Id);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBCLIENTEESPECIAL", DbType.String, customer.SpecialCustomer?"S":"N");
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se imprime la cotización
        /// </summary>
        /// <param name="quotationId">Id de la cotización</param>
        public void PrintQuotation(Int64 quotationId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacioncomercial.proImprimeCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, quotationId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //IMPRIME PRECUPON CASO 200-2000
        public void PrintPreCupon(Int64 quotationId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDCPKGGENPRECUPONCOTIZA.PRINTPRECUPON"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, quotationId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualiza cotizacion de OSF
        /// </summary>
        /// <param name="quotationId">Id de la cotización</param>
        /// <param name="deleteFinanCond">Indica si se deben borrar las condiciones de financiación</param>
        public void UpdateOSFQuotation(Int64 quotationId, Boolean deleteFinanCond)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacioncomercial.proActualizaCotiOSF"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, quotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "BLBORRACONDFIN", DbType.Boolean, deleteFinanCond);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se valida si tiene condiciones de financiación
        /// </summary>
        /// <param name="quotationId">Id de la cotización</param>
        public Boolean HasFinancCondition(Int64 quotationId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacioncomercial.fblTieneCondFinanc"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, quotationId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        /// <summary>
        /// Se valida la entrega
        /// </summary>
        /// <param name="nomEntrega">Nombre de la entrega</param>
        public Int64 AplicaEntrega(String nomEntrega)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_FNU_APLICAENTREGA"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNOMBRE_ENTREGA", DbType.String, nomEntrega);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se valida la entrega
        /// </summary>
        /// <param name="nomEntrega">Nombre de la entrega</param>
        public bool AplicaEntregaxCAso(String nomEntrega)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("FBLAPLICAENTREGAXCASO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNUMEROCASO", DbType.String, nomEntrega);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToBoolean(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        public Object getParam(String sbParam, String tipo)
        {
            try
            {
                Object valor = null;
                switch (tipo)
                {
                    case "String":
                        {
                            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_parameter.fsbgetvalue_chain"))
                            {
                                OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, sbParam);
                                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                                valor = OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
                            }
                        }
                        break;
                    case "Int64":
                        {
                            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_parameter.fnugetnumeric_value"))
                            {
                                OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, sbParam);
                                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                                valor = OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
                            }
                        }
                        break;
                    default:
                        valor = null;
                        break;
                }
                return valor;
            }
            catch
            {
                return null;
            }
        }

        //12.07.18
        //Servicios Diseñados por el Ing. Sebastian Tapias para el Manejo de las nuevas condiciones de la Forma
        /*Servicio Reportado
         PROCEDURE proRegistraComercial(inuPackageId     IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                                 inuContratista   IN ldc_coticomercial_adic.contratista%TYPE,
                                 inuOperatingUnit IN ldc_coticomercial_adic.unidad_operativa%TYPE,
                                 onuErrorCode     OUT NUMBER,
                                 osbErrorMessage  OUT VARCHAR2);*/
        public void proRegistraComercial(Int64 inuPackageId, Int64 inuContratista, Int64 inuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proRegistraComercial"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContratista", DbType.Int64, inuContratista);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOperatingUnit", DbType.Int64, inuOperatingUnit);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*Servicio Reportado
          PROCEDURE proRegistraComercialItem(inuPackageId    IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                                     inuConsecutivo  IN ldc_itemscoticomer_adic.consecutivo%TYPE,
                                     inuIditem       IN ldc_itemscoticomer_adic.id_item%TYPE,
                                     isbClassItem    IN ldc_itemscoticomer_adic.class_item%TYPE,
                                     onuErrorCode    OUT NUMBER,
                                     osbErrorMessage OUT VARCHAR2);*/
        public void proRegistraComercialItem(Int64 inuPackageId, Int64 inuConsecutivo, Int64 inuIditem, String isbClassItem, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proRegistraComercialItem"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConsecutivo", DbType.Int64, inuConsecutivo);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIditem", DbType.Int64, inuIditem);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbClassItem", DbType.String, isbClassItem);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*Servicio Reportado
         PROCEDURE proActualizaComercial(inuPackageId     IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                                  inuContratista   IN ldc_coticomercial_adic.contratista%TYPE,
                                  inuOperatingUnit IN ldc_coticomercial_adic.unidad_operativa%TYPE,
                                  onuErrorCode     OUT NUMBER,
                                  osbErrorMessage  OUT VARCHAR2);*/
        public void proActualizaComercial(Int64 inuPackageId, Int64 inuContratista, Int64 inuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proActualizaComercial"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContratista", DbType.Int64, inuContratista);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOperatingUnit", DbType.Int64, inuOperatingUnit);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*Servicio Reportado
         PROCEDURE proActualizaComercialItem(inuConsecutivo  IN ldc_itemscoticomer_adic.consecutivo%TYPE,
                                      inuIditem       IN ldc_itemscoticomer_adic.id_item%TYPE,
                                      isbClassItem    IN ldc_itemscoticomer_adic.class_item%TYPE,
                                      isbOperacion    IN VARCHAR2, --Operacion
                                      onuErrorCode    OUT NUMBER,
                                      osbErrorMessage OUT VARCHAR2);*/
        public void proActualizaComercialItem(Int64 inuConsecutivo, Int64 inuIditem, String isbClassItem, String isbOperacion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proActualizaComercialItem"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConsecutivo", DbType.Int64, inuConsecutivo);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIditem", DbType.Int64, inuIditem);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbClassItem", DbType.String, isbClassItem);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbOperacion", DbType.String, isbOperacion);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*Servicio Reportado
         ROCEDURE proEliminaComercialItem(inuConsecutivo  IN ldc_itemscoticomer_adic.consecutivo%TYPE,
                                    onuErrorCode    OUT NUMBER,
                                    osbErrorMessage OUT VARCHAR2);*/
        public void proEliminaComercialItem(Int64 inuConsecutivo, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proEliminaComercialItem"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConsecutivo", DbType.Int64, inuConsecutivo);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*Servicio Reportado
         PROCEDURE proCargaComercial(inuPackageId     IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                              onuContratista   OUT ldc_coticomercial_adic.contratista%TYPE,
                              onuOperatingUnit OUT ldc_coticomercial_adic.unidad_operativa%TYPE,
                              onuErrorCode     OUT NUMBER,
                              osbErrorMessage  OUT VARCHAR2)
         */
        public void proCargaComercial(Int64 inuPackageId, out Int64 onuContratista, out Int64 onuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proCargaComercial"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuContratista", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuOperatingUnit", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuContratista = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuContratista"));
                onuOperatingUnit = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuOperatingUnit"));
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        //Inicio Servicios OSF-1492
        /// <summary>
        /// Se registran el AIU de al cotizacion
        /// </summary>
        /// <param name="quotationTaskType">instancia de QuotationTaskType</param>
        public void registerAIUQuotation(Double InuQuotationId, Double InuAIUporcentate)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOCOTIZACIONCOMERCIAL.proRegistraAIUCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, InuQuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUAIUPORCENTAJE", DbType.Int64, InuAIUporcentate);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }
        /// <summary>
        /// Se registran el AIU de al cotizacion
        /// </summary>
        /// <param name="quotationTaskType">instancia de QuotationTaskType</param>
        public void actualizaAIUQuotation(Double InuQuotationId, Double InuAIUporcentate)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOCOTIZACIONCOMERCIAL.proActualizaAIUCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, InuQuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUAIUPORCENTAJE", DbType.Int64, InuAIUporcentate);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }
        /// <summary>
        /// Se Obtiene el AIU de al cotizacion
        /// </summary>
        /// <param name="nomEntrega">Nombre de la entrega</param>
        public Double obtieneAIUQuotation(Double InuQuotationId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOCOTIZACIONCOMERCIAL.fnuObtenerAIUCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNUMEROCASO", DbType.String, InuQuotationId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }
        /// <summary>
        /// Se Obtiene valor numerico de parametro personalizaciones
        /// </summary>
        /// <param name="nomEntrega">Nombre de la entrega</param>
        public Double numeroParametro(String isbNombreParametro)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("pkg_parametros.fnuGetValorNumerico"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNUMEROCASO", DbType.String, isbNombreParametro);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }
        /// <summary>
        /// Se Obtiene valor cadena de parametro personalizaciones
        /// </summary>
        /// <param name="nomEntrega">Nombre de la entrega</param>
        public String cadenaParametro(String isbNombreParametro)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("pkg_parametros.fsbGetValorCadena"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, isbNombreParametro);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }
        //Fin Servicios OSF-1492

        //Inicio Servicios OSF-3104

        //Proceso para realizar el llamado del servicio encargado de validar Estabelcer si el valor existe un parametro de cadena
        public Double fnuValidaSiExisteCadena(String isbNombreParametro, String isbSeparador, String isbCadena)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("pkg_parametros.fnuValidaSiExisteCadena"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbNombreParametro", DbType.String, isbNombreParametro);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbSeparador", DbType.String, isbSeparador);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbCadena", DbType.String, isbCadena);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        //Servicio para validar actividad de cargo por conexion industrial
        public Double ExisteActividadCargoConexionIndustrial(Double nuActividad)
        {
            //Establecer si la actividad existe
            Double nuExiste = fnuValidaSiExisteCadena("ACT_CAR_CON_IND_LDC_FCVC", ",", Convert.ToString(nuActividad));
            return nuExiste;
        }

        //Servicio para validar actividad de inspeccion/certificacion industrial
        public Double ExisteActividadInspecCertificaIndustrial(Double nuActividad)
        {
            //Establecer si la actividad existe
            Double nuExiste = fnuValidaSiExisteCadena("ACT_INS_CER_IND_LDC_FCVC", ",", Convert.ToString(nuActividad));
            return nuExiste;
        }
        //Fin Servicios OSF-3104

    }
}
