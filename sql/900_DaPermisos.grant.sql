--Integraciones GP
--Prop�sito. Rol que da accesos a objetos de nota fiscal
--Requisitos. Ejecutar en la bd de la compa��a
--09/04/19 JCF Creaci�n

use gbra 
go

IF DATABASE_PRINCIPAL_ID('ROL_NOTAFISCAL') IS NULL
	create role ROL_NOTAFISCAL;

grant select on dbo.vwCfdiTransaccionesDeVenta to ROL_NOTAFISCAL;

