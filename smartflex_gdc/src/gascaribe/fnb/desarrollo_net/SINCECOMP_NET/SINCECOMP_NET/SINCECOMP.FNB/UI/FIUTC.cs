#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : FIUTC
 * Descripcion   : Solicitud de Unión/Traslado de Cupos
 * Autor         : Sidecom
 * Fecha         : -
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 15-Nov-2013  223401  LDiuza         1 - Se modifica el proceso de calculo de valores totales para solucionar errores relacionados
 *                                         con proceso de union y traslado.
 * 15-Oct-2013  219648  LDiuza         1 - Se transfiere metodo <GetPendTransfQuota> a la clase FIFAP.
 *                                     2 - Se modifican los parametros del metodo <ShowDialog>
 * 27-Sep-2013  217614  lfernandez     1 - <ShowDialog> Se adiciona parámetros total venta, cupo disponible,
 *                                         cupo transferido, canal de venta, artículos y cupo extra. Se obtiene
 *                                         el valor pendiente a transferir con GetPendTransfQuota
 *                                     2 - <GetPendTransfQuota> Se adiciona método para obtener el valor
 *                                         pendiente a transferir. Para cada artículo obtiene el cupo extra que
 *                                         aplica y luego aplica el cupo de la suscripción, y lo que falte se
 *                                         debe transferir
 * 11-Sep-2013  211751  mmeusburgger   1 - Se modifica <<openButton1_Click>> y se implementa el método 
 *                                          <<clearCache>>
 * 07-Sep-2013  212252  mmira          1 - Se modifica <ugTransfer_AfterCellUpdate> para validar que el contrato
 *                                      codeudor ceda cupo.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using Infragistics.Win.UltraWinGrid;
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.Entities;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Util;


namespace SINCECOMP.FNB.UI
{
    public partial class FIUTC : OpenForm
    {
        blFIUTC _blFIUTC = new blFIUTC();
        BLGENERAL general = new BLGENERAL();
        BLFIFAP _blFIFAP = new BLFIFAP();

        Int32 _maxTransferQuota;
        Int64 _subscription;

        //Incicio CASO 200-854
        Int64 _nucontratodeudorfiutc;
        Int64 _nucontratocodeudorfiutc;
        Int64 _nuTipoIdentificacioncodeudorfiutc;
        String _nuIdentificacioncodeudorfiutc;
        Boolean _blTitularFacturafiutc;
        Int64 _nucodigoerror;
        String _sbmensaje;
        Int64 _onucontatocodeudor;
        //Fin CASO 200-854
        
        Double _pendTransf; 
        public Double TransferQuota;        
        public Boolean correcto = true;
        public Int64 OrderId;
        private String tempSubscriber;
        private Int64 _subscriptCosigner;
        private Int64 _identTypeCosigner;
        private String _identCosigner;       
        private Boolean hasCosigner = false;

        private List<TransferQuota> lstTransferQuota = new List<TransferQuota>();

        public List<TransferQuota> LstTransferQuota
        {
            get { return lstTransferQuota; }
            set { lstTransferQuota = value; }
        }

        public FIUTC()
        {
            
        }

        public FIUTC(Int64 subsId, Double pendTransf)
        {
            InitializeComponent();            
            _pendTransf = pendTransf;
            try
            {
                _maxTransferQuota = int.Parse  ( general.getParam("MAX_TRANSFER_QUOTA", "Int64").ToString()); /*COnsultar el parametro */
            }
            catch 
            {
                correcto = false;
            }
            _subscription = subsId; /* obtiene desde la forma de venta */
            //columnas obligatorias
            String[] fieldssimulator = new string[] { "SubscriptionId", "TransferQuotaValue" };
            general.setColumnRequiered(ugTransfer, fieldssimulator);
            ostPendTransfer.TextBoxValue = pendTransf.ToString();

            ugTransfer.DisplayLayout.Bands[0].Columns["TransferQuotaValue"].Format = "$ #,##0.00";
            ugTransfer.DisplayLayout.Bands[0].Columns["AvalibleQuota"].Format = "$ #,##0.00";

            openHeaderTitles1.HeaderSubtitle1 = "Contrato Origen : " + OpenConvert.ToString(subsId);            
                  
        }
        
