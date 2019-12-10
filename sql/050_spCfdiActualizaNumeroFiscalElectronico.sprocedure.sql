IF OBJECT_ID('dbo.spCfdiActualizaNumeroFiscalElectronico')IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.spCfdiActualizaNumeroFiscalElectronico
END
GO

--Prop�sito. Actualiza el NFS-e de una nota fiscal en el campo cstponbr de la factura en GP
--06/12/19 p almada. Creaci�n
--
CREATE PROCEDURE dbo.spCfdiActualizaNumeroFiscalElectronico(@SOPTYPE SMALLINT,@NUMFAC VARCHAR(21),@SERNUM VARCHAR(21),@MENS VARCHAR(200) OUTPUT)
AS
	BEGIN TRY		
		IF EXISTS(SELECT * FROM sop10100 WHERE SOPTYPE = @SOPTYPE AND SOPNUMBE= @SERNUM)
		BEGIN
			UPDATE sop10100 SET cstponbr = @NUMFAC WHERE SOPTYPE = @SOPTYPE AND SOPNUMBE= @SERNUM			
			SET @MENS = 'La factura fue actualizada con el NFS-e: ' +@NUMFAC+ ' (no contabilizada)'
		END
		ELSE			
			IF EXISTS(SELECT * FROM SOP30200 WHERE SOPTYPE = @SOPTYPE AND SOPNUMBE= @SERNUM)
			BEGIN
				UPDATE SOP30200 SET cstponbr = @NUMFAC WHERE SOPTYPE = @SOPTYPE AND SOPNUMBE = @SERNUM			
				SET @MENS = 'La factura fue actualizada con el NFS-e: ' +@NUMFAC+ ' (contabilizada)'
			END
			ELSE
				SET @MENS = 'La factura no existe en GP'
	END TRY
	BEGIN CATCH
		SET @MENS = substring(ERROR_MESSAGE(), 1, 200);
	END CATCH
GO

IF (@@Error = 0) PRINT 'Procedure Creation: spCfdiActualizaNumeroFiscalElectronico Succeeded'
ELSE PRINT 'Procedure Creation: spCfdiActualizaNumeroFiscalElectronico Error on Creation'
GO

