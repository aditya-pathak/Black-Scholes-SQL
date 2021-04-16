
 GO
DROP FUNCTION If EXISTS BS.ImpliedVolatility

 GO 
CREATE FUNCTION BS.ImpliedVolatility(@_CallPut int, @_S0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_P Decimal(15,5))
RETURNS Decimal(15,5)
BEGIN
	Declare @_s Decimal(15,5), @_increment Decimal(15,5), @_GuessP Decimal(15,5)
	Declare @_count int, @_bigger int

	set @_s = 0.4;
	set @_count = 0;
	set @_increment = 0.30;
	set @_bigger = 0;

	WHILE (@_count < 200)
	Begin
		if @_CallPut = 0
		Begin
			set @_GuessP = BS.CallPrice(@_S0, @_q, @_t, @_X, @_r, @_s);
		End
		else
		Begin
			set @_GuessP = BS.PutPrice(@_S0, @_q, @_t, @_X, @_r, @_s);
		END
		if @_GuessP > @_P -0.01 and @_GuessP < @_P +0.01
		Begin
			RETURN @_s;
		END
		
		if @_GuessP > @_P
		Begin
			if @_bigger = 0 AND @_increment >= 0.0001
			Begin
				set @_increment = @_increment*3/4;
			END
			set @_s = @_s - @_increment;
			set @_bigger = 1
		End
		else
		Begin
			if @_bigger = 1 AND @_increment >= 0.0001
			Begin
				set @_increment = @_increment*3/4;
			END
			set @_s = @_s + @_increment;
			set @_bigger = 0;
		END
		set @_count = @_count + 1;
	END
    RETURN @_s;
END