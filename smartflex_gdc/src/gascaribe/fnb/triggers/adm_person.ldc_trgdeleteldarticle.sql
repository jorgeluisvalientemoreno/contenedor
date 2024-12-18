CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGDELETELDARTICLE
FOR delete ON  ld_article

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : ldc_trgDeleteLdArticle
    Descripcion    :  Disparador para bloquear la eliminación de artículos brilla en
                      estado aprobado.
    Autor          : Sayra Ocoro
    Fecha          : 09/11/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
COMPOUND TRIGGER
   rcArticle ld_article%ROWTYPE;
   BEFORE EACH ROW IS
    BEGIN
       ut_trace.trace('ldc_trgDeleteLdArticle -  Inicio -> BEFORE EACH ROW ', 10);
       rcArticle.approved := :OLD.approved;
       rcArticle.article_id := :OLD.article_id;
       ut_trace.trace('ldc_trgDeleteLdArticle -  Fin -> BEFORE EACH ROW', 10);
   END BEFORE EACH ROW;

   AFTER STATEMENT IS
     BEGIN
       if rcArticle.approved = 'Y' then
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El artículo ['|| rcArticle.article_id ||'] se encuentra APROBADO. No es posible eliminarlo');
           raise ex.CONTROLLED_ERROR;
       end if;
       EXCEPTION
          when ex.CONTROLLED_ERROR then
              raise;
          when OTHERS then
              Errors.setError;
              raise ex.CONTROLLED_ERROR;
   END  AFTER STATEMENT;
END ldc_trgDeleteLdArticle;
/
