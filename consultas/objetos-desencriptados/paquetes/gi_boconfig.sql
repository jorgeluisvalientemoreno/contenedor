
CREATE OR REPLACE PACKAGE BODY GI_BOCONFIG IS
   CSBVERSION CONSTANT VARCHAR2( 10 ) := 'SAO66863';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   FUNCTION FNUGETCONFIG( INUENTITY IN GE_ENTITY.ENTITY_ID%TYPE, INUEXTERNALID IN GE_ENTITY_ATTRIBUTES.ATTRIBUTE_TYPE_ID%TYPE, INUCONFIGTYPEID IN GI_CONFIG_TYPE.CONFIG_TYPE_ID%TYPE := GI_BOCONSTANTS.CNUCUSTOM_CARE_NEW_CONFIG_TYPE )
    RETURN NUMBER
    IS
      CURSOR CUCONFIG IS
SELECT gi_config.config_id
		FROM gi_config
		WHERE  gi_config.entity_root_id = inuEntity
		AND    gi_config.external_root_id = inuExternalId
        AND    gi_config.config_type_id=inuConfigTypeId;
      NUIDCONFIG GI_CONFIG.CONFIG_ID%TYPE := NULL;
    BEGIN
      OPEN CUCONFIG;
      FETCH CUCONFIG
         INTO NUIDCONFIG;
      IF CUCONFIG%NOTFOUND THEN
         CLOSE CUCONFIG;
         RETURN NULL;
      END IF;
      CLOSE CUCONFIG;
      RETURN NUIDCONFIG;
   END;
   FUNCTION EXIST( INUENTITY IN GE_ENTITY.ENTITY_ID%TYPE, INUEXTERNALID IN GE_ENTITY_ATTRIBUTES.ATTRIBUTE_TYPE_ID%TYPE, INUCONFIGTYPEID IN GI_CONFIG_TYPE.CONFIG_TYPE_ID%TYPE := GI_BOCONSTANTS.CNUCUSTOM_CARE_NEW_CONFIG_TYPE )
    RETURN BOOLEAN
    IS
      NUIDCONFIG GI_CONFIG.CONFIG_ID%TYPE := NULL;
    BEGIN
      NUIDCONFIG := FNUGETCONFIG( INUENTITY, INUEXTERNALID, INUCONFIGTYPEID );
      IF ( NUIDCONFIG IS NULL ) THEN
         RETURN FALSE;
       ELSE
         RETURN TRUE;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE CLEARCOMPOSATTR( INUCOMPOSITIONID IN GI_COMPOSITION.COMPOSITION_ID%TYPE )
    IS
      CURSOR CUATTRIB( NUCOMP IN NUMBER ) IS
SELECT *
        FROM gi_comp_attribs
        WHERE composition_id = nuComp;
      PROCEDURE CLEARATTBYFRAME( NUIDATRIBUTO IN NUMBER )
       IS
       BEGIN
         DELETE gi_comp_frame_attrib
		    WHERE  gi_comp_frame_attrib.comp_attribs_id = nuIdatributo;
         DAGI_COMP_ATTRIBS.DELRECORD( NUIDATRIBUTO );
      END;
      PROCEDURE CLEARFRAMES( NUIDCOMPOSICION IN NUMBER )
       IS
         CURSOR CUFRAMES IS
SELECT frame_id
		    FROM gi_frame
		    WHERE composition_id = nuIdComposicion;
       BEGIN
         FOR RCFRAME IN CUFRAMES
          LOOP
            DELETE gi_comp_frame_Attrib
		       WHERE  frame_id = rcFrame.frame_id
		       AND    gi_comp_frame_attrib.comp_attribs_id is null;
            DELETE gi_frame
		       WHERE frame_id = rcFrame.frame_id;
         END LOOP;
      END;
    BEGIN
      FOR RCATT IN CUATTRIB( INUCOMPOSITIONID )
       LOOP
         CLEARATTBYFRAME( RCATT.COMP_ATTRIBS_ID );
      END LOOP;
      CLEARFRAMES( INUCOMPOSITIONID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END CLEARCOMPOSATTR;
   PROCEDURE CLEARCONFIG( INUENTITY IN GE_ENTITY.ENTITY_ID%TYPE, INUEXTERNALID IN GE_ENTITY_ATTRIBUTES.ATTRIBUTE_TYPE_ID%TYPE, INUCONFIGTYPEID IN GI_CONFIG_TYPE.CONFIG_TYPE_ID%TYPE := GI_BOCONSTANTS.CNUCUSTOM_CARE_NEW_CONFIG_TYPE )
    IS
      CURSOR CUCONFIG IS
SELECT *
		FROM gi_config
		WHERE  gi_config.entity_root_id = inuEntity
		AND    gi_config.external_root_id = inuExternalId
        AND    gi_config.config_type_id = inuConfigTypeId;
      CURSOR CUCOMPOSICION( NUCONF IN NUMBER ) IS
SELECT a.*
        FROM gi_composition a, gi_config_comp b
        WHERE b.config_id = nuconf
        AND   b.composition_id = a.composition_id;
    BEGIN
      FOR RCREG IN CUCONFIG
       LOOP
         FOR RCCOMP IN CUCOMPOSICION( RCREG.CONFIG_ID )
          LOOP
            CLEARCOMPOSATTR( RCCOMP.COMPOSITION_ID );
            DAGI_COMPOSITION.DELRECORD( RCCOMP.COMPOSITION_ID );
         END LOOP;
         DAGI_CONFIG.DELRECORD( RCREG.CONFIG_ID );
      END LOOP;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE CLEARCONFIGBYID( INUCONFIGID IN GI_CONFIG.CONFIG_ID%TYPE )
    IS
      CURSOR CUCOMPOSICION( NUCONF IN NUMBER ) IS
SELECT a.*
        FROM gi_composition a
        WHERE a.config_id = nuconf;
    BEGIN
      FOR RCCOMP IN CUCOMPOSICION( INUCONFIGID )
       LOOP
         CLEARCOMPOSATTR( RCCOMP.COMPOSITION_ID );
         DAGI_COMPOSITION.DELRECORD( RCCOMP.COMPOSITION_ID );
      END LOOP;
      DAGI_CONFIG.DELRECORD( INUCONFIGID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE CLEARCONFIGCOMP( INUENTITY IN GE_ENTITY.ENTITY_ID%TYPE, INUEXTERNALID IN GE_ENTITY_ATTRIBUTES.ATTRIBUTE_TYPE_ID%TYPE, INUCONFIGTYPEID IN GI_CONFIG_TYPE.CONFIG_TYPE_ID%TYPE := GI_BOCONSTANTS.CNUCUSTOM_CARE_NEW_CONFIG_TYPE )
    IS
      CURSOR CUCONFIG IS
SELECT *
		FROM gi_config
		WHERE  gi_config.entity_root_id   = inuEntity
		AND    gi_config.external_root_id = inuExternalId
        AND    gi_config.config_type_id   = inuConfigTypeId;
      RCREG CUCONFIG%ROWTYPE;
      PROCEDURE CLEARCONFIGCOMP( INUIDCONFIG IN NUMBER )
       IS
       BEGIN
         DELETE gi_config_comp
		    WHERE  gi_config_comp.config_id = inuIdConfig;
      END;
    BEGIN
      FOR RCREG IN CUCONFIG
       LOOP
         CLEARCONFIGCOMP( RCREG.CONFIG_ID );
      END LOOP;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
END GI_BOCONFIG;
/


