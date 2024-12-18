using System;
using System.Collections.Generic;
using System.Text;

namespace Ludycom.Constructoras.ENTITIES
{
    class ProjectBasicData
    {
        private Int64 projectId;

        public Int64 ProjectId
        {
            get { return projectId; }
            set { projectId = value; }
        }

        private String projectName;

        public String ProjectName
        {
            get { return projectName; }
            set { projectName = value; }
        }

        private String comment;

        public String Comment
        {
            get { return comment; }
            set { comment = value; }
        }

        private Int64? addressId;

        public Int64? AddressId
        {
            get { return addressId; }
            set { addressId = value; }
        }

        private Int64? locationId;

        public Int64? LocationId
        { 
            get { return locationId; }
            set { locationId = value; }
        }

        private DateTime? registerDate;

        public DateTime? RegisterDate {
            get { return registerDate; }
            set { registerDate = value; }
        }

        private DateTime? lastModDate;

        public DateTime? LastModDate {
            get { return lastModDate; }
            set { lastModDate = value; }
        }

        private Int64 floorsQuantity;

        public Int64 Floors {
            get { return floorsQuantity; }
            set { floorsQuantity = value; }
        }

        private Int64 towersQuantity;

        public Int64 Towers {
            get { return towersQuantity; }
            set { towersQuantity = value;}
        }

        private Int64 unitsPropTypes;

        public Int64 UnitsPropTypes {
            get { return unitsPropTypes; }
            set { unitsPropTypes = value; }
        }

        private Int64 unitsPropTotal;

        public Int64 UnitsPropTotal {
            get { return unitsPropTotal;}
            set { unitsPropTotal = value;}
        }

        private int buildingType;

        public int BuildingType {
            get { return buildingType; }
            set { buildingType = value; } 
        }

        private String promissoryNote;

        public String PrommissoryNote
        {
            get { return promissoryNote; }
            set { promissoryNote = value; }
        }

        private String contract;

        public String Contract
        {
            get { return contract; }
            set { contract = value; }
        }

        private String paymentModality;

        public String PaymentModality
        {
            get { return paymentModality; }
            set { paymentModality = value; }
        }

        private Int64? tenementType;

        public Int64? TenementType
        {
            get { return tenementType; }
            set { tenementType = value; }
        }

    }
}
