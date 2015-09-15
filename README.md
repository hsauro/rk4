# rk4
Implements a basic 4th order Runge-Kutta in Object Pascal. Solves a set of ordinary differential equations:

dy/dt = f (y, t)

where y is a vector. 

```javascript
type
  TMySystem = class (TObject)
    class procedure func (time : double; y, p, dydt : TDoubleDynArray);
  end;
  
class procedure TMySystem.func (time : double; y, p, dydt : TDoubleDynArray);
begin
  dydt[0] := p[0] - p[1]*y[0];
  dydt[1] := p[1]*y[0]  - p[2]*y[1];
end;

rk4 := TRK4.Create (2, 3, TMySystem.func);
rk4.p[0] := vo; rk4.p[1] := k1; rk4.p[2] := k2;

tepSize := strToFloat (edtStepSize.Text);
umberOfsteps := strtoInt (edtNumberOfSteps.Text);
for i := 0 to numberOfsteps - 1 do
   startTime := rk4.eval (startTime, y, stepSize);



```
