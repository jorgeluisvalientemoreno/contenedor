using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace Ludycom.CommercialSale.Entities
{
   public class CustomerBasicData
    {
        private long? id;

        public long? Id
        {
            get { return id; }
            set { id = value; }
        }

        private String identificationType;

        public String IdentificationType
        {
            get { return identificationType; }
            set { identificationType = value; }
        }

        private String identification;

        public String Identification
        {
            get { return identification; }
            set { identification = value; }
        }

        private String customerName;

        public String CustomerName
        {
            get { return customerName; }
            set { customerName = value; }
        }

        private Boolean specialCustomer;

        public Boolean SpecialCustomer
        {
            get { return specialCustomer; }
            set { specialCustomer = value; }
        }

        private Int64? contract;

        public Int64? Contract
        {
            get { return contract; }
            set { contract = value; }
        }

        private Int64? product;

        public Int64? Product
        {
            get { return product; }
            set { product = value; }
        }

        public CustomerBasicData()
        {

        }

        public CustomerBasicData(CustomerBasicData customer)
        {
            this.id = customer.Id;
            this.identificationType = customer.IdentificationType;
            this.identification = customer.Identification;
            this.customerName = customer.CustomerName;
            this.specialCustomer = customer.SpecialCustomer;
            this.product = customer.Product;
            this.contract = customer.Contract;
        }

        public CustomerBasicData Clone()
        {
            return new CustomerBasicData(this);
        }
    }
}
