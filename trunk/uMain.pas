{
PixLock - Small utility for video editing.
Grasiani Da Ré dos Santos - 2010
grasianisantos@yahoo.com.br

pixLock is a proudly user of madExcept!
madExcept: http://madshi.net/madExceptDescription.htm

Where I get a lot of useful code for this project:

http://www.delphipages.com/forum/showthread.php?t=15928
http://delphi.about.com/od/delphitips2007/qt/rgb_cmyk.htm
http://delphi.about.com/od/adptips2006/qt/RgbToHsb.htm
http://delphi.about.com/od/adptips2006/qt/rgb2tcolor.htm
}

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, JvExMask, JvSpin, ComCtrls;

 type
    TRGBColor = record
      Red,
      Green,
      Blue : Integer;
    end;
 
    THSBColor = record
      Hue,
      Saturnation,
      Brightness : Double;
    end;

type
  TfMain = class(TForm)
    pnCor: TPanel;
    tmGetPixelColor: TTimer;
    pcOptions: TPageControl;
    tsData: TTabSheet;
    tsOptions: TTabSheet;
    tbAbout: TTabSheet;
    gbRGB: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblRed: TLabel;
    lblGreen: TLabel;
    lblBlue: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblHue: TLabel;
    lblSat: TLabel;
    lblBri: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CbEnabled: TCheckBox;
    edClock: TJvSpinEdit;
    Label1: TLabel;
    pnRed: TPanel;
    pnGreen: TPanel;
    pnBlue: TPanel;
    Label12: TLabel;
    EdRadius: TJvSpinEdit;
    Label8: TLabel;
    CbCalculate: TCheckBox;
    Label13: TLabel;
    Label14: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tmGetPixelColorTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edClockChange(Sender: TObject);
    procedure CbEnabledClick(Sender: TObject);
    procedure CbCalculateClick(Sender: TObject);
    procedure EdRadiusChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    UpAnRunning: Boolean; //wait for App to start
    Pxl:TBitmap;
		useCustomPos, calcRadius: Boolean;  //.ini file option
    Radius: Integer;                    //.ini file option
		customX, customY: Integer;
    function RGBToHSB(rgb : TRGBColor) : THSBColor;
    procedure SaveConf(Name: String; Value: Integer);
    function ReadConf(Name: String; DefaultValue: Integer = 0): Integer;
  public
    { Public declarations }
  end;

Const
  APP_NAME = 'PixLocker';
  CONF = 'Conf';
  iniRADIUS = 'Radius';
  iniINTERVAL = 'Interval';
  iniENABLED = 'Enabled';
  iniCALC = 'Calculate';

var
  fMain: TfMain;

implementation

Uses Math, inifiles;

{$R *.dfm}

procedure TfMain.FormCreate(Sender: TObject);
begin
  UpAnRunning := False;
  Radius := 0;
  calcRadius := False;
	customX := 0;
  customY := 0;
	useCustomPos := False;
	pncor.Caption := '';
  Pxl:=TBitmap.Create;
  Pxl.Width:=1;
  Pxl.Height:=1;

  pcOptions.ActivePageIndex := 0;
  pnRed.Caption := '';
  pnGreen.Caption := '';
  pnBlue.Caption := '';

  edClock.Value := ReadConf(iniINTERVAL,100);
  EdRadius.Value := ReadConf(iniRADIUS,10);
  CbEnabled.Checked := (ReadConf(iniENABLED,1) = 1);
  CbCalculate.Checked := (ReadConf(iniCALC) = 1);

  tmGetPixelColor.Interval := Trunc(edClock.Value);
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  P: TPoint;
begin
  if UpAnRunning then
  begin
    if Key = VK_F5 then //for debug purposes only ;)
      tmGetPixelColorTimer(Self);

  { TODO: User set his own shortcut
    if (ssCtrl in Shift) then
    begin
      if (ssShift in Shift) then
      begin   }
        if (Key = VK_F2) then
        begin
          if not useCustomPos then
          begin
            GetCursorPos(P);
            customX := P.x;
            customY := P.y;
            Self.Caption :=   APP_NAME + ' - Locked!';
          end
          else
            Self.Caption :=   APP_NAME + ' - Reloaded';
          useCustomPos := not useCustomPos;
        end; {
      end;
    end;  }
  end;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  UpAnRunning := True;
