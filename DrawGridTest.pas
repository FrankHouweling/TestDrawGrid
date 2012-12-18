unit DrawGridTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Grids, Data.DB,
  Datasnap.DBClient, Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TForm1 = class(TForm)
    DrawGrid: TDrawGrid;
    BtnOpslaan: TButton;
    CDS: TClientDataSet;
    Image1: TImage;
    BtnWeergeven: TButton;
    procedure FormCreate(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtnOpslaanClick(Sender: TObject);
    procedure BtnWeergevenClick(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);

  private
    procedure Setparams(Parameters: array of variant);

  public

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnOpslaanClick(Sender: TObject);
begin
  Setparams();
end;

procedure TForm1.Setparams(Parameters: array of Variant);
var
  CDS : TClientDataSet;
begin

  CDS := TClientDataSet.Create;

  try
    with CDS do
      begin
        FieldDefs.Add('Anton', ftString, 50);
        CreateDataSet;
        Active := True;
        Append;
        FieldByName('Anton').Value := Parameters[0];
        Post;
        SaveToFile('C:\Users\avandervlugt\Dropbox\Anton en Jaap-Willem\Anton');
      end;
  finally
    CDS.Free;
  end;
end;

procedure TForm1.BtnWeergevenClick(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawGrid.Canvas.StretchDraw(Rect, Image1.Picture.Graphic);
end;

procedure TForm1.DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawGrid.Canvas.StretchDraw(Rect, Image1.Picture.Graphic);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  with DrawGrid do
    begin
      ColCount         := 1;
      FixedCols        := 0;
      FixedRows        := 0;
      RowCount         := 1;
      DefaultColWidth  := 86;
      DefaultRowHeight := 86;
    end;

end;

end.
