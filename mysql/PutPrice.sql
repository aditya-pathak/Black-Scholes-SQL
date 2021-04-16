CREATE FUNCTION BS.PutPrice (@_s0 decimal(8,2), @_q decimal(8,2), @_t decimal(8,2), @_X decimal(8,2), @_r decimal(8,2), @_s decimal(8,2)) 
RETURNS decimal(8,2)
BEGIN
	Declare @@_t decimal(8,2), @_d1 decimal(8,2), @_d2 decimal(8,2)

	set @@_t = @_t;
	if @_t < 0
	Begin
		set @@_t = 0;
	END
	set @_d1 = BS.D1(@_s0, @_X, @@_t, @_r, @_q, @_s);
	set @_d2 = BS.D2(@_d1, @_s, @@_t);
    RETURN @_X * Exp(-1*@_r*@@_t) * BS.CND(-1*@_d2) - @_s0 * Exp(-1*@_q*@@_t) * BS.CND(-1*@_d1);
END