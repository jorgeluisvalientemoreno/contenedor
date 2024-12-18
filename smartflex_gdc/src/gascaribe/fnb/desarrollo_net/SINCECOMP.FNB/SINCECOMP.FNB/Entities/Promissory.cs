using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.FNB.Entities
{
    internal class Promissory
    {
        private Int64 promissoryId;

        public Int64 PromissoryId
        {
            get { return promissoryId; }
            set { promissoryId = value; }
        }
        private String holderBill;

        public String HolderBill
        {
            get { return holderBill; }
            set { holderBill = value; }
        }

        private String debtorName;

        public String DebtorName
        {
            get { return debtorName; }
            set { debtorName = value; }
        }

        private String debtorLastName;

        public String DebtorLastName
        {
            get { return debtorLastName; }
            set { debtorLastName = value; }
        }

        private String identification;

        public String Identification
        {
            get { return identification; }
            set { identification = value; }
        }

        private String identType;

        public String IdentType
        {
            get { return identType; }
            set { identType = value; }
        }

        private Int64? forwardingPlace;

        public Int64? ForwardingPlace
        {
            get { return forwardingPlace; }
            set { forwardingPlace = value; }
        }

        private DateTime forwardingDate;

        public DateTime ForwardingDate
        {
            get { return forwardingDate; }
            set { forwardingDate = value; }
        }

        private String gender;

        public String Gender
        {
            get { return gender; }
            set { gender = value; }
        }

        private Int64? civilStateId;

        public Int64? CivilStateId
        {
            get { return civilStateId; }
            set { civilStateId = value; }
        }

        private DateTime birthdayDate;

        public DateTime BirthdayDate
        {
            get { return birthdayDate; }
            set { birthdayDate = value; }
        }

        private Int64? schoolDegree;

        public Int64? SchoolDegree
        {
            get { return schoolDegree; }
            set { schoolDegree = value; }
        }

        private Int64? addressId;

        public Int64? AddressId
        {
            get { return addressId; }
            set { addressId = value; }
        }

        private String propertyPhone;

        public String PropertyPhone
        {
            get { return propertyPhone; }
            set { propertyPhone = value; }
        }

        private Int64? dependentsNumber;

        public Int64? DependentsNumber
        {
            get { return dependentsNumber; }
            set { dependentsNumber = value; }
        }

        private Int64? housingType;

        public Int64? HousingType
        {
            get { return housingType; }
            set { housingType = value; }
        }

        private Int64? housingMonth;

        public Int64? HousingMonth
        {
            get { return housingMonth; }
            set { housingMonth = value; }
        }

        private Int64? holderRelation;

        public Int64? HolderRelation
        {
            get { return holderRelation; }
            set { holderRelation = value; }
        }

        private String occupation;

        public String Occupation
        {
            get { return occupation; }
            set { occupation = value; }
        }

        private String companyName;

        public String CompanyName
        {
            get { return companyName; }
            set { companyName = value; }
        }

        private Int64? companyAddressId;

        public Int64? CompanyAddressId
        {
            get { return companyAddressId; }
            set { companyAddressId = value; }
        }

        private String phone1;

        public String Phone1
        {
            get { return phone1; }
            set { phone1 = value; }
        }

        private String phone2;

        public String Phone2
        {
            get { return phone2; }
            set { phone2 = value; }
        }

        private String movilPhone;

        public String MovilPhone
        {
            get { return movilPhone; }
            set { movilPhone = value; }
        }
        Int64? oldLabor;

        public Int64? OldLabor
        {
            get { return oldLabor; }
            set { oldLabor = value; }
        }

        private String activity;

        public String Activity
        {
            get { return activity; }
            set { activity = value; }
        }

        private Double monthlyIncome;

        public Double MonthlyIncome
        {
            get { return monthlyIncome; }
            set { monthlyIncome = value; }
        }

        private Double expensesIncome;

        public Double ExpensesIncome
        {
            get { return expensesIncome; }
            set { expensesIncome = value; }
        }

        private String familiarReference;

        public String FamiliarReference
        {
            get { return familiarReference; }
            set { familiarReference = value; }
        }

        private String phoneFamiRefe;

        public String PhoneFamiRefe
        {
            get { return phoneFamiRefe; }
            set { phoneFamiRefe = value; }
        }

        private String movilPhoFamiRefe;

        public String MovilPhoFamiRefe
        {
            get { return movilPhoFamiRefe; }
            set { movilPhoFamiRefe = value; }
        }

        private String personalReference;

        public String PersonalReference
        {
            get { return personalReference; }
            set { personalReference = value; }
        }

        private String phonePersRefe;

        public String PhonePersRefe
        {
            get { return phonePersRefe; }
            set { phonePersRefe = value; }
        }

        private String movilPhoPersRefe;

        public String MovilPhoPersRefe
        {
            get { return movilPhoPersRefe; }
            set { movilPhoPersRefe = value; }
        }

        private String commercialReference;

        public String CommercialReference
        {
            get { return commercialReference; }
            set { commercialReference = value; }
        }

        private String phoneCommRefe;

        public String PhoneCommRefe
        {
            get { return phoneCommRefe; }
            set { phoneCommRefe = value; }
        }

        private String movilPhoCommRefe;

        public String MovilPhoCommRefe
        {
            get { return movilPhoCommRefe; }
            set { movilPhoCommRefe = value; }
        }

        private String email;

        public String Email
        {
            get { return email; }
            set { email = value; }
        }

        private Int64 packageId;

        public Int64 PackageId
        {
            get { return packageId; }
            set { packageId = value; }
        }

        private String promissoryType;

        public String PromissoryType
        {
            get { return promissoryType; }
            set { promissoryType = value; }
        }

        private Double payment;

        public Double Payment
        {
            get { return payment; }
            set { payment = value; }
        }

        private Int64? addressFamiRef;

        public Int64? AddressFamiRef
        {
            get { return addressFamiRef; }
            set { addressFamiRef = value; }
        }

        private Int64? addressPersRef;

        public Int64? AddressPersRef
        {
            get { return addressPersRef; }
            set { addressPersRef = value; }
        }

        private Int64? addressCommRef;

        public Int64? AddressCommRef
        {
            get { return addressCommRef; }
            set { addressCommRef = value; }
        }

        private Int64? subscriberId;

        public Int64? SubscriberId
        {
            get { return subscriberId; }
            set { subscriberId = value; }
        }

        private Int64? contractType;

        public Int64? ContractType
        {
            get { return contractType; }
            set { contractType = value; }
        }

        private Int64? categoryId;

        public Int64? CategoryId
        {
            get { return categoryId; }
            set { categoryId = value; }
        }

        private Int64? subcategoryId;

        public Int64? SubcategoryId
        {
            get { return subcategoryId; }
            set { subcategoryId = value; }
        }

        /**04-10-2014 Llozada [RQ 1218]: Flag deudor solidario*/
        private String flagDeudorSolidario;

        public String FlagDeudorSolidario
        {
            get { return flagDeudorSolidario; }
            set { flagDeudorSolidario = value; }
        }

        /**04-10-2014 Llozada [RQ 1218]: Flag deudor solidario*/
        private int causal;
        public int Causal
        {
            get { return causal; }
            set { causal = value; }
        }
    }
}
