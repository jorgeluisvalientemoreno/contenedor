using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.FNB.Entities
{
    class ApprovalRequestFIRTC
    {
        private Int64 numberRequest;

        [DisplayName("Solicitud")]
        public Int64 NumberRequest
        {
            get { return numberRequest; }
           
        }

        private String contract;

        [DisplayName("Contrato")]
        public String Contract
        {
            get { return contract; }
            
        }

        private String status;

        [DisplayName("Estado")]
        public String Status
        {
            get { return status; }

        }

        private String taskType;

        [DisplayName("Tipo")]
        public String TaskType
        {
            get { return taskType; }
            
        }

        private Double totalValue;

        [DisplayName("Valor Total")]
        public Double TotalValue
        {
            get { return this.totalValue; }
            
        }

        String requestObservation;

        [Browsable(false)]
        public String RequestObservation
        {
            get { return requestObservation; }
            set { requestObservation = value; }
        }


        String reviewObservation;
        [Browsable(false)]
        public String ReviewObservation
        {
            get { return reviewObservation; }
            set { reviewObservation = value; }
        }


        public ApprovalRequestFIRTC(Int64 NumberRequest, String Contract, String TaskType, Double totalValue, String Status, string RequestObservation, string ReviewObservation)
        {
            this.numberRequest = NumberRequest;
            this.contract = Contract;
            this.taskType = TaskType;
            this.totalValue = totalValue;
            this.status = Status;
            this.requestObservation = RequestObservation;
            this.reviewObservation = ReviewObservation;
        }
    }
}
