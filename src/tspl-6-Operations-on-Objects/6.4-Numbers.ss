#!/usr/bin/scheme --script

(display "
================================================================================
Section 6.4. Numbers
")

(exact? 1) ;; #t
(exact? -15/16) ;; #t
(exact? 2.01) ;; #f
(exact? #i77) ;; #f
(exact? #i2/3) ;; #f
(exact? 1.0-2i) ;; #f

(inexact? -123) ;; #f
(inexact? #i123) ;; #t
(inexact? 1e23) ;; #t
(inexact? +i) ;; #f


(= 7 7) ;; #t
(= 7 9) ;; #f 

(< 2e3 3e2) ;; #f
(<= 1 2 3 3 4 5) ;; #t
(<= 1 2 3 4 5) ;; #t 

(> 1 2 2 3 3 4) ;; #f
(>= 1 2 2 3 3 4) ;; #f 

(= -1/2 -0.5) ;; #t
(= 2/3 .667) ;; #f
(= 7.2+0i 7.2) ;; #t
(= 7.2-3i 7) ;; #f 

(< 1/2 2/3 3/4) ;; #t
(> 8 4.102 2/3 -5) ;; #t 

(let ([x 0.218723452])
  (< 0.210 x 0.220)) ;; #t 

(let ([i 1] [v (vector 'a 'b 'c)])
  (< -1 i (vector-length v))) ;; #t 

(apply < '(1 2 3 4)) ;; #t
(apply > '(4 3 3 2)) ;; #f 

(= +nan.0 +nan.0) ;; #f
(< +nan.0 +nan.0) ;; #f
(> +nan.0 +nan.0) ;; #f
(>= +inf.0 +nan.0) ;; #f
(>= +nan.0 -inf.0) ;; #f
(> +nan.0 0.0) ;; #f

(+) ;; 0
(+ 1 2) ;; 3
(+ 1/2 2/3) ;; 7/6
(+ 3 4 5) ;; 12
(+ 3.0 4) ;; 7.0
(+ 3+4i 4+3i) ;; 7+7i
(apply + '(1 2 3 4 5)) ;; 15

(- 3) ;; -3
(- -2/3) ;; 2/3
(- 4 3.0) ;; 1.0
(- 3.25+4.25i 1/4+1/4i) ;; 3.0+4.0i
(- 4 3 2 1) ;; -2

(*) ;; 1
(* 3.4) ;; 3.4
(* 1 1/2) ;; 1/2
(* 3 4 5.5) ;; 66.0
(* 1+2i 3+4i) ;; -5+10i
(apply * '(1 2 3 4 5)) ;; 120

(/ -17) ;; -1/17
(/ 1/2) ;; 2
(/ .5) ;; 2.0
(/ 3 4) ;; 3/4
(/ 3.0 4) ;; .75
(/ -5+10i 3+4i) ;; 1+2i
(/ 60 5 4 3 2) ;; 1/2

(zero? 0) ;; #t
(zero? 1) ;; #f
(zero? (- 3.0 3.0)) ;; #t
(zero? (+ 1/2 1/2)) ;; #f
(zero? 0+0i) ;; #t
(zero? 0.0-0.0i) ;; #t

(positive? 128) ;; #t
(positive? 0.0) ;; #f
(positive? 1.8e-15) ;; #t
(positive? -2/3) ;; #f
;;(positive? .001-0.0i) ;; exception: not a real number

(negative? -65) ;; #t
(negative? 0) ;; #f
(negative? -0.0121) ;; #t
(negative? 15/16) ;; #f
(negative? -7.0+0.0i) ;; exception: not a real number


(even? 0) ;; #t
(even? 1) ;; #f
(even? 2.0) ;; #t
(even? -120762398465) ;; #f
;;(even? 2.0+0.0i) ;; exception: not an integer 

(odd? 0) ;; #f
(odd? 1) ;; #t
(odd? 2.0) ;; #f
(odd? -120762398465) ;; #t
;;(odd? 2.0+0.0i) ;; exception: not an integer

(finite? 2/3) ;; #t
(infinite? 2/3) ;; #f
(nan? 2/3) ;; #f 

(finite? 3.1415) ;; #t
(infinite? 3.1415) ;; #f
(nan? 3.1415) ;; #f 

(finite? +inf.0) ;; #f
(infinite? -inf.0) ;; #t
(nan? -inf.0) ;; #f 

(finite? +nan.0) ;; #f
(infinite? +nan.0) ;; #f
(nan? +nan.0) ;; #t

(quotient 45 6) ;; 7
(quotient 6.0 2.0) ;; 3.0
(quotient 3.0 -2) ;; -1.0 

(remainder 16 4) ;; 0
(remainder 5 2) ;; 1
(remainder -45.0 7) ;; -3.0
(remainder 10.0 -3.0) ;; 1.0
(remainder -17 -9) ;; -8 

(modulo 16 4) ;; 0
(modulo 5 2) ;; 1
(modulo -45.0 7) ;; 4.0
(modulo 10.0 -3.0) ;; -2.0
(modulo -17 -9) ;; -8
(div-and-mod 17.5 3) ;; 5.0 2.5



(div0 17 3) ;; 6
(mod0 17 3) ;; -1
(div0 -17 3) ;; -6
(mod0 -17 3) ;; 1
(div0 17 -3) ;; -6
(mod0 17 -3) ;; -1
(div0 -17 -3) ;; 6
(mod0 -17 -3) ;; 1 

(div0-and-mod0 17.5 3) ;; 6.0 -0.5

(truncate 19) ;; 19
(truncate 2/3) ;; 0
(truncate -2/3) ;; 0
(truncate 17.3) ;; 17.0
(truncate -17/2) ;; -8

(floor 19) ;; 19
(floor 2/3) ;; 0
(floor -2/3) ;; -1
(floor 17.3) ;; 17.0
(floor -17/2) ;; -9

(ceiling 19) ;; 19
(ceiling 2/3) ;; 1
(ceiling -2/3) ;; 0
(ceiling 17.3) ;; 18.0
(ceiling -17/2) ;; -8

(round 19) ;; 19
(round 2/3) ;; 1
(round -2/3) ;; -1
(round 17.3) ;; 17.0
(round -17/2) ;; -8
(round 2.5) ;; 2.0
(round 3.5) ;; 4.0

(abs 1) ;; 1
(abs -3/4) ;; 3/4
(abs 1.83) ;; 1.83
(abs -0.093) ;; 0.093

(max 4 -7 2 0 -6) ;; 4
(max 1/2 3/4 4/5 5/6 6/7) ;; 6/7
(max 1.5 1.3 -0.3 0.4 2.0 1.8) ;; 2.0
(max 5 2.0) ;; 5.0
(max -5 -2.0) ;; -2.0
(let ([ls '(7 3 5 2 9 8)])
  (apply max ls)) ;; 9

(min 4 -7 2 0 -6) ;; -7
(min 1/2 3/4 4/5 5/6 6/7) ;; 1/2
(min 1.5 1.3 -0.3 0.4 2.0 1.8) ;; -0.3
(min 5 2.0) ;; 2.0
(min -5 -2.0) ;; -5.0
(let ([ls '(7 3 5 2 9 8)])
  (apply min ls)) ;; 2

(gcd) ;; 0
(gcd 34) ;; 34
(gcd 33.0 15.0) ;; 3.0
(gcd 70 -42 28) ;; 14

(expt 2 10) ;; 1024
(expt 2 -10) ;; 1/1024
(expt 2 -10.0) ;; 9.765625e-4
(expt -1/2 5) ;; -1/32
(expt 3.0 3) ;; 27.0
(expt +i 2) ;; -1

(inexact 3) ;; 3.0
(inexact 3.0) ;; 3.0
(inexact -1/4) ;; -.25
(inexact 3+4i) ;; 3.0+4.0i
(inexact (expt 10 20)) ;; 1e20

(exact 3.0) ;; 3
(exact 3) ;; 3
(exact -.25) ;; -1/4
(exact 3.0+4.0i) ;; 3+4i
(exact 1e20) ;; 100000000000000000000

(rationalize 3/10 1/10) ;; 1/3
(rationalize .3 1/10) ;; 0.3333333333333333
(eqv? (rationalize .3 1/10) #i1/3) ;; #t

(numerator 9) ;; 9
(numerator 9.0) ;; 9.0
(numerator 0.0) ;; 0.0
(numerator 2/3) ;; 2
(numerator -9/4) ;; -9
(numerator -2.25) ;; -9.0

(denominator 9) ;; 1
(denominator 9.0) ;; 1.0
(denominator 0) ;; 1
(denominator 0.0) ;; 1.0
(denominator 2/3) ;; 3
(denominator -9/4) ;; 4
(denominator -2.25) ;; 4.0

(real-part 3+4i) ;; 3
(real-part -2.3+0.7i) ;; -2.3
(real-part -i) ;; 0
(real-part 17.2) ;; 17.2
(real-part -17/100) ;; -17/100

(imag-part 3+4i) ;; 4
(imag-part -2.3+0.7i) ;; 0.7
(imag-part -i) ;; -1
(imag-part -2.5) ;; 0
(imag-part -17/100) ;; 0

(make-rectangular -2 7) ;; -2+7i
(make-rectangular 2/3 -1/2) ;; 2/3-1/2i
(make-rectangular 3.2 5.3) ;; 3.2+5.3i

(make-polar 2 0) ;; 2
(make-polar 2.0 0.0) ;; 2.0+0.0i
(make-polar 1.0 (asin -1.0)) ;; 0.0-1.0i
(eqv? (make-polar 7.2 -0.588) 7.2@-0.588) ;; #t

(angle 7.3@1.5708) ;; 1.5708
(angle 5.2) ;; 0.0

(magnitude 1) ;; 1
(magnitude -3/4) ;; 3/4
(magnitude 1.83) ;; 1.83
(magnitude -0.093) ;; 0.093
(magnitude 3+4i) ;; 5
(magnitude 7.25@1.5708) ;; 7.25

(sqrt 16) ;; 4
(sqrt 1/4) ;; 1/2
(sqrt 4.84) ;; 2.2
(sqrt -4.84) ;; 0.0+2.2i
(sqrt 3+4i) ;; 2+1i
(sqrt -3.0-4.0i) ;; 1.0-2.0i

(exact-integer-sqrt 0) ;; 0
                       ;;   0
(exact-integer-sqrt 9) ;; 3
                       ;; 0
(exact-integer-sqrt 19) ;; 4
                        ;; 3


(exp 0.0) ;; 1.0
(exp 1.0) ;; 2.7182818284590455
(exp -.5) ;; 0.6065306597126334

(log 1.0) ;; 0.0
(log (exp 1.0)) ;; 1.0
(/ (log 100) (log 10)) ;; 2.0
(log (make-polar (exp 2.0) 1.0)) ;; 2.0+1.0i 

(log 100.0 10.0) ;; 2.0
(log .125 2.0) ;; -3.0

(sin 0.0) ;; 0.0
(cos 0.0) ;; 1.0
(tan 0.0) ;; 0.0

(define pi (* (asin 1) 2))
(= (* (acos 0) 2) pi) ;; #t

(define pi (* (atan 1) 4))
(= (* (atan 1.0 0.0) 2) pi) ;; #t


(bitwise-not 0) ;; -1
(bitwise-not 3) ;; -4 

(bitwise-and #b01101 #b00111) ;; #b00101
(bitwise-ior #b01101 #b00111) ;; #b01111
(bitwise-xor #b01101 #b00111) ;; #b01010

(bitwise-if #b101010 #b111000 #b001100) ;; #b101100

(bitwise-bit-count #b00000) ;; 0
(bitwise-bit-count #b00001) ;; 1
(bitwise-bit-count #b00100) ;; 1
(bitwise-bit-count #b10101) ;; 3 

(bitwise-bit-count -1) ;; -1
(bitwise-bit-count -2) ;; -2
(bitwise-bit-count -4) ;; -3

(bitwise-length #b00000) ;; 0
(bitwise-length #b00001) ;; 1
(bitwise-length #b00100) ;; 3
(bitwise-length #b00110) ;; 3 

(bitwise-length -1) ;; 0
(bitwise-length -6) ;; 3
(bitwise-length -9) ;; 4

(bitwise-first-bit-set #b00000) ;; -1
(bitwise-first-bit-set #b00001) ;; 0
(bitwise-first-bit-set #b01100) ;; 2 

(bitwise-first-bit-set -1) ;; 0
(bitwise-first-bit-set -2) ;; 1
(bitwise-first-bit-set -3) ;; 0


(string->number "0") ;; 0
(string->number "3.4e3") ;; 3400.0
(string->number "#x#e-2e2") ;; -738
(string->number "#e-2e2" 16) ;; -738
(string->number "#i15/16") ;; 0.9375
(string->number "10" 16) ;; 16

(number->string 3.4) ;; "3.4"
(number->string 1e2) ;; "100.0"
(number->string 1e-23) ;; "1e-23"
(number->string -7/2) ;; "-7/2"
(number->string 220/9 16) ;; "DC/9"