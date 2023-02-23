unit untPrincipal;

interface

uses
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  System.ImageList, FMX.ImgList, FMX.ListView, FMX.MultiView, FMX.Objects,
  FMX.Types, FMX.Controls, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Forms, System.Classes;

type
  TSorteio = array of integer;

  TfrmPrincipal = class(TForm)
    ToolBar1: TToolBar;
    Button_Menu: TButton;
    MultiView_Menu: TMultiView;
    ImageList_Menu: TImageList;
    ListView_Menu: TListView;
    ImageList_Fichas: TImageList;
    Image_Tabuleiro: TImage;
    Button1: TButton;
    StyleBook1: TStyleBook;
    Label_TempoDecorrido: TLabel;
    Timer1: TTimer;
    Image1: TImage;
    Image28: TImage;
    Image2: TImage;
    Image18: TImage;
    Image29: TImage;
    Image4: TImage;
    Image26: TImage;
    Image24: TImage;
    Image21: TImage;
    Image16: TImage;
    Image32: TImage;
    Image13: TImage;
    Image15: TImage;
    Image14: TImage;
    Image20: TImage;
    Image23: TImage;
    Image25: TImage;
    Image7: TImage;
    Image5: TImage;
    Image3: TImage;
    Image6: TImage;
    Image27: TImage;
    Image22: TImage;
    Image19: TImage;
    Image17: TImage;
    Image31: TImage;
    Image11: TImage;
    Image12: TImage;
    Image10: TImage;
    Image8: TImage;
    Image9: TImage;
    Image30: TImage;
    Rectangle1: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure ListView_MenuItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Draw;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FSorteio: TSorteio;
    FInicio: TDateTime;
    function FoiSorteada(Ficha: Integer): Boolean;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

const
  Posicoes = 32;

implementation

uses
  System.SysUtils;

{$R *.fmx}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  Self.Timer1.Enabled := False;
end;

procedure TfrmPrincipal.Draw;
var
  Contador, Ficha: Integer;
begin
  SetLength(Self.FSorteio, 0);
  SetLength(Self.FSorteio, 9);

  for Contador := 0 to Length(Self.FSorteio) -1 do
  begin
    repeat
      Ficha := Random(Posicoes +1)
    until NOT Self.FoiSorteada(Ficha);

    Self.FSorteio[Contador] := Ficha;
  end;

  Ficha := 0;
  for Contador := 0 to Self.Image_Tabuleiro.ChildrenCount -1 do
  begin
    if ( Self.FoiSorteada(Contador) ) then
      begin
        TImage(Self.Image_Tabuleiro.Children.Items[Contador]).Bitmap := ImageList_Fichas.Bitmap(Image1.Size.Size, Ficha);
        Inc(Ficha);
      end
    else
      TImage(Self.Image_Tabuleiro.Children.Items[Contador]).Bitmap.Clear($00000000);
  end;

  Self.FInicio := Now;
  Self.Timer1.Enabled := True;
end;

function TfrmPrincipal.FoiSorteada(Ficha: Integer): Boolean;
var
  Contador: Integer;
begin
  Result := False;

  if (Ficha = 0) then Exit;  

  for Contador := 0 to Length(Self.FSorteio) -1 do
  begin
    if (Self.FSorteio[Contador] = Ficha) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  Item: TListViewItem;
begin
  Item := Self.ListView_Menu.Items.Add;

  Item.ImageIndex := 1;
  Item.IndexTitle := 'Sortear';
  Item.Detail := 'Sortear um modelo';
  Item.TagString := 'draw';

  Self.FInicio := 0;
  Self.Timer1.Enabled := False;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  Self.Rectangle1.Width := Self.Width;
  Self.Rectangle1.Height := Self.Image_Tabuleiro.Height;
end;

procedure TfrmPrincipal.ListView_MenuItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  if (AItem.TagString = 'draw') then
  begin
    Self.Draw;
    Self.MultiView_Menu.HideMaster;
  end;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  Self.Label_TempoDecorrido.Text := FormatDateTime('hh:nn:ss.zzz', Now - Self.FInicio);
end;

end.
