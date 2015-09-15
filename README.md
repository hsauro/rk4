# rk4
Implements a basic 4th order Runge-Kutta in Object Pascal. Solves a set of ordinary differential equations of the form:

dy/dt = f (t, y,  p)

where t is the independent variable, y a vector of dependent variables and p a vector of parameters.

```javascript
type
  TMySystem = class (TObject)
    class procedure func (time : double; var y, p, dydt : array of double);
  end;
  
class procedure TMySystem.func (time : double; var y, p, dydt : array of double);
begin
  dydt[0] := p[0] - p[1]*y[0];
  dydt[1] := p[1]*y[0]  - p[2]*y[1];
end;

rk4 := TRK4.Create (2, 3, TMySystem.func);
rk4.p[0] := vo; rk4.p[1] := k1; rk4.p[2] := k2;

stepSize := 0.05;
numberOfsteps := 20;
for i := 0 to numberOfsteps - 1 do
  // y is updated at each interation
   startTime := rk4.eval (startTime, y, stepSize);
```
