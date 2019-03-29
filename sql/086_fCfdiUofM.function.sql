IF OBJECT_ID ('dbo.fCfdiUofM') IS NOT NULL
   DROP FUNCTION dbo.fCfdiUofM
GO

create function dbo.fCfdiUofM(@UOMSCHDL varchar(11), @UOFM varchar(9))
returns table
as
--Prop�sito. Obtiene la descripci�n larga de la unidad de medida 
--Requisitos. 
--02/08/12 jcf Creaci�n 
--
return
( 
	select UOFMLONGDESC
	from iv40202	--unidades de medida [UOMSCHDL SEQNUMBR]
	WHERE UOMSCHDL = @UOMSCHDL
	and UOFM = @UOFM 
)
go

IF (@@Error = 0) PRINT 'Creaci�n exitosa de la funci�n: fCfdiUofM()'
ELSE PRINT 'Error en la creaci�n de la funci�n: fCfdiUofM()'
GO

------------------------------------------------------------------------------------------
