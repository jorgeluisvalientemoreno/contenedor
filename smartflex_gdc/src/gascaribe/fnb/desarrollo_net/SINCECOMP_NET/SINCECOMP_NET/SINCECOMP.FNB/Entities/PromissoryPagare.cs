#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : PromissoryPagare
 * Descripcion   : Clase contenedora de la informacion de  un pagare
 * Autor         : 
 * Fecha         : 
 *
 * Fecha        SAO     Autor           Modificación                                                          
 * ===========  ======  ==============  =====================================================================
 * 08-10-2013   219165  LDiuza          1 - Se cambia el tipo de dato al atributo full_article para que acepte
 *                                          numeros decimales.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using SINCECOMP.FNB.DAL;
using OpenSystems.Common.Util;

namespace SINCECOMP.FNB.Entities
{
    class PromissoryPagare
    {

        /*Deudor*/
        private Int64 promissory_id;
        private String debtorname;
        private String holder_bill;
        private String identification;
        private String forwardingplace;
        private DateTime forwardingdate;
        private String gender;
        private String civil_state_id;
        private DateTime birthdaydate;
        private String school_degree_;
        private String address_id;
        private String neighborthood_id;
        private String city;
        private String department;
        private String propertyphone_id;
        private string dependentsnumber;
        private String housingtype;
        private Int64 housingmonth;
        private String holderrelation;
        private String occupation;
        private String companyname;
        private String companyaddress_id;
        private String phone1_id;
        private String phone2_id;
        private String movilphone_id;
        private string oldlabor;
        private String activity;
        private Int64 monthlyincome;
        private Int64 expensesincome;
        private String commerreference;
        private String phonecommrefe;
        private String movilphocommrefe;
        private String addresscommrefe;
        private String familiarreference;
        private String phonefamirefe;
        private String movilphofamirefe;
        private String addressfamirefe;
        //personalreference;
        //phonepersrefe;
        //movilphopersrefe;
        //addresspersrefe;
        private String email;
        private String package_id;
        //promissory_type;
        private String digital_prom_note_cons;
        private String request_date_dd;
        private String request_date_mm;
        private String request_date_yyyy;
        private String effective_date;
        private String person_id;
        private String article_id;
        private String reference;
        private String description;
        private String amount;
        private Double unit_value;
        private Double full_article;
        private String payment;
        private String discount;
        private String subtotal;
        private String fund_value;
        private String number_shares;
        private String subscriber_name;
        private String contract_type_id;
   
        private Int64 subscription_id;  // Contrato
        private Double rem_interest;   // Interés remuneratorio
        private Double def_interest;   // Interés mora
        private Double max_interest;   // Interés máximo legal
        private Double tot_sale_value; // Valor
        private String sale_reg_date;  // Fecha otorgamiento
        private String loan_fin_date;  // Fecha vencimiento

        private String typePrint;

        public String Package_id
        {
            get { return package_id; }
            set { package_id = value; }
        }

        public String Contract_type_id
        {
            get { return contract_type_id; }
            set { contract_type_id = value; }
        }

        public Int64 Promissory_id
        {
            get { return promissory_id; }
            set { promissory_id = value; }
        }

