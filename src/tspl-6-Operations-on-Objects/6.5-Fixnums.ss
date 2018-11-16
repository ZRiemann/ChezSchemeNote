#!/usr/bin/scheme --script

(display "
================================================================================
Section 6.5.Fixnums
")

(fixnum? 0) ;; #t
(fixnum? -1) ;; #t
(fixnum? (- (expt 2 23))) ;; #t
(fixnum? (- (expt 2 23) 1)) ;; #t

(fixnum? (- (least-fixnum) 1)) ;; #f
(fixnum? (least-fixnum)) ;; #t
(fixnum? (greatest-fixnum)) ;; #t
(fixnum? (+ (greatest-fixnum) 1)) ;; #f
(least-fixnum)  ;; -1152921504606846976
(greatest-fixnum) ;; 1152921504606846975
(fixnum-width) ;;

(define w (fixnum-width))
(= (least-fixnum) (- (expt 2 (- w 1)))) ;; #t
(= (greatest-fixnum) (- (expt 2 (- w 1)) 1)) ;; #t
(>= w 24) ;; #t

(fx=? 0 0) ;; #t
(fx=? -1 1) ;; #f
(fx<? (least-fixnum) 0 (greatest-fixnum)) ;; #t
(let ([x 3]) (fx<=? 0 x 9)) ;; #t
(fx>? 5 4 3 2 1) ;; #t
(fx<=? 1 3 2) ;; #f
(fx>=? 0 0 (least-fixnum)) ;; #t

(fxzero? 0) ;; #t
(fxzero? 1) ;; #f 

(fxpositive? 128) ;; #t
(fxpositive? 0) ;; #f
(fxpositive? -1) ;; #f 

(fxnegative? -65) ;; #t
(fxnegative? 0) ;; #f
(fxnegative? 1) ;; #f

(fxeven? 0) ;; #t
(fxeven? 1) ;; #f
(fxeven? -1) ;; #f
(fxeven? -10) ;; #t 

(fxodd? 0) ;; #f
(fxodd? 1) ;; #t
(fxodd? -1) ;; #t
(fxodd? -10) ;; #f

(fxmin 4 -7 2 0 -6) ;; -7 

(let ([ls '(7 3 5 2 9 8)])
  (apply fxmin ls)) ;; 2 

(fxmax 4 -7 2 0 -6) ;; 4 

(let ([ls '(7 3 5 2 9 8)])
  (apply fxmax ls)) ;; 9

(fx+ -3 4) ;; 1

(fx- 3) ;; -3
(fx- -3 4) ;; -7

(fx* -3 4) ;; -12

(fxdiv 17 3) ;; 5
(fxmod 17 3) ;; 2
(fxdiv -17 3) ;; -6
(fxmod -17 3) ;; 1
(fxdiv 17 -3) ;; -5
(fxmod 17 -3) ;; 2
(fxdiv -17 -3) ;; 6
(fxmod -17 -3) ;; 1 

(fxdiv-and-mod 17 3) ;; 5
;; 2

(fxdiv0 17 3) ;; 6
(fxmod0 17 3) ;; -1
(fxdiv0 -17 3) ;; -6
(fxmod0 -17 3) ;; 1
(fxdiv0 17 -3) ;; -6
(fxmod0 17 -3) ;; -1
(fxdiv0 -17 -3) ;; 6
(fxmod0 -17 -3) ;; 1 

(fxdiv0-and-mod0 17 3) ;; 6
;; -1

(fxif #b101010 #b111000 #b001100) ;; #b101100

(fxbit-count #b00000) ;; 0
(fxbit-count #b00001) ;; 1
(fxbit-count #b00100) ;; 1
(fxbit-count #b10101) ;; 3 

(fxbit-count -1) ;; -1
(fxbit-count -2) ;; -2
(fxbit-count -4) ;; -3

(fxlength #b00000) ;; 0
(fxlength #b00001) ;; 1
(fxlength #b00100) ;; 3
(fxlength #b00110) ;; 3 

(fxlength -1) ;; 0
(fxlength -6) ;; 3
(fxlength -9) ;; 4

(fxfirst-bit-set #b00000) ;; -1
(fxfirst-bit-set #b00001) ;; 0
(fxfirst-bit-set #b01100) ;; 2 

(fxfirst-bit-set -1) ;; 0
(fxfirst-bit-set -2) ;; 1
(fxfirst-bit-set -3) ;; 0

(fxbit-set? #b01011 0) ;; #t
(fxbit-set? #b01011 2) ;; #f 

(fxbit-set? -1 0) ;; #t
(fxbit-set? -1 20) ;; #t
(fxbit-set? -3 1) ;; #f
(fxbit-set? 0 (- (fixnum-width) 1)) ;; #f
(fxbit-set? -1 (- (fixnum-width) 1)) ;; #t

(fxcopy-bit #b01110 0 1) ;; #b01111
(fxcopy-bit #b01110 2 0) ;; #b01010

(fxbit-field #b10110 0 3) ;; #b00110
(fxbit-field #b10110 1 3) ;; #b00011
(fxbit-field #b10110 2 3) ;; #b00001
(fxbit-field #b10110 3 3) ;; #b00000

(fxcopy-bit-field #b10000 0 3 #b10101) ;; #b10101
(fxcopy-bit-field #b10000 1 3 #b10101) ;; #b10010
(fxcopy-bit-field #b10000 2 3 #b10101) ;; #b10100
(fxcopy-bit-field #b10000 3 3 #b10101) ;; #b10000

(fxarithmetic-shift-right #b10000 3) ;; #b00010
(fxarithmetic-shift-right -1 1) ;; -1
(fxarithmetic-shift-right -64 3) ;; -8 

(fxarithmetic-shift-left #b00010 2) ;; #b01000
(fxarithmetic-shift-left -1 2) ;; -4

(fxarithmetic-shift #b10000 -3) ;; #b00010
(fxarithmetic-shift -1 -1) ;; -1
(fxarithmetic-shift -64 -3) ;; -8
(fxarithmetic-shift #b00010 2) ;; #b01000
(fxarithmetic-shift -1 2) ;; -4

(fxrotate-bit-field #b00011010 0 5 3) ;; #b00010110
(fxrotate-bit-field #b01101011 2 7 3) ;; #b01011011

(fxreverse-bit-field #b00011010 0 5) ;; #b00001011
(fxreverse-bit-field #b01101011 2 7) ;; #b00101111