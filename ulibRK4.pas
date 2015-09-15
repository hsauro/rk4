unit ulibRK4;

interface

Uses Classes, Types, SysUtils;

// Implements a basic Runge-Kutta integrator
// Derived from older code
// Date: 3 Jan, 2015

// How to use:

// Declare your function that contains the differential equations:
// Arguments include the independent variable time, y the dependent variables,
// p any parameters that are needed by the equations and dydt which must
// return the rates of change.
//
// The function must be part of an object but can be a class method which
// saves having to instantiate the object
// Eg
// TMySystem = class (TObject)
//   class procedure func (time : double; y, p, dydt : TDoubleDynArray);
// end;

//class procedure TMySystem.func (time : double; y, p, dydt : TDoubleDynArray);
//begin
//  dydt[0] := p[0] - p[1]*y[0];
//  dydt[1] := p[1]*y[0]  - p[2]*y[1];
//end

// Create RK4 object
// First argument = number of differential equations
// Second argument = number of parameters in the differential eqautions (if any)
// Third argument = reference to the differential equation function

// rk4 := TRK4.Create (2, 3, TMySystem.func);
// Set up the y variable array
// setLength (y, n);
// Assign initial values to y
// y[0] := 0; etc
// Assign any parameter values
// rk4.p[0] := 2.3; etc
// Run eval to get next time step
// newTime := rk4.eval (startTime, y, stepSize);


type
   TODEFunction = procedure (time : double; y, p, dydt : TDoubleDynArray) of object;

   TRK4 = class (TObject)
     private
       nv, np : integer;    // Number of equations to solve
       odeFunc : TODEFunction;
       // Temporary workspace
       dydt : TDoubleDynArray;
       k1, k2, k3, k4 : TDoubleDynArray;
       yTmp : TDoubleDynArray;
     public
       p : TDoubleDynArray;   // System Parameters
       constructor Create (nv, np : integer; odeFunc : TODEFunction);
       destructor  Destroy; override;
       function    eval (time : double; y : TDoubleDynArray; stepSize : double) : double;
   end;

implementation

const oneSixth : double = 1/6;

// nv = number of differential equations
// np = number of parameters, if any
// odeFunc = Function that evaluates the dydt values
constructor TRK4.Create (nv, np: integer; odeFunc : TODEFunction);
begin
  inherited Create;
  self.nv := nv;
  self.np := np;
  self.odeFunc := odeFunc;
  setLength (dydt, nv);
  setLength (yTmp, nv);
  setLength (k1, nv);
  setLength (k2, nv);
  setLength (k3, nv);
  setLength (k4, nv);
  setLength (p, np);
end;

destructor TRK4.Destroy;
begin
  setLength (dydt, 0);
  setLength (yTmp, 0);
  setLength (k1, 0);
  setLength (k2, 0);
  setLength (k3, 0);
  setLength (k4, 0);
  setLength (p, 0);
  inherited Destroy;
end;


// time = current value for independent variable
// y = current values for dependent variables
// stepSize = step size to next solution
// Returns the new time (time + stepSize)
//
// newTime = rk4.eval (currentTime, y, 0.1)
//
function TRK4.eval (time : double; y : TDoubleDynArray; stepSize : double) : double;
var xh2, h6, half_stepSize : double;
    i : integer;
begin
  half_stepSize := 0.5*stepSize; // h.2
  xh2 := time + half_stepSize;   // t + h/2

  // k1 = f (t, y)
  odeFunc (time, y, p, k1);

  // k2 = f (t + h/2, y + 0.5*k1)
  for i := 0 to nv - 1 do
      yTmp[i] := y[i] + half_stepSize*k1[i];
  odeFunc (xh2, yTmp, p, k2);

  // k3 =  f(t + h/2, y + 0.5*k2)
  for i := 0 to nv - 1 do
      yTmp[i] := y[i] + half_stepSize*k2[i];
  odeFunc (xh2, y, p, k3);

  // k4 = f (t + h, y + k3*h)
  for i := 0 to nv - 1 do
      yTmp[i] := y[i] + stepSize*k3[i];
  odeFunc (time + stepSize, y, p, k4);

  h6 := stepSize*oneSixth;
  for i := 0 to nv - 1 do
      y[i] := y[i] + h6*(k1[i] + 2*(k2[i] + k3[i]) + k4[i]);
  result := time + stepSize;
end;

end.
