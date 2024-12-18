using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.ExceptionHandler;
using System.ComponentModel;

namespace SINCECOMP.FNB.Entities
{
    public class TransferQuota
    {
        private Int64 transferId;

        [DisplayName("Identificador de Cupo")]
        public Int64 TransferId
        {
            get { return transferId; }
           
        }
        private Int64 subscriptionId;

        [DisplayName("Contrato")]
        public Int64 SubscriptionId
        {
            get { return subscriptionId; }
            set { subscriptionId = value; }
        }
        private String subscriberName;

        [DisplayName("Nombre de Suscriptor")]
        public String SubscriberName
        {
            get { return subscriberName; }
          
        }
        private Double avalibleQuota;

        [DisplayName("Cupo Disponible")]
        public Double AvalibleQuota
        {
            get { return avalibleQuota; }
     
        }
        private Double transferQuotaValue;

        [DisplayName("Valor de Cupo Transferido")]
        public Double TransferQuotaValue
        {
            get { return transferQuotaValue; }
            set {

                if (avalibleQuota >= value)
                {
                    transferQuotaValue = value;
                }
                else 
                {
                    ExceptionHandler.DisplayMessage(2741, "El valor ingresado excede el cupo disponible de este contrato"); 
                }
            
            }
        }

        public  TransferQuota(Int64 TransferId, Int64 SubscriptionId, String SubscriberName, Double AvalibleQuota)
        { 
            this.transferId = TransferId;
            this.subscriptionId = SubscriptionId;
            this.subscriberName = SubscriberName;
            this.avalibleQuota = AvalibleQuota;
            this.transferQuotaValue = 0; 
        
        }


        public TransferQuota()
        {
            this.subscriptionId = 0;
            this.subscriberName = " ";
            this.avalibleQuota = 0;
            this.transferQuotaValue = 0; 

        }
 
 

    }
}
