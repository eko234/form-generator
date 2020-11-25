unit Frm_IYCNovedades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frm_EstandarGrilla, Vcl.ImgList,
  uniImageList, DBAccess, Uni, uniGUIBaseClasses, uniGUIClasses, Vcl.DBActns,
  Vcl.ActnList, Vcl.Menus, uniMainMenu, Data.DB, uniBasicGrid, uniDBGrid,
  uniPageControl, uniStatusBar, uniDBNavigator, uniButton, uniBitBtn,
  uniSpeedButton, uniPanel, DM_IyC, DM_GNR, MainModule, UnitBiblioteca,
  System.ImageList, System.Actions;

type
  TFrmIYCNovedades = class(TFrmEstandarGrilla)
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



function FrmIYCNovedades: TFrmIYCNovedades;
implementation

{$R *.dfm}





function FrmIYCNovedades: TFrmIYCNovedades;
begin
  Result := TFrmIYCNovedades(UniMainModule.GetFormInstance(TFrmIYCNovedades));
end;


procedure TFrmIYCNovedades.UniFormCreate(Sender: TObject);
begin
  _LimpiarDatasets(Datasets);
  Datasets[1].Titulo  :=  'Novedades';
  Datasets[1].Dataset :=  DMIYC.Novedades;
  EstiloFiltro        :=  efLibre;
  ClausulaWhere       :=  '';
  ClausulaWhereFiltro :=  '';
  inherited;
end;




end.
