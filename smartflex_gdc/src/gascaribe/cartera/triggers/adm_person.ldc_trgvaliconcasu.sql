CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALICONCASU BEFORE INSERT or update
ON LDC_COACTCASU   FOR EACH ROW
/**************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : LDC_TRGVALICONCASU
  Descripcion : trigger para validar configuracion de la forma LDCCACASU
  Autor       : Horbath
  Ticket      : 176
  Fecha       : 19-12-2020

Historia de Modificaciones
Fecha               Autor                Modificacion
=========           =========          ====================
**************************************************************************/
DECLARE
  sbdatos VARCHAR2(1); --se almacena datos

 --se valida tipo de causal
 CURSOR cuValiTipoCausal IS
  SELECT 'X'
  FROM ps_package_causaltyp a, cc_causal_type b, ps_package_type c
  WHERE a.causal_type_id = b.causal_type_id
    AND a.package_type_id = c.package_type_id
    AND  a.causal_type_id = :NEW.CACSTICA
    AND c.TAG_NAME = 'P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156'
    AND NOT EXISTS (
                    SELECT 1
                    FROM  ps_pack_type_param d
                    WHERE  c.package_type_id = d.package_type_id
                      AND d.attribute_id = 112
                      AND b.causal_type_id = d.value);
  --se valida causal
  CURSOR cuValidaCausal IS
  SELECT 'X'
    FROM ps_package_type        p
        ,ps_package_causaltyp   c
        ,cc_causal              u
    WHERE p.tag_name        = 'P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156'
    AND   p.package_type_id = c.package_type_id
    AND   c.causal_type_id  = u.causal_type_id
    AND   u.causal_type_id  =   :NEW.CACSTICA
    AND   u.causal_id  = :NEW.CACSCASU;

  --se valida persona
  CURSOR cuValidaPersona IS
  SELECT 'X'
  FROM or_oper_unit_persons
  where person_id = :new.CACSPERS
   and operating_unit_id = :new.CACSUNID;

 sbmensa varchar2(4000);
BEGIN
 ut_trace.trace('INICIO LDC_TRGVALICONCASU', 10);
 IF FBLAPLICAENTREGAXCASO('0000176') THEN
   --se valida tipo de causal
   OPEN cuValiTipoCausal;
   FETCH cuValiTipoCausal INTO sbDATOS;
   IF cuValiTipoCausal%NOTFOUND THEN
      CLOSE cuValiTipoCausal;
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Tipo de causal digitada no pertenece al tramite de suspension ');
   END IF;
   CLOSE cuValiTipoCausal;

   --se valida causal
   OPEN cuValidaCausal;
   FETCH cuValidaCausal INTO sbDATOS;
   IF cuValidaCausal%NOTFOUND THEN
      CLOSE cuValidaCausal;
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Causal digitada no esta relacionada al tipo de causal o no pertenece al tramite de suspension ');
   END IF;
   CLOSE cuValidaCausal;

   --se valida causal
   OPEN cuValidaPersona;
   FETCH cuValidaPersona INTO sbDATOS;
   IF cuValidaPersona%NOTFOUND THEN
      CLOSE cuValidaPersona;
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Persona digitada no esta relacionada a la unidad operativa');
   END IF;
   CLOSE cuValidaPersona;

 END IF;
 ut_trace.trace('FIN LDC_TRGVALICONCASU', 10);
EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
  WHEN OTHERS THEN
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

END LDC_TRGVALICONCASU;
/
