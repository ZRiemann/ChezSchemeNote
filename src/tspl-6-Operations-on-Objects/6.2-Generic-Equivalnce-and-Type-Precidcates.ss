#!/usr/bin/scheme --script

(display "
================================================================================
6.2.Generic Equivalence and Type Predicates
")

(eq? 'a 3) ;; #f
(eq? #t 't) ;; #f
(eq? "abc" 'abc) ;; #f
(eq? "hi" '(hi)) ;; #f
(eq? #f '()) ;; #f 

(eq? 9/2 7/2) ;; #f
(eq? 3.4 53344) ;; #f
(eq? 3 3.0) ;; #f
(eq? 1/3 #i1/3) ;; #f 

(eq? 9/2 9/2) ;; unspecified
(eq? 3.4 (+ 3.0 .4)) ;; unspecified
(let ([x (* 12345678987654321 2)])
  (eq? x x)) ;; unspecified 

(eq? #\a #\b) ;; #f
(eq? #\a #\a) ;; unspecified
(let ([x (string-ref "hi" 0)])
  (eq? x x)) ;; unspecified 

(eq? #t #t) ;; #t
(eq? #f #f) ;; #t
(eq? #t #f) ;; #f
(eq? (null? '()) #t) ;; #t
(eq? (null? '(a)) #f) ;; #t 

(eq? (cdr '(a)) '()) ;; #t 

(eq? 'a 'a) ;; #t
(eq? 'a 'b) ;; #f
(eq? 'a (string->symbol "a")) ;; #t 

(eq? '(a) '(b)) ;; #f
(eq? '(a) '(a)) ;; unspecified
(let ([x '(a . b)]) (eq? x x)) ;; #t
(let ([x (cons 'a 'b)])
  (eq? x x)) ;; #t
(eq? (cons 'a 'b) (cons 'a 'b)) ;; #f 

(eq? "abc" "cba") ;; #f
(eq? "abc" "abc") ;; unspecified
(let ([x "hi"]) (eq? x x)) ;; #t
(let ([x (string #\h #\i)]) (eq? x x)) ;; #t
(eq? (string #\h #\i)
     (string #\h #\i)) ;; #f 

(eq? '#vu8(1) '#vu8(1)) ;; unspecified
(eq? '#vu8(1) '#vu8(2)) ;; #f
(let ([x (make-bytevector 10 0)])
  (eq? x x)) ;; #t
(let ([x (make-bytevector 10 0)])
  (eq? x (make-bytevector 10 0))) ;; #f 

(eq? '#(a) '#(b)) ;; #f
(eq? '#(a) '#(a)) ;; unspecified
(let ([x '#(a)]) (eq? x x)) ;; #t
(let ([x (vector 'a)])
  (eq? x x)) ;; #t
(eq? (vector 'a) (vector 'a)) ;; #f 

(eq? car car) ;; #t
(eq? car cdr) ;; #f
(let ([f (lambda (x) x)])
  (eq? f f)) ;; #t
(let ([f (lambda () (lambda (x) x))])
  (eq? (f) (f))) ;; unspecified
(eq? (lambda (x) x) (lambda (y) y)) ;; unspecified 

(let ([f (lambda (x)
           (lambda ()
             (set! x (+ x 1))
             x))])
  (eq? (f 0) (f 0))) ;; #f

;;; eqv?
(eqv? +0.0 -0.0) ;; #f
(= +0.0 -0.0) ;; #t
(/ 1.0 -0.0) ;; -inf.0
(/ 1.0 +0.0) ;; +inf.0
(= 3.0+0.0i 3.0) ;; #t
(eqv? 3.0+0.0i 3.0) ;; #f
(eqv? 'a 3) ;; #f
(eqv? #t 't) ;; #f
(eqv? "abc" 'abc) ;; #f
(eqv? "hi" '(hi)) ;; #f
(eqv? #f '()) ;; #f 

(eqv? 9/2 7/2) ;; #f
(eqv? 3.4 53344) ;; #f
(eqv? 3 3.0) ;; #f
(eqv? 1/3 #i1/3) ;; #f 

(eqv? 9/2 9/2) ;; #t
(eqv? 3.4 (+ 3.0 .4)) ;; #t
(let ([x (* 12345678987654321 2)])
  (eqv? x x)) ;; #t 

(eqv? #\a #\b) ;; #f
(eqv? #\a #\a) ;; #t
(let ([x (string-ref "hi" 0)])
  (eqv? x x)) ;; #t 

(eqv? #t #t) ;; #t
(eqv? #f #f) ;; #t
(eqv? #t #f) ;; #f
(eqv? (null? '()) #t) ;; #t
(eqv? (null? '(a)) #f) ;; #t 

(eqv? (cdr '(a)) '()) ;; #t 

(eqv? 'a 'a) ;; #t
(eqv? 'a 'b) ;; #f
(eqv? 'a (string->symbol "a")) ;; #t 

(eqv? '(a) '(b)) ;; #f
(eqv? '(a) '(a)) ;; unspecified
(let ([x '(a . b)]) (eqv? x x)) ;; #t
(let ([x (cons 'a 'b)])
  (eqv? x x)) ;; #t
(eqv? (cons 'a 'b) (cons 'a 'b)) ;; #f 

(eqv? "abc" "cba") ;; #f
(eqv? "abc" "abc") ;; unspecified
(let ([x "hi"]) (eqv? x x)) ;; #t
(let ([x (string #\h #\i)]) (eqv? x x)) ;; #t
(eqv? (string #\h #\i)
      (string #\h #\i)) ;; #f 

(eqv? '#vu8(1) '#vu8(1)) ;; unspecified
(eqv? '#vu8(1) '#vu8(2)) ;; #f
(let ([x (make-bytevector 10 0)])
  (eqv? x x)) ;; #t
(let ([x (make-bytevector 10 0)])
  (eqv? x (make-bytevector 10 0))) ;; #f 

(eqv? '#(a) '#(b)) ;; #f
(eqv? '#(a) '#(a)) ;; unspecified
(let ([x '#(a)]) (eqv? x x)) ;; #t
(let ([x (vector 'a)])
  (eqv? x x)) ;; #t
(eqv? (vector 'a) (vector 'a)) ;; #f 

(eqv? car car) ;; #t
(eqv? car cdr) ;; #f
(let ([f (lambda (x) x)])
  (eqv? f f)) ;; #t
(let ([f (lambda () (lambda (x) x))])
  (eqv? (f) (f))) ;; unspecified
(eqv? (lambda (x) x) (lambda (y) y)) ;; unspecified 

(let ([f (lambda (x)
           (lambda ()
             (set! x (+ x 1))
             x))])
  (eqv? (f 0) (f 0))) ;; #f

--------------------------------------------------------------------------------

(equal? 'a 3) ;; #f
(equal? #t 't) ;; #f
(equal? "abc" 'abc) ;; #f
(equal? "hi" '(hi)) ;; #f
(equal? #f '()) ;; #f 

(equal? 9/2 7/2) ;; #f
(equal? 3.4 53344) ;; #f
(equal? 3 3.0) ;; #f
(equal? 1/3 #i1/3) ;; #f 

(equal? 9/2 9/2) ;; #t
(equal? 3.4 (+ 3.0 .4)) ;; #t
(let ([x (* 12345678987654321 2)])
  (equal? x x)) ;; #t 

(equal? #\a #\b) ;; #f
(equal? #\a #\a) ;; #t
(let ([x (string-ref "hi" 0)])
  (equal? x x)) ;; #t 

(equal? #t #t) ;; #t
(equal? #f #f) ;; #t
(equal? #t #f) ;; #f
(equal? (null? '()) #t) ;; #t
(equal? (null? '(a)) #f) ;; #t 

(equal? (cdr '(a)) '()) ;; #t 

(equal? 'a 'a) ;; #t
(equal? 'a 'b) ;; #f
(equal? 'a (string->symbol "a")) ;; #t 

(equal? '(a) '(b)) ;; #f
(equal? '(a) '(a)) ;; #t
(let ([x '(a . b)]) (equal? x x)) ;; #t
(let ([x (cons 'a 'b)])
  (equal? x x)) ;; #t
(equal? (cons 'a 'b) (cons 'a 'b)) ;; #t 

(equal? "abc" "cba") ;; #f
(equal? "abc" "abc") ;; #t
(let ([x "hi"]) (equal? x x)) ;; #t
(let ([x (string #\h #\i)]) (equal? x x)) ;; #t
(equal? (string #\h #\i)
        (string #\h #\i)) ;; #t 

(equal? '#vu8(1) '#vu8(1)) ;; #t
(equal? '#vu8(1) '#vu8(2)) ;; #f
(let ([x (make-bytevector 10 0)])
  (equal? x x)) ;; #t
(let ([x (make-bytevector 10 0)])
  (equal? x (make-bytevector 10 0))) ;; #t 

(equal? '#(a) '#(b)) ;; #f
(equal? '#(a) '#(a)) ;; #t
(let ([x '#(a)]) (equal? x x)) ;; #t
(let ([x (vector 'a)])
  (equal? x x)) ;; #t
(equal? (vector 'a) (vector 'a)) ;; #t 

(equal? car car) ;; #t
(equal? car cdr) ;; #f
(let ([f (lambda (x) x)])
  (equal? f f)) ;; #t
(let ([f (lambda () (lambda (x) x))])
  (equal? (f) (f))) ;; unspecified
(equal? (lambda (x) x) (lambda (y) y)) ;; unspecified 

(let ([f (lambda (x)
           (lambda ()
             (set! x (+ x 1))
             x))])
  (equal? (f 0) (f 0))) ;; #f 

(equal?
  (let ([x (cons 'x 'x)])
    (set-car! x x)
    (set-cdr! x x)
    x)
  (let ([x (cons 'x 'x)])
    (set-car! x x)
    (set-cdr! x x)
    (cons x x))) ;; #t

(boolean? #t) ;; #t
(boolean? #f) ;; #t
(or (boolean? 't) (boolean? '())) ;; #f

(null? '()) ;; #t
(null? '(a)) ;; #f
(null? (cdr '(a))) ;; #t
(null? 3) ;; #f
(null? #f) ;; #f

(pair? '(a b c)) ;; #t
(pair? '(3 . 4)) ;; #t
(pair? '()) ;; #f
(pair? '#(a b)) ;; #f
(pair? 3) ;; #f

(integer? 1901) ;; #t
(rational? 1901) ;; #t
(real? 1901) ;; #t
(complex? 1901) ;; #t
(number? 1901) ;; #t 

(integer? -3.0) ;; #t
(rational? -3.0) ;; #t
(real? -3.0) ;; #t
(complex? -3.0) ;; #t
(number? -3.0) ;; #t 

(integer? 7+0i) ;; #t
(rational? 7+0i) ;; #t
(real? 7+0i) ;; #t
(complex? 7+0i) ;; #t
(number? 7+0i) ;; #t 

(integer? -2/3) ;; #f
(rational? -2/3) ;; #t
(real? -2/3) ;; #t
(complex? -2/3) ;; #t
(number? -2/3) ;; #t 

(integer? -2.345) ;; #f
(rational? -2.345) ;; #t
(real? -2.345) ;; #t
(complex? -2.345) ;; #t
(number? -2.345) ;; #t 

(integer? 7.0+0.0i) ;; #f
(rational? 7.0+0.0i) ;; #f
(real? 7.0+0.0i) ;; #f
(complex? 7.0+0.0i) ;; #t
(number? 7.0+0.0i) ;; #t 

(integer? 3.2-2.01i) ;; #f
(rational? 3.2-2.01i) ;; #f
(real? 3.2-2.01i) ;; #f
(complex? 3.2-2.01i) ;; #t
(number? 3.2-2.01i) ;; #t 

(integer? 'a) ;; #f
(rational? '(a b c)) ;; #f
(real? "3") ;; #f
(complex? '#(1 2)) ;; #f
(number? #\a) ;; #f


(integer-valued? 1901) ;; #t
(rational-valued? 1901) ;; #t
(real-valued? 1901) ;; #t 

(integer-valued? -3.0) ;; #t
(rational-valued? -3.0) ;; #t
(real-valued? -3.0) ;; #t 

(integer-valued? 7+0i) ;; #t
(rational-valued? 7+0i) ;; #t
(real-valued? 7+0i) ;; #t 

(integer-valued? -2/3) ;; #f
(rational-valued? -2/3) ;; #t
(real-valued? -2/3) ;; #t 

(integer-valued? -2.345) ;; #f
(rational-valued? -2.345) ;; #t
(real-valued? -2.345) ;; #t 

(integer-valued? 7.0+0.0i) ;; #t
(rational-valued? 7.0+0.0i) ;; #t
(real-valued? 7.0+0.0i) ;; #t 

(integer-valued? 3.2-2.01i) ;; #f
(rational-valued? 3.2-2.01i) ;; #f
(real-valued? 3.2-2.01i) ;; #f

integer-valued? 1901) ;; #t
(rational-valued? 1901) ;; #t
(real-valued? 1901) ;; #t 

(integer-valued? -3.0) ;; #t
(rational-valued? -3.0) ;; #t
(real-valued? -3.0) ;; #t 

(integer-valued? 7+0i) ;; #t
(rational-valued? 7+0i) ;; #t
(real-valued? 7+0i) ;; #t 

(integer-valued? -2/3) ;; #f
(rational-valued? -2/3) ;; #t
(real-valued? -2/3) ;; #t 

(integer-valued? -2.345) ;; #f
(rational-valued? -2.345) ;; #t
(real-valued? -2.345) ;; #t 

(integer-valued? 7.0+0.0i) ;; #t
(rational-valued? 7.0+0.0i) ;; #t
(real-valued? 7.0+0.0i) ;; #t 

(integer-valued? 3.2-2.01i) ;; #f
(rational-valued? 3.2-2.01i) ;; #f
(real-valued? 3.2-2.01i) ;; #f

(char? 'a) ;; #f
(char? 97) ;; #f
(char? #\a) ;; #t
(char? "a") ;; #f
(char? (string-ref (make-string 1) 0)) ;; #t

(string? "hi") ;; #t
(string? 'hi) ;; #f
(string? #\h) ;; #f

(vector? '#()) ;; #t
(vector? '#(a b c)) ;; #t
(vector? (vector 'a 'b 'c)) ;; #t
(vector? '()) ;; #f
(vector? '(a b c)) ;; #f
(vector? "abc") ;; #f

(symbol? 't) ;; #t
(symbol? "t") ;; #f
(symbol? '(t)) ;; #f
(symbol? #\t) ;; #f
(symbol? 3) ;; #f
(symbol? #t) ;; #f

(procedure? car) ;; #t
(procedure? 'car) ;; #f
(procedure? (lambda (x) x)) ;; #t
(procedure? '(lambda (x) x)) ;; #f
(call/cc procedure?) ;; #t

(bytevector? #vu8()) ;; #t
(bytevector? '#()) ;; #f
(bytevector? "abc") ;; #f

(hashtable? (make-eq-hashtable)) ;; #t
(hashtable? '(not a hash table)) ;; #f