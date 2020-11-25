#lang racket

(require racket/contract)

(define input-types (list 'STRING 'INT 'CASH 'DATE 'PICK-FIXED 'PICK-SOURCE))

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

(define (mk-prop field)
    (~a #:separator "\n" ( fields)))

(define (prepare-template template unit-name)
    (string-replace template "<UNITNAME>" unit-name))

(define (mk-file-design form)
    (define template_ (prepare-template file-design-template (<form>-title form)))
    (raise "TODO"))


(define (mk-file-code form)
    (define template_ (prepare-template file-code-template (<form>-title form)))
    (match form-data
        [(list a b) 
            (format template_ a b)
            (raise "TODO")]
        [_ (raise "wrong pattern boy")]))

(print (mk-file-form "RECAUDO" (list)))

(struct <field> ( label input-type source [options null] [constraints null] ) )
(define (mk-<field> label input-type source [options null] [constraints null])
    (<input> input-type source options constraints))

; add contract to make options mandatory if pick fixed is chosed
; options can be a select statement that determines the posible values a select can take

(define informacion-para-efectuar-liquidacion
    (<form> "INFORMACION_LIQUIDACION"
            "informacion para efectuar liquidacion" 
            (list (mk-<field> "Vigencia"            'DATE        'LIQ-VIG  )
                  (mk-<field> "Actividad Economica" 'PICK-SOURCE 'ACT-ECO "select * from actividades-economicas" )
                  (mk-<field> "Ingresos Brutos"     'CASH        'LIQ-ING )
                  (mk-<field> "Ingresos Fuera Mun"  'CASH        'LIQ-ING-EXT )
                  (mk-<field> "Ingresos Netos"      'CASH        'LIQ-ING ))))

; the most important thing is the datasource of the liquidation, there the checks must be very precise

(struct <form> ( unit-name
                 title
                 fields ))
                 