end;

procedure TfMain.tmGetPixelColorTimer(Sender: TObject);
type
   TIntegerArray = array[0..MaxInt div SizeOf(integer) - 1] of integer;
 PIntegerArray = ^TIntegerArray;
var
 scanLine : PIntegerArray;
	myColor: TColor;
  P: TPoint;
  hsb, mediaHSB: THSBColor;
  rgb, mediaRGB: TRGBColor;
  qtd: integer;

  function getColorFromXY(X, Y: Integer): TColor;
  begin
    if (X > 0) and (Y > 0) then
    begin
      BitBlt(Pxl.Canvas.Handle,0,0,1,1,GetDC(0),X ,Y,SRCCOPY);
      scanLine := Pxl.ScanLine[0];
      Result := scanLine^[0];
      //Result := Pxl.Canvas.Pixels[0,0];
    end
    else
      Result := 0;
  end;

  function getRGBfromColor(myColor: TColor):TRGBColor;
  begin
    Result.Red := GetRValue(myColor);
    Result.Green := GetGValue(myColor);
    Result.Blue := GetBValue(myColor);
  end;

  procedure DoCalc;
  begin
    inc(qtd);
    rgb := getRGBfromColor(myColor);
    hsb := RGBToHSB(rgb);
    mediaRGB.Red         := mediaRGB.Red   + rgb.Red;
    mediaRGB.Green       := mediaRGB.Green + rgb.Green;
    mediaRGB.Blue        := mediaRGB.Blue  + rgb.Blue;
    mediaHSB.Hue         := mediaHSB.Hue         + hsb.Hue;
    mediaHSB.Saturnation := mediaHSB.Saturnation + hsb.Saturnation;
    mediaHSB.Brightness  := mediaHSB.Brightness  + hsb.Brightness;
  end;

begin
  if UpAnRunning then
  begin
    //get mouse position
    if useCustomPos then
    begin
      P.x := customX;
      P.y := customY;
    end
    else
      GetCursorPos(P);

    //get color
    myColor := getColorFromXY(P.X, P.Y);
    if (myColor <> 0) then
    begin
      pnCor.Color := myColor;

      //get color info
      rgb := getRGBfromColor(myColor);
      hsb := RGBToHSB(rgb);

      //radius...
      mediaHSB := hsb;
      mediaRGB := rgb;
      {$REGION 'Media calculus'}
      qtd := 0;
      if calcRadius then
      begin
        if (Radius > 0) then
        begin
          myColor := getColorFromXY(P.X-radius, P.Y-radius); //1
          if (myColor <> 0) then
            DoCalc;

          myColor := getColorFromXY(P.X, P.Y-radius); //2
          if (myColor <> 0) then
            DoCalc;

          myColor := getColorFromXY(P.X+radius, P.Y-radius); //3
          if (myColor <> 0) then
            DoCalc;

          myColor := getColorFromXY(P.X-radius, P.Y); //4
          if (myColor <> 0) then
            DoCalc;

          myColor := getColorFromXY(P.X+radius, P.Y);//5
          if (myColor <> 0) then
            DoCalc;

          myColor := getColorFromXY(P.X-radius, P.Y+radius); //6
          if (myColor <> 0) then
            DoCalc;

          myColor := getColorFromXY(P.X, P.Y+radius);  //7
          if (myColor <> 0) then
            DoCalc;

          myColor := getColorFromXY(P.X+radius, P.Y+radius); //8
          if (myColor <> 0) then
            DoCalc;
          if (qtd > 0) then
          begin
            inc(qtd); //it already starts with the values from the original pixel.
            mediaRGB.Red         := Trunc(mediaRGB.Red /qtd);
            mediaRGB.Green       := Trunc(mediaRGB.Green /qtd);
            mediaRGB.Blue        := Trunc(mediaRGB.Blue /qtd);
            mediaHSB.Hue         := mediaHSB.Hue /qtd;
            mediaHSB.Saturnation := mediaHSB.Saturnation /qtd;
            mediaHSB.Brightness  := mediaHSB.Brightness /qtd;
          end;
        end;
      end;
      {$ENDREGION}
      //show info about this color
      lblRed.Caption   := IntToStr(mediaRGB.Red);
      lblGreen.Caption := IntToStr(mediaRGB.Green);
      lblBlue.Caption  := IntToStr(mediaRGB.Blue);
      lblHue.Caption   := FormatFloat('###,##0',mediaHSB.Hue);
      lblSat.Caption   := FormatFloat('###,##0',mediaHSB.Saturnation);
      lblBri.Caption   := FormatFloat('###,##0',mediaHSB.Brightness);

      //panels "progress bars"...
      pnRed.Width := mediaRGB.Red;
      pnGreen.Width := mediaRGB.Green;
      pnBlue.Width := mediaRGB.Blue;
    end;
  end;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    SaveConf(iniENABLED,IfThen(CbEnabled.Checked,1,0));
    SaveConf(iniCALC,IfThen(CbCalculate.Checked,1,0));
    SaveConf(iniRADIUS,Trunc(EdRadius.Value));
    SaveConf(iniINTERVAL,Trunc(edClock.Value));

   Pxl.Free;
