
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