        public String Holder_bill
        {
            get { return holder_bill; }
            set { holder_bill = value; }
        }
        public String Debtorname
        {
            get { return debtorname; }
            set { debtorname = value; }
        }
        public String Identification
        {
            get { return identification; }
            set { identification = value; }
        }
        public String Forwardingplace
        {
            get { return forwardingplace; }
            set { forwardingplace = value; }
        }
        public DateTime Forwardingdate
        {
            get { return forwardingdate; }
            set { forwardingdate = value; }
        }
        public String Gender
        {
            get { return gender; }
            set { gender = value; }
        }
        public String Civil_state_id
        {
            get { return civil_state_id; }
            set { civil_state_id = value; }
        }
        public DateTime Birthdaydate
        {
            get { return birthdaydate; }
            set { birthdaydate = value; }
        }
        public String School_degree_
        {
            get { return school_degree_; }
            set { school_degree_ = value; }
        }
        public String Address_id
        {
            get { return address_id; }
            set { address_id = value; }
        }
        public String Neighborthood_id
        {
            get { return neighborthood_id; }
            set { neighborthood_id = value; }
        }
        public String City
        {
            get { return city; }
            set { city = value; }
        }
        public String Department
        {
            get { return department; }
            set { department = value; }
        }
        public String Propertyphone_id
        {
            get { return propertyphone_id; }
            set { propertyphone_id = value; }
        }
        public string Dependentsnumber
        {
            get { return dependentsnumber; }
            set { dependentsnumber = value; }
        }
        public String Housingtype
        {
            get { return housingtype; }
            set { housingtype = value; }
        }
        public Int64 Housingmonth
        {
            get { return housingmonth; }
            set { housingmonth = value; }
        }
        public String Holderrelation
        {
            get { return holderrelation; }
            set { holderrelation = value; }
        }
        public String Occupation
        {
            get { return occupation; }
            set { occupation = value; }
        }
        public String Companyname
        {
            get { return companyname; }
            set { companyname = value; }
        }
        public String Companyaddress_id
        {
            get { return companyaddress_id; }
            set { companyaddress_id = value; }
        }
        public String Phone1_id
        {
            get { return phone1_id; }
            set { phone1_id = value; }
        }
        public String Phone2_id
        {
            get { return phone2_id; }
            set { phone2_id = value; }
        }
        public String Movilphone_id
        {
            get { return movilphone_id; }
            set { movilphone_id = value; }
        }
        public string Oldlabor
        {
            get { return oldlabor; }
            set { oldlabor = value; }
        }
        public String Activity
        {
            get { return activity; }
            set { activity = value; }
        }
        public Int64 Monthlyincome
        {
            get { return monthlyincome; }
            set { monthlyincome = value; }
        }
        public Int64 Expensesincome
        {
            get { return expensesincome; }
            set { expensesincome = value; }
        }
        public String Commerreference
        {
            get { return commerreference; }
            set { commerreference = value; }
        }
        public String Phonecommrefe
        {
            get { return phonecommrefe; }
            set { phonecommrefe = value; }
        }
        public String Movilphocommrefe
        {
            get { return movilphocommrefe; }
            set { movilphocommrefe = value; }
        }
        public String Addresscommrefe
        {
            get { return addresscommrefe; }
            set { addresscommrefe = value; }
        }
        public String Familiarreference
        {
            get { return familiarreference; }
            set { familiarreference = value; }
        }
        public String Phonefamirefe
        {
            get { return phonefamirefe; }
            set { phonefamirefe = value; }
        }
        public String Movilphofamirefe
        {
            get { return movilphofamirefe; }
            set { movilphofamirefe = value; }
        }
        public String Addressfamirefe
        {
            get { return addressfamirefe; }
            set { addressfamirefe = value; }
        }
        public String Digital_prom_note_cons
        {
            get { return digital_prom_note_cons; }
            set { digital_prom_note_cons = value; }
        }
        public String Request_date_dd
        {
            get { return request_date_dd; }
            set { request_date_dd = value; }
        }
        public String Request_date_mm
        {
            get { return request_date_mm; }
            set { request_date_mm = value; }
        }
        public String Request_date_yyyy
        {
            get { return request_date_yyyy; }
            set { request_date_yyyy = value; }
        }
        public String Effective_date
        {
            get { return effective_date; }
            set { effective_date = value; }
        }
        public String Person_id
        {
            get { return person_id; }
            set { person_id = value; }
        }
        public String Article_id
        {
            get { return article_id; }
            set { article_id = value; }
        }
        public String Reference
        {
            get { return reference; }
            set { reference = value; }
        }
        public String Description
        {
            get { return description; }
            set { description = value; }
        }
        public String Amount
        {
            get { return amount; }
            set { amount = value; }
        }
        public Double Unit_value
        {
            get { return unit_value; }
            set { unit_value = value; }
        }
        public Double Full_article
        {
            get { return full_article; }
            set { full_article = value; }
        }
        public String Payment
        {
            get { return payment; }
            set { payment = value; }
        }
        public String Discount
        {
            get { return discount; }
            set { discount = value; }
        }
        public String Subtotal
        {
            get { return subtotal; }
            set { subtotal = value; }
        }
        public String Fund_value
        {
            get { return fund_value; }
            set { fund_value = value; }
        }
        public String Number_shares
        {
            get { return number_shares; }
            set { number_shares = value; }
        }
        public String Subscriber_name
        {
            get { return subscriber_name; }
            set { subscriber_name = value; }
        }
        public String Email
        {
            get { return email; }
            set { email = value; }
        }
        /*FIN Deudor*/

