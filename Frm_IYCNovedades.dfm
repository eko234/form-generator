inherited FrmIYCNovedades: TFrmIYCNovedades
  ClientHeight = 612
  ClientWidth = 1159
  Caption = 'Novedades'
  BorderStyle = bsDialog
  FormStyle = fsMDIChild
  Position = poScreenCenter
  Visible = True
  Layout = 'form'
  ExplicitWidth = 1175
  ExplicitHeight = 651
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelBotones: TUniPanel
    Width = 1159
    ExplicitWidth = 1159
  end
  inherited UniStatusBar1: TUniStatusBar
    Top = 593
    Width = 1159
    ExplicitTop = 593
    ExplicitWidth = 1159
  end
  inherited UniPanelMaestro: TUniPanel
    Width = 1159
    Height = 561
    ExplicitWidth = 1159
    ExplicitHeight = 561
    inherited UniPageControlMaestra: TUniPageControl
      Width = 1157
      Height = 559
      ExplicitWidth = 1157
      ExplicitHeight = 559
      inherited UniTabSheetMaestraListado: TUniTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 1149
        ExplicitHeight = 531
        inherited UniDBGridMaestro: TUniDBGrid
          Width = 1149
          Height = 531
          Columns = <
            item
              FieldName = 'ID_UNIDAD_ECONOMICA_CONCEPTO'
              Title.Caption = 'Consecutivo'
              Width = 76
              ReadOnly = True
            end
            item
              FieldName = 'ID_UNIDAD_ECONOMICA'
              Title.Caption = 'Id Unidad Economica'
              Width = 128
              Visible = False
            end
            item
              FieldName = 'ID_CONCEPTO'
              Title.Caption = 'Id Concepto'
              Width = 76
            end
            item
              FieldName = 'CODIGO_CONCEPTO'
              Title.Caption = 'Codigo Concepto'
              Width = 124
              ReadOnly = True
            end
            item
              FieldName = 'DESCRIPCION_CONCEPTO'
              Title.Caption = 'Descripcion Concepto'
              Width = 244
              ReadOnly = True
            end
            item
              FieldName = 'ID_ACTIVIDAD'
              Title.Caption = 'Id Actividad'
              Width = 76
              ReadOnly = True
            end
            item
              FieldName = 'CODIGO_ACTIVIDAD'
              Title.Caption = 'Codigo Actividad'
              Width = 124
              ReadOnly = True
            end
            item
              FieldName = 'DESCRIPCION_ACTIVIDAD'
              Title.Caption = 'Descripcion Actividad'
              Width = 1204
              ReadOnly = True
            end
            item
              FieldName = 'ANNO'
              Title.Caption = 'Anno'
              Width = 64
            end
            item
              FieldName = 'VALOR'
              Title.Caption = 'Valor'
              Width = 64
            end
            item
              FieldName = 'VALOR_PERIODO'
              Title.Caption = 'Valor Periodo'
              Width = 89
              ReadOnly = True
            end
            item
              FieldName = 'APLICAR_RECARGO'
              Title.Caption = 'Aplicar Recargo'
              Width = 102
            end
            item
              FieldName = 'FORMA_DE_REGISTRO'
              Title.Caption = 'Forma de Registro'
              Width = 116
              ReadOnly = True
            end
            item
              FieldName = 'FECHA_REGISTRO'
              Title.Caption = 'Fecha Registro'
              Width = 94
              ReadOnly = True
            end
            item
              FieldName = 'ID_USUARIO'
              Title.Caption = 'Id Usuario'
              Width = 124
              ReadOnly = True
            end>
        end
      end
    end
  end
  inherited DataSourceMaestro: TDataSource
    DataSet = DMIYC.Novedades
  end
end
