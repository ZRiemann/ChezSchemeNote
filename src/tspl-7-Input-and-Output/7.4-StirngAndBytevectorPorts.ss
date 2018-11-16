#!/usr/bin/scheme --script

(display "
================================================================================
Section 7.4. String and Bytevector Ports
")
(let-values ([(op g) (open-bytevector-output-port)])
  (put-u8 op 15)
  (put-u8 op 73)
  (put-u8 op 115)
  (set-port-position! op 2)
  (let ([bv1 (g)])
    (put-u8 op 27)
    (list bv1 (g)))) ;; (#vu8(15 73 115) #vu8(27))

(let-values ([(op g) (open-string-output-port)])
  (put-string op "some data")
  (let ([str1 (g)])
    (put-string op "new stuff")
    (list str1 (g)))) ;; ("some data" "new stuff")

(let ([tx (make-transcoder (latin-1-codec) (eol-style lf)
            (error-handling-mode replace))])
  (call-with-bytevector-output-port
    (lambda (p) (put-string p "abc"))
    tx)) ;; #vu8(97 98 99)

(define (object->string x)
  (call-with-string-output-port
    (lambda (p) (put-datum p x)))) 

(object->string (cons 'a '(b c))) ;; "(a b c)"

