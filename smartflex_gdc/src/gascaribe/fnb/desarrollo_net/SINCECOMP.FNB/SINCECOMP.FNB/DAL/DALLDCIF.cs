using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.DAL
{
    class DALLDCIF
    {
        public static DataTable FtrfPromissory(Int64 nuPackageId, String sbPromissoryTypeDebtor, String sbPromissoryTypeCosigner)
        {
            DataSet DSpromissory = new DataSet("promissory");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQueryFNB.ftrfpromissory"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuPackageId", DbType.Int64, nuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeDebtor", DbType.String, sbPromissoryTypeDebtor);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeCosigner", DbType.String, sbPromissoryTypeCosigner);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSpromissory, "promissory");
            }
            return DSpromissory.Tables["promissory"];
        }
        public static DataTable FtrfSaleFNB(String FindRequest)
        {
            DataSet DSSaleFNB = new DataSet("SaleFNB");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQueryFNB.frfGetSaleFNBInfo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inufindvalue", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSSaleFNB, "SaleFNB");
            }
            return DSSaleFNB.Tables["SaleFNB"];
        }
        /*public static DataTable FtrfAditional(Int64 nuPackageId, String sbPromissoryTypeDebtor, String sbPromissoryTypeCosigner)
        {
            DataSet DSpromissory = new DataSet("promissory");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQueryFNB.FtrfdATOSPromissory"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuPackageId", DbType.Int64, nuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeDebtor", DbType.String, sbPromissoryTypeDebtor);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeCosigner", DbType.String, sbPromissoryTypeCosigner);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSpromissory, "promissory");
            }
            return DSpromissory.Tables["promissory"];
        }*/


        /// <summary>
        /// Llama procedimiento para actualizar informacion del deudor o codeudor
        /// </summary>
        /// <param name="packageId">Solicitud</param>
        /// <param name="promissory">Información del deudor o codeudor</param>
        public static void EditPromissory(Int64? packageId, Promissory promissory)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.EditPromissoryData"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, packageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPromissoryType", DbType.String, promissory.PromissoryType);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtForwardingDate", DbType.DateTime, promissory.ForwardingDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbGender", DbType.String, promissory.Gender);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCivil_State_Id", DbType.Int64, promissory.CivilStateId);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtBirthdayDate", DbType.DateTime, promissory.BirthdayDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSchool_Degree_", DbType.Int64, promissory.SchoolDegree);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPropertyPhone", DbType.Int64, promissory.PropertyPhone);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuDependentsNumber", DbType.Int64, promissory.DependentsNumber);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuHousingTypeId", DbType.Int64, promissory.HousingType);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuHousingMonth", DbType.Int64, promissory.HousingMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbOccupation", DbType.String, promissory.Occupation);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbCompanyName", DbType.String, promissory.CompanyName);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhone1", DbType.Int64, promissory.Phone1);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhone2", DbType.Int64, promissory.Phone2);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbMovilPhone", DbType.Int64, promissory.MovilPhone);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOldLabor", DbType.Int64, promissory.OldLabor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuActivityId", DbType.String, promissory.Activity);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuMonthlyIncome", DbType.Double, promissory.MonthlyIncome);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuExpensesIncome", DbType.Double, promissory.ExpensesIncome);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbFamiliarReference", DbType.String, promissory.FamiliarReference);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhoneFamiRefe", DbType.String, promissory.PhoneFamiRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuMovilPhoFamiRefe", DbType.String, promissory.MovilPhoFamiRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPersonalReference", DbType.String, promissory.PersonalReference);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhonePersRefe", DbType.String, promissory.PhonePersRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbMovilPhoPersRefe", DbType.String, promissory.MovilPhoPersRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbcommerreference", DbType.String, promissory.CommercialReference);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbphonecommrefe", DbType.String, promissory.PhoneCommRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbmovilphocommrefe", DbType.String, promissory.MovilPhoCommRefe);

                //Aecheverry 210972
                Int64? contractType = null;
                if (!(promissory.ContractType == 0))
                {
                    contractType = promissory.ContractType;
                }

                OpenDataBase.db.AddInParameter(cmdCommand, "isbEmail", DbType.String, promissory.Email);                
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContractType", DbType.Int64, contractType);               

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Llama funcion para validar punto de venta actual
        /// </summary>
        /// <param name="inuPackageId">Codigo de la solicitud</param>
        public static Int64 fnuValidateContract(Int64? packageId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnuValidateContract"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, packageId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        //Inicio 200-310
        public static DataTable FRTCODEUDORACTUALIZADO(String FindRequest)
        {
            DataSet DSSaleFNB = new DataSet("GeneralFNB");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAFNB.FRTDATOSGENERALES"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inufindvalue", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSSaleFNB, "GeneralFNB");
            }
            return DSSaleFNB.Tables["GeneralFNB"];
        }
        //Fin 200-310

        //Inicio 200-854
        public static DataTable FRTDATOSPAGAREUNICO(Int64 inupackage_id)
        {
            DataSet DSPUFNB = new DataSet("DATOSPAGAREUNICO");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FRTDATOSPAGAREUNICO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inupackage_id", DbType.Int64, inupackage_id);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSPUFNB, "DATOSPAGAREUNICO");
            }
            return DSPUFNB.Tables["DATOSPAGAREUNICO"];
        }
        //Fin 200-854

        //Inicio 200-2422
        public static DataTable FRFNUDATOSCAMPANA(Int64 inupackage_id)
        {
            DataSet DSPUFNB = new DataSet("DATOSCAMPAMAFNB");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCAMPANAFNB.FNUDATOSCAMPANA"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inupackage_id", DbType.Int64, inupackage_id);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSPUFNB, "DATOSCAMPAMAFNB");
            }
            return DSPUFNB.Tables["DATOSCAMPAMAFNB"];
        }
        //Fin 200-2422

    
    }


}