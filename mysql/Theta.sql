CREATE FUNCTION BS.Theta(@_CallPut int, @_S0 decimal(8,2), @_q decimal(8,2), @_t decimal(8,2), @_X decimal(8,2), @_r decimal(8,2), @_s decimal(8,2)) 
RETURNS decimal(8,2)
BEGIN
	Declare
	@_d1 decimal(8,2)
	, @_d2 decimal(8,2)
	, @_temp1 decimal(8,2)

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