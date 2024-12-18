CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDC_TARIFAS_GESTCART
--******************************************************************************************************************************************************
--** EMPRESA              :HORBATH TECNOLOGIES
--** OBJETO               : TRG_LDC_TARIFAS_GESTCART
--** PROPOSITO            : Registra modificaciones de registros de la tabla LDC_TARIFAS_GESTCART a la tabla de auditoria : LDC_TARIFAS_GESTCART_AUDI
--** AUTOR                : John Jairo Jimenez Marimon
--** FECHA CREACION       : 01/02/2019
--*******************************************************************************************************************************************************
--***********************************HISTORIAL DE MODIFICACIONES*****************************************************************************************
--*******************************************************************************************************************************************************
--    FECHA                 TICKET        AUTOR                                           MODIFICACION
-- 05/07/2019              200-2704    ELKIN ALVAREZ     SE ACTUALIZA INSERT EN LA TABLA LDC_TARIFAS_GESTCART_AUDI ADICIONANDO CAMPOS NUEVOS
--
-- 12/08/2019      		   200-2704    ELKIN ALVAREZ     SE CAMBIA TIPO DE PRODUCTO POR EL CODIGO DEL GRUPO
--
-- 18/10/2024      		   OSF-3383    Lubin Pineda      Se migra a ADM_PERSON
--*******************************************************************************************************************************************************
AFTER INSERT OR UPDATE OR DELETE ON LDC_TARIFAS_GESTCART
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
DECLARE
 sboperacion VARCHAR2(1);
BEGIN
 IF inserting THEN
  sboperacion := 'I';
 ELSIF updating THEN
  sboperacion := 'U';
 ELSIF deleting THEN
  sboperacion := 'D';
 ELSE
  sboperacion := '-';
 END IF;
 IF sboperacion <> '-' THEN
  INSERT INTO LDC_TARIFAS_GESTCART_AUDI(
                                        id,
                                       GRUPTIPR,
                                        rango_inicial,
                                        rango_final,
                                        tipo_tarifa,
										rango_inicump,
										rango_fincump,
                                        valor,
                                        unidad_operativa,
                                        grupo_categoria,
                                        fecha_inicial_vig,
                                        fecha_final_vig,
                                        tipo_operacion,
                                        fecha,
                                        usuario

			 						   )
                                VALUES(
										decode(sboperacion,'D',:old.id,:new.id)
										,decode(sboperacion,'D',:old.GRUPTIPR,:new.GRUPTIPR)
										,decode(sboperacion,'D',:old.rango_inicial,:new.rango_inicial)
										,decode(sboperacion,'D',:old.rango_final,:new.rango_final)
										,decode(sboperacion,'D',:old.tipo_tarifa,:new.tipo_tarifa)
										,decode(sboperacion,'D',:old.rango_inicump,:new.rango_inicump)
										,decode(sboperacion,'D',:old.rango_fincump,:new.rango_fincump)
										,decode(sboperacion,'D',:old.valor,:new.valor)
										,decode(sboperacion,'D',:old.unidad_operativa,:new.unidad_operativa)
										,decode(sboperacion,'D',:old.grupo_categoria,:new.grupo_categoria)
										,decode(sboperacion,'D',:old.fecha_inicial_vig,:new.fecha_inicial_vig)
										,decode(sboperacion,'D',:old.fecha_final_vig,:new.fecha_final_vig)
										,sboperacion
										,SYSDATE
										,USER
								      );
 END IF;
 EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise ex.CONTROLLED_ERROR ;
    when others then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Error no controlado '||sqlerrm);
      raise ex.CONTROLLED_ERROR ;
 END;
/
