IF OBJECT_ID( N'[Open].[FormatString]', 'FN' ) IS NOT NULL
    DROP FUNCTION [Open].[FormatString]
GO
/***************************************************
Object Name : FormatString
Purpose : Returns the formatted string.
Original Author : Karthik D V http://stringformat-in-sql.blogspot.com/
Sample Call:
SELECT dbo.FormatString ( N'Format {0} {1} {2} {0}', N'1,2,3' )
*******************************************/
CREATE FUNCTION [Open].[FormatString](
@Format NVARCHAR(max) ,
@Parameters NVARCHAR(max)
)
RETURNS NVARCHAR(max)
AS
BEGIN
    --DECLARE @Format NVARCHAR(4000), @Parameters NVARCHAR(4000) select @format='{0}{1}', @Parameters='hello,world'
    DECLARE @Message NVARCHAR(max), @Delimiter CHAR(1)
    DECLARE @ParamTable TABLE ( ID INT IDENTITY(0,1), Parameter VARCHAR(1000) )
    Declare @startPos int, @endPos int
    SELECT @Message = @Format, @Delimiter = ','

    --handle first parameter
     set @endPos=CHARINDEX(@Delimiter,@Parameters)
    if (@endPos=0 and @Parameters is not null) --there is only one parameter
        insert into @ParamTable (Parameter) values(@Parameters)
    else begin
        insert into @ParamTable (Parameter) select substring(@Parameters,0,@endPos)
    end

    while @endPos>0
    Begin
        --insert a row for each parameter in the 
        set @startPos = @endPos + LEN(@Delimiter)
        set @endPos = CHARINDEX(@Delimiter,@Parameters, @startPos)
        if (@endPos>0)
            insert into @ParamTable (Parameter) select substring(@Parameters,@startPos,@endPos)
        else
            insert into @ParamTable (Parameter) select substring(@Parameters,@startPos,4000)            
    End

    UPDATE @ParamTable SET @Message = REPLACE ( @Message, '{'+CONVERT(VARCHAR,ID) + '}', Parameter )
    RETURN @Message
END
Go