        /*Codeudor*/
        private String cosigner_promissory_id;
        private String cosigner_debtorname;
        private String cosigner_holder_bill;
        private String cosigner_identification;
        private String cosigner_forwardingplace;
        private String cosigner_forwardingdate;
        private String cosigner_gender;
        private String cosigner_civil_state_id;
        private String cosigner_birthdaydate;
        private String cosigner_school_degree_;
        private String cosigner_address_id;
        private String cosigner_neighborthood_id;
        private String cosigner_city;
        private String cosigner_department;
        private String cosigner_propertyphone_id;
        private String cosigner_dependentsnumber;
        private String cosigner_housingtype;
        private String cosigner_housingmonth;
        private String cosigner_holderrelation;
        private String cosigner_occupation;
        private String cosigner_companyname;
        private String cosigner_companyaddress_id;
        private String cosigner_phone1_id;
        private String cosigner_phone2_id;
        private String cosigner_movilphone_id;
        private String cosigner_oldlabor;
        private String cosigner_activity;
        private String cosigner_monthlyincome;
        private String cosigner_expensesincome;
        private String cosigner_commerreference;
        private String cosigner_phonecommrefe;
        private String cosigner_movilphocommrefe;
        private String cosigner_addresscommrefe;
        private String cosigner_familiarreference;
        private String cosigner_phonefamirefe;
        private String cosigner_movilphofamirefe;
        private String cosigner_addressfamirefe;
        //personalreference;
        //phonepersrefe;
        //movilphopersrefe;
        //addresspersrefe;
        //email;
        //package_id;
        //promissory_type;
        //cosigner_digital_prom_note_cons;
        /**/

        //EVESAN 17/Julio/2013
        private String identificationtype;
        public String IdentificationType
        {
            get { return identificationtype; }
            set { identificationtype = value; }
        }
        private String cosigner_identificationtype;
        public String cosigner_IdentificationType
        {
            get { return cosigner_identificationtype; }
            set { cosigner_identificationtype = value; }
        }
        private String estrato_deudor;
        public String Estrato_Deudor
        {
            get { return estrato_deudor; }
            set { estrato_deudor = value; }
        }
        private String estrato_codeudor;
        public String Estrato_Codeudor
        {
            get { return estrato_codeudor; }
            set { estrato_codeudor = value; }
        }

        private String valor_aprox_cuota_mensual;
        public String Valor_aprox_cuota_mensual
        {
            get { return valor_aprox_cuota_mensual; }
            set { valor_aprox_cuota_mensual = value; }
        }

        private String valor_seguro;
        public String Valor_seguro
        {
            get { return valor_seguro; }
            set { valor_seguro = value; }
        }
        
        private String cosigner_Contract_type_id;

        public String Cosigner_promissory_id
        {
            get { return cosigner_promissory_id; }
            set { cosigner_promissory_id = value; }
        }

        public String Cosigner_holder_bill
        {
            get { return cosigner_holder_bill; }
            set { cosigner_holder_bill = value; }
        }
        public String Cosigner_debtorname
        {
            get { return cosigner_debtorname; }
            set { cosigner_debtorname = value; }
        }
        public String Cosigner_identification
        {
            get { return cosigner_identification; }
            set { cosigner_identification = value; }
        }
        