        /// <summary>
        /// Abre la forma FIUTC pero primero obtiene el valor pendiente a transferir
        /// </summary>
        /// <param name="subsId">Suscripción</param>
        /// <param name="totalSale">Total venta</param>
        /// <param name="availableQuota">Cupo disponible de la suscripción</param>
        /// <param name="transferQuota">Cupo transferido</param>
        /// <param name="cosignerContract">Codeudor</param>
        /// <param name="identTypeCosigner">Tipo identificación codeudor</param>
        /// <param name="identCosigner">Identificación codeudor</param>
        /// <param name="salesChannel">Canal de venta</param>
        /// <param name="articles">Lista de artículos</param>
        /// <param name="extraQuotas">Lista de cupos extra</param>
        /// <param name="lstTranferQuote">Lista de transferencia</param>
        /// <returns></returns>
        public DialogResult ShowDialog(
            Int64 subsId,
            Double transferQuota,
            String cosignerContract,
            String identTypeCosigner,
            String identCosigner,
            List<TransferQuota> lstTranferQuote,
            double pendTransf,
            //Inicio CASO 200-854
            //Int64 nucontratodeudorfiutc,
            //Int64 nucontratocodeudorfiutc,
            //Int64 nuIdentificacioncodeudorfiutc,
            Boolean blTitularFacturafiutc)
            //Fin CASO 200-854
        {
            try
            {
                _maxTransferQuota = int.Parse(general.getParam("MAX_TRANSFER_QUOTA", "Int64").ToString()); /*COnsultar el parametro */
            }
            catch
            {
            }

            this.TransferQuota = 0;
            tempSubscriber = String.Empty;
            
             /* obtiene desde la forma de venta */
            _subscription = subsId;          
            _identTypeCosigner =Convert.ToInt64(identTypeCosigner);
            _identCosigner = identCosigner;


            //Inicio CASO 200-854
            _nucontratodeudorfiutc = _subscription; // nucontratodeudorfiutc;
            _nucontratocodeudorfiutc = Convert.ToInt64(cosignerContract); // nucontratocodeudorfiutc;
            _nuTipoIdentificacioncodeudorfiutc = _identTypeCosigner;
            _nuIdentificacioncodeudorfiutc = _identCosigner; //nuIdentificacioncodeudorfiutc;
            _blTitularFacturafiutc = blTitularFacturafiutc;
            //Fin CASO 200-854

            if (!String.IsNullOrEmpty(cosignerContract))
                _subscriptCosigner = Convert.ToInt64(cosignerContract);
                       
            //columnas obligatorias
            String[] fieldssimulator = new string[] { "SubscriptionId", "TransferQuotaValue" };
            general.setColumnRequiered(ugTransfer, fieldssimulator);
            ostPendTransfer.TextBoxValue = pendTransf.ToString();
            _pendTransf = pendTransf;

            transferQuotaBindingSource.Clear();
            List<TransferQuota> lstAux = new List<TransferQuota>();
            lstAux.AddRange(lstTranferQuote);
            transferQuotaBindingSource.DataSource = lstAux;
            //15-Nov-2013:LDiuza:223401:1
            Double forTransfer = _pendTransf - calTotalTrasn();
            ostbTransfer.TextBoxValue = calTotalTrasn().ToString();
            ostbForTransfer.TextBoxValue = Convert.ToString(Math.Round(forTransfer, 2));

            if (lstAux.Count == 0)
            {
                ostbForTransfer.TextBoxValue = "0";
                ostbTransfer.TextBoxValue = "0";
                ostbRequestObservation.TextBoxValue = "";
            }

            DialogResult result = this.ShowDialog();        
            
            return result; 
        }        

        private void bindingNavigatorAddNewItem_Click(object sender, EventArgs e)
        {
            if (transferQuotaBindingSource.Count < _maxTransferQuota)
                transferQuotaBindingSource.AddNew();
            else
                general.mensajeERROR("Ha superado el máximo de transferencias de cupo");
        }


