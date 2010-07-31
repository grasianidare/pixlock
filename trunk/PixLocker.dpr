program PixLocker;

uses
  Forms,
  uMain in 'uMain.pas' {fMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PixLocker';
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