        public String Cosigner_forwardingplace
        {
            get { return cosigner_forwardingplace; }
            set { cosigner_forwardingplace = value; }
        }
        public String Cosigner_forwardingdate
        {
            get { return cosigner_forwardingdate; }
            set { cosigner_forwardingdate = value; }
        }
        public String Cosigner_gender
        {
            get { return cosigner_gender; }
            set { cosigner_gender = value; }
        }
        public String Cosigner_civil_state_id
        {
            get { return cosigner_civil_state_id; }
            set { cosigner_civil_state_id = value; }
        }
        public String Cosigner_birthdaydate
        {
            get { return cosigner_birthdaydate; }
            set { cosigner_birthdaydate = value; }
        }
        public String Cosigner_school_degree_
        {
            get { return cosigner_school_degree_; }
            set { cosigner_school_degree_ = value; }
        }
        public String Cosigner_address_id
        {
            get { return cosigner_address_id; }
            set { cosigner_address_id = value; }
        }
        public String Cosigner_neighborthood_id
        {
            get { return cosigner_neighborthood_id; }
            set { cosigner_neighborthood_id = value; }
        }
        public String Cosigner_city
        {
            get { return cosigner_city; }
            set { cosigner_city = value; }
        }
        public String Cosigner_department
        {
            get { return cosigner_department; }
            set { cosigner_department = value; }
        }
        public String Cosigner_propertyphone_id
        {
            get { return cosigner_propertyphone_id; }
            set { cosigner_propertyphone_id = value; }
        }
        public String Cosigner_dependentsnumber
        {
            get { return cosigner_dependentsnumber; }
            set { cosigner_dependentsnumber = value; }
        }
        public String Cosigner_housingtype
        {
            get { return cosigner_housingtype; }
            set { cosigner_housingtype = value; }
        }
        public String Cosigner_housingmonth
        {
            get { return cosigner_housingmonth; }
            set { cosigner_housingmonth = value; }
        }
        public String Cosigner_holderrelation
        {
            get { return cosigner_holderrelation; }
            set { cosigner_holderrelation = value; }
        }
        public String Cosigner_occupation
        {
            get { return cosigner_occupation; }
            set { cosigner_occupation = value; }
        }
        public String Cosigner_companyname
        {
            get { return cosigner_companyname; }
            set { cosigner_companyname = value; }
        }
        public String Cosigner_companyaddress_id
        {
            get { return cosigner_companyaddress_id; }
            set { cosigner_companyaddress_id = value; }
        }
        public String Cosigner_phone1_id
        {
            get { return cosigner_phone1_id; }
            set { cosigner_phone1_id = value; }
        }
        public String Cosigner_phone2_id
        {
            get { return cosigner_phone2_id; }
            set { cosigner_phone2_id = value; }
        }
        public String Cosigner_movilphone_id
        {
            get { return cosigner_movilphone_id; }
            set { cosigner_movilphone_id = value; }
        }
        public String Cosigner_oldlabor
        {
            get { return cosigner_oldlabor; }
            set { cosigner_oldlabor = value; }
        }
        public String Cosigner_activity
        {
            get { return cosigner_activity; }
            set { cosigner_activity = value; }
        }
        public String Cosigner_monthlyincome
        {
            get { return cosigner_monthlyincome; }
            set { cosigner_monthlyincome = value; }
        }
        public String Cosigner_expensesincome
        {
            get { return cosigner_expensesincome; }
            set { cosigner_expensesincome = value; }
        }
        public String Cosigner_commerreference
        {
            get { return cosigner_commerreference; }
            set { cosigner_commerreference = value; }
        }
        public String Cosigner_phonecommrefe
        {
            get { return cosigner_phonecommrefe; }
            set { cosigner_phonecommrefe = value; }
        }
        public String Cosigner_movilphocommrefe
        {
            get { return cosigner_movilphocommrefe; }
            set { cosigner_movilphocommrefe = value; }
        }
        public String Cosigner_addresscommrefe
        {
            get { return cosigner_addresscommrefe; }
            set { cosigner_addresscommrefe = value; }
        }
        public String Cosigner_familiarreference
        {
            get { return cosigner_familiarreference; }
            set { cosigner_familiarreference = value; }
        }
        public String Cosigner_phonefamirefe
        {
            get { return cosigner_phonefamirefe; }
            set { cosigner_phonefamirefe = value; }
        }
        public String Cosigner_movilphofamirefe
        {
            get { return cosigner_movilphofamirefe; }
            set { cosigner_movilphofamirefe = value; }
        }
        public String Cosigner_addressfamirefe
        {
            get { return cosigner_addressfamirefe; }
            set { cosigner_addressfamirefe = value; }
        }
        public String Cosigner_Contract_type_id
        {
            get { return cosigner_Contract_type_id; }
            set { cosigner_Contract_type_id = value; }
        }

        /*FIN Codeudor*/

        public String TypePrint
        {
            get { return typePrint; }
            set { typePrint = value; }
        }

        public Int64 Subscription_Id
        {
            get { return subscription_id; }
            set { subscription_id = value; }
        }

        public Double Rem_interest
        {
            get { return rem_interest; }
            set { rem_interest = value; }
        }

        public Double Def_interest
        {
            get { return def_interest; }
            set { def_interest = value; }
        }

        public Double Max_interest
        {
            get { return max_interest; }
            set { max_interest = value; }
        }

        public Double Tot_sale_value
        {
            get { return tot_sale_value; }
            set { tot_sale_value = value; }
        }

        public String Sale_reg_date
        {
            get { return sale_reg_date; }
            set { sale_reg_date = value; }
        }