        private void ugTransfer_AfterCellUpdate(object sender, CellEventArgs e)
        {
            //general.mensajeERROR("_nucontratodeudorfiutc[" + _nucontratodeudorfiutc.ToString() + "]");
            //general.mensajeERROR("_nucontratocodeudorfiutc[" + _nucontratocodeudorfiutc.ToString() + "]");
            //general.mensajeERROR("_nuTipoIdentificacioncodeudorfiutc[" + _nuTipoIdentificacioncodeudorfiutc.ToString() + "]");
            //general.mensajeERROR("_nuIdentificacioncodeudorfiutc[" + _nuIdentificacioncodeudorfiutc + "]");
            //general.mensajeERROR("Convert.ToInt64(e.Cell.Value)[" + e.Cell.Value + "]");
           
            try
            {
                if (e.Cell.Column.Key == "SubscriptionId")
                {
                    Int32 x = transferQuotaBindingSource.Position;

                    if (_blTitularFacturafiutc)
                    {
                        _blFIUTC.PRGETINFOCODEUDOR(_nucontratodeudorfiutc,
                                                   _nucontratocodeudorfiutc,
                                                   _nuTipoIdentificacioncodeudorfiutc,
                                                   _nuIdentificacioncodeudorfiutc,
                                                   Convert.ToInt64(e.Cell.Value),
                                                   out _onucontatocodeudor,
                                                   out _nucodigoerror,
                                                   out _sbmensaje);
                        if (_nucodigoerror == -1)
                        {
                            transferQuotaBindingSource[x] = new TransferQuota();
                            general.mensajeERROR(_sbmensaje);
                            return;
                        }
                        else
                        {
                            if (_onucontatocodeudor > 0)
                                _subscriptCosigner = _onucontatocodeudor;
                       
                        }
                    }
                                        
                    if (_subscription != Convert.ToInt64(e.Cell.Value))
                    {
                        
                        if ((!hasCosigner) && _subscriptCosigner != Convert.ToInt64(e.Cell.Value))
                        {
                            transferQuotaBindingSource[x] = new TransferQuota();
                            general.mensajeERROR("El contrato no corresponde al codeudor de la venta.");
                        }
                        else
                        {
                            if (existTransfer(transferQuotaBindingSource, Convert.ToInt64(e.Cell.Value)))
                            {
                                TransferQuota tmpTransQuota = (TransferQuota)transferQuotaBindingSource.Current;
                                TransferQuota transfer = _blFIUTC.getTrasnferQuotaData(tmpTransQuota.SubscriptionId);
                                if (!(transfer.SubscriptionId == 0))
                                {
                                    if (transfer.AvalibleQuota <= 0)
                                    {
                                        transferQuotaBindingSource[x] = new TransferQuota();
                                        general.mensajeERROR("El codeudor [" + transfer.SubscriptionId + "] No tiene cupo disponible");                                     
                                    }
                                    else
                                    {
                                        transferQuotaBindingSource[x] = transfer;
                                        transferQuotaBindingSource.EndEdit();

                                        if (transfer.SubscriptionId == _subscriptCosigner)
                                        {
                                            hasCosigner = true;
                                        }
                                    }
                                }
                                else
                                {
                                    transferQuotaBindingSource[x] = new TransferQuota();
                                    general.mensajeERROR("El contrato no existe");
                                }
                                
                            }
                            else
                            {
                                transferQuotaBindingSource[x] = new TransferQuota();
                                general.mensajeERROR("El contrato ya está cediendo cupo");
                            }
                        }
                    }
                    else
                    {
                        transferQuotaBindingSource[x] = new TransferQuota();
                        general.mensajeERROR("No se puede trasladar cupo desde el mismo contrato");
                    }
                }

                if (e.Cell.Column.Key == "TransferQuotaValue")
                {
                    Double? value = OpenSystems.Common.Util.OpenConvert.ToLongNullable(e.Cell.Value);
                    if (value <= 0)
                    {
                        general.mensajeERROR("El valor de Cupo a Transferir debe ser mayor a cero($0.00)");
                    }
                }
                

                Double forTransfer = _pendTransf - calTotalTrasn();
                ostbTransfer.TextBoxValue = calTotalTrasn().ToString();
                ostbForTransfer.TextBoxValue = Convert.ToString(Math.Round(forTransfer,2));
            }
            catch (Exception exp)
            {
                //EVESAN 03/Julio/2013
                //transferQuotaBindingSource[x] = new TransferQuota();
                general.messageErrorException(exp);
            }
        }

