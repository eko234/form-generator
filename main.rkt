#lang racket

(require racket/contract)
(require racket/pretty)

(define input-types (list 'STR 'INT 'CASH 'DATE 'PICK-F 'PICK-S))

(define file-design-template
"
")

(define file-code-template ; <UNITNAME> must be replaced before using the returned template
"unit <UNITNAME>;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm;
type
  TFRM<UNITNAME> = class(TUniForm)
    procedure UniFormCreate(Sender: TObject);
~a
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
~a
end.
")


(define (prepare-template template unit-name)
    (string-replace template "<UNITNAME>" unit-name))

(define (mk-file-design form)
    (define template_ (prepare-template file-design-template (<form>-title form)))
    (raise "TODO"))

(struct <field> (label input-type source options constraints))

(struct <form> ( unit-name
                 title
                 fields ))

(define (field->design field)
  (raise "TODO"))

(define (field->code field)
  (match field
     [(<field> label input-type source options constraints)
      (~a #:separator "\n" 
          (format "    uniLabel~a: TUniLabel;" source)
          (match input-type
           ['STR    (format "    uniDBEdit~a: TUniDBEdit;"                     source)]
           ['INT    (format "    uniDBNumberEdit~a: TUniDBNumberEdit;"         source)]
           ['CASH   (format "    uniDBNumberEdit~a: TUniDBNumberEdit;"         source)]
           ['DATE   (format "    uniDBDateTimePicker~a: TUniDBDateTimePicker;" source)]
           ['PICK-F (format "    uniDBComboBox~a: TUniDBComboBox;"             source)]
           ['PICK-S (format "    uniDBComboBox~a: TUniDBComboBox;"             source)]))]))

(define (mk-<field> label input-type source [options null] [constraints null])
    (<field> label input-type source options constraints))

; add contract to make options mandatory if pick fixed is chosed
; options can be a select statement that determines the posible values a select can take

(define informacion-para-efectuar-liquidacion
    (<form> "INFORMACION_LIQUIDACION"
            "informacion para efectuar liquidacion" 
            (list (mk-<field> "Vigencia"            'DATE        'LIQ-VIG  )
                  (mk-<field> "Actividad Economica" 'PICK-S      'ACT-ECO "select * from actividades-economicas" )
                  (mk-<field> "Ingresos Brutos"     'CASH        'LIQ-ING )
                  (mk-<field> "Ingresos Fuera Mun"  'CASH        'LIQ-ING-EXT )
                  (mk-<field> "Ingresos Netos"      'CASH        'LIQ-ING ))))

; the most important thing is the datasource of the liquidation, there the checks must be very precise
                
(define (mk-file-code form)
  (match form
    [(<form> unit-name title fields)
        (define template_ (prepare-template file-code-template unit-name))
        (format template_ (apply ~a #:separator "\n" `(,@(map field->code fields))) "//write functions here nigger")]
    [_ (raise "wrong pattern boy")]))

;(pretty-display (field->code (car (<form>-fields informacion-para-efectuar-liquidacion))))
; (pretty-display (mk-file-code informacion-para-efectuar-liquidacion))
