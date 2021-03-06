--GETTY - Factura Electr�nica BRASIL
--Prop�sito. Tablas y funciones para monitorear la creaci�n de facturas en formato xml
--
---------------------------------------------------------------------------------------
--Prop�sito. Log de facturas emitidas en formato xml. S�lo debe haber un estado emitido para cada factura.
--28/03/19 jcf Creaci�n
--
IF not EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[cfdLogFacturaXML]') AND OBJECTPROPERTY(id,N'IsTable') = 1)
begin
	CREATE TABLE dbo.cfdLogFacturaXML (
	  soptype SMALLINT  NOT NULL DEFAULT 0 ,
	  sopnumbe VARCHAR(21)  NOT NULL DEFAULT '' ,
	  secuencia INTEGER  NOT NULL IDENTITY ,
	  estado VARCHAR(20)  NOT NULL DEFAULT 'anulado' , 
	  mensaje VARCHAR(255)  NOT NULL DEFAULT 'xml no emitido' ,
	  estadoActual varchar(20) default '000100000000', 
	  mensajeEA varchar(255) default '',
	  noAprobacion varchar(21) not null default '',
	  fechaEmision datetime not null default getdate(), 
	  idUsuario varchar(10) not null default '',
	  fechaAnulacion datetime not null default 0,
	  idUsuarioAnulacion varchar(10) not null default '',
	  archivoXML xml default ''
	PRIMARY KEY(soptype, sopnumbe, secuencia));

	create index idx1_cfdLogFacturaXML on dbo.cfdLogFacturaXML(soptype, sopnumbe, estado) include (estadoActual, archivoXML);
end
else
begin
	alter table dbo.cfdLogFacturaXML drop constraint chk_estado;

end
go

--alter table dbo.cfdLogFacturaXML add constraint chk_estado check(estado in ('emitido', 'anulado', 'impreso', 'publicado', 'enviado', 'rechazo_sunat', 'acepta_sunat', 'sunat', 'error'));
--alter table dbo.cfdLogFacturaXML drop constraint chk_estado ;


go
---------------------------------------------------------------------------------------------------------------------------

