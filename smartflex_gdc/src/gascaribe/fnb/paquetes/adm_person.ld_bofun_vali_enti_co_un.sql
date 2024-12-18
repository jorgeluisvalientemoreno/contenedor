CREATE OR REPLACE PACKAGE adm_person.LD_BOFun_Vali_Enti_Co_Un
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad        : LD_Validate_Tables_Co_Un
Descripcion   : Paquete para la validación de las tablas de Unidades constructivas para las LDC

Parametro      Descripcion
============  ==============================

Historia de Modificaciones
Fecha                   Autor            Modificacion
====================   =========        ====================
15/07/2024              PAcosta           OSF-2885: Cambio de esquema ADM_PERSON  
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
****************************************************************/

/*Public function and procedure declarations*/

/*Function FnuVali_co_un_tk_tp. Función que valida si un registro existe en la tabla LD_Co_Un_Task_Type*/
  Function FnuVali_co_un_tk_tp(
    inuId                 In LD_Co_Un_Task_Type.Co_Un_Task_Type_Id%type,
    inuTask_Type          In LD_Co_Un_Task_Type.Task_Type_Id%type
    )
    Return Number;
  /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Re_Ma_Ge_Lo
  Descripción   : Función que valida si un registro existe en la
                  tabla LD_Rel_Mar_Geo_Loc

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/
  Function FnuVali_Re_Ma_Ge_Lo(
    inuId                  In LD_Rel_Mar_Geo_Loc.Rel_Mar_Geo_Loc_Id%type,
    inuRelevant_Market_Id  In LD_Rel_Mar_Geo_Loc.Relevant_Market_Id%type,
    inuGeograp_Location_Id In LD_Rel_Mar_Geo_Loc.Geograp_Location_Id%type
    )
    Return Number;

  /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Rel_Mar_rate
  Descripción   : Función que valida si un registro existe en la
                  tabla LD_Rel_Market_Rate

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/
  Function FnuVali_Rel_Mar_rate(
    inuId                   In Ld_Rel_Market_Rate.Rel_Market_Rate_Id%type,
    inuRelevant_Market_Id   In Ld_Rel_Market_Rate.Relevant_Market_Id%type,
    inuYear                 In Ld_Rel_Market_Rate.Year%type,
    inuMonth                In Ld_Rel_Market_Rate.Month%type
    )
    Return Number;

  /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Rel_Mar_Budget
  Descripción   : Función que valida si un registro existe en la
                  tabla Ld_Rel_Mark_Budget

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/
  Function FnuVali_Rel_Mar_Budget(
     inuId                  in Ld_Rel_Mark_Budget.Rel_Mark_Budget_Id%type,
     inuRelevant_Market_Id  in Ld_Rel_Mark_Budget.Relevant_Market_Id%type,
     inuGeograp_Location_Id in Ld_Rel_Mark_Budget.Geograp_Location_Id%type,
     inuYear                in Ld_Rel_Mark_Budget.Year%type,
     inuMonth               in Ld_Rel_Mark_Budget.Month%type
  )
    Return Number;

 /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Con_Uni_Budget
  Descripción   : Función que valida si un registro existe en la
                  tabla Ld_Con_Uni_Budget

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/
  Function FnuVali_Con_Uni_Budget(
     inuId                  in Ld_Con_Uni_Budget.Con_Uni_Budget_Id%type,
     inuRel_Mark_Budget_Id  in Ld_Con_Uni_Budget.Rel_Mark_Budget_Id%type,
     inuConstruct_Unit_Id   in Ld_Con_Uni_Budget.Construct_Unit_Id%type
  )
    Return Number;

