DECLARE
  CURSOR cuConstarintTabla(sbConstarint VARCHAR2) IS
    SELECT * FROM all_constraints a where a.CONSTRAINT_NAME = sbConstarint;
  rccuConstarintTabla cuConstarintTabla%ROWTYPE;

  CURSOR cuLlavePrimaria(sbTabla VARCHAR2, sbLlavePrimaria VARCHAR2) IS
    select *
      from user_constraints uc
     where uc.constraint_type = 'P'
       and uc.table_name = sbTabla
       and uc.CONSTRAINT_NAME = sbLlavePrimaria;
  rccuLlavePrimaria cuLlavePrimaria%ROWTYPE;

BEGIN

  --/*
  ---Retirar llave foranea LDC_SUI_CONFIREPSUIA_FK2
  OPEN cuConstarintTabla('LDC_SUI_CONFIREPSUIA_FK2');
  FETCH cuConstarintTabla
    INTO rccuConstarintTabla;
  IF (cuConstarintTabla%FOUND) THEN
    EXECUTE IMMEDIATE 'alter table LDC_SUI_CONFIREPSUIA drop constraint LDC_SUI_CONFIREPSUIA_FK2 cascade';
    Dbms_Output.Put_Line('Retira la llave foranea LDC_SUI_CONFIREPSUIA_FK2 de al entidad LDC_SUI_TITRCALE');
  ELSE
    Dbms_Output.Put_Line('***************Constraint LDC_SUI_CONFIREPSUIA_FK2 No existe');
  END IF;
  CLOSE cuConstarintTabla;
  ----------------------------------------------------------------------------------

  ---Ratira llave primaria de LDC_SUI_TITRCALE_PK
  OPEN cuLlavePrimaria('LDC_SUI_TITRCALE', 'LDC_SUI_TITRCALE_PK');
  FETCH cuLlavePrimaria
    INTO rccuLlavePrimaria;
  IF (cuLlavePrimaria%FOUND) THEN
    EXECUTE IMMEDIATE 'alter table LDC_SUI_TITRCALE  drop primary key';
    Dbms_Output.Put_Line('Ratira llave primaria LDC_SUI_TITRCALE_PK de la entidad LDC_SUI_TITRCALE');
  ELSE
    Dbms_Output.Put_Line('***************llave primaria LDC_SUI_TITRCALE_PK No existe');
  END IF;
  CLOSE cuLlavePrimaria;
  --------------------   

  -------------------------------------------------------------------------------------------------
  ---Retirar llave foranea LDC_SUI_CONFIREPSUIA_FK4
  OPEN cuConstarintTabla('LDC_SUI_CONFIREPSUIA_FK4');
  FETCH cuConstarintTabla
    INTO rccuConstarintTabla;
  IF (cuConstarintTabla%FOUND) THEN
    EXECUTE IMMEDIATE 'alter table LDC_SUI_CONFIREPSUIA drop constraint LDC_SUI_CONFIREPSUIA_FK4 cascade';
    Dbms_Output.Put_Line('Retira la llave foranea LDC_SUI_CONFIREPSUIA_FK4 de al entidad LDC_SUI_CONFIREPSUIA');
  ELSE
    Dbms_Output.Put_Line('***************Constraint LDC_SUI_CONFIREPSUIA_FK4 No existe');
  END IF;
  CLOSE cuConstarintTabla;
  ----------------------------------------------------------------------------------

  ---Ratira llave primaria de LDC_SUI_CAUS_EQU
  OPEN cuLlavePrimaria('LDC_SUI_CAUS_EQU', 'LDC_SUI_CAUS_EQU');
  FETCH cuLlavePrimaria
    INTO rccuLlavePrimaria;
  IF (cuLlavePrimaria%FOUND) THEN
    EXECUTE IMMEDIATE 'alter table LDC_SUI_CAUS_EQU  drop primary key';
    Dbms_Output.Put_Line('Ratira llave primaria LDC_SUI_CAUS_EQU de la entidad LDC_SUI_CAUS_EQU');
  ELSE
    Dbms_Output.Put_Line('***************llave primaria LDC_SUI_CAUS_EQU No existe');
  END IF;
  CLOSE cuLlavePrimaria;
  --------------------   
  --*/
  --/*
  ---Ratira llave primaria de LDC_SUI_TITRCALE_PK
  OPEN cuConstarintTabla('LDC_SUI_TITRCALE_PK');
  FETCH cuConstarintTabla
    INTO rccuConstarintTabla;
  IF (cuConstarintTabla%NOTFOUND) THEN
    EXECUTE IMMEDIATE 'alter table LDC_SUI_TITRCALE add constraint LDC_SUI_TITRCALE_PK PRIMARY KEY (TIPO_TRABAJO, CAUSAL_LEGALIZACION, RESPUESTA)';
    Dbms_Output.Put_Line('Creacion de llave primaria compuesta LDC_SUI_TITRCALE_PK de la entidad LDC_SUI_TITRCALE');
  ELSE
    Dbms_Output.Put_Line('***************llave primaria LDC_SUI_TITRCALE_PK Ya existe');
  END IF;
  CLOSE cuConstarintTabla;
  --------------------   

  --/*
  ---Crear llave primaria de LDC_SUI_CAUS_EQU
  OPEN cuLlavePrimaria('LDC_SUI_CAUS_EQU', 'LDC_SUI_CAUS_EQU');
  FETCH cuLlavePrimaria
    INTO rccuLlavePrimaria;
  IF (cuLlavePrimaria%NOTFOUND) THEN
    EXECUTE IMMEDIATE 'ALTER TABLE LDC_SUI_CAUS_EQU ADD CONSTRAINT LDC_SUI_CAUS_EQU PRIMARY KEY (CAUSAL_REGISTRO, TIPO_SOLICITUD) USING INDEX ENABLE';
    Dbms_Output.Put_Line('Crear llave primaria compuesta LDC_SUI_CAUS_EQU de la entidad LDC_SUI_CAUS_EQU');
  ELSE
    Dbms_Output.Put_Line('***************llave primaria LDC_SUI_CAUS_EQU ya existe');
  END IF;
  CLOSE cuLlavePrimaria;
  --------------------    
  --*/

END;
/