        public String Loan_fin_date
        {
            get { return loan_fin_date; }
            set { loan_fin_date = value; }
        }

        /*Deudor*/
        public PromissoryPagare(DataRow row, Boolean blControl, String Printer)
        {
            string category, subcategory;
            if (blControl == true)
            {
                Promissory_id = Convert.ToInt64(row["promissory_id"]);
                Holder_bill = Convert.ToString(row["holder_bill"]).ToUpper();
                if (String.IsNullOrEmpty(Holder_bill.ToString()) == false)
                {
                    if (Holder_bill == "Y")
                    {
                        Holder_bill = "SI";
                    }
                    else
                    {
                        Holder_bill = "NO";
                    }
                }
                else
                {
                    Holder_bill = null;
                }
                                
                /**/
                Debtorname = Convert.ToString(row["debtorname"]);
                IdentificationType = row["ident_type_id"].ToString();
                Identification = Convert.ToString(row["identification"]);
                Forwardingplace = Convert.ToString(row["forwardingplace"]);
                Forwardingdate = Convert.ToDateTime(row["forwardingdate"]);
                Gender = Convert.ToString(row["gender"]);
                Civil_state_id = Convert.ToString(row["civil_state_id"]);
                Birthdaydate = Convert.ToDateTime(row["birthdaydate"]);
                School_degree_ = Convert.ToString(row["school_degree_"]);
                Address_id = Convert.ToString(row["address_id"]);
                Neighborthood_id = Convert.ToString(row["neighborthood_id"]);
                City = Convert.ToString(row["city"]);
                Department = Convert.ToString(row["department"]);
                Propertyphone_id = Convert.ToString(row["propertyphone_id"]);
                Dependentsnumber = OpenConvert.ToString(row["DEU_PERSONAS_CARGO"]);
                Housingtype = Convert.ToString(row["housingtype"]);
                category = OpenConvert.ToString(row["categoria"]);
                subcategory = OpenConvert.ToString(row["subcategoria"]);
                if(category != string.Empty || subcategory != string.Empty)
                {
                    Estrato_Deudor = category + " - " + subcategory;
                }                
                Housingmonth = Convert.ToInt64(row["housingmonth"]);
                Holderrelation = Convert.ToString(row["holderrelation"]);
                
                if (Holderrelation == "1")
                {
                    Holderrelation = "Conyuge";
                }
                else
                {
                    if (Holderrelation == "2")
                    {
                        Holderrelation = "Hijo";
                    }
                    else
                    {
                        if (Holderrelation == "3")
                        {
                            Holderrelation = "Padre/madre";
                        }
                        else
                        {
                            if (Holderrelation == "4")
                            {
                                Holderrelation = "Familiar";
                            }
                            else
                            {
                                if (Holderrelation == "5")
                                {
                                    Holderrelation = "Arrendatario";
                                }
                                else
                                {
                                    if (Holderrelation == "6")
                                    {
                                        Holderrelation = "Amigo";
                                    }
                                    else
                                    {
                                        if (String.IsNullOrEmpty(Holderrelation) == false)
                                        {
                                            Holderrelation = "Otro";
                                        }
                                        else
                                        {
                                            Holderrelation = null;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Occupation = Convert.ToString(row["occupation"]);
                Companyname = Convert.ToString(row["companyname"]);
                Companyaddress_id = Convert.ToString(row["companyaddress_id"]);
                Phone1_id = Convert.ToString(row["phone1_id"]);
                Phone2_id = Convert.ToString(row["phone2_id"]);
                Movilphone_id = Convert.ToString(row["movilphone_id"]);
                Email = Convert.ToString(row["email"]);
                Contract_type_id = string.IsNullOrEmpty(row["contract_type_id"].ToString()) ? "" : Convert.ToString(row["contract_type_id"]); //Convert.ToString(row["contract_type_id"]);
                if (Contract_type_id == "1")
                {
                    Contract_type_id = "Indefinido";
                }
                else
                {
                    if (Contract_type_id == "2")
                    {
                        Contract_type_id = "Temporal";
                    }
                    else
                    {
                        if (Contract_type_id == "3")
                        {
                            Contract_type_id = "Fijo";
                        }
                        else
                        {
                            if (String.IsNullOrEmpty(Contract_type_id) == false)
                            {
                                Contract_type_id = "Otro";
                            }
                            else
                            {
                                Contract_type_id = null;
                            }
                        }

                    }
                }                
                
                Oldlabor = OpenConvert.ToString(row["oldlabor"]);
                Activity = Convert.ToString(row["activity"]);
                Monthlyincome = Convert.ToInt64(row["monthlyincome"]);
                Expensesincome = Convert.ToInt64(row["expensesincome"]);
                Familiarreference = Convert.ToString(row["familiarreference"]);
                Phonefamirefe = Convert.ToString(row["phonefamirefe"]);
                Movilphofamirefe = Convert.ToString(row["movilphofamirefe"]);
                Addressfamirefe = Convert.ToString(row["addressfamirefe"]);
                Commerreference = Convert.ToString(row["commerreference"]);
                Phonecommrefe = Convert.ToString(row["phonecommrefe"]);
                Movilphocommrefe = Convert.ToString(row["movilphocommrefe"]);
                Addresscommrefe = Convert.ToString(row["addresscommrefe"]);                
                
                Digital_prom_note_cons = Convert.ToString(row["digital_prom_note_cons"]);
                Request_date_dd = Convert.ToString(row["request_date"]).Substring(0, 2);
                Request_date_mm = Convert.ToString(row["request_date"]).Substring(3, 2);
                Request_date_yyyy = Convert.ToString(row["request_date"]).Substring(6, 4);
                Effective_date = Convert.ToString(row["effective_date"]).Substring(0, 10);
                Person_id = Convert.ToString(row["person_id"]);
                
                Article_id = Convert.ToString(row["article_id"]);
                Reference = Convert.ToString(row["reference"]);
                Description = Convert.ToString(row["description"]);
                Amount = Convert.ToString(row["amount"]);
                Unit_value = Convert.ToDouble(row["unit_value"]);
                Full_article = Convert.ToDouble(Amount) * Convert.ToDouble(Unit_value);
                Number_shares = Convert.ToString(row["quotas_number"]);
                Payment = Convert.ToString(row["payment"]);
                Discount = null;//Por ahora esto no se usa //EveSan
                Subtotal = null;//Por ahora esto no se usa //EveSan
                Subscriber_name = Convert.ToString(row["subscriber_name"]);

                Package_id = Convert.ToString(row["package_id"]);

                Subscription_Id = Convert.ToInt64(row["Subscription_id"]);
                Rem_interest = Convert.ToDouble(row["rem_interest"]);
                Max_interest = Convert.ToDouble(row["max_interest"]);
                Tot_sale_value = Convert.ToDouble(row["tot_sale_value"]);
                Sale_reg_date = Convert.ToString(row["request_date"]).Substring(0, 10);
                Loan_fin_date = Convert.ToString(row["loan_fin_date"]).Substring(0, 10);

                //DataTable TBArticle = DALFIFAP.FtrfArticle(Convert.ToInt64(Package_id));

                //Int64 nuAmountArticle = 1;

                //if (TBArticle != null)
                //{
                //    foreach (DataRow rowarticle in TBArticle.Rows)
                //    {
                //        if (nuAmountArticle == 1)
                //        {
                //            //Articulo 1
                //            Article_id1 = Convert.ToString(rowarticle["article_id"]);
                //            Reference1 = Convert.ToString(rowarticle["reference"]);
                //            Description1 = Convert.ToString(rowarticle["description"]);
                //            Amount1 = Convert.ToString(rowarticle["amount"]);
                //            Unit_value1 = Convert.ToString(rowarticle["unit_value"]);
                //            Full_article1 = Convert.ToString(Convert.ToInt64(Amount1) * Convert.ToInt64(Unit_value1));
                //            Number_shares1 = Convert.ToString(rowarticle["quotas_number"]);
                //            Subtotal = Full_article1;
                //        }
                //        else
                //        {
                //            if (nuAmountArticle == 2)
                //            {
                //                //Articulo 2
                //                Article_id2 = Convert.ToString(rowarticle["article_id"]);
                //                Reference2 = Convert.ToString(rowarticle["reference"]);
                //                Description2 = Convert.ToString(rowarticle["description"]);
                //                Amount2 = Convert.ToString(rowarticle["amount"]);
                //                Unit_value2 = Convert.ToString(rowarticle["unit_value"]);
                //                Full_article2 = Convert.ToString(Convert.ToInt64(Amount2) * Convert.ToInt64(Unit_value2));
                //                Number_shares2 = Convert.ToString(rowarticle["quotas_number"]);
                //                Subtotal = Convert.ToString(Convert.ToInt64(Subtotal) + Convert.ToInt64(Full_article2));

                //            }
                //            else
                //            {
                //                if (nuAmountArticle == 3)
                //                {
                //                    //Articulo 3
                //                    Article_id3 = Convert.ToString(rowarticle["article_id"]);
                //                    Reference3 = Convert.ToString(rowarticle["reference"]);
                //                    Description3 = Convert.ToString(rowarticle["description"]);
                //                    Amount3 = Convert.ToString(rowarticle["amount"]);
                //                    Unit_value3 = Convert.ToString(rowarticle["unit_value"]);
                //                    Full_article3 = Convert.ToString(Convert.ToInt64(Amount3) * Convert.ToInt64(Unit_value3));
                //                    Number_shares3 = Convert.ToString(rowarticle["quotas_number"]);
                //                    Subtotal = Convert.ToString(Convert.ToInt64(Subtotal) + Convert.ToInt64(Full_article3));
                //                }
                //                else
                //                {
                //                    //Articulo 4
                //                    Article_id4 = Convert.ToString(rowarticle["article_id"]);
                //                    Reference4 = Convert.ToString(rowarticle["reference"]);
                //                    Description4 = Convert.ToString(rowarticle["description"]);
                //                    Amount4 = Convert.ToString(rowarticle["amount"]);
                //                    Unit_value4 = Convert.ToString(rowarticle["unit_value"]);
                //                    Full_article4 = Convert.ToString(Convert.ToInt64(Amount4) * Convert.ToInt64(Unit_value4));
                //                    Number_shares4 = Convert.ToString(rowarticle["quotas_number"]);
                //                    Subtotal = Convert.ToString(Convert.ToInt64(Subtotal) + Convert.ToInt64(Full_article4));
                //                }
                //            }
                //        }
                //        nuAmountArticle = nuAmountArticle + 1;
                //    }
                //}
                //EveSan 11/Julio/2013
                //if (String.IsNullOrEmpty(Payment) == false)
                //{
                //    Fund_value = Convert.ToString(Convert.ToInt64(Fund_value) + (Convert.ToInt64(Full_article) - Convert.ToInt64(Payment)));
                //}
                //else
                //{ 
                //    Fund_value = Convert.ToString(Convert.ToInt64(Full_article));
                //}

//            }
//            else /////////////////////EVESANNNN 14/JULIO/2013
//            {


                
                Cosigner_promissory_id = Convert.ToString(row["CODE_PAGARE_ID"]);
                Cosigner_holder_bill = Convert.ToString(row["CODE_TITULAR_FACT"]);
                if (String.IsNullOrEmpty(Cosigner_holder_bill.ToString()) == false)
                {
                    if (Cosigner_holder_bill == "Y")
                    {
                        Cosigner_holder_bill = "SI";
                    }
                    else
                    {
                        Cosigner_holder_bill = "NO";
                    }
                }
                else
                {
                    Cosigner_holder_bill = null;
                }
                /*EveSan 11/Julio/2013*/
                cosigner_IdentificationType = row["C_ident_type_id"].ToString();
                Cosigner_debtorname = Convert.ToString(row["CODE_NOMBRE"]);
                Cosigner_identification = Convert.ToString(row["CODE_IDENTIFICATION"]);
                category = OpenConvert.ToString(row["C_categoria"]);
                subcategory = OpenConvert.ToString(row["C_subcategoria"]);
                if(category != string.Empty || subcategory != string.Empty)
                {
                    Estrato_Codeudor = category + " - " + subcategory;
                }                
                Cosigner_forwardingplace = Convert.ToString(row["CODE_LUGAR_EXPEDICION"]);
                Cosigner_forwardingdate = Convert.ToString(row["CODE_FECHA_EXPEDICION"]);
                Cosigner_gender = Convert.ToString(row["CODE_GENERO"]);
                Cosigner_civil_state_id = Convert.ToString(row["CODE_ESTADO_CIVIL"]);
                Cosigner_birthdaydate = Convert.ToString(row["CODE_FEC_NAC"]);
                Cosigner_school_degree_ = Convert.ToString(row["CODE_NIVEL_ESTUDIO"]);
                Cosigner_address_id = Convert.ToString(row["CODE_DIRECCION"]);
                Cosigner_neighborthood_id = Convert.ToString(row["CODE_BARRIO"]);
                Cosigner_city = Convert.ToString(row["CODE_CIUDAD"]);
                Cosigner_department = Convert.ToString(row["CODE_DEPARTAMENTO"]);
                Cosigner_propertyphone_id = Convert.ToString(row["CODE_TELEFONO"]);
                Cosigner_dependentsnumber = Convert.ToString(row["CODE_PERSONAS_CARGO"]);
                Cosigner_housingtype = Convert.ToString(row["CODE_TIPO_VIVI"]);
                Cosigner_housingmonth = Convert.ToString(row["CODE_ANTIGUEDAD"]);
                Cosigner_holderrelation = Convert.ToString(row["CODE_RELAC_TITU"]);
                                
                if (Cosigner_holderrelation == "1")
                {
                    Cosigner_holderrelation = "Conyuge";
                }
                else
                {
                    if (Cosigner_holderrelation == "2")
                    {
                        Cosigner_holderrelation = "Hijo";
                    }
                    else
                    {
                        if (Cosigner_holderrelation == "3")
                        {
                            Cosigner_holderrelation = "Padre/madre";
                        }
                        else
                        {
                            if (Cosigner_holderrelation == "4")
                            {
                                Cosigner_holderrelation = "Familiar";
                            }
                            else
                            {
                                if (Cosigner_holderrelation == "5")
                                {
                                    Cosigner_holderrelation = "Arrendatario";
                                }
                                else
                                {
                                    if (Cosigner_holderrelation == "6")
                                    {
                                        Cosigner_holderrelation = "Amigo";
                                    }
                                    else
                                    {
                                        if (String.IsNullOrEmpty(Cosigner_holderrelation) == false)
                                        {
                                            Cosigner_holderrelation = "Otro";
                                        }
                                        else
                                        {
                                            Cosigner_holderrelation = null;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Cosigner_occupation = Convert.ToString(row["CODE_OCUPACION"]);
                Cosigner_companyname = Convert.ToString(row["CODE_NOMBRE_EMPRESA"]);
                Cosigner_companyaddress_id = Convert.ToString(row["CODE_DIRECC_EMPRESA"]);
                Cosigner_phone1_id = Convert.ToString(row["CODE_TEL1"]);
                Cosigner_phone2_id = Convert.ToString(row["CODE_TEL2"]);
                Cosigner_movilphone_id = Convert.ToString(row["CODE_CELULAR"]);
                Cosigner_oldlabor = Convert.ToString(row["CODE_TIPO_CONTRATO"]);
                Cosigner_activity = Convert.ToString(row["CODE_ACTI"]);
                Cosigner_monthlyincome = Convert.ToString(row["CODE_INGRESO_MENSUAL"]);
                Cosigner_expensesincome = Convert.ToString(row["C_expensesincome"]);
                Cosigner_commerreference = Convert.ToString(row["C_commerreference"]);
                Cosigner_phonecommrefe = Convert.ToString(row["C_phonecommrefe"]);
                Cosigner_movilphocommrefe = Convert.ToString(row["C_movilphocommrefe"]);
                Cosigner_addresscommrefe = Convert.ToString(row["C_addresscommrefe"]);
                Cosigner_familiarreference = Convert.ToString(row["C_familiarreference"]);
                Cosigner_phonefamirefe = Convert.ToString(row["C_phonefamirefe"]);
                Cosigner_movilphofamirefe = Convert.ToString(row["C_movilphofamirefe"]);
                Cosigner_addressfamirefe = Convert.ToString(row["C_addressfamirefe"]);
                Cosigner_Contract_type_id = Convert.ToString(row["C_contract_type_id"]);
                if (Cosigner_Contract_type_id == "1")
                {
                    Cosigner_Contract_type_id = "Indefinido";
                }
                else
                {
                    if (Cosigner_Contract_type_id == "2")
                    {
                        Cosigner_Contract_type_id = "Temporal";
                    }
                    else
                    {
                        if (Cosigner_Contract_type_id == "3")
                        {
                            Cosigner_Contract_type_id = "Fijo";
                        }
                        else
                        {
                            if (String.IsNullOrEmpty(Cosigner_Contract_type_id) == false)
                            {
                                Cosigner_Contract_type_id = "Otro";
                            }
                            else
                            {
                                Cosigner_Contract_type_id = null;
                            }
                        }

                    }
                }

                Valor_aprox_cuota_mensual = Convert.ToString(row["cuota_mensual_aprox"]);
                Valor_seguro = Convert.ToString(row["valor_seguro"]);

            }
            TypePrint = Printer;
        }
    }
}