/***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVal_Amo_Leg_Fields
  Descripción   : Función que valida:
                a). Cuando se ingresa cantidad presupuestada (Amount,
                pero no se ingresa el valor Presupuestado y viceversa

                b). Cuando se ingresa Cantidad Legalizada (Amount Executed,
                perono se ingresa el valor de lo legalizado y viceversa en
                la tabla Ld_Con_Uni_Budget.

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 06/02/2013

  Parámetro      Descripción
  ============  ==============================
   InuAmount             Campo con la cantidad presupuestada
   InuValue_Budget_Cop   Campo con el Valor de lo Preseupuestado
   InuAmount_Executed    Campo con Cantidad ejecutada o legalizada
   InuValue_Executed     Campo con el valor de lo legalizado

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  06/02/2013             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/

  Function FnuVal_Amo_Leg_Fields(InuId                 in Ld_Con_Uni_Budget.Con_Uni_Budget_Id%type,
                                 InuAmount             in Ld_Con_Uni_Budget.Amount%type,
                                 InuValue_Budget_Cop   in Ld_Con_Uni_Budget.Value_Budget_Cop%type,
                                 InuAmount_Executed    in Ld_Con_Uni_Budget.Amount_Executed%type,
                                 InuValue_Executed     in Ld_Con_Uni_Budget.Value_Executed%type
                                 )

    Return Number;

 /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Service_Budget
  Descripción   : Función que valida si un registro existe en la
                  tabla Ld_Service_Budget

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/
  Function FnuVali_Service_Budget(
     inuId                  in Ld_Service_Budget.Service_Budget_Id%type,
     inuRel_Mark_Budget_Id  in Ld_Service_Budget.Rel_Mark_Budget_Id%type,
     inuCatecodi            in Ld_Service_Budget.Catecodi%type,
     inuSucacodi            in Ld_Service_Budget.Sucacodi%type
  )
    Return Number;

  /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Demand_Budget
  Descripción   : Función que valida si un registro existe en la
                  tabla Ld_Demand_Budget

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/
  Function FnuVali_Demand_Budget(
     inuId                  in Ld_Demand_Budget.Demand_Budget_Id%type,
     inuRel_Mark_Budget_Id  in Ld_Demand_Budget.Rel_Mark_Budget_Id%type,
     inuCatecodi            in Ld_Demand_Budget.Catecodi%type,
     inuSucacodi            in Ld_Demand_Budget.Sucacodi%type
  )
    Return Number;

  /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Dis_Exp_Budget
  Descripción   : Función que valida si un registro existe en la
                  tabla Ld_Dis_Exp_Budget

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/
  Function FnuVali_Dis_Exp_Budget(
     inuId                  in Ld_Dis_Exp_budget.Dis_Exp_budget_id%type,
     inuRel_Mark_Budget_Id  in Ld_Dis_Exp_budget.Rel_Mark_Budget_Id%type
  )
    Return Number;

 /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Mar_Exp_Budget
  Descripción   : Función que valida si un registro existe en la
                  tabla Ld_Mar_Exp_Budget

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/
  Function FnuVali_Mar_Exp_Budget(
     inuId                  in Ld_Mar_Exp_budget.Mar_Exp_budget_id%type,
     inuRel_Mark_Budget_Id  in Ld_Mar_Exp_budget.Rel_Mark_Budget_Id%type
  )
    Return Number;

END LD_BOFun_Vali_Enti_Co_Un;
/
CREATE OR REPLACE Package Body adm_person.LD_BOFun_Vali_Enti_Co_Un As
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad        : LD_BOFun_Vali_Enti_Co_Un
Descripción   : Paquete para la validación de las Entidades del
                Proyecto Unidades constructivas para las LDC

Autor         : Evens Herard Gorut - eherard.
Fecha         : 05/10/2012

Parámetro      Descripción
============  ==============================

Historia de Modificaciones
Fecha                  Autor                 Modificación
====================   =========            ====================
05/10/2012             eherard.<SAO156931>  Creación del paquete
****************************************************************/


/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad        : FnuVali_co_un_tk_tp
Descripción   : Función que valida si un registro existe en la
                tabla LD_Co_Un_Task_Type

Autor         : Evens Herard Gorut - eherard.
Fecha         : 05/10/2012

Parámetro      Descripción
============  ==============================

