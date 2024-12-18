using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.FNB.Entities
{
    class BasicDataFNBCR
    {

        private Int64 identType;

        public Int64 IdentType
        {
            get { return identType; }
            set { identType = value; }
        }
        private String identification;

        public String Identification
        {
            get { return identification; }
            set { identification = value; }
        }
        private String subName;

        public String SubName
        {
            get { return subName; }
            set { subName = value; }
        }
        private String subLastname;

        public String SubLastname
        {
            get { return subLastname; }
            set { subLastname = value; }
        }

        private Int64 addressId;

        public Int64 AddressId
        {
            get { return addressId; }
            set { addressId = value; }
        }

        private String address;

        public String Address
        {
            get { return address; }
            set { address = value; }
        }

        private Int64 geoLocation;

        public Int64 GeoLocation
        {
            get { return geoLocation; }
            set { geoLocation = value; }
        }

        private String fullPhone;

        public String FullPhone
        {
            get { return fullPhone; }
            set { fullPhone = value; }
        }


        private Int64 categoryId;

        public Int64 CategoryId
        {
            get { return categoryId; }
            set { categoryId = value; }
        }

        private Int64 subcategoryId;

        public Int64 SubcategoryId
        {
            get { return subcategoryId; }
            set { subcategoryId = value; }
        }

        private String subCategory;

        public String SubCategory
        {
            get { return subCategory; }
            set { subCategory = value; }
        }

        private String category;

        public String Category
        {
            get { return category; }
            set { category = value; }
        }

        private Int64 subscriberId;

        public Int64 SubscriberId
        {
            get { return subscriberId; }
            set { subscriberId = value; }
        }


    }
}
