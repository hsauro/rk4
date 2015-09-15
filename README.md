# rk4
Implements a basic 4th order Runge-Kutta in Object Pascal. Solves a set of ordinary differential equations:

dy/dt = f (y, t)

where y is a vector. 

```javascript
class procedure TMySystem.func (time : double; y, p, dydt : TDoubleDynArray);
begin
  dydt[0] := p[0] - p[1]*y[0];
  dydt[1] := p[1]*y[0]  - p[2]*y[1];
end;
```
