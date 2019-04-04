IF OBJECT_ID ('dbo.fCfdiParametrosTipoLeyenda') IS NOT NULL
   DROP FUNCTION dbo.fCfdiParametrosTipoLeyenda
GO

create function dbo.fCfdiParametrosTipoLeyenda(@ADRSCODE char(15), @Master_Type varchar(3))
returns table
as
--Prop�sito. Devuelve todo el texto de notas de la direcci�n @ADRSCODE
--Requisitos. -
--02/01/18 jcf Creaci�n 
--
return
(
	select ia.inetinfo, ia.INET7, ia.INET8
	from SY01200 ia								--coInetAddress Direcci�n de la compa��a
	inner join dbo.synonymGPCompanyMaster ci	--sy_company_mstr 
		on ci.INTERID = DB_NAME()
		and ia.Master_ID = ci.INTERID
		and ia.ADRSCODE = case when @ADRSCODE = 'PREDETERMINADO' then ci.LOCATNID else @ADRSCODE end
	where ia.Master_Type = @Master_Type
)
go

IF (@@Error = 0) PRINT 'Creaci�n exitosa de la funci�n: fCfdiParametrosTipoLeyenda()'
ELSE PRINT 'Error en la creaci�n de la funci�n: fCfdiParametrosTipoLeyenda()'
GO

-----------------------------------------------------------------------------------------------
--select *
--from dbo.fCfdiParametrosTipoLeyenda('LEYENDASFE', 'CMP')



--NOOOOOO