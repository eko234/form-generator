#lang racket
(provide config)

(define config 
  (list 
   '( "INFORMACION-LIQUIDACION"               ;FORM-NAME
      "Informacion para efectuar liquidacion" ;FORM-TITLE
      "Vigencia"                              ;LABEL-TEXT
      'DATE                                   ;INPUT-TYPE
      "liquidacion_vigenciali"                ;DATA-FIELD
       1                                      ;POSITION
                                              ))

; (define informacion-para-efectuar-liquidacion
;     (<form> "INFORMACION_LIQUIDACION"
;             "informacion para efectuar liquidacion" 
;             (list (mk-<field> "Vigencia"            'DATE   'LIQ-VIG     1 )
;                   (mk-<field> "Actividad Economica" 'PICK-S 'ACT-ECO     2  "select * from actividades-economicas" )
;                   (mk-<field> "Ingresos Brutos"     'CASH   'LIQ-ING     3 )
;                   (mk-<field> "Ingresos Fuera Mun"  'CASH   'LIQ-ING-EXT 4 )
;                   (mk-<field> "Ingresos Netos"      'CASH   'LIQ-ING     5 ))))
