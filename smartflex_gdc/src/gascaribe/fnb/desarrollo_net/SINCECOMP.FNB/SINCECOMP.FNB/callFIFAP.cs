#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : callFIFAP
 * Descripcion   : Llamado dinámicamente a la forma FIFAP
 * Autor         : 
 * Fecha         : 
 *
 * Fecha        SAO     Autor           Modificación                                                          
 * ===========  ======  ==============  =====================================================================
 * 27-Sep-2013  217614  lfernandez      1 - <Execute> Se reemplaza asignacióna  billSlope por llamado a
 *                                          SetBillSlope
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.FNB.UI;

namespace SINCECOMP.FNB
{
     
    public class callFIFAP : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {

            //Agordillo Cambio.6853 04-10-2015
            // Se instancia la clase IFIFAP
            IFIFAP ififap_ = new IFIFAP();
            ififap_.Visible = false;
            ififap_.ShowDialog();

            if (ififap_.Aceptar)
            {

                Int64 SubscriptionId = 0;

                SINCECOMP.FNB.BL.BLFIFAP _blFIFAP = new SINCECOMP.FNB.BL.BLFIFAP();

                SINCECOMP.FNB.BL.BLGENERAL general = new SINCECOMP.FNB.BL.BLGENERAL();

                SubscriptionId = Convert.ToInt64(parameters["NodeId"].ToString());

                Boolean flValVenta;
                //Agordillo 29/09/2015 Cambio.6853
                // Si se selecciono Venta de Materiales realiza las siguientes validaciones
                if (ififap_.VentaMateriales)
                {
                    //Agordillo Cambio.6853 
                    //Se verifica si el contratista conectado al sistema puede realizar este tipo de venta
                    Boolean blSaleMaterial = _blFIFAP.fblValidMaterialSales();
                    if (!blSaleMaterial)
                    {
                        flValVenta = false;
                        general.mensajeERROR("La persona conectada al sistema no puede realizar una Venta de Tipo Materiales");
                    }
                    else
                    {
                        flValVenta = true;
                    }

                }
                else
                {
                    flValVenta = true;
                }

                //Agordillo Cambio.6853 04-10-2015
                //se agrega la variable flValVenta para condicionar si se abre la ventada de FIFAP                
                if (_blFIFAP.GetLock(SubscriptionId) && flValVenta)
                {
                    //CONSULTA DE RESGITROS SEGUN EL NUMERO DE LA SUBSCRIPCION
                    SINCECOMP.FNB.Entities.DataFIFAP _dataFIFAP = _blFIFAP.getSubscriptionData(SubscriptionId);

                    int validateBill = _blFIFAP.numberBill(SubscriptionId);

                    int nuExistPendingSale = _blFIFAP.fnuPendingSaleOrder(SubscriptionId); //KCIENFUEGOS.SAO313402 04-05-2015

                    Boolean isValidateGranSuperficie = true;
                    //ABaldovino RQ 6492 23/04/2015 
                    try
                    {
                        if ("N".Equals(string.IsNullOrEmpty(general.getParam("VAL_FAVEN_FNB_GS", "String").ToString()) ?
                                                            "" :
                                                            general.getParam("VAL_FAVEN_FNB_GS", "String").ToString()))
                        {
                            isValidateGranSuperficie = false;
                        }
                        else
                        {
                            isValidateGranSuperficie = true;
                        }
                    }
                    catch
                    {

                    }


                    if (_dataFIFAP.isGranSuperficie() && isValidateGranSuperficie)
                    {
                        if (validateBill == -1 || validateBill != 0)
                        {
                            general.mensajeERROR("Posee facturas vencidas, no se realizara venta");
                        }
                        else
                        {
                            using (FIFAP frm = new FIFAP(SubscriptionId, _dataFIFAP))
                            {
                                ////Agordillo Cambio.6853 04-10-2015
                                //se setea la instancia de IFIFAP
                                frm.setIfifap(ififap_);
                                frm.SetBillSlope(validateBill);
                                frm.ShowDialog();
                            }
                        }
                    }
                    else
                    {
                        if (validateBill == -1)
                        {
                            general.mensajeERROR("Posee facturas vencidas. No se realizará venta");
                        }
                        else
                        {
                            if (validateBill != 0)
                            {
                                general.mensajeERROR("Posee facturas vencidas. Sin embargo, se realizará la venta aunque no será legalizada hasta que se realice el pago, a menos que el pago sea de contado.");
                                using (FIFAP frm = new FIFAP(SubscriptionId, _dataFIFAP))
                                {
                                    //Agordillo Cambio.6853 04-10-2015
                                    //se setea la instancia de IFIFAP
                                    frm.setIfifap(ififap_);
                                    frm.SetBillSlope(validateBill);
                                    frm.ShowDialog();
                                }
                            }
                            else
                            {
                                using (FIFAP frm = new FIFAP(SubscriptionId, _dataFIFAP))
                                {
                                    //Agordillo Cambio.6853 04-10-2015
                                    //se setea la instancia de IFIFAP
                                    frm.setIfifap(ififap_);
                                    frm.SetBillSlope(validateBill);
                                    frm.ShowDialog();
                                }
                            }
                        }
                    }
                    _blFIFAP.ReleaseLock(SubscriptionId);
                }
                else
                {
                    //Agordillo Cambio.6853 04-10-2015
                    //se agrega una condicion para mostrar el mensaje
                    if (flValVenta)
                    {
                        general.mensajeERROR("En este momento otro usuario está registrando una venta FNB para este contrato. No se puede proceder hasta que dicha venta finalice");

                    }
                }
            }
        }
    }
}
