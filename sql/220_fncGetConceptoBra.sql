USE [GBRA]
GO

/****** Object:  UserDefinedFunction [dbo].[fncGetConceptoBra]    Script Date: 05/09/2019 07:39:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






ALTER FUNCTION [dbo].[fncGetConceptoBra] (@INSopType smallint
										 ,@INSopNumbe CHAR(21)
										 ,@INFileType CHAR(30)
										 ,@INLeyenda  CHAR(1650)
																		)
RETURNS CHAR(1650)
AS

BEGIN
	DECLARE @Description AS CHAR(1900)
	DECLARE @Concepto AS VARCHAR(1900)
	DECLARE @TEMP AS VARCHAR(1900)
	DECLARE @ITEMS as INT
  	
	DECLARE	Curc CURSOR FOR 
				SELECT 
					CASE 
						WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1) end -2 )) in( 'RM') THEN			    
								LEFT(LTRIM(RTRIM(A.ITEMNMBR))+REPLICATE(' ', 12),12) + ' ' -- Imagem
								+ LEFT(LTRIM(RTRIM(A.ITEMDESC))+ REPLICATE(' ', 24),24) + ' ' -- Uso
								+ RIGHT(REPLICATE(' ',16)+ isnull(Substring(C.COMMENT_1,charindex('-',C.COMMENT_1,charindex('-',C.COMMENT_1,1)+1)+1,16),' '),16) + ' '-- Industria
								+ RIGHT(isnull(Substring(RTRIM(CONVERT(CHAR,C.COMMENT_1)),1,1),'  '),2) + ' '-- Prot
								+ RIGHT(RTRIM(CONVERT(CHAR,A.ReqShipDate,3)),8) + ' ' --Inicio
								+ RIGHT(RTRIM(CONVERT(CHAR,A.ACTLSHIP,3)),8) + ' ' --Fin
								+ ISNULL(Substring(RTRIM(C.COMMENT_1),charindex('-',C.COMMENT_1,1)+1,2),'  ') + ' '-- Territ
							    + RIGHT(REPLICATE(' ',11) + RTRIM(cast(format(A.UNITPRCE, 'N', 'de-de') as char)),11) + '|' --VAlor
						WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1)-2 end)) in( 'PREMIUM','PRODUCAO','MMS') THEN			    
								LEFT(LTRIM(RTRIM(A.ITEMNMBR))+REPLICATE(' ', 20),20) + ' ' -- Imagem
								+ LEFT(LTRIM(RTRIM(A.ITEMDESC))+ REPLICATE(' ', 30),30) + ' ' -- Uso
								+ REPLICATE(' ',23) + ' '
							    + RIGHT(REPLICATE(' ',13) + RTRIM(cast(format(A.UNITPRCE, 'N', 'de-de') as char)),13) + '|' --VAlor
						WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1)-2 end)) in('RF','ISTOCK','PAXP','TRILHA') THEN
								LEFT(LTRIM(RTRIM(A.ITEMNMBR))+REPLICATE(' ', 20),20) + ' ' -- Imagem
								+ LEFT(RTRIM(A.ITEMDESC)+REPLICATE(' ', 55) ,55) + ' '-- Descipsao Tamabnho
								+ RIGHT(REPLICATE(' ',12) + RTRIM(cast(format(A.UNITPRCE, 'N', 'de-de') as char)),12) + '|' --VAlor
						WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1)-2 end)) in('RR') THEN			    
								LEFT(LTRIM(RTRIM(A.ITEMNMBR))+REPLICATE(' ', 12),12) + ' ' -- Imagem
								+ LEFT(LTRIM(RTRIM(A.ITEMDESC))+ REPLICATE(' ', 45),45) + ' ' -- Utilizasao
								+ RIGHT(RTRIM(CONVERT(CHAR,A.ReqShipDate,3)),8) + ' ' --Inicio
								+ RIGHT(RTRIM(CONVERT(CHAR,A.ACTLSHIP,3)),8) + ' ' --Fin
								+ RIGHT(REPLICATE(' ',12) + RTRIM(cast(format(A.UNITPRCE, 'N', 'de-de') as char)),12) + '|' --VAlor
						END
				FROM SOP30300 A
					 LEFT OUTER JOIN SOP10202 C ON C.SOPTYPE = A.SOPTYPE and C.SOPNUMBE = A.SOPNUMBE AND C.LNITMSEQ = A.LNITMSEQ
				WHERE A.SOPTYPE = @INSopType
				AND A.SOPNUMBE = @INSopNumbe
				AND A.QUANTITY = 0
				union all
				SELECT 
					CASE
						WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1)-2 end)) in( 'RM') THEN			    
								LEFT(LTRIM(RTRIM(A.ITEMNMBR))+REPLICATE(' ', 12),12) + ' ' -- Imagem
								+ LEFT(LTRIM(RTRIM(A.ITEMDESC))+ REPLICATE(' ', 24),24) + ' ' -- Uso
								+ RIGHT(REPLICATE(' ',16)+ isnull(Substring(C.COMMENT_1,charindex('-',C.COMMENT_1,charindex('-',C.COMMENT_1,1)+1)+1,16),' '),16) + ' '-- Industria
								+ RIGHT(isnull(Substring(RTRIM(CONVERT(CHAR,C.COMMENT_1)),1,1),'  '),2) + ' '-- Prot
								+ RIGHT(RTRIM(CONVERT(CHAR,A.ReqShipDate,3)),8) + ' ' --Inicio
								+ RIGHT(RTRIM(CONVERT(CHAR,A.ACTLSHIP,3)),8) + ' ' --Fin
								+ ISNULL(Substring(RTRIM(C.COMMENT_1),charindex('-',C.COMMENT_1,1)+1,2),'  ') + ' '-- Territ
							    + RIGHT(REPLICATE(' ',11) + RTRIM(cast(format(A.UNITPRCE, 'N', 'de-de') as char)),11) + '|' --VAlor
						WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1)-2 end)) in( 'PREMIUM','PRODUCAO','MMS') THEN			    
								LEFT(LTRIM(RTRIM(A.ITEMNMBR))+REPLICATE(' ', 20),20) + ' ' -- Imagem
								+ LEFT(LTRIM(RTRIM(A.ITEMDESC))+ REPLICATE(' ', 30),30) + ' ' -- Uso
								+ REPLICATE(' ',23) + ' '
							    + RIGHT(REPLICATE(' ',13) + RTRIM(cast(format(A.UNITPRCE, 'N', 'de-de') as char)),13) + '|' --VAlor
						WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1)-2 end)) in('RF','ISTOCK','PAXP','TRILHA') THEN
								LEFT(LTRIM(RTRIM(A.ITEMNMBR))+REPLICATE(' ', 20),20) + ' ' -- Imagem
								+ LEFT(RTRIM(A.ITEMDESC)+REPLICATE(' ', 55) ,55) + ' '-- Descipsao Tamabnho
								+ RIGHT(REPLICATE(' ',12) + RTRIM(cast(format(A.UNITPRCE, 'N', 'de-de') as char)),12) + '|' --VAlor
						WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1)-2 end)) in('RR') THEN			    	    
								LEFT(LTRIM(RTRIM(A.ITEMNMBR))+REPLICATE(' ', 12),12) + ' ' -- Imagem
								+ LEFT(LTRIM(RTRIM(A.ITEMDESC))+ REPLICATE(' ', 45),45) + ' ' -- Utilizasao
								+ RIGHT(RTRIM(CONVERT(CHAR,A.ReqShipDate,3)),8) + ' ' --Inicio
								+ RIGHT(RTRIM(CONVERT(CHAR,A.ACTLSHIP,3)),8) + ' ' --Fin
								+ RIGHT(REPLICATE(' ',12) + RTRIM(cast(format(A.UNITPRCE, 'N', 'de-de') as char)),12) + '|' --VAlor
						END
				FROM SOP10200 A
					 LEFT OUTER JOIN SOP10202 C ON C.SOPTYPE = A.SOPTYPE and C.SOPNUMBE = A.SOPNUMBE AND C.LNITMSEQ = A.LNITMSEQ
				WHERE A.SOPTYPE = @INSopType
				AND A.SOPNUMBE = @INSopNumbe
				AND A.QUANTITY = 0        
	
	SELECT @TEMP=CASE 
					WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1)-2 end)) in( 'RM','PREMIUM','PRODUCAO','MMS') THEN
							-- 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
							--'Imagem	            Uso	              Industria       Prot Inicio   Termino  Territ   Valor|'
							'Cess�o de direitos'  +' |'
							+ LEFT(LTRIM(RTRIM('Imagem'))+REPLICATE(' ', 12),12) + ' ' -- Imagem
							+ LEFT(LTRIM(RTRIM('Uso'	))+ REPLICATE(' ', 24),24) + ' ' -- Uso
							+ Substring('Industria               ',1,16) + ' '-- Industria
							+ RIGHT(Substring(RTRIM(CONVERT(CHAR,'Prot')),1,1),2) + ' '-- Prot
							+ RIGHT(REPLICATE(' ',8)+'In�cio',8) + ' ' --Inicio
							+ RIGHT(REPLICATE(' ',8)+'T�rmino',8) + ' ' --Fin
							+ Substring(RTRIM('Territ'),1,2) + ' '-- Territ
							+ RIGHT(REPLICATE(' ',11) + RTRIM('Valor'),11) + '|' --VAlor
					WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1)-2 end)) in('RF','ISTOCK','PAXP','TRILHA') THEN 
							-- 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
							'Cess�o de direitos'  +' |'
							+ LEFT(LTRIM(RTRIM('Imagem'))+REPLICATE(' ', 20),20) + ' ' -- Imagem
							+ LEFT(RTRIM('Descri��o Tamanho')+REPLICATE(' ', 55) ,55) + ' '-- Descipsao Tamabnho
							+ RIGHT(REPLICATE(' ',12) + RTRIM('Valor'),12) + '|' --VAlor
					WHEN UPPER(Substring(RTRIM(@INFileType),1,case charindex('-',@INFileType,1) when 0 then 0 else charindex('-',@INFileType,1)-2 end)) in('RR') THEN 
							'Cess�o de direitos'  +' |'
							+ LEFT(LTRIM(RTRIM('Imagem'))+REPLICATE(' ', 12),12) + ' ' -- Imagem
							+ LEFT(LTRIM(RTRIM('Utiliza��o'))+ REPLICATE(' ', 45),45) + ' ' -- Utilizasao
							+ RIGHT(REPLICATE(' ',8)+'In�cio',8) + ' ' --Inicio
							+ RIGHT(REPLICATE(' ',8)+'T�rmino',8) + ' ' --Fin
							+ RIGHT(REPLICATE(' ',12) + RTRIM('Valor'),12) + '|' --VAlor
					END 

	OPEN Curc
	SELECT @Concepto='',@ITEMS=1
	FETCH NEXT FROM Curc INTO @Description
	WHILE @@fetch_status = 0
		BEGIN
			IF @ITEMS > 16 --OR (LEN(@TEMP) + LEN(@Description)) > 1600 
				BEGIN
					SELECT @Concepto=null
					BREAK
				END
			ELSE
				SELECT @Concepto=CONCAT(RTRIM(@TEMP),@Description)	
			
			select @TEMP=RTRIM(@Concepto),@ITEMS=@ITEMS+1
			
			FETCH NEXT FROM Curc INTO @Description
		END
	CLOSE Curc
	DEALLOCATE Curc
	
	IF @Concepto='' or @Concepto is null
		Return null

	Return @Concepto
	
END

















GO


