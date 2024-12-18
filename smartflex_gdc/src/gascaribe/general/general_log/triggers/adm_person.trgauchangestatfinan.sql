CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAUCHANGESTATFINAN
AFTER UPDATE ON SERVSUSC
REFERENCING
    OLD AS OLD
    NEW AS NEW
FOR EACH ROW
WHEN ( 
       (new.sesuesfn  <> old.sesuesfn ) 
     )
DECLARE
/*****************************************************************
Propiedad intelectual de gdca
Autor : Edmundo Lara
Fecha : 21.09.2022 (Fecha Creación)  N° Tiquete (OSF-556)
Nombre: TRGAUCHANGESTATSUSP
Descripción: Trigger after UPDATE sobre servsusc para guardar cambio de estado financiero
             en la tabla HICAESPR
Historia de Modificaciones

Fecha           Autor.                  Modificación
-----------  -------------------    -------------------------------------
21.09.2022      EDMLAR              creacion
******************************************************************/
    sbTerm  HICAESPR.HCETTERM%type ;  -- Terminal
    sbUser  HICAESPR.HCETUSUA%type ;  -- Usuario
    sbProg  HICAESPR.HCETPROG%type ;  -- Programa
    sbErrMsg  varchar2(2000);         -- Mensaje error
    nuErrCode  number;                -- Mensaje error
    nuSequen   number;                -- Consecutivo de la transaccion.

Begin

    -- Se setea el trgaurChgStFinanHistory en el modulo de errores

    pkErrors.Push('TRGAUCHANGESTATFINAN');

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
    HCETEFAC,
    HCETEFAN,
    HCETFECH,
    HCETUSUA,
    HCETTERM,
    HCETPROG,
    HCETCONS
    )
    VALUES
    (
    :new.sesunuse,
    :new.sesususc,
    :old.sesuserv,
    :new.sesuesfn,
    :old.sesuesfn,
    sysdate,
    sbUser,
    sbTerm,
    sbProg,
    nuSequen
    );
    dbms_output.put_Line('Termina trigger TRGAUCHANGESTATFINAN');
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