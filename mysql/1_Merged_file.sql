
 GO
DROP FUNCTION If EXISTS BS.CallPrice

 GO 
CREATE FUNCTION BS.CallPrice (@_s0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare @@_t as Decimal(15,5)
	, @_d1 Decimal(15,5)
	, @_d2 Decimal(15,5)

	set @@_t = @_t;
	if @_t < 0
	Begin
		set @@_t = 0;
	END
	set @_d1 = BS.D1(@_s0, @_X, @@_t, @_r, @_q, @_s);
	set @_d2 = BS.D2(@_d1, @_s, @@_t);
    RETURN @_s0 * Exp(-1*@_q*@@_t) * BS.CND(@_d1)- @_X * Exp(-1*@_r*@@_t) * BS.CND(@_d2);
END
 GO
DROP FUNCTION If EXISTS BS.Charm

 GO 
CREATE FUNCTION BS.Charm(@_CallPut int, @_s0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare @_d1 Decimal(15,5)
	Declare @_dd1 Decimal(15,5)
	Declare @_d2 Decimal(15,5)

	set @_d1 = BS.D1(@_s0, @_X, @_t, @_r, @_q, @_s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	set @_d2 = BS.D2(@_d1, @_s, @_t);
	
	if @_CallPut = 0
		RETURN (1/365.0)*(@_q*Exp(-1*@_q*@_t)*BS.CND(@_d1) + Exp(-1*@_q*@_t)*@_dd1 * (@_d2/(2*@_t) - (@_r-@_q)/(@_s*Sqrt(@_t))));
	else
		RETURN (1/365.0)*(@_q*Exp(-1*@_q*@_t)*(BS.CND(@_d1)-1) + Exp(-1*@_q*@_t)*@_dd1 * (@_d2/(2*@_t) - (@_r-@_q)/(@_s*Sqrt(@_t))));

	--Will never reach to this statement but it's required.
	RETURN 0.0
END
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
 GO
DROP FUNCTION If EXISTS BS.Colour

 GO
CREATE FUNCTION BS.Colour(@_s0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare
	@_d1 Decimal(15,5)
	, @_dd1 Decimal(15,5)
	, @_d2 Decimal(15,5)

	set @_d1 = BS.D1(@_s0, @_X, @_t, @_r, @_q, @_s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	set @_d2 = BS.D2(@_d1, @_s, @_t);
	RETURN (1/365.0)* (Exp(-1*@_q*@_t) * @_dd1 / ( @_s * @_s0 * Sqrt(@_t)) * (@_q + (1-@_d1*@_d2)/(2*@_t) - @_d1*(@_r-@_q)/(@_s* Sqrt(@_t))));
END
 GO
DROP FUNCTION If EXISTS BS.D1

 GO 
CREATE FUNCTION BS.D1(@_s0 Decimal(15,5), @_X Decimal(15,5), @_t decimal(8,5), @_r Decimal(15,5), @_q Decimal(15,5), @_s Decimal(15,5))
RETURNS Decimal(15,5)
BEGIN
    RETURN (Log(@_s0/@_X)+@_t*(@_r-@_q+Power(@_s,2)/2))/(@_s*Sqrt(@_t));
END
 GO
DROP FUNCTION If EXISTS BS.D2

 GO 
CREATE FUNCTION BS.D2(@_D1 Decimal(15,5), @_s Decimal(15,5), @_t decimal(8,5))
RETURNS Decimal(15,5)
BEGIN
    RETURN @_D1 - @_s * Sqrt(@_t);
END

 GO
DROP FUNCTION If EXISTS BS.Delta

 GO 
CREATE FUNCTION BS.Delta(@_CallPut int, @_s0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare @_d1 as Decimal(15,5)

	set @_d1 = BS.D1(@_s0, @_X, @_t, @_r, @_q, @_s);
	if @_CallPut = 0
		RETURN Exp(-1*@_q*@_t) * BS.CND(@_d1);
	else
		RETURN Exp(-1*@_q*@_t) * (BS.CND(@_d1)-1);

	--Not reachable return but it's required.
	Return 0.0
END
 GO
DROP FUNCTION If EXISTS BS.Gamma

 GO 
CREATE FUNCTION BS.Gamma(@_s0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare @_d1 as Decimal(15,5)
	, @_dd1 as Decimal(15,5)

	set @_d1 = BS.D1(@_s0, @_X, @_t, @_r, @_q, @_s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	RETURN (Exp(-1*@_q*@_t) / (@_s0 * @_s * Sqrt(@_t))) * @_dd1;
END
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
 GO
DROP FUNCTION If EXISTS BS.OptionPrice

 GO 
CREATE FUNCTION BS.OptionPrice (@_CallPut int, @_S0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare @_p Decimal(15,5)

	if @_CallPut = 0
		set @_p = BS.CallPrice(@_S0, @_q, @_t, @_X, @_r, @_s);
	else
		set @_p = BS.PutPrice(@_S0, @_q, @_t, @_X, @_r, @_s);

	RETURN @_p;
END
 GO
DROP FUNCTION If EXISTS BS.PutPrice

 GO 
CREATE FUNCTION BS.PutPrice (@_s0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare @@_t decimal(8,5), @_d1 Decimal(15,5), @_d2 Decimal(15,5)

	set @@_t = @_t;
	if @_t < 0
	Begin
		set @@_t = 0;
	END
	set @_d1 = BS.D1(@_s0, @_X, @@_t, @_r, @_q, @_s);
	set @_d2 = BS.D2(@_d1, @_s, @@_t);
    RETURN @_X * Exp(-1*@_r*@@_t) * BS.CND(-1*@_d2) - @_s0 * Exp(-1*@_q*@@_t) * BS.CND(-1*@_d1);
END
 GO
DROP FUNCTION If EXISTS BS.Rho

 GO 
CREATE FUNCTION BS.Rho(@_CallPut int, @_S0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare @_d1 Decimal(15,5)
	, @_d2 Decimal(15,5)

	set @_d1 = BS.D1(@_S0, @_X, @_t, @_r, @_q, @_s);
	set @_d2 = BS.D2(@_d1, @_s, @_t);
	
	if @_CallPut = 0
		RETURN (1/100.0)*@_X*@_t*Exp(-1*@_r*@_t)*BS.CND(@_d2);
	else
		RETURN (-1/100.0)*@_X*@_t*Exp(-1*@_r*@_t)*BS.CND(-1*@_d2);

	--Not reachable return but it's required.
	Return 0.0
END 
 GO
DROP FUNCTION If EXISTS BS.Speed

 GO 
CREATE FUNCTION BS.Speed(@_S0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare
	@_d1 Decimal(15,5)
	, @_dd1 Decimal(15,5)
	
	set @_d1 = BS.D1(@_S0, @_X, @_t, @_r, @_q, @_s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	RETURN Exp(-1*@_q*@_t)*@_dd1/(@_s*@_s*@_S0*@_S0*@_t) * (@_d1+@_s*Sqrt(@_t));
END
 GO
DROP FUNCTION If EXISTS BS.Theta

 GO 
CREATE FUNCTION BS.Theta(@_CallPut int, @_S0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare
	@_d1 Decimal(15,5)
	, @_d2 Decimal(15,5)
	, @_temp1 Decimal(15,5)

	set @_d1 = BS.D1(@_S0, @_X, @_t, @_r, @_q, @_s);
	set @_d2 = BS.D2(@_d1, @_s, @_t);
	set @_temp1 = ((@_S0*@_s*Exp(-1*@_q*@_t))/(2*Sqrt(@_t)))*(1/sqrt(2*PI()))*Exp(-1*(@_d1*@_d1)/ 2);
	
	
	if @_CallPut = 0
		RETURN (1/365.0)*(-1*@_temp1 - @_r*@_X*Exp(-1*@_r*@_t)*BS.CND(@_d2) + @_q*@_S0*Exp(-1*@_q*@_t)*BS.CND(@_d1));
	else
		RETURN (1/365.0)*(-1*@_temp1 + @_r*@_X*Exp(-1*@_r*@_t)*BS.CND(-1*@_d2) - @_q*@_S0*Exp(-1*@_q*@_t)*BS.CND(-1*@_d1));

	--Not reachable return but it's required.
	Return 0.0
END
 GO
DROP FUNCTION If EXISTS BS.Vega

 GO 
CREATE FUNCTION BS.Vega(@_S0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare
	@_d1 Decimal(15,5)
	, @_dd1 Decimal(15,5)

	set @_d1 = BS.D1(@_S0, @_X, @_t, @_r, @_q, @_s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	RETURN (1/100.0) * @_S0 * Exp(-1*@_q*@_t) * Sqrt(@_t) * @_dd1;
END
 GO
DROP FUNCTION If EXISTS BS.Volga

 GO 
CREATE FUNCTION BS.Volga(@_S0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare
	@_d1 Decimal(15,5)
	, @_dd1 Decimal(15,5)
	, @_d2 Decimal(15,5)

	set @_d1 = BS.D1(@_S0, @_X, @_t, @_r, @_q, @_s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	set @_d2 = BS.D2(@_d1, @_s, @_t);
	RETURN @_S0 * Sqrt(@_t) * Exp(-1*@_q*@_t) * @_dd1 * @_d1 * @_d2 / @_s;
END