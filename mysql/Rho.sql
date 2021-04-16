CREATE FUNCTION BS.Rho(@_CallPut int, @_S0 decimal(8,2), @_q decimal(8,2), @_t decimal(8,2), @_X decimal(8,2), @_r decimal(8,2), @_s decimal(8,2)) 
RETURNS decimal(8,2)
BEGIN
	Declare @_d1 decimal(8,2)
	, @_d2 decimal(8,2)

	set @_d1 = BS.D1(@_S0, @_X, @_t, @_r, @_q, @_s);
	set @_d2 = BS.D2(@_d1, @_s, @_t);
	
	if @_CallPut = 0
		RETURN (1/100.0)*@_X*@_t*Exp(-1*@_r*@_t)*BS.CND(@_d2);
	else
		RETURN (-1/100.0)*@_X*@_t*Exp(-1*@_r*@_t)*BS.CND(-1*@_d2);

	--Not reachable return but it's required.
	Return 0.0
END 