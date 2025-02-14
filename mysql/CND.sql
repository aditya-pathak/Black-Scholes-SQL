
 GO
DROP FUNCTION If EXISTS BS.CND

 GO 
CREATE FUNCTION BS.CND(@_X Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
    Declare
    @X Decimal(15,5)
    , @a1 decimal(10,8)
    , @a2 decimal(10,8)
    , @a3 decimal(10,8)
    , @a4 decimal(10,8)
    , @a5 decimal(10,8)
    , @L decimal(10,8)
    , @K decimal(10,8)
    , @CND1 decimal(10,8)


    set @X = @_X;
    set @a1 = 0.31938153;
    set @a2 = -0.356563782;
    set @a3 = 1.781477937;
    set @a4 = -1.821255978;
    set @a5 = 1.330274429;
    set @L = Abs(@X);
    set @K = 1 / (1 + 0.2316419 * @L);
    set @CND1 = 1 - 1 / Sqrt(2 * Pi()) * Exp(-1 * power(@L,2) / 2) * (@a1 * @K + 
        @a2 * power(@K,2) + @a3 * power(@K,3) + @a4 * power(@K,4) + @a5 * 
        power(@K,5));

    if @X < 0
    Begin
        set @CND1 = 1 - @CND1;
    END

    RETURN @CND1;
END