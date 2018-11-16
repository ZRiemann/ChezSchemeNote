#!/usr/bin/scheme --script

(display "
================================================================================
Section 6.3.Hashtables
")

(define ht1 (make-eq-hashtable))
(define ht2 (make-eq-hashtable 32))

(define ht (make-hashtable string-hash string=?))

(hashtable-mutable? (make-eq-hashtable)) <graphic> #t
(hashtable-mutable? (hashtable-copy (make-eq-hashtable))) <graphic> #f

(define ht (make-eq-hashtable))
(hashtable-hash-function ht) <graphic> #f
(eq? (hashtable-equivalence-function ht) eq?) <graphic> #t 

(define ht (make-hashtable string-hash string=?))
(eq? (hashtable-hash-function ht) string-hash) <graphic> #t
(eq? (hashtable-equivalence-function ht) string=?) <graphic> #t

(define ht (make-eq-hashtable))
(hashtable-hash-function ht) <graphic> #f
(eq? (hashtable-equivalence-function ht) eq?) <graphic> #t 

(define ht (make-hashtable string-hash string=?))
(eq? (hashtable-hash-function ht) string-hash) <graphic> #t
(eq? (hashtable-equivalence-function ht) string=?) <graphic> #t

(define p1 (cons 'a 'b))
(define p2 (cons 'a 'b)) 

(define eqht (make-eq-hashtable))
(hashtable-set! eqht p1 73)
(hashtable-ref eqht p1 55) <graphic> 73
;;
(hashtable-ref eqht p2 55) <graphic> 55 

(define equalht (make-hashtable equal-hash equal?))
(hashtable-set! equalht p1 73)
(hashtable-ref equalht p1 55) <graphic> 73
;; equal? (a . b) (a . b) => #t
(hashtable-ref equalht p2 55) <graphic> 73

(define ht (make-eq-hashtable))
(define p1 (cons 'a 'b))
(define p2 (cons 'a 'b))
(hashtable-set! ht p1 73)
(hashtable-contains? ht p1) <graphic> #t
(hashtable-contains? ht p2) <graphic> #f

(define ht (make-eq-hashtable))
(hashtable-update! ht 'a
  (lambda (x) (* x 2))
  55)
(hashtable-ref ht 'a 0) <graphic> 110
(hashtable-update! ht 'a
  (lambda (x) (* x 2))
  0)
(hashtable-ref ht 'a 0) <graphic> 220