end;

function TfMain.ReadConf(Name: String; DefaultValue: Integer = 0): Integer;
var
  IniFile : TIniFile;
begin
  IniFile := Nil;
  try
    try
      IniFile := TIniFile.Create(
        IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))
        + ChangeFileExt(ExtractFileName(Application.ExeName),'.ini'));
      Result := IniFile.ReadInteger(CONF,Name,DefaultValue);
    except
      Result := 0;
    end;
  finally
    IniFile.Free;
  end;
end;

function TfMain.RGBToHSB(rgb: TRGBColor): THSBColor;
 var
    minRGB, maxRGB, delta : Double;
    h , s , b : Double ;
 begin
    H := 0.0 ;
    minRGB := Min(Min(rgb.Red, rgb.Green), rgb.Blue) ;
    maxRGB := Max(Max(rgb.Red, rgb.Green), rgb.Blue) ;
    delta := ( maxRGB - minRGB ) ;
    b := maxRGB ;
    if (maxRGB <> 0.0) then 
		  s := 255.0 * Delta / maxRGB
    else 
		  s := 0.0;
    if (s <> 0.0) then
    begin
      if rgb.Red = maxRGB then 
			  h := (rgb.Green - rgb.Blue) / Delta
      else
        if rgb.Green = maxRGB then 
				  h := 2.0 + (rgb.Blue - rgb.Red) / Delta
        else
          if rgb.Blue = maxRGB then 
					  h := 4.0 + (rgb.Red - rgb.Green) / Delta
    end
    else 
		  h := -1.0;
    h := h * 60 ;
    if h < 0.0 then 
		  h := h + 360.0;
    with result do
    begin
      Hue := h;
      Saturnation := s * 100 / 255;
      Brightness := b * 100 / 255;
    end;
 end; 

procedure TfMain.SaveConf(Name: String; Value: Integer);
var
  IniFile : TIniFile;
begin
  IniFile := Nil;
  try
    IniFile := TIniFile.Create(
      IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))
      + ChangeFileExt(ExtractFileName(Application.ExeName),'.ini'));
    IniFile.WriteInteger(CONF,Name,Value);
  finally
    IniFile.Free;
  end;
end;

procedure TfMain.edClockChange(Sender: TObject);
begin
  if UpAnRunning then
  begin
	  tmGetPixelColor.Interval := Trunc(edClock.Value);
  end;
end;

procedure TfMain.EdRadiusChange(Sender: TObject);
begin
  if UpAnRunning then
  begin
    Radius := Trunc(EdRadius.Value);
  end;
end;

procedure TfMain.CbCalculateClick(Sender: TObject);
begin
  if UpAnRunning then
  begin
    calcRadius := CbCalculate.Checked;
  end;
end;

procedure TfMain.CbEnabledClick(Sender: TObject);
begin
  if UpAnRunning then
  begin
  	tmGetPixelColor.Enabled := CbEnabled.Checked;
  end;
end;

end.
