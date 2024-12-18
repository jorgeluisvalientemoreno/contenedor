using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.SUBSIDYS.Entities
{
    class erpt_LDLAR
    {
        private String location;

        public String Location
        {
            get { return location; }
            set { location = value; }
        }

        private DateTime genDate;

        public DateTime GenDate
        {
            get { return genDate; }
            set { genDate = value; }
        }

        private String clientName;

        public String ClientName
        {
            get { return clientName; }
            set { clientName = value; }
        }

        private String lastName;

        public String LastName
        {
            get { return lastName; }
            set { lastName = value; }
        }

        private Int64 contract;

        public Int64 Contract
        {
            get { return contract; }
            set { contract = value; }
        }

        private String instAddress;

        public String InstAddress
        {
            get { return instAddress; }
            set { instAddress = value; }
        }

        private String tels;

        public String Tels
        {
            get { return tels; }
            set { tels = value; }
        }

        private String geoUbication;

        public String GeoUbication
        {
            get { return geoUbication; }
            set { geoUbication = value; }
        }

        private String sponsorName;

        public String SponsorName
        {
            get { return sponsorName; }
            set { sponsorName = value; }
        }

        private String dealName;

        public String DealName
        {
            get { return dealName; }
            set { dealName = value; }
        }

        private Int64 subsidyValue;

        public Int64 SubsidyValue
        {
            get { return subsidyValue; }
            set { subsidyValue = value; }
        }

        private String conceptName;

        public String ConceptName
        {
            get { return conceptName; }
            set { conceptName = value; }
        }

        private Int64 daysParameter;

        public Int64 DaysParameter
        {
            get { return daysParameter; }
            set { daysParameter = value; }
        }

        private String lDCName;

        public String LDCName
        {
            get { return lDCName; }
            set { lDCName = value; }
        }

        private String companyTels;

        public String CompanyTels
        {
            get { return companyTels; }
            set { companyTels = value; }
        }

        private Int64 socialStatus;

        public Int64 SocialStatus
        {
            get { return socialStatus; }
            set { socialStatus = value; }
        }
    }
}
