#!/usr/bin/scheme --script

(display "
================================================================================
Section 5.14.Enumerations
")
(define-enumeration weather-element
  (hot warm cold sunny rainy snowy windy)
  weather)

(weather-element hot) ;; hot
;;(weather-element fun) ;; syntax violation
(weather hot sunny windy) ;; #<enum-set>
(enum-set->list (weather rainy cold rainy)) ;; (cold rainy)
(define weather-sub-set
  (weather hot sunny windy))
(enum-set->list weather-sub-set)

(define weather-enum-set
  (make-enumeration '(hot sunny)))
(enum-set->list weather-enum-set)

(define positions (make-enumeration '(top bottom above top beside)))
(enum-set->list positions) ;; (top bottom above beside)
positions

(define e1 (make-enumeration '(one two three four)))
(define p1 (enum-set-constructor e1))
(define e2 (p1 '(one three)))
(enum-set->list e2) ;; (one three)
;;; p2 的symbol集合是'(one two three four) 不是 '(one three)，等价于p1
(define p2 (enum-set-constructor e2))
(define e3 (p2 '(one two four)))
(enum-set->list e3) ;; (one two four)
(define e4 (p2 '(one four two)))
(enum-set->list e4) ;; (one for two)


(define e1 (make-enumeration '(a b c a b c d)))
(enum-set->list (enum-set-universe e1)) ;; (a b c d)
(define e2 ((enum-set-constructor e1) '(c)))
(enum-set->list (enum-set-universe e2)) ;; (a b c d)

(define e1 (make-enumeration '(a b c a b c d)))
(enum-set->list e1) ;; (a b c d)
(define e2 ((enum-set-constructor e1) '(d c a b)))
(enum-set->list e2) ;; (a b c d)

(define e1 (make-enumeration '(a b c)))
(define e2 (make-enumeration '(a b c d e)))
(enum-set-subset? e1 e2) ;; #t
(enum-set-subset? e2 e1) ;; #f
;;; e3 是由 e2 集合枚举构造其 构造的，所以是e2的子集，但不是e1的子集
(define e3 ((enum-set-constructor e2) '(a c)))
(enum-set-subset? e3 e1) ;; #f
(enum-set-subset? e3 e2) ;; #t
;;; e3 是由 e1 集合枚举构造其 构造的，所以是e1的子集，
;;; 但e1是e2的子集，所以e4也是e2的子集
(define e4 ((enum-set-constructor e1) '(a c)))
(enum-set-subset? e4 e1) ;; #f
(enum-set-subset? e4 e2) ;; #t


(define e1 (make-enumeration '(a b c d)))
(define e2 ((enum-set-constructor e1) '(a c)))
(define e3 ((enum-set-constructor e1) '(b c)))
;;; e2 e3 具有公共的超级 e1，可以进行以下运算
(enum-set->list (enum-set-union e2 e3)) ;; (a b c)
(enum-set->list (enum-set-intersection e2 e3)) ;; (c)
(enum-set->list (enum-set-difference e2 e3)) ;; (a)
(enum-set->list (enum-set-difference e3 e2)) ;; (b)

;;; e4 , e5 不是 e1的子集，不能进行 并集、交集、差的运算
(define e4 (make-enumeration '(b d c a)))
(enum-set-union e1 e4) ;; exception: different enumeration types
(define e5 (make-enumeration '(a b c d e f g)))
(enum-set-union e1 e5)

(define e1 (make-enumeration '(a b c d)))
(enum-set->list (enum-set-complement e1)) ;; ()
(define e2 ((enum-set-constructor e1) '(a c)))
(enum-set->list (enum-set-complement e2)) ;; (b d)

(define e1 (make-enumeration '(a b c d)))
(define e2 (make-enumeration '(a b c d e f g)))
(define e3 ((enum-set-constructor e1) '(a d)))
(define e4 ((enum-set-constructor e2) '(a c e g)))
(enum-set->list (enum-set-projection e4 e3)) ;; (a c)
(enum-set->list
 (enum-set-union e3
                 (enum-set-projection e4 e3))) ;; (a c d)

(define e1 (make-enumeration '(a b c d)))
(define e2 ((enum-set-constructor e1) '(a d)))
(define p (enum-set-indexer e2))
(list (p 'a) (p 'c) (p 'e)) ;; (0 2 #f)