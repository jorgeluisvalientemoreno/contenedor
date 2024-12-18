CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAUCHANGESTATSUSP
AFTER UPDATE ON PR_PRODUCT
REFERENCING
    OLD AS OLD
    NEW AS NEW
FOR EACH ROW
WHEN ( (new.product_status_id <> old.product_status_id) OR
       (new.suspen_ord_act_id <> old.suspen_ord_act_id) OR
       (new.suspen_ord_act_id IS NULL AND old.suspen_ord_act_id IS NOT NULL) OR
       (new.suspen_ord_act_id IS NOT NULL AND old.suspen_ord_act_id IS NULL)
     )
DECLARE
/*****************************************************************
Propiedad intelectual de gdca
Autor : Isabel Becerra
Fecha : 21.09.2022 (Fecha Creación)  N° Tiquete (OSF-556)
Nombre: TRGAUCHANGESTATSUSP
Descripción: Trigger after UPDATE sobre pr_product para guardar cambio de estado de producto y última actividad de suspensión
             en la tabla HICAESPR
Historia de Modificaciones

Fecha           Autor.                  Modificación
-----------  -------------------    -------------------------------------
21.09.2022      EDMLAR              MODIFICACION
******************************************************************/
    sbTerm	HICAESPR.HCETTERM%type ;	-- Terminal
    sbUser	HICAESPR.HCETUSUA%type ;	-- Usuario
    sbProg	HICAESPR.HCETPROG%type ;	-- Programa
    sbErrMsg	varchar2(2000);			-- Mensaje error
    nuErrCode	number;				    -- Mensaje error
    nuSequen    number;                 -- Consecutivo de la transaccion.    

Begin

    -- Se setea el trgaurChgStSuspHistory en el modulo de errores

    pkErrors.Push('TRGAUCHANGESTATSUSP');

    -- Se obtiene el usuario

    sbUser := pkGeneralServices.fsbGetUserName;

    -- Se obtiene la terminal

    sbTerm := pkGeneralServices.fsbGetTerminal;

    -- Se obtiene el programa

    sbProg := pkErrors.fsbGetApplication;

    IF sbProg IS null OR sbProg = '' THEN
        sbProg := 'CRM';
    END IF;

    -- Se obtiene consecutivo 
    select LDCI_SEQHICAESPR.NEXTVAL into nuSequen from dual;    

    -- Inserta registro en HICAESPR
    INSERT INTO HICAESPR
    (
    HCETNUSE,
    HCETSUSC,
    HCETSERV,
    HCETEPAC,
    HCETEPAN,
    HCETFECH,
    HCETUSUA,
    HCETTERM,
    HCETPROG,
    HCETACAC,
    HCETACAN,
    HCETCONS
    )
    VALUES
    (
    :new.product_id,
    :new.subscription_id,
    :old.product_type_id,
    :new.product_status_id,
    :old.product_status_id,
    sysdate,
    sbUser,
    sbTerm,
    sbProg,
    :new.suspen_ord_act_id,
    :old.suspen_ord_act_id,
    nuSequen
    );
    dbms_output.put_Line('Termina trigger TRGAUCHANGESTATSUSP');
    pkErrors.Pop;

exception
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
pkErrors.GetErrorVar( nuErrCode, sbErrMsg );
pkErrors.Pop;
raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
    when others then
pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
pkErrors.Pop;
raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
End;
/