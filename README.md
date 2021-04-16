# Black-Scholes-SQL
This project is work in progress to convert original MySQL version into SQL-Server version.
Black Scholes Formulas written in SQL Server (T-SQL).

Variables used:
    
    @_s0 - Stock (/ underlying) price
    
    @_t - Time to expiry (in what unit Years / days / hours?)
    
    @_X - exercise Price (or strike price)
    
    @_r - Risk free interest rate
    
    @_s - Sigma (Implied Volatility)
    
    @_P - Current option price
    
    @_q - ????

Option price:

    CallPrice (_S0 double, _q double, _t double, _X double, _r double, _s double) 

    PutPrice (_S0 double, _q double, _t double, _X double, _r double, _s double) 
    
    ImpliedVolatility(_CallPut int, _S0 double, _q double, _t double, _X double, _r double, _P double)

Greeks:

    Delta(_CallPut int, _S0 double, _q double, _t double, _X double, _r double, _s double) 

    Gamma(_S0 double, _q double, _t double, _X double, _r double, _s double) 

    Theta(_CallPut int, _S0 double, _q double, _t double, _X double, _r double, _s double) 

    Vega(_S0 double, _q double, _t double, _X double, _r double, _s double) 

    Rho(_CallPut int, _S0 double, _q double, _t double, _X double, _r double, _s double) 

Advanced Greeks:

    Volga(_S0 double, _q double, _t double, _X double, _r double, _s double) 

    Colour(_S0 double, _q double, _t double, _X double, _r double, _s double) 

    Charm(_CallPut int, _S0 double, _q double, _t double, _X double, _r double, _s double) 

    Speed(_S0 double, _q double, _t double, _X double, _r double, _s double) 
