CREATE OR REPLACE Trigger ADM_PERSON.TRG_AFUPDATE_INCONSISTENCYDC
  After Update Of Number_Account_Reported, Id_Number, Name_Reported, Novelty_Reported, Novelty_Present, Office_Radication, City_Office_Radication, Type_Identification, Number_Identification, Number_Account, Names_, Situation_Holder, Date_Opening, Date_Expiration, Quality_Of_Debtor, Type_Obligation, Mortgage_Subsidy, Date_Subsidy, Term_Contract, Method_Payment, Frequency_Payment, Novelty, State_Origin_Account, Date_State_Origin, State_Account, Date_State_Account, Plastic_State, Plastic_State_Date, Adjective, Adjective_Date, Class_Card, Franchise, Private_Mark_Name, Type_Currency, Warranty_Type, Qualification, Breach_Probability, Age_Of_Mora, Initial_Value, Balance_Value, Available_Value, Monthly_Value, Total_Share, Shares_Canceled, Name_Office_Radication, Clause_Permanence, Date_Permanence_Clause, Payment_Deadline, Date_Of_Payment, City_Radication, City_Residence, Department_Residence, Residence_Address, Phone_Residence, Working_City, Code_Dane_Working_City, Working_Department, Working_Address, Working_Phone, Correspondence_City, Correspondence_Address, e_Mail, Cell, Destination_Suscriber, Validates_Type, Action_Type, Valid_Name, White_Space, Default_Age, Sample_Id On Ld_Inconsistency_Detai_Dc
  For Each Row
Declare
  /*Trigger para validar que los registros re- numerados no sean modificador una vez el flag de envio a centrales estén en S*/
  sbmensaje     ge_message.description%Type;
  cnuerror_2741 Number := 2741;
Begin
  pkerrors.push('Trg_Afupdate_Inconsistencydc');
  If (:new.state = 'C') Then
    sbmensaje := 'No se puede actualizar el registro. Este registro ya fué procesado y gestionado ante la central de Riesgo';
    ge_boerrors.seterrorcodeargument(cnuerror_2741, sbmensaje);
  End If;
  pkerrors.pop;
Exception
  When ex.controlled_error Then
    Raise ex.controlled_error;

  When Others Then
    errors.seterror;
    pkerrors.pop;
    Raise ex.controlled_error;
End TRG_AFUPDATE_INCONSISTENCYDC;
/