        private void ugTransfer_Error(object sender, ErrorEventArgs e)
        {
            e.Cancel = true;
        }


        private Boolean existTransfer(BindingSource binding, Int64 subscriptionId)
        {
            int count = 0;
            foreach (TransferQuota x in binding)
            {
                if (x.SubscriptionId == subscriptionId)
                    count++;
                if (count > 1)
                    return false;
            }
            return true;
        }

        private void openButton1_Click(object sender, EventArgs e)
        {
            Boolean countSubscrip = false;
            Boolean salesOK= true;   
            
            if (_pendTransf == calTotalTrasn())
            {
                _blFIUTC.validationsTrasferQuota(_subscription,_pendTransf,_subscriptCosigner,_identTypeCosigner,  _identCosigner,tempSubscriber );
                
                //Limpia Cache
                _blFIUTC.clearCache();
                lstTransferQuota.Clear();

                foreach (TransferQuota valQuote in transferQuotaBindingSource)
                {
                    if (valQuote.TransferQuotaValue <= 0)
                    {
                        salesOK = false;
                        general.mensajeERROR("El valor de Cupo a Transferir debe ser mayor a cero($0.00)");
                        break;
                    }

                    if (_subscriptCosigner == valQuote.SubscriptionId)
                    {
                        countSubscrip = true;
                    }
                }

                if (salesOK )                        
                {
                    if (countSubscrip)
                    {
                        foreach (TransferQuota TransQuote in transferQuotaBindingSource)
                        {
                            if (!(TransQuote.SubscriptionId == 0))
                            {
                                _blFIUTC.RegisterTransferQuota(TransQuote.SubscriptionId, _subscription, TransQuote.TransferQuotaValue, DateTime.Today, TransQuote.TransferId, ostbRequestObservation.TextBoxValue);
                                TransferQuota = TransferQuota + TransQuote.TransferQuotaValue;

                                lstTransferQuota.Add(TransQuote);
                            }
                        }
                        DialogResult = DialogResult.OK; //cierra el formulario
                    }
                    else
                    {
                        general.mensajeERROR("El contrato no corresponde al codeudor de la venta.");                        
                    }
                }
            }
            else
                general.mensajeERROR("El cupo a trasladar debe ser exactamente el necesario");
        }

        private double calTotalTrasn()
        {
            double total = 0;
            foreach (TransferQuota x in transferQuotaBindingSource)
            {
                total = total + x.TransferQuotaValue;
                
                if(String.IsNullOrEmpty(tempSubscriber))
                    tempSubscriber = x.SubscriptionId.ToString();
                else
                    tempSubscriber =tempSubscriber+ ","+x.SubscriptionId;
            }
            return total; 
        }

        private void FIUTC_Load(object sender, EventArgs e)
        {
            if (!correcto)
                Close();
        }

        private void ugTransfer_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {


        }

        private void ugTransfer_AfterRowsDeleted(object sender, EventArgs e)
        {
            Double forTransfer = _pendTransf - calTotalTrasn();
            ostbTransfer.TextBoxValue = calTotalTrasn().ToString();
            ostbForTransfer.TextBoxValue = forTransfer.ToString();
        }

        private void ugTransfer_Validated(object sender, EventArgs e)
        {
            
        }

        private void ugTransfer_BeforeRowsDeleted(object sender, BeforeRowsDeletedEventArgs e)
        {

        }

        private void transferQuotaBindingSource_ListChanged(object sender, System.ComponentModel.ListChangedEventArgs e)
        {
            if (e.ListChangedType == System.ComponentModel.ListChangedType.ItemDeleted)
            {
                Double forTransfer = _pendTransf - calTotalTrasn();
                ostbTransfer.TextBoxValue = calTotalTrasn().ToString();
                ostbForTransfer.TextBoxValue = forTransfer.ToString();
            }
        }

        private void ugTransfer_InitializeLayout_1(object sender, InitializeLayoutEventArgs e)
        {

        }
    }
}