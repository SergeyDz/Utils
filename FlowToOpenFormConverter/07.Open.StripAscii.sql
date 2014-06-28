GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Open].[StripLowAscii]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [Open].[StripLowAscii]
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sergey Dzyuban>
-- Create date: <2014-06-27>
-- Description:	<Remove illegal XML characters from string>
-- =============================================
CREATE FUNCTION [Open].[StripLowAscii] (@string nvarchar(4000))
RETURNS nvarchar(4000)
AS
BEGIN
IF @string IS NOT NULL
BEGIN
	DECLARE @Result varchar(255)
	SET @Result = ''

	DECLARE @nchar nvarchar(1)
	DECLARE @position int

	SET @position = 1
	WHILE @position <= LEN(@string)
	BEGIN
		SET @nchar = SUBSTRING(@string, @position, 1)
		--Unicode & ASCII are the same from 1 to 255.
		--Only Unicode goes beyond 255
		--0 to 31 are non-printable characters
		IF UNICODE(@nchar) between 32 and 255
			SET @Result = @Result + @nchar
		SET @position = @position + 1
	END

END
RETURN(@Result)
END