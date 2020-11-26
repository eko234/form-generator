#lang racket

(require racket/contract)
(require racket/pretty)

(define input-types (list 'STR 'INT 'CASH 'DATE 'PICK-F 'PICK-S))

; <UNITNAME> must be replaced before using the returned template

(define file-design-template ;2 placeholders
"
inheritedTFRM<UNITNAME>
  clientHeight = 600
  clientWidth = 1000
  caption = ~a
  BorderStyle = bsNone
  FormStyle = fsMDIChild
  Position = poScreenCenter
  Visible = True
  Layout = 'form'
  ExplicitWidth = 1000
  ExplicitHeight = 600
  PixelPerInch = 96
  TextHeight = 13
~a
end
")

(define file-code-template ;3 placeholders
"
unit <UNITNAME>;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm;
type
  TFRM<UNITNAME> = class(TUniForm)
// components
~a
// procedures
~a 
  procedure UniFormCreate(Sender: TObject);
  private
  public
  end;
function FRM<UNITNAME> : T<UNITNAME>;
implementation
uses 
  uniGUIVars, MainModule, UniGUIApplication;
{$R *.dfm}
function FRM<UNITNAME> : T<UNITNAME>;
begin
  Result := T<UNITNAME>(UniMainModule.GetFormInstance(T<UNITNAME>))
end;
// mount
~a 
end.
")

(define on-create-picker-def-template ;1 placeholders
"
procedure TFRM~a.onCreate~a(sender:TObject);
"
)

(define on-create-picker-impl-template ;1 placeholders
"
procedure TFRM~a.onCreate~a(sender:TObject);
begin
  _PreparaDataset(uniConsulta,'query');
  while not uniConsulta.Eof do begin
    Combo.Items.Add(uniConsulta.Fields.Fields[0].AsString);
    uniConsulta.Next;
  end;
  uniConsulta.Close;
end;
"
)

(define (prepare-template template unit-name)
    (string-replace template "<UNITNAME>" unit-name))

(struct <field> (label input-type source order options))

(struct <form> ( unit-name
                 title
                 fields ))

(define (label-position o)
  (~a #:separator "\n"
   (format "Left = ~a" 30)
  (format "Top = ~a" (* o 100))))

(define (field-position o)
  (~a #:separator "\n"
   (format "Left = ~a" 100)
   (format "Top = ~a" (* o 100))))

(define (field-properties field)
  (define on-create (format "onCreate = ~create;"))
  (~a "una cosa"
      "otra cosa"))
; bind on create event to fill the select fields

(define (field->proc-defs field)
  (match field
         [(<field> label input-type source order options)
            (match input-type
                   ['PICK-S  (format on-create-picker-def-template)]
                   [_ ""])]
         [_ (raise "wrong pattern")]))

(define (field->proc-impls field)
  (match field
         [(<field> label input-type source order options)
            (match input-type
                   ['PICK-S (format on-create-picker-impl-template)]
                   [_ ""])]
         [_ (raise "wrong pattern")]))

(define (field->components field)
  (match field
     [(<field> label input-type source order options)
      (~a #:separator "\n" 
          (format "    uniLabel~a: TUniLabel;" source)
          (match input-type
           ['STR    (format "    uniDBEdit~a: TUniDBEdit;"                     source)]
           ['INT    (format "    uniDBNumberEdit~a: TUniDBNumberEdit;"         source)]
           ['CASH   (format "    uniDBNumberEdit~a: TUniDBNumberEdit;"         source)]
           ['DATE   (format "    uniDBDateTimePicker~a: TUniDBDateTimePicker;" source)]
           ['PICK-F (format "    uniDBComboBox~a: TUniDBComboBox;"             source)]
           ['PICK-S (format "    uniDBComboBox~a: TUniDBComboBox;"             source)]))]))

(define (field->design field)
  (match field
     [(<field> label input-type source order options)
      (~a #:separator "\n" 
          (format "    inherited uniLabel~a: TUniLabel" source)
          (label-position order)  
          "end"
          (match input-type
           ['STR    (format "    inherited uniDBEdit~a: TUniDBEdit"                     source)]
           ['INT    (format "    inherited uniDBNumberEdit~a: TUniDBNumberEdit"         source)]
           ['CASH   (format "    inherited uniDBNumberEdit~a: TUniDBNumberEdit"         source)]
           ['DATE   (format "    inherited uniDBDateTimePicker~a: TUniDBDateTimePicker" source)]
           ['PICK-F (format "    inherited uniDBComboBox~a: TUniDBComboBox"             source)]
           ['PICK-S (format "    inherited uniDBComboBox~a: TUniDBComboBox"             source)])
          (field-position order)
          (field-properties field)
          "end")]))

; FIELD CONSTRUCTOR
(define (mk-<field> label input-type source order [options null])
    (<field> label input-type source order options))

; EXAMPLE STRUCTURE
(define informacion-para-efectuar-liquidacion
    (<form> "INFORMACION_LIQUIDACION"
            "informacion para efectuar liquidacion" 
            (list (mk-<field> "Vigencia"            'DATE   'LIQ-VIG     1 )
                  (mk-<field> "Actividad Economica" 'PICK-S 'ACT-ECO     2  "select * from actividades-economicas" )
                  (mk-<field> "Ingresos Brutos"     'CASH   'LIQ-ING     3 )
                  (mk-<field> "Ingresos Fuera Mun"  'CASH   'LIQ-ING-EXT 4 )
                  (mk-<field> "Ingresos Netos"      'CASH   'LIQ-ING     5 ))))

(define (mk-file-code form)
  (define (stringify f)
     (apply ~a #:separator "\n" f))
  (match form
    [(<form> unit-name title fields)
      (define template_ (prepare-template file-code-template unit-name))
      (format template_ (stringify `(,@(map field->components fields)))
                        (stringify `(,@(map field->proc-defs  fields)))
                        (stringify `(,@(map field->proc-impls fields))))]
    [_ (raise "wrong pattern")]))

(define (mk-file-design form)
  (match form
    [(<form> unit-name title fields)
     (define template_ (prepare-template file-design-template unit-name))
     (format template_ title "components")
     (raise "TODO")]
    [_ (raise "wrong pattern")]))
