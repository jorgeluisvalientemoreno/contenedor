/*
 *
 * Autor   : Jose Donado <jdonado@gascaribe.com>
 * Fecha   : 25/07/2022
 * Descripcion : Creación de Tabla
 *
 * Historia de Modificaciones
 * Autor          Fecha  Descripcion
**/
-- Create table
create table LDCI_LOGENVIOMSG
(
  LEMCLIE NUMBER(15) not null,
  LEMCELS VARCHAR2(50) not null,
  LEMTIPO NUMBER(1) not null,
  LEMESTA VARCHAR2(20) not null,
  LEMFEEN DATE not null,
  LEMFERE DATE,
  LEMREEN CLOB,
  LEMREUS VARCHAR2(100)
);
-- Add comments to the table 
comment on table LDCI_LOGENVIOMSG
  is 'TABLA PARA REGISTRO DE ENVIO DE MENSAJES A CLIENTES';
-- Add comments to the columns 
comment on column LDCI_LOGENVIOMSG.LEMCLIE
  is 'CODIGO DE CLIENTE';
comment on column LDCI_LOGENVIOMSG.LEMCELS
  is 'NUMEROS TELEFONICOS';
comment on column LDCI_LOGENVIOMSG.LEMTIPO
  is 'TIPO DE MENSAJE [1-SMS, 2-WHATSAPP]';
comment on column LDCI_LOGENVIOMSG.LEMESTA
  is 'ESTADO DEL MENSAJE';
comment on column LDCI_LOGENVIOMSG.LEMFEEN
  is 'FECHA DE ENVIO DE MENSAJE';
comment on column LDCI_LOGENVIOMSG.LEMFERE
  is 'FECHA DE RESPUESTA DE USUARIO';
comment on column LDCI_LOGENVIOMSG.LEMREEN
  is 'RESPUESTA DE SERVICIO DE ENVIO DE MENSAJE';
comment on column LDCI_LOGENVIOMSG.LEMREUS
  is 'RESPUESTA DE CLIENTE';
-- Create/Recreate primary, unique and foreign key constraints 
create index IDX_LDCI_LOGENVIOMSG_IDX1 on LDCI_LOGENVIOMSG (LEMCLIE);
create index IDX_LDCI_LOGENVIOMSG_IDX2 on LDCI_LOGENVIOMSG (LEMFEEN);
create index IDX_LDCI_LOGENVIOMSG_IDX3 on LDCI_LOGENVIOMSG (LEMFERE);
create index IDX_LDCI_LOGENVIOMSG_IDX4 on LDCI_LOGENVIOMSG (LEMESTA);
-- Grant/Revoke object privileges 
grant select, insert, update, delete on LDCI_LOGENVIOMSG to OPEN;