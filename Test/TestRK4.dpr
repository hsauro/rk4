program TestRK4;

uses
  Vcl.Forms,
  ufMain in 'ufMain.pas' {frmMain},
  ulibRK4 in '..\ulibRK4.pas',
  ulibRK45 in '..\ulibRK45.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
