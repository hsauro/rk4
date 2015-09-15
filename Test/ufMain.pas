unit ufMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ulibRK4, Vcl.StdCtrls, Types,
  Vcl.ExtCtrls;

type
  TMySystem = class (TObject)
    class procedure func (time : double; var y, p, dydt : array of double);
  end;

  TfrmMain = class(TForm)
    memo: TMemo;
    Panel1: TPanel;
    Label3: TLabel;
    Panel2: TPanel;
    btnRun: TButton;
    Label1: TLabel;
    edtStepSize: TEdit;
    Label2: TLabel;
    edtNumberOfSteps: TEdit;
    procedure btnRunClick(Sender: TObject);
  private
    { Private declarations }
    vo, k1, k2 : double;
  public
    { Public declarations }
    procedure computeExpected (time : double; var y: array of double);
    procedure addActualAndExpected (time : double; var y : array of double);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

// Analytical solution derived from Mathematica
//A[t]->(vo-E^(-k1 t) vo)/k1,B[t]->((k1-E^(-k2 t) k1+(-1+E^(-k1 t)) k2) vo)/((k1-k2) k2)
procedure TfrmMain.computeExpected (time : double; var y : array of double);
begin
  y[0] := (vo-exp(-k1*time)*vo)/k1;
  y[1] := ((k1-exp(-k2*time)*k1+(-1+exp(-k1*time))*k2)*vo)/((k1-k2)*k2);
end;

class procedure TMySystem.func (time : double; var y, p, dydt : array of double);
begin
  dydt[0] := p[0] - p[1]*y[0];
  dydt[1] := p[1]*y[0]  - p[2]*y[1];
end;

procedure TfrmMain.addActualAndExpected (time : double; var y : array of double);
var str : string;
    yExpected : TDoubleDynArray;
begin
  setLength (yExpected, 2);
  computeExpected (time, yExpected);
  str := Format ('%12.5f, %12.5f, %12.5f, %12.5f, %12.5f, %12.5f, %12.5f', [time, y[0], y[1], yExpected[0], yExpected[1], y[0]-yExpected[0], y[1]-yExpected[1]]);
  memo.Lines.Add(str);
end;


procedure TfrmMain.btnRunClick(Sender: TObject);
var rk4 : TRK4;
    startTime : double;
    y : TDoubleDynArray;
    i : integer;
    stepSize : double;
    numberOfsteps : integer;
begin
  vo := 1.2;
  k1 := 0.34;
  k2 := 0.78;
  setLength (y, 2);
  y[0] := 0; y[1] := 0;
  startTime := 0;
  memo.Clear;
  memo.Lines.Add (Format ('%12s, %12s, %12s, %12s, %12s, %12s, %12s', ['Time', 'y0', 'y1', 'Expected_0', 'Expected_1', 'Error_0', 'Error_1']));
  addActualAndExpected (startTime, y);

  rk4 := TRK4.Create (2, 3, TMySystem.func);
  rk4.p[0] := vo; rk4.p[1] := k1; rk4.p[2] := k2;

  stepSize := strToFloat (edtStepSize.Text);
  numberOfsteps := strtoInt (edtNumberOfSteps.Text);
  for i := 0 to numberOfsteps - 1 do
     begin
     startTime := rk4.eval (startTime, y, stepSize);
     addActualAndExpected (startTime, y);
     end;
  // Scroll memo back to top
  memo.SelStart := 0; memo.SelLength := 0;
end;

end.
