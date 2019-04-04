--Factura electr�nica 
--Prop�sito. Crea vista de los id de documentos que se incluyen en factura electr�nica.
--
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[vwCfdIdDocumentos]') AND OBJECTPROPERTY(id,N'IsView') = 1)
    DROP view dbo.[vwCfdIdDocumentos];
GO
create view dbo.vwCfdIdDocumentos as
--Prop�sito. Obtiene id de documentos de venta gp
--Utilizado por. Factura electr�nica
--28/03/19 jcf Creaci�n
--
select ds.soptype, ds.docid, ds.SOPNUMBE
from sop40200 ds			--sop_id_setp
where soptype in (3, 4)
--where exists (
--	select invdocid 
--	from SOP40100			--sop_setp
--	where (INVDOCID = ds.DOCID
--		or RETDOCID = ds.DOCID)
--	)
go
IF (@@Error = 0) PRINT 'Creaci�n exitosa de la vista: vwCfdIdDocumentos'
ELSE PRINT 'Error en la creaci�n de la vista: vwCfdIdDocumentos'
GO

----------------------------------------------------------------------------------------------------------------------------------------
