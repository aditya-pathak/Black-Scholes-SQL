CREATE FUNCTION BS.D1(@_s0 decimal(8,2), @_X decimal(8,2), @_t decimal(8,2), @_r decimal(8,2), @_q decimal(8,2), @_s decimal(8,2))
RETURNS decimal(8,2)
BEGIN
    RETURN (Log(@_s0/@_X)+@_t*(@_r-@_q+Power(@_s,2)/2))/(@_s*Sqrt(@_t));
END