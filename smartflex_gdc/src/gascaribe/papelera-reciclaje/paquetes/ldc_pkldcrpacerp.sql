create or replace PACKAGE LDC_pkLDCRPACERP
AS
    PROCEDURE LDCRPACERP;

END LDC_pkLDCRPACERP;
/
create or replace PACKAGE BODY LDC_pkLDCRPACERP
AS

    csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError  NUMBER;
    sbError  VARCHAR2(4000);

  ------------------------------------------------------------------------
  PROCEDURE LDCRPACERP
  IS

      /*****************************************************************
      Propiedad intelectual de Gases de occidente.

      Nombre del Paquete: LDC_pkLDCRPACERP
      Descripcion: actualizar la fecha de registro y de revisi?n con la fecha digitada en la forma y dejar log de auditoria.

      Autor  : Ing.Viviana Barrag?n G?mez, Horbath Technologies
      Fecha  : 16-11-2016 (Fecha Creacion Paquete)  No Tiquete CA(200-598)

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.            Modificacion
      -----------  -------------------    -------------------------------------
      16/01/2025    cgonzalez           OSF-3862: Recuperar objeto y aplicar reemplazos
      ******************************************************************/
      nusession               NUMBER;                                     --Numero de sesion
      nuCont                  NUMBER;                                     --Conteo de registros para saber cada cuanto registros hago commit
      cnuNULL_ATTRIBUTE       constant number := 2126;

      nuProducto              ge_boInstanceControl.stysbValue;
      nuUltCer                ge_boInstanceControl.stysbValue;
      dtfecre                 ge_boInstanceControl.stysbValue;
      sbObser                 ge_boInstanceControl.stysbValue;

      dtFechaEstFinCerAc      date;

      nuExec_id               NUMBER;                                     -- Codigo del ejecutable del reporte

      --cursor que obtiene la informaci?n de pr_certificate

      CURSOR cupr_certificate(inuProducto number, inuUltCert number) is
      select p.*
      from pr_certificate p
      where p.product_id = inuProducto
        and p.certificate_id = inuUltCert;

      TYPE tytbData  IS TABLE OF cupr_certificate%ROWTYPE INDEX BY BINARY_INTEGER;   --Tomo el tipo del cursor
      tbData         tytbData;                                                  --Variable tipo tabla basada en el cursor
      
      csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';      
  BEGIN


      --Control de registro que inicio y fin satisfactorio del proceso
      nusession := userenv('sessionid');
      
      ldc_proinsertaestaprog(to_number(to_char(sysdate,'YYYY')),to_number(to_char(sysdate,'MM')),'LDCRPACER','Inicia ejecucion..',nusession,USER);

      --Obtenemos los datos que vienen de filtro del PB
      nuProducto      := ge_boInstanceControl.fsbGetFieldValue ('LDC_OSF_CONFIG_FB2', 'PRODUCTO');
      nuUltCer        := ge_boInstanceControl.fsbGetFieldValue ('PR_PRODUCT', 'PRODUCT_ID');
      dtfecre         := /*to_date(*/ge_boInstanceControl.fsbGetFieldValue ('PR_PRODUCT', 'CREATION_DATE')/*,'dd/mm/yyyy')*/;
      sbObser         := ge_boInstanceControl.fsbGetFieldValue ('GE_ENTITY_ATTRIBUTES', 'COMMENT_');

      --Validacion de atributos o filtros requeridos:
      if (nuProducto IS NULL) then
          pkg_error.setErrorMessage(cnuNULL_ATTRIBUTE, 'N?mero del producto');
      end if;

      if (nuUltCer IS NULL) then
          pkg_error.setErrorMessage(cnuNULL_ATTRIBUTE, 'Ultimo certificado');
      end if;

      if (dtfecre IS NULL) then
          pkg_error.setErrorMessage(cnuNULL_ATTRIBUTE, 'Fecha de revisi?n');
      end if;

      if (sbObser IS NULL) then
          pkg_error.setErrorMessage(cnuNULL_ATTRIBUTE, 'Observacion');
      end if;

      if (dtfecre > sysdate) then
          pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error, 'La fecha de revisi?n no puede ser mayor que la del sistema');
      end if;

      -----------------------------------------------

      --Obteniendo la fecha estimada de finalizaci?n del certificado
      dtFechaEstFinCerAc:= add_months(to_date(dtfecre),ge_boparameter.fnuValorNumerico('ADVANCE_PERIOD')*12);

      --Inicializamos el contador para realizar commit cada 100 registros
      nuCont := 0;

      --Se recorre la poblacion
      OPEN  cupr_certificate(to_number(nuProducto),to_number(nuUltCer));
      loop

      --Borra tabla temporal
      tbData.delete;

      FETCH cupr_certificate BULK COLLECT INTO tbData LIMIT 10;

      if(tbData.count > 0)then

          for nuIndex IN tbData.first..tbData.last loop

            BEGIN
            --Se inserta el registro en la tabla de resultados
            INSERT INTO LDC_LOGAUDI_LDCRPACER(
                  CERTIFICATE_ID,
                  PRODUCT_ID,
                  REGISTER_DATE_A,
                  REVIEW_DATE_A,
                  ESTIMATED_END_DATE_A,
                  FECHA_CAMBIO,
                  REGISTER_DATE_D,
                  REVIEW_DATE_D,
                  ESTIMATED_END_DATE_D,
                  USUARIO,
                  TERMINAL,
                  OBSERVACION
            )
            VALUES(
              nuUltCer,
              nuProducto,
              tbData(nuIndex).register_date,
              tbData(nuIndex).review_date,
              tbData(nuIndex).estimated_end_date,
              sysdate,
              dtfecre,
              dtfecre,
              dtFechaEstFinCerAc,
              user,
              (SELECT MACHINE FROM V$SESSION H WHERE H.AUDSID = USERENV('SESSIONID')AND H.USERNAME=USER),
              sbObser
            );
            EXCEPTION
              when others then
                ldc_proactualizaestaprog(nusession,SUBSTR('FALLO INSERCION: '||sqlerrm,1,2000),'LDC_LOGAUDI_LDCRPACER','Termino con Error');
                GOTO ABORTAR;
            END;

            --Control de commit cada 100 registros
            nuCont := nuCont + 1;
            if (nuCont >= 100) then
              COMMIT;
              nuCont := 0;
            end if;

          end loop; -- Loop sobre la tabla tbData

      end if; -- if validacion que la tabla (tbData) pl contenga registros

      exit when (cupr_certificate%notfound);

      end loop; -- Loop sobre el cursor cuRegistros

      CLOSE cupr_certificate;

      COMMIT;

      --se actualiza la tabla pr_certificate

      begin
        update pr_certificate p
        set p.register_date =dtfecre,
            p.review_date = dtfecre,
            p.estimated_end_date = dtFechaEstFinCerAc
        where p.product_id = nuProducto
        and p.certificate_id = nuUltCer;

        commit;
      end;

      ldc_certificate_rp(nuProducto, null, to_date(dtfecre));
      commit;
      --Se indica en la tabla de estado de proceso que termina
      ldc_proactualizaestaprog(nusession,'Proceso Finalizado','LDRBDEV','Ok');

      <<ABORTAR>>
      NULL;

  EXCEPTION
  when pkg_error.CONTROLLED_ERROR then
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError,sbError);
      pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
      pkg_traza.trace('sqlerrm => '||sqlerrm, csbNivelTraza );
      ldc_proactualizaestaprog(nusession,SUBSTR('ERROR: '||sqlerrm,1,2000),'LDRBDEV','Termino con Error');
      RAISE pkg_error.CONTROLLED_ERROR;
  when others then
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_error.setError;
      pkg_Error.getError(nuError,sbError);
      pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
      pkg_traza.trace('sqlerrm => '||sqlerrm, csbNivelTraza );
      ldc_proactualizaestaprog(nusession,SUBSTR('ERROR: '||sqlerrm,1,2000),'LDRBDEV','Termino con Error');
      RAISE pkg_error.CONTROLLED_ERROR;
  END LDCRPACERP;

  ------------------------------------------------------------------------

END LDC_pkLDCRPACERP;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKLDCRPACERP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKLDCRPACERP','OPEN');
END;
/