Historia de Modificaciones
Fecha                  Autor                 Modificación
====================   =========            ====================
05/10/2012             eherard.<SAO156931>  Creación del paquete
****************************************************************/
  Function FnuVali_co_un_tk_tp(
                              inuId In LD_Co_Un_Task_Type.Co_Un_Task_Type_Id%type,
                              inuTask_Type In LD_Co_Un_Task_Type.Task_Type_Id%type
                               )
    Return Number is
    /******************************************
        Declaración de variables y Constantes
    ******************************************/
    nuvalexist  number;

  begin
    /*Recorrer la tabla*/
     SELECT count (1) into nuValexist
     FROM LD_Co_Un_Task_Type
     WHERE Co_Un_Task_Type_Id != InuId
     AND Task_Type_Id = inuTask_Type;

     Return nuValexist;

      EXCEPTION
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
   End;

 /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Re_Ma_Ge_Lo
  Descripción   : Función que valida si un registro existe en la
                  tabla LD_Rel_Mar_Geo_Loc

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/

  Function FnuVali_Re_Ma_Ge_Lo(
    inuId In LD_Rel_Mar_Geo_Loc.Rel_Mar_Geo_Loc_Id%type,
    inuRelevant_Market_Id In LD_Rel_Mar_Geo_Loc.Relevant_Market_Id%type,
    inuGeograp_Location_Id In LD_Rel_Mar_Geo_Loc.Geograp_Location_Id%type
    )
    Return Number is

    /******************************************
        Declaración de variables y Constantes
    ******************************************/
    nuvalexist  number;

  begin
    /*Recorrer la tabla*/
     SELECT count (1) into nuValexist
     FROM LD_Rel_Mar_Geo_Loc
     WHERE Rel_Mar_Geo_Loc_Id != InuId
     AND Relevant_Market_Id  = inuRelevant_Market_Id
     AND Geograp_Location_Id = inuGeograp_Location_Id;

     Return nuValexist;

      EXCEPTION
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
   End;

  /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Rel_Mar_rate
  Descripción   : Función que valida si un registro existe en la
                  tabla LD_Rel_Market_Rate

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/

  Function FnuVali_Rel_Mar_rate(
    inuId In Ld_Rel_Market_Rate.Rel_Market_Rate_Id%type,
    inuRelevant_Market_Id In Ld_Rel_Market_Rate.Relevant_Market_Id%type,
    inuYear  In Ld_Rel_Market_Rate.Year%type,
    inuMonth In Ld_Rel_Market_Rate.Month%type
    )
    Return Number is

    /******************************************
        Declaración de variables y Constantes
    ******************************************/
    nuvalexist  number;

  begin
    /*Recorrer la tabla*/
     SELECT count (1) into nuValexist
     FROM Ld_Rel_Market_Rate
     WHERE Rel_Market_Rate_Id != InuId
     AND Relevant_Market_Id  = inuRelevant_Market_Id
     AND Year = inuYear
     AND Month = inuMonth;

     Return nuValexist;

      EXCEPTION
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
   End;

  /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Rel_Mar_Budget
  Descripción   : Función que valida si un registro existe en la
                  tabla Ld_Rel_Mark_Budget

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/

   Function FnuVali_Rel_Mar_Budget(
     inuId                  in Ld_Rel_Mark_Budget.Rel_Mark_Budget_Id%type,
     inuRelevant_Market_Id  in Ld_Rel_Mark_Budget.Relevant_Market_Id%type,
     inuGeograp_Location_Id in Ld_Rel_Mark_Budget.Geograp_Location_Id%type,
     inuYear                in Ld_Rel_Mark_Budget.Year%type,
     inuMonth               in Ld_Rel_Mark_Budget.Month%type
    )
    Return Number is

    /******************************************
     Declaración de variables y Constantes
    ******************************************/
    nuvalexist  number;

  begin
    /*Recorrer la tabla*/
     SELECT count (1) into nuValexist
     FROM Ld_Rel_Mark_Budget
     WHERE Rel_Mark_Budget_Id != InuId
     AND Relevant_Market_Id  = inuRelevant_Market_Id
     AND Geograp_Location_Id = inuGeograp_Location_Id
     AND Year = inuYear
     AND Month = inuMonth;

     Return nuValexist;

      EXCEPTION
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
   End;

 /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Con_Uni_Budget
  Descripción   : Función que valida si un registro existe en la
                  tabla Ld_Con_Uni_Budget

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/

   Function FnuVali_Con_Uni_Budget(
       inuId                  in Ld_Con_Uni_Budget.Con_Uni_Budget_Id%type,
       inuRel_Mark_Budget_Id  in Ld_Con_Uni_Budget.Rel_Mark_Budget_Id%type,
       inuConstruct_Unit_Id   in Ld_Con_Uni_Budget.Construct_Unit_Id%type
    )
    Return Number is

    /******************************************
     Declaración de variables y Constantes
    ******************************************/
    nuvalexist  number;

  begin
    /*Recorrer la tabla*/
     SELECT count (1) into nuValexist
     FROM Ld_Con_Uni_Budget
     WHERE Con_Uni_Budget_Id != InuId
     AND Rel_Mark_Budget_Id  = inuRel_Mark_Budget_Id
     AND Construct_Unit_Id = inuConstruct_Unit_Id;

     Return nuValexist;

      EXCEPTION
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
   End;

  /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVal_Amo_Leg_Fields
  Descripción   : Función que valida:
                  a). Cuando se ingresa cantidad presupuestada (Amount,
                  pero no se ingresa el valor Presupuestado y viceversa

                  b). Cuando se ingresa Cantidad Legalizada (Amount Executed,
                  perono se ingresa el valor de lo legalizado y viceversa en
                  la tabla Ld_Con_Uni_Budget.

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 06/02/2013

  Parámetro      Descripción
  ============  ==============================
   InuAmount             Campo con la cantidad presupuestada
   InuValue_Budget_Cop   Campo con el Valor de lo Preseupuestado
   InuAmount_Executed    Campo con Cantidad ejecutada o legalizada
   InuValue_Executed     Campo con el valor de lo legalizado

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  06/02/2013             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/

  Function FnuVal_Amo_Leg_Fields(InuId                 in Ld_Con_Uni_Budget.Con_Uni_Budget_Id%type,
                                 InuAmount             in Ld_Con_Uni_Budget.Amount%type,
                                 InuValue_Budget_Cop   in Ld_Con_Uni_Budget.Value_Budget_Cop%type,
                                 InuAmount_Executed    in Ld_Con_Uni_Budget.Amount_Executed%type,
                                 InuValue_Executed     in Ld_Con_Uni_Budget.Value_Executed%type
                                 )
    Return Number is

    /******************************************
     Declaración de variables y Constantes
    ******************************************/
    nuvaltoVerify  number;

  begin
    /*Verificar los valores delos campos según los casos*/
    /*Caso a).*/
    If (InuAmount = 0) and (InuValue_Budget_Cop != 0) Then
      nuvaltoVerify := ld_boconstans.cnuonenumber;
      Return nuvaltoVerify;
    Elsif (InuValue_Budget_Cop = 0) and (InuAmount != 0) Then
      nuvaltoVerify := ld_boconstans.cnutwonumber;
      Return nuvaltoVerify;
    End if;

    /*Caso b)*/
    If (InuAmount_Executed = 0) and (InuValue_Executed != 0) Then
      nuvaltoVerify := ld_boconstans.cnuthreenumber;
      Return nuvaltoVerify;
    Elsif (InuValue_Executed = 0) and (InuAmount_Executed != 0) Then
      nuvaltoVerify := ld_boconstans.cnufournumber;
      Return nuvaltoVerify;
    End if;

      Return ld_boconstans.cnuCero_Value;

      EXCEPTION
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
   End;

 /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Service_Budget
  Descripción   : Función que valida si un registro existe en la
                  tabla Ld_Service_Budget

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/

   Function FnuVali_Service_Budget(
     inuId                  in Ld_Service_Budget.Service_Budget_Id%type,
     inuRel_Mark_Budget_Id  in Ld_Service_Budget.Rel_Mark_Budget_Id%type,
     inuCatecodi            in Ld_Service_Budget.Catecodi%type,
     inuSucacodi            in Ld_Service_Budget.Sucacodi%type
    )
    Return Number is

    /******************************************
     Declaración de variables y Constantes
    ******************************************/
    nuvalexist  number;

  begin
    /*Recorrer la tabla*/
     SELECT count (1) into nuValexist
     FROM Ld_Service_Budget
     WHERE Service_Budget_Id != InuId
     AND Rel_Mark_Budget_Id  = inuRel_Mark_Budget_Id
     AND Catecodi = inuCatecodi
     AND Sucacodi = inuSucacodi;

     Return nuValexist;

      EXCEPTION
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
   End;

  /***************************************************************
  Propiedad intelectual de Sincecomp Ltda.

  Unidad        : FnuVali_Demand_Budget
  Descripción   : Función que valida si un registro existe en la
                  tabla Ld_Demand_Budget

  Autor         : Evens Herard Gorut - eherard.
  Fecha         : 05/10/2012

  Parámetro      Descripción
  ============  ==============================

  Historia de Modificaciones
  Fecha                  Autor                 Modificación
  ====================   =========            ====================
  05/10/2012             eherard.<SAO156931>  Creación del paquete
  ****************************************************************/

   Function FnuVali_Demand_Budget(
     inuId                  in Ld_Demand_Budget.Demand_Budget_Id%type,
     inuRel_Mark_Budget_Id  in Ld_Demand_Budget.Rel_Mark_Budget_Id%type,
     inuCatecodi            in Ld_Demand_Budget.Catecodi%type,
     inuSucacodi            in Ld_Demand_Budget.Sucacodi%type
    )
    Return Number is

    /******************************************
     Declaración de variables y Constantes
    ******************************************/
    nuvalexist  number;

  begin
    /*Recorrer la tabla*/
     SELECT count (1) into nuValexist
     FROM Ld_Demand_Budget
     WHERE Demand_Budget_Id != InuId
     AND Rel_Mark_Budget_Id  = inuRel_Mark_Budget_Id
     AND Catecodi = inuCatecodi
     AND Sucacodi = inuSucacodi;

     Return nuValexist;

      EXCEPTION
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
   End;

   /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.

    Unidad        : FnuVali_Dis_Exp_Budget
    Descripción   : Función que valida si un registro existe en la
                    tabla Ld_Dis_Exp_Budget

    Autor         : Evens Herard Gorut - eherard.
    Fecha         : 05/10/2012

    Parámetro      Descripción
    ============  ==============================

    Historia de Modificaciones
    Fecha                  Autor                 Modificación
    ====================   =========            ====================
    05/10/2012             eherard.<SAO156931>  Creación del paquete
    ****************************************************************/

     Function FnuVali_Dis_Exp_Budget(
          inuId                  in Ld_Dis_Exp_budget.Dis_Exp_budget_id%type,
          inuRel_Mark_Budget_Id  in Ld_Dis_Exp_budget.Rel_Mark_Budget_Id%type
      )
    Return Number is

    /******************************************
     Declaración de variables y Constantes
    ******************************************/
    nuvalexist  number;

  begin
    /*Recorrer la tabla*/
     SELECT count (1) into nuValexist
     FROM Ld_Dis_Exp_Budget
     WHERE Dis_Exp_Budget_Id != InuId
     AND Rel_Mark_Budget_Id  = inuRel_Mark_Budget_Id;

     Return nuValexist;

      EXCEPTION
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
   End;

    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.

    Unidad        : FnuVali_Mar_Exp_Budget
    Descripción   : Función que valida si un registro existe en la
                    tabla Ld_Mar_Exp_Budget

    Autor         : Evens Herard Gorut - eherard.
    Fecha         : 05/10/2012

    Parámetro      Descripción
    ============  ==============================

    Historia de Modificaciones
    Fecha                  Autor                 Modificación
    ====================   =========            ====================
    05/10/2012             eherard.<SAO156931>  Creación del paquete
    ****************************************************************/

    Function FnuVali_Mar_Exp_Budget(
     inuId                  in Ld_Mar_Exp_budget.Mar_Exp_budget_id%type,
     inuRel_Mark_Budget_Id  in Ld_Mar_Exp_budget.Rel_Mark_Budget_Id%type
    )
    Return Number is

    /******************************************
     Declaración de variables y Constantes
    ******************************************/
    nuvalexist  number;

  begin
    /*Recorrer la tabla*/
     SELECT count (1) into nuValexist
     FROM Ld_Mar_Exp_Budget
     WHERE Mar_Exp_Budget_Id != InuId
     AND Rel_Mark_Budget_Id  = inuRel_Mark_Budget_Id;

     Return nuValexist;

      EXCEPTION
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
   End;


End LD_BOFun_Vali_Enti_Co_Un;
/
PROMPT Otorgando permisos de ejecucion a LD_BOFUN_VALI_ENTI_CO_UN
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BOFUN_VALI_ENTI_CO_UN', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LD_BOFUN_VALI_ENTI_CO_UN para reportes
GRANT EXECUTE ON adm_person.LD_BOFUN_VALI_ENTI_CO_UN TO rexereportes